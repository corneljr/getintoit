class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name, :null => false
      t.boolean :team_sport, :null => false, :default => true
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end
  end
end
