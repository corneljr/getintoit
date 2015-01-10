class CreatePlayerSports < ActiveRecord::Migration
  def change
    create_table :player_sports do |t|
      t.integer :player_id
      t.integer :sport_id, :null => false
      t.boolean :deleted
      t.string :position
      t.integer :skill_level, :null => false, :default => 0, :limit => 4
      t.text :comments

      t.timestamps
    end

    add_index :player_sports, :player_id
    add_index :player_sports, [:sport_id, :skill_level]
  end
end
