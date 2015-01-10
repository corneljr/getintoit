class PostalCode < ActiveRecord::Base
  belongs_to :province
  belongs_to :city

  validates :province_id, :city_id, :label, :presence => true
end
