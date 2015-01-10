class CreateLeagueDivisions < ActiveRecord::Migration
  def change
    create_table :league_divisions do |t|
      t.integer :league_id, :null => false
      t.string :name, :null => false
      t.integer :num_teams, :null => false, :default => 0
      t.integer :num_players, :null => false, :default => 0

      t.timestamps
    end

    add_index :league_divisions, :league_id
    add_column :games, :division_id, :integer
    add_column :teams, :division_id, :integer
  end
end
