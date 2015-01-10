class CreatePlayerGames < ActiveRecord::Migration
  def change
    create_table :player_games do |t|
      t.integer :league_id, :null => false
      t.integer :player_id, :null => false
      t.integer :team_id
      t.integer :game_id, :null => false
      t.boolean :subbed, :null => false, :default => false
      t.boolean :deleted, :null => false, :default => false
      t.boolean :checked_in, :null => false, :default => false

      t.timestamps
    end

    add_index :player_games, :player_id
    add_index :player_games, :game_id
  end
end
