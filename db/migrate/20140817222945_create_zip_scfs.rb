class CreateZipScfs < ActiveRecord::Migration
  def change
    create_table :zip_scfs do |t|
      t.integer :state_id, :null => false
      t.integer :scf, :null => false

      t.timestamps
    end
  end
end
