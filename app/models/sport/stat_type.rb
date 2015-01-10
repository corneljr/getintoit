class Sport::StatType < ActiveRecord::Base
  belongs_to :sport

  validates :name, :sport_id, :presence => true
end
