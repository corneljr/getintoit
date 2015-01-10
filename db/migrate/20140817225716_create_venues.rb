class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.integer :country, :null => false, :limit => 3
      t.integer :city_id, :null => false
      t.integer :province_id, :null => false
      t.string :name, :null => false
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.string :address, :null => false
      t.text :notes

      t.timestamps
    end

    add_index :venues, :city_id
    add_index :venues, :name
  end
end
