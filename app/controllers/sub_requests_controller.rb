class SubRequestsController < ApplicationController
	skip_before_filter :require_login
	skip_before_filter :force_feedback 
	
	def index
		@soonest = current_user.potential_sub_games.sort_by(&:start_time).reverse
		@newest = current_user.potential_sub_games.sort_by(&:created_at).reverse

		order = current_user.sports.pluck(:name)
		order_hash = Hash[order.map.with_index.to_a]
		@sport = current_user.potential_sub_games.sort_by {|game| order_hash[game.sport.name]}

		@sub_requests = current_user.potential_sub_games.sort_by(&:start_time).reverse
		@other_sub_requests = SubRequest.other_sports(current_user.sports)

		respond_to do |format|
			format.html {}
			format.js {}
		end
	end

	def new
		@sub_request = SubRequest.new
		@sports = Sport.sports_with_ids
		@teams = current_user.teams_with_ids

		respond_to do |format|
			format.html {}
			format.js {}
		end
	end

	def edit
		@sub_request = SubRequest.find(params[:id])
		@sports = Sport.sports_with_ids
		@teams = current_user.teams_with_ids
	end

	def update
		SubRequest.find(params[:id]).destroy

		@team = Team.find(params[:sub_request][:team_id])
		@venue = Venue.find_or_initialize_by(name: params[:venue].downcase)
		@venue.update(address: params[:venue_address].downcase, country: 1, city_id: 1, province_id: 1, latitude: 43.643617, longitude: -79.378927)	

		day = Player::Availability::DAYS[params[:sub_request][:start_time].to_date.strftime("%a").downcase.to_sym]

		(params[:number_of_subs].to_i).times do
			@sub_request = current_user.sub_requests.create(sub_request_params.merge(venue_id: @venue.id, city_id: 1, day: day, sport_id: @team.league.sport.id, skill_level: @team.skill_rating, gender: @team.gender))
		end

		flash[:success] = 'Sub request successfully updated.'
		redirect_to player_path(current_user)
	end

	def create
		@team = Team.find(params[:sub_request][:team_id])
		@venue = Venue.find_or_initialize_by(name: params[:venue].downcase)
		@venue_specific = params[:venue_specific]
		@venue.update(address: params[:venue_address].downcase, country: 1, city_id: 1, province_id: 1, latitude: 43.643617, longitude: -79.378927)	

		day = Player::Availability::DAYS[params[:sub_request][:start_time].to_date.strftime("%a").downcase.to_sym]

		(params[:number_of_subs].to_i).times do
			@sub_request = current_user.sub_requests.create(sub_request_params.merge(venue_id: @venue.id, city_id: 1, day: day, sport_id: @team.league.sport.id, skill_level: @team.skill_rating, gender: @team.gender, venue_specific: @venue_specific))
		end

		flash[:success] = 'Sub request successfully created.'
		redirect_to player_path(current_user)
	end

	def fill_sub
		@sub_request = SubRequest.find(params[:sub_request_id])
		@charge = current_user.create_charge(699)

		if @charge.paid
			@sub_request.update(sub_id: current_user.id, status: 1)
			PlayerMailer.delay.sub_in_email(current_user, @sub_request)
			PlayerMailer.delay.filled_sub_email(@sub_request.poster, @sub_request)  
			flash[:success] = 'Successfully subbed in!'
			redirect_to player_path(current_user)
		else
			flash[:error] = @charge.failure_message
			redirect_to sub_requests_path
		end
	end

	def details
		@for_sub = params[:sub] == 'true' 
		@upcoming_sub = params[:upcoming_sub] == 'true'
		@my_request = params[:my_request] == 'true'
		@sub_request = SubRequest.find(params[:sub_request_id])
		render layout: false
	end

	def destroy
		@sub_request = SubRequest.find(params[:id])
		@sub_request.destroy
		redirect_to player_path(current_user)
	end

private

	def sub_request_params
		params.require(:sub_request).permit(:sport_id, :start_time, :team_id, :skill_level)
	end
end
