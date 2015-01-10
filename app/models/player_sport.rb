class PlayerSport < ActiveRecord::Base
  belongs_to :player, foreign_key: :player_id
  belongs_to :sport, :inverse_of => :player_sports

  validates :sport_id, :skill_level, :presence => true

  before_save :set_actual_skill_rating

  # enum skill_level: SkillLevel.all

  def set_actual_skill_rating
    if self.skill_rating.nil?
      self.skill_rating = self.skill_level.to_f
    end
  end
end
