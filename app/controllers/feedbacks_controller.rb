class FeedbacksController < ApplicationController
	skip_before_filter :force_feedback
	
	def new
		@player = Player.find(params[:player_id])
		@sub_request = @player.sub_requests.waiting_for_feedback.first
		@player_feedback = Player::Feedback.new
		render layout: false
	end

	def create
		@player = Player.find(params[:player_id])
		@sub_request = SubRequest.find(params[:sub_request_id])
		@feedback = Player::Feedback.new(player_feedback_params)

		if @feedback.save
			@sub_request.update(status: 3)
			redirect_to sub_requests_path, notice: 'Thanks for your feedback!'
		else
			flash.now[:alert] = 'There was an issue with your feedback.'
			render :new
		end
	end

private

	def player_feedback_params
		params.require(:player_feedback).permit(:fit_score, :skill_score, :punctuality_score, :personality_score, :player_id, :league_id, :division_id, :reviewer_id)
	end
end