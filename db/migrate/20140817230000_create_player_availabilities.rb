class CreatePlayerAvailabilities < ActiveRecord::Migration
  def change
    create_table :player_availabilities do |t|
      t.integer :player_id
      t.integer :day, :null => false
      t.time :available_from, :null => false
      t.time :available_to, :null => false

      t.timestamps
    end

    add_index :player_availabilities, :player_id
    add_index :player_availabilities, [:day, :available_from, :available_to],
      :name => "availability_search_index"
  end
end
