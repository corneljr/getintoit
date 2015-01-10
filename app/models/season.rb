class Season < ActiveRecord::Base
  has_many :game
  has_many :player_stats
  has_many :player_teams
  has_many :divisions
end
