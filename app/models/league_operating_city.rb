class LeagueOperatingCity < ActiveRecord::Base
  belongs_to :league
  belongs_to :city

  validates :league_id, :city_id, :presence => true
end
