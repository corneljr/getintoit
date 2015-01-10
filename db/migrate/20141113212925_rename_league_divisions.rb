class RenameLeagueDivisions < ActiveRecord::Migration
  def change
  	rename_table :league_divisions, :divisions
  end
end
