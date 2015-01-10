class SorceryCore < ActiveRecord::Migration
  def change
    add_column(:players, :crypted_password, :string)
    add_column(:players, :salt, :string)
    add_index :players, :email, unique: true
  end
end
