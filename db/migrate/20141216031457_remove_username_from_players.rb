class RemoveUsernameFromPlayers < ActiveRecord::Migration
  def change
  	remove_column :players, :username
  end
end
