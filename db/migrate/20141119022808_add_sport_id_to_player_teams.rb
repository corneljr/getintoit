class AddSportIdToPlayerTeams < ActiveRecord::Migration
  def change
  	add_column :player_teams, :sport_id, :integer
  end
end
