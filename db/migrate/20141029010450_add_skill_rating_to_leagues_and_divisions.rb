class AddSkillRatingToLeaguesAndDivisions < ActiveRecord::Migration
  def change
    add_column(:leagues, :skill_rating, :float)
    add_column(:league_divisions, :skill_rating, :float)
  end
end
