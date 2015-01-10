class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.integer :zip_scf_id, :null => false
      t.integer :zip_code, :null => false
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.integer :city_id, :null => false
      t.integer :state_id, :null => false

      t.timestamps
    end

    add_index :zip_codes, :zip_scf_id
    add_index :zip_codes, :zip_code
  end
end
