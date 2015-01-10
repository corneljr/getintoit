class AddSkillLevelToLeagueDivisions < ActiveRecord::Migration
  def change
    add_column(:divisions, :skill_level, :integer, :null => false)
  end
end
