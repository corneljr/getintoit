class SportsController < ApplicationController
	skip_before_filter :require_login, only: [:get_leagues]
	
	def get_leagues
		sport = Sport.find(params[:sport_id])
		team = Team.find_by(name: params[:team])
		@leagues = sport.leagues
	end
end
