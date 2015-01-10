require 'country'

class City < ActiveRecord::Base
  belongs_to :region, :polymorphic => true
  has_many :sub_requests, :inverse_of => :city
  has_many :venues
  has_many :games

  has_many :league_operating_cities,
    :class_name => 'LeagueOperatingCity',
    :foreign_key => :city_id
  has_many :leagues,
    :class_name => 'League',
    :through => :league_operating_cities,
    :foreign_key => :city_id

  enum country: Country.all

  validates :country, :region_id, :region_type, :name, :presence => true
end
