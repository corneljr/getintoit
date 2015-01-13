class AddPostalCodeToPlayer < ActiveRecord::Migration
  def change
  	add_column :players, :postal_code, :string
  end
end
