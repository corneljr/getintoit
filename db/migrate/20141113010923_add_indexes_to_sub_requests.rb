class AddIndexesToSubRequests < ActiveRecord::Migration
  def change
  	add_index :sub_requests, :venue_id
    add_index :sub_requests, :sport_id
    add_index :sub_requests, :sub_id
  end
end
