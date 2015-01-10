class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :league_id, :null => false
      t.datetime :starts_at, :null => false
      t.datetime :ends_at, :null => false

      t.timestamps
    end

    add_index :seasons, :league_id
    add_column :player_teams, :season_id, :integer, :null => false
    add_column :games, :season_id, :integer, :null => false
    add_column :league_divisions, :season_id, :integer, :null => false
  end
end
