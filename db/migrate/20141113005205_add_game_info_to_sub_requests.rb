class AddGameInfoToSubRequests < ActiveRecord::Migration
  def change
  	remove_column :sub_requests, :game_id
  	remove_column :sub_requests, :player_game_id
  	add_column :sub_requests, :start_time, :datetime
  	add_column :sub_requests, :end_time, :datetime
  	add_column :sub_requests, :venue_id, :integer
  	add_column :sub_requests, :sport_id, :integer
  	add_column :sub_requests, :sub_id, :integer
  	add_column :sub_requests, :status, :integer
  end
end
