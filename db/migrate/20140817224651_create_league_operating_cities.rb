class CreateLeagueOperatingCities < ActiveRecord::Migration
  def change
    create_table :league_operating_cities do |t|
      t.integer :league_id, :null => false
      t.integer :city_id, :null => false
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :league_operating_cities, :league_id
    add_index :league_operating_cities, :city_id
  end
end
