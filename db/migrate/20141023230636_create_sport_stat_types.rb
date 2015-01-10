class CreateSportStatTypes < ActiveRecord::Migration
  def change
    create_table :sport_stat_types do |t|
      t.integer :sport_id
      t.string :name

      t.timestamps
    end

    add_index :sport_stat_types, :sport_id
  end
end
