class AddFeedConfigNameToLeagues < ActiveRecord::Migration
  def change
    add_column(:leagues, :feed_config_name, :string)
  end
end
