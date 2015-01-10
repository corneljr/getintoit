class Fsa < ActiveRecord::Base
  belongs_to :province
  belongs_to :city

  validates :label, :city_id, :province_id, :presence => true
end
