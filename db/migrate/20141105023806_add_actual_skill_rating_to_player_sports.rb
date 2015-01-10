class AddActualSkillRatingToPlayerSports < ActiveRecord::Migration
  def change
    add_column(:player_sports, :actual_skill_rating, :float, :null => false)
  end
end
