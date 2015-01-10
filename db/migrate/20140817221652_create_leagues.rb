class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.integer :sport_id, :null => false
      t.string :name, :null => false
      t.integer :num_teams, :null => false, :default => 0
      t.integer :num_players, :null => false, :default => 0
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :leagues, :sport_id
  end
end
