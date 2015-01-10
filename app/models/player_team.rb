class PlayerTeam < ActiveRecord::Base
  belongs_to :player, :inverse_of => :player_teams
  belongs_to :team, :inverse_of => :player_teams
  belongs_to :league
  belongs_to :season

  validates :team_id, :league_id, :presence => true
end
