class CreatePostalCodes < ActiveRecord::Migration
  def change
    create_table :postal_codes do |t|
      t.string :label, :null => false
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.integer :city_id, :null => false
      t.integer :province_id, :null => false

      t.timestamps
    end

    add_index :postal_codes, :label
  end
end
