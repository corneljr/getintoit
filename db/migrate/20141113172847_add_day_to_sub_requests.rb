class AddDayToSubRequests < ActiveRecord::Migration
  def change
  	add_column :sub_requests, :day, :integer
  end
end
