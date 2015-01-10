class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name, :null => false
      t.string :abbreviation, :null => false, :limit => 2

      t.timestamps
    end

    add_index :provinces, :name, :unique => true
  end
end
