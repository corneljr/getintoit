class CreatePlayerCities < ActiveRecord::Migration
  def change
    create_table :player_cities do |t|
      t.integer :player_id, :null => false
      t.integer :city_id, :null => false
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :player_cities, :player_id
    add_index :player_cities, :city_id
  end
end
