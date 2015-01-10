class CreatePlayerStats < ActiveRecord::Migration
  def change
    create_table :player_stats do |t|
      t.integer :player_id, :null => false
      t.integer :sport_id, :null => false
      t.integer :league_id, :null => false
      t.integer :season_id, :null => false
      t.integer :stat_type_id, :null => false
      t.float :stat_type_value, :null => false

      t.timestamps
    end

    add_index :player_stats, [:player_id, :league_id, :season_id]
    add_index :player_stats, [:player_id, :sport_id]
  end
end
