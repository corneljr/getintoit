class UpdateNullRequirementsForSubRequests < ActiveRecord::Migration
  def change
  	change_column :sub_requests, :start_time, :datetime, null: false
  	change_column :sub_requests, :venue_id, :integer, null: false
  	change_column :sub_requests, :sport_id, :integer, null: false
  	change_column :sub_requests, :status, :integer, default: 0, null: false
  	change_column :sub_requests, :skill_level, :integer, null: false
  end
end
