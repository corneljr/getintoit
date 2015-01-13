class ChangePostalCodeToAddress < ActiveRecord::Migration
  def change
  	remove_column :players, :postal_code
  	add_column :players, :address, :string
  end
end
