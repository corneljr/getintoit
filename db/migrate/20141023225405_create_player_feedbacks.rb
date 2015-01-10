class CreatePlayerFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :player_feedbacks do |t|
      t.integer :player_id, :null => false
      t.integer :game_id, :null => false
      t.integer :league_id, :null => false
      t.integer :division_id
      t.integer :reviewer_id, :null => false
      t.integer :fit_score
      t.integer :skill_score
      t.integer :punctuality_score
      t.integer :personality_score
    end
  end

  def self.down
    drop_table :player_feedbacks
  end
end
