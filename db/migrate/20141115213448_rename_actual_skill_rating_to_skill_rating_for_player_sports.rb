class RenameActualSkillRatingToSkillRatingForPlayerSports < ActiveRecord::Migration
  def change
    rename_column(:player_sports, :actual_skill_rating, :skill_rating)
  end
end
