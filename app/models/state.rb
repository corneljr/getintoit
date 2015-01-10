class State < ActiveRecord::Base
  has_many :zip_scfs, :inverse_of => :state
  has_many :zip_codes, :inverse_of => :state
  has_many :cities, :as => :region

  validates :name, :abbreviation, :presence => true
end
