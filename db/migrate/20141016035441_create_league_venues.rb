class CreateLeagueVenues < ActiveRecord::Migration
  def change
    create_table :league_venues do |t|
      t.integer :league_id, :null => false
      t.integer :venue_id, :null => false
      t.boolean :deleted, :default => false, :null => false

      t.timestamps
    end

    add_index :league_venues, :league_id
    add_index :league_venues, :venue_id
  end
end
