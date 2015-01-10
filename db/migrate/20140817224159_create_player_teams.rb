class CreatePlayerTeams < ActiveRecord::Migration
  def change
    create_table :player_teams do |t|
      t.integer :player_id, :null => false
      t.integer :league_id, :null => false
      t.integer :team_id, :null => false
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :player_teams, :player_id
    add_index :player_teams, :team_id
    add_index :player_teams, :league_id
  end
end
