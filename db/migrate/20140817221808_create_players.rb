class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, :null => false
      t.string :username, :null => false
      t.string :email
      t.string :phone_number
      t.float :availability_radius, :null => false, :default => 30.0
      t.text :regions
      t.integer :num_games, :null => false, :default => 0
      t.integer :num_leagues, :null => false, :default => 0
      t.integer :num_subs, :null => false, :default => 0
      t.boolean :deleted, :null => false, :default => false

      t.timestamps
    end

    add_index :players, :username, :unique => true
  end
end
