class Sport < ActiveRecord::Base
  has_many :leagues
  has_many :sub_requests
  has_many :player_sports
  has_many :players, :through => :player_sports
  has_many :games

  validates :name, :presence => true

  scope :team_based, lambda{ where(:team_sport => true) }
  scope :individual, lambda{ where(:team_sport => false) }
 

  def self.sports_with_ids
    sports = []
    Sport.all.each do |sport|
      sports << [sport.name.capitalize, sport.id]
    end
    sports
  end
end
