class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :sport_id, :null => false
      t.integer :league_id, :null => false
      t.integer :city_id, :null => false
      t.integer :venue_id, :null => false
      t.integer :team1_id
      t.integer :team2_id
      t.integer :player1_id
      t.integer :player2_id
      t.datetime :starts_at, :null => false
      t.datetime :finishes_at, :null => false
      t.integer :score1, :default => 0, :null => false
      t.integer :score2, :default => 0, :null => false
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :games, [:sport_id, :city_id]
    add_index :games, :league_id
    add_index :games, [:team1_id, :team2_id]
    add_index :games, [:player1_id, :player2_id]
  end
end
