class AddFirstNameLastNameToPlayers < ActiveRecord::Migration
  def change
  	remove_column :players, :name
  	add_column :players, :first_name, :string
  	add_column :players, :last_name, :string
  end
end
