class CreateSubRequests < ActiveRecord::Migration
  def change
    create_table :sub_requests do |t|
      t.integer :game_id, :null => false
      t.integer :poster_id, :null => false
      t.integer :team_id, :null => false
      t.integer :player_game_id

      t.timestamps
    end

    add_index :sub_requests, :game_id
    add_index :sub_requests, :poster_id
    add_index :sub_requests, :team_id
  end
end
