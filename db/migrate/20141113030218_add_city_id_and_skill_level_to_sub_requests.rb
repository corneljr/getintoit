class AddCityIdAndSkillLevelToSubRequests < ActiveRecord::Migration
  def change
  	add_column :sub_requests, :skill_level, :integer
  	add_column :sub_requests, :city_id, :integer

  	add_index :sub_requests, :city_id
  end
end
