class Game < ActiveRecord::Base
  belongs_to :player1,
    :class_name => 'Player',
    :foreign_key => :player1_id
  belongs_to :player2,
    :class_name => 'Player',
    :foreign_key => :player2_id
  belongs_to :team1,
    :class_name => 'Team',
    :foreign_key => :team1_id
  belongs_to :team2,
    :class_name => 'Team',
    :foreign_key => :team2_id
  belongs_to :sport, :inverse_of => :games
  belongs_to :league, :inverse_of => :games
  belongs_to :city, :inverse_of => :games
  belongs_to :venue, :inverse_of => :games
  belongs_to :division,
    :class_name => "LeagueDivision",
    :inverse_of => :games
  belongs_to :season, :inverse_of => :games

  has_many :player_games, :inverse_of => :game
  has_many :players, :through => :player_games
  has_many :sub_requests

  validates :sport_id, :league_id, :city_id, :presence => true
  validates :venue_id, :starts_at, :finishes_at, :presence => true
  validates :score1, :score2, :presence => true
  validates :optimal_skill_rating, :presence => true
  validate :_must_have_either_players_or_teams

  enum skill_level: SkillLevel.all

  scope :matches_player_sports, lambda{ |player_sports|
    conditions = []; query_params = []
    player_sports.map do |ps|
      conditions << '(`games`.`sport_id` = ? AND `games`.`skill_level` = ?)'
      query_params << [ps.sport_id, Game.skill_levels[ps.skill_level]]
    end

    where('(' + conditions.join(" OR ") + ')', *query_params.flatten)
  }

  # http://stackoverflow.com/questions/2523286/mysql-convert-tz will help
  # sysadmin set up the time zone keystrings - we can store these directly
  # with the cities that the user chooses to operate in, as well as with
  # the players themselves.
  scope :coincides_with, lambda{ |availabilities|
    conditions = []; query_params = []

    availabilities.map do |a|
      conditions << "(DAYOFWEEK(CONVERT_TZ(`games`.`starts_at`, 'UTC', `cities`.`timezone`)) = ? AND
                     TIME(CONVERT_TZ(`games`.`starts_at`, 'UTC', `cities`.`timezone`)) BETWEEN ? AND ?)"
      query_params << [a.day,
                       a.available_from.strftime("%H:%M:%S"),
                       a.available_to.strftime("%H:%M:%S")]
    end

    joins(:city).where('(' + conditions.join(" OR ") + ')', *query_params.flatten)
  }

  scope :takes_place_in, lambda{ |cities|
    where('`games`.`city_id` IN (?)', cities.select('id').map(&:id))
  }

  # Use this for getting all games that were played by
  # a specific team (for team sports)
  def self.by_team(team_id)
    where('team1_id = :tid OR team2_id = :tid', :tid => team_id)
  end

  # Use this for getting all games that were played by
  # a specific player (for individual sports)
  def self.by_player(player_id)
    where('player1_id = :pid OR player2_id = :pid', :pid => player_id)
  end

  # Sets the optimal skill rating so that we know what the ideal
  # skill level of a player joining this game would be
  def set_optimal_skill_rating
    self.optimal_skill_rating = \
      [self[:skill_level].to_f,
       _average_player_skill_rating,
       _division_relative_skill_rating,
       _league_relative_skill_rating].mean

    self.save!
  end

  # Gets the skill range that should be optimal for this game to
  # have the best possible subbing experience - if a sub is exactly
  # at the optimal_skill_rating, then they'll likely be the best
  # possible fit.
  def optimal_skill_range
    if self.optimal_skill_rating.nil? || self.optimal_skill_rating.zero?
      set_optimal_skill_rating
    end

    # As the game time gets closer, we should expand the range
    # that we send to plays_within_range
    time_to_game = (self.starts_at - Time.zone.now)
    skill_increment =
      case
        when time_to_game >= 7.days
          0.3
        when time_to_game >= 24.hours
          0.5
        when time_to_game >= 12.hours
          0.6
        when time_to_game >= 2.hours
          0.8
        else
          1.0
      end

    [self.optimal_skill_rating - skill_increment,
     self.optimal_skill_rating + skill_increment]
  end

  # Get any players who could potentially sub into this game based
  # on their availability, skill level, and the cities that they
  # operate in.
  #
  def potential_sub_players
    CompatibilityEngine.get_compatible_players(self)
  end

  private

    def _must_have_either_players_or_teams
      if self.sport.team_sport?
        unless self.team1_id.present? && self.team2_id.present?
          errors.add(:team1_id, "game must have two teams")
        end
      else
        unless self.player1_id.present? && self.player2_id.present?
          errors.add(:team2_id, "game must have two players")
        end
      end
    end

    def _average_player_skill_rating
      player_ids = self.player_games.
        select('player_id').
        map(&:player_id).
        join(',')

      query = <<-SQL
        SELECT
          skill_rating
        FROM player_sports
        WHERE
          sport_id = #{self.sport_id} AND
          player_id IN (#{player_ids})
      SQL

      Game.connection.execute(query).to_a.flatten.mean
    end

    def _division_relative_skill_rating
      mean = self.division.sibling_divisions.map(&:skill_rating).mean
      return self[:skill_level] if mean.zero?
      (self.division.skill_rating / mean) * self[:skill_level]
    end

    def _league_relative_skill_rating
      mean = self.league.sibling_leagues.map(&:skill_rating).mean
      return self[:skill_level] if mean.zero?
      puts "league mean: #{mean}"
      (self.league.skill_rating / mean) * self[:skill_level]
    end

end
