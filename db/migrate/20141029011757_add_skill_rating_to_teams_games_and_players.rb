class AddSkillRatingToTeamsGamesAndPlayers < ActiveRecord::Migration
  def change
    add_column(:players, :skill_rating, :float)
    add_column(:teams, :skill_rating, :float)
    add_column(:games, :optimal_skill_rating, :float)
  end
end
