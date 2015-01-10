class AddPlayCoedToPlayerSports < ActiveRecord::Migration
  def change
  	add_column :player_sports, :play_coed, :boolean
  end
end
