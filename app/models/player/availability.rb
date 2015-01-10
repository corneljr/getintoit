class Player::Availability < ActiveRecord::Base
  belongs_to :player, :inverse_of => :availabilities

  validates :day, :available_from, :available_to, :presence => true

   TIMES = {
  	morning: ['6:00:00','12:00:01'],
  	afternoon: ['10:59:59','17:00:01'],
  	evening: ['15:59:59','23:59:00']
  }

  DAYS = {
  	mon: 1,
  	tue: 2,
  	wed: 3,
  	thu: 4,
  	fri: 5,
  	sat: 6,
  	sun: 7
  }

  def self.section(time)
    if time == '06'
      return 'morning'
    elsif time == '10'
      return 'afternoon'
    else 
      return 'evening'
    end
  end
end
