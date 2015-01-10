class AddWeightedOverallScoreToPlayers < ActiveRecord::Migration
  def change
    add_column(:players, :weighted_overall_score, :float)
  end
end
