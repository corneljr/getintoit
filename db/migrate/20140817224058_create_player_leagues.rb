class CreatePlayerLeagues < ActiveRecord::Migration
  def change
    create_table :player_leagues do |t|
      t.integer :player_id, :null => false
      t.integer :league_id, :null => false
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :player_leagues, :player_id
    add_index :player_leagues, :league_id
  end
end
