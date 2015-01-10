class ZipCode < ActiveRecord::Base
  belongs_to :state
  belongs_to :city

  validates :zip_code, :state_id, :presence => true
end
