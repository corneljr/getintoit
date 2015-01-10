class LeagueVenue < ActiveRecord::Base
  belongs_to :league
  belongs_to :venue

  validates :league_id, :venue_id, :presence => true
end
