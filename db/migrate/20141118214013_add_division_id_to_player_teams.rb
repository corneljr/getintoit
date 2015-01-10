class AddDivisionIdToPlayerTeams < ActiveRecord::Migration
  def change
  	add_column :player_teams, :division_id, :integer, null: false
  end
end
