class Province < ActiveRecord::Base
  has_many :cities, :as => :region
  has_many :fsas, :inverse_of => :province
  has_many :postal_codes, :inverse_of => :province

  validates :name, :abbreviation, :presence => true
end
