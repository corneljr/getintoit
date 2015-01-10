class AddAgeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :age, :string
  end
end
