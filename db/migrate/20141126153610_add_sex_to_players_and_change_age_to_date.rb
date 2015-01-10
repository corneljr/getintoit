class AddSexToPlayersAndChangeAgeToDate < ActiveRecord::Migration
  def change
  	remove_column :players, :age
  	add_column :players, :birth_date, :datetime
  	add_column :players, :sex, :string
  end
end
