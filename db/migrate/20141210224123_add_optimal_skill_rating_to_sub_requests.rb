class AddOptimalSkillRatingToSubRequests < ActiveRecord::Migration
  def change
    add_column(:sub_requests, :optimal_skill_rating, :float)
  end
end
