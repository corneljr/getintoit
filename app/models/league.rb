class League < ActiveRecord::Base
  include LeagueModules::FeedProcessing

  belongs_to :sport
  has_many :league_operating_cities,
    :class_name => 'LeagueOperatingCity',
    :foreign_key => :league_id
  has_many :cities,
    :class_name => 'City',
    :through => :league_operating_cities,
    :foreign_key => :league_id
  has_many :player_leagues, :inverse_of => :league
  has_many :players, :through => :player_leagues
  has_many :league_venues,
    :class_name => 'LeagueVenue',
    :foreign_key => :league_id
  has_many :venues,
    :through => :league_venues,
    :foreign_key => :league_id
  has_many :divisions
  has_many :games, :inverse_of => :league
  has_many :seasons
  has_many :teams

  validates :name, :presence => true

  before_save :set_skill_rating

  def sibling_leagues
    League.where(:sport_id => self.sport_id).
      where('id != ?', self.id)
  end

  def set_skill_rating
    if self.skill_rating.nil?
      self.skill_rating = self.sibling_leagues.map(&:skill_rating).mean
      self.skill_rating = 3.0 if self.skill_rating == 0.0
    end
  end

  def self.league_array
    array = []
    League.all.each do |team|
      array.push(team.name)
    end

    array.to_json
  end

end
