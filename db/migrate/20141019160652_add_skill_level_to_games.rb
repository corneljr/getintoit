class AddSkillLevelToGames < ActiveRecord::Migration
  def change
    add_column(:games, :skill_level, :integer, :null => false)
  end
end
