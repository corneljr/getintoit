class AddOpponentTeamIdToSubRequests < ActiveRecord::Migration
  def change
    add_column(:sub_requests, :opposing_team_id, :integer)
  end
end
