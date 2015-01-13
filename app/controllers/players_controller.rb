class PlayersController < ApplicationController
	include PrepareObjects

	skip_before_filter :require_login, only: [:new, :create, :check_email]
	before_filter :redirect_if_logged_in, only: [:new, :create]
	before_filter :correct_player, only: [:show,:edit,:payment_info,:new_teams]
	helper_method :prepare_availabilities
	helper_method :prepare_sports
	
	def index
	end

	def new
		@player = Player.new
		@player.availabilities.build
		@player.player_sports.build
	end

	def create
		@player = Player.new(player_params)
		@player.timezone = 'EST'

		if @player.save
			#temporary while only in toronto
			@player.add_city('Toronto')
			auto_login(@player)
			PlayerMailer.delay.welcome_email(@player)

			@sports = Sport.sports_with_ids
		else
			@player.availabilities.destroy_all
			@player.player_sports.destroy_all
			render :new
		end
	end

	def payment_info
	end

	def add_payment_info
		@player = Player.find(params[:player_id])
		token = params[:paymentToken]

		Stripe.api_key = ENV['stripe_api_key']

    begin 
      customer = Stripe::Customer.create(
        card: token,
        description: @player.email
      )

      @player.update(stripe_customer_id: customer.id)

      if params[:section] == 'payment' && params[:sub_request]
				flash[:success] = 'Payment information successfully updated.'
				redirect_to sub_requests_path(sub_request: params[:sub_request])
			else
				redirect_to edit_player_path(current_user, section: 'payment')
			end
			
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to sub_requests_path
    end
	end

	def create_teams
		sport_id = params[:sport_id]
		skill_level = params[:skill_level]
		@player = Player.find(params[:player_id])
		@league = League.find_or_create_by(sport_id: sport_id, name: params[:league])
		@division = Division.find_or_initialize_by(league_id: @league.id, name: params[:division], season_id: 1)

		if @division.new_record?
			@division.skill_level = skill_level
			@division.skill_rating = skill_level
			@division.save
		end
		
		@team = Team.find_or_initialize_by(league_id: @league.id, name: params[:team], division_id: @division.id, gender: params[:gender])

		if @team.new_record? 
			@team.skill_rating = skill_level
			@team.save
		end

		@player.player_teams.create(league_id: @league.id, team_id: @team.id, season_id: 1, division_id: @division.id, sport_id: sport_id)
		@player.leagues << @league
	end

	def destroy_team
		@player = Player.find(params[:player_id])
		team = Team.find(params[:team_id])
		team.destroy
	end

	def show 
		@subs = current_user.upcoming_subs.order('start_time DESC')
		@sub_requests = current_user.sub_requests.order('start_time DESC')
		@past_games = current_user.past_games

		respond_to do |format|
			format.js {}
			format.html {}
		end

	end

	def edit
		@player = Player.find(params[:id])
		@sports = Sport.sports_with_ids
	end

	def update
		@player = Player.find(params[:id])
		case params[:section]
		when 'personal'
			if @player.update(player_params)
				flash[:success] = 'Personal settings updated.'
				redirect_to root_path
			else
				flash.now[:error] = 'There was an error updating your information.'
				render :edit
			end
		when 'availability'
			@player.availabilities.destroy_all
			if @player.update(player_params)
				flash[:success] = 'Settings successfully updated.'
				redirect_to root_path
			else 
				flash.now[:error] = 'There was an error updating your information.'
				render :edit
			end
		when 'sports'
			@player.player_sports.destroy_all
			if @player.update(player_params)
				flash[:success] = 'Settings successfully updated.'
				redirect_to root_path
			else 
				flash.now[:alert] = 'There was an error updating your information.'
				render :edit
			end
		when 'teams'
			flash[:success] = 'Settings successfully updated.'
			redirect_to root_path
		end
	end

	def check_email
		email = params[:email]
		emails = Player.all.pluck(:email)
		if emails.include?(email)
			render json: {valid: false}
		else
			render json: {valid: true}
		end
	end

private

	def correct_player
		id = params[:id] || params[:player_id]
		if current_user.id != id.to_i
			flash[:error] = 'You are not authorized to see that page.'
			redirect_to sub_requests_path
		end
	end
	
	def player_params
		params.require(:player).permit(:sex,:first_name,:last_name,:email,:password,:password_confirmation,:birth_date,:availability_radius, availabilities_attributes: [:id, :day, :available_from, :available_to], player_sports_attributes: [:id, :player_id, :skill_level, :sport_id, :play_coed,:skill_rating], player_teams_attributes: [:id, :league_id, :sport_id, :team_id, :division_id, :season_id])
	end
end
