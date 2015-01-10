class Division < ActiveRecord::Base
  belongs_to :league
  belongs_to :team
  has_many :teams
  has_many :games
  has_many :feedbacks,
    :class_name => "Player::Feedback"
  belongs_to :season

  validates :name, :skill_rating, :presence => true

  def sibling_divisions
    self.league.divisions.
      where(:league_id => self.league_id).
      where('id != ?', self.id)
  end

end
