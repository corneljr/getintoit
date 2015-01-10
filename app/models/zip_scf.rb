class ZipScf < ActiveRecord::Base
  belongs_to :state

  validates :scf, :state_id, :presence => true
end
