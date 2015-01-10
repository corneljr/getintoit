class AddGenderToSubRequests < ActiveRecord::Migration
  def change
  	add_column :sub_requests, :gender, :string
  end
end
