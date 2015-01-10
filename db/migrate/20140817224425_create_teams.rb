class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :league_id, :null => false
      t.string :name, :null => false
      t.integer :num_players
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :teams, :league_id
  end
end
