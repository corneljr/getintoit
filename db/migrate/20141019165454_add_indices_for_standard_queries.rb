class AddIndicesForStandardQueries < ActiveRecord::Migration
  def change
    #add_index :fsas, :city_id
    #add_index :player_games, :league_id
    #add_index :player_sports, :player_id
    # add_index :player_sports, [:sport_id, :skill_level]
    add_index :zip_scfs, :state_id
    add_index :zip_scfs, :scf
  end
end
