class PlayerGame < ActiveRecord::Base
  belongs_to :player, :inverse_of => :player_games
  belongs_to :game, :inverse_of => :player_games
  belongs_to :league, :inverse_of => :player_games
  belongs_to :team

  validates :player_id, :game_id, :league_id, :team_id, :presence => true

  scope :sub, lambda{ where(:subbed => true) }
  scope :regular, lambda{ where(:subbed => false) }
end
