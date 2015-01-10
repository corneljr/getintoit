class AddAverageFeedbackScoresCacheValuesToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :avg_fit_score, :float
  	add_column :players, :avg_skill_score, :float
  	add_column :players, :avg_punctuality_score, :float
  	add_column :players, :avg_personality_score, :float
  end
end
