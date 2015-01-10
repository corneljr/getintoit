class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :country, :default => 1, :limit => 3, :null => false
      t.integer :region_id, :null => false
      t.string :region_type, :null => false
      t.string :name, :null => false
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10

      t.timestamps
    end

    add_index :cities, :country
    add_index :cities, [:region_id, :region_type]
  end
end
