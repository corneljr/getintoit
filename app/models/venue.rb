require 'country'

class Venue < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  has_many :sub_requests

  has_many :league_venues,
    :class_name => 'LeagueVenue',
    :foreign_key => :venue_id
  has_many :leagues, :through => :league_venues

  enum country: Country.all

  validates :name, :city_id, :province_id, :country, :address, :presence => true

  def self.information_array
		array = []
		Venue.all.each do |venue|
			hash = {} 
			hash[:value] = venue.name
			hash[:address] = venue.address
			array.push(hash)
		end

		array.to_json
	end  
end
