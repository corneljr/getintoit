class AddVenueSpecificToSubRequests < ActiveRecord::Migration
  def change
  	add_column :sub_requests, :venue_specific, :string
  end
end
