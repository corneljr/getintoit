class PlayerCity < ActiveRecord::Base
  belongs_to :player
  belongs_to :city

  validates :player_id, :city_id, :presence => true
end
