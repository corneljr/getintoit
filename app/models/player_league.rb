class PlayerLeague < ActiveRecord::Base
  belongs_to :player, :inverse_of => :player_leagues
  belongs_to :league, :inverse_of => :player_leagues
  has_many :feedbacks,
    :class_name => "Player::Feedback"

  validates :player_id, :league_id, :presence => true
end
