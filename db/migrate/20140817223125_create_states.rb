class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name, :null => false
      t.string :abbreviation, :null => false, :limit => 2

      t.timestamps
    end

    add_index :states, :name, :unique => true
  end
end
