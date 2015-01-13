class AddLatLngToSubRequests < ActiveRecord::Migration
  def change
  	add_column :sub_requests, :latitude, :float
  	add_column :sub_requests, :longitude, :float
  end
end
