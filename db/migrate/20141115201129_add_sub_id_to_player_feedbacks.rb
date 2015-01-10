class AddSubIdToPlayerFeedbacks < ActiveRecord::Migration
  def change
  	remove_column :player_feedbacks, :game_id
  end
end
