class AddGenderToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :gender, :string
  end
end
