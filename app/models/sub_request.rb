class SubRequest < ActiveRecord::Base
  belongs_to :poster,
    :class_name => "::Player",
    :foreign_key => :poster_id
  belongs_to :sub,
  	:class_name => '::Player',
  	:foreign_key => :sub_id
  belongs_to :sport
  belongs_to :player_game
  belongs_to :city
  belongs_to :venue
  belongs_to :team
  belongs_to :opposing_team,
    :class_name => '::Team',
    :foreign_key => :opposing_team_id

  has_one :player_feedback
  has_one :division, :through => :team
  has_one :league, :through => :team

  scope :unfilled, lambda{ where(:player_game_id => nil) }
  scope :filled, lambda{ where('player_game_id is not null') }

  enum status: Status.all
  # enum skill_level: SkillLevel.all

  scope :is_waiting_for_sub, lambda{
    where(status: 0)
  }

  scope :upcoming, lambda { |time|
    where('start_time BETWEEN ? AND ?', time, time + 24.hours)
  }

  scope :upcoming_games, lambda {
    where('start_time > ?', Time.now)
  }

  scope :recently_ended, lambda{
    where('start_time BETWEEN ? AND ?', Time.now - 1.day, Time.now)
  }

  scope :past_games, lambda{ |player|
    where('sub_id = ? AND start_time < ?', player.id, Time.now)
  }

  scope :matches_player_sports, lambda{ |player_sports|
    conditions = []; query_params = []

    player_sports.map do |ps|
      conditions << '(sport_id = ? AND (skill_level BETWEEN ? AND ?) AND (gender = ? OR (gender = ? AND ?)))'
      query_params << [ps.sport_id, ps.skill_level - 1, ps.skill_level + 1, ps.player.sex, 'coed', ps.play_coed]
    end
    where('(' + conditions.join(" OR ") + ')', *query_params.flatten)
  }

  scope :coincides_with, lambda{ |availabilities|
    conditions = []; query_params = []

    availabilities.map do |a|
      conditions << "(day = ? AND (CAST(start_time as time) BETWEEN ? AND ?))"
      query_params << [a.day,
                       a.available_from.strftime("%H:%M:%S"),
                       a.available_to.strftime("%H:%M:%S")]
    end

    where('(' + conditions.join(" OR ") + ')', *query_params.flatten)
  }

  scope :takes_place_in, lambda{ |cities|
    where(city_id: cities.select('id').map(&:id))
  }

  scope :waiting_for_feedback, lambda{
    where(status: 2)
  }

  scope :does_not_include_teams, lambda{ |player|
    where.not(team_id: player.teams.pluck(:id))
  }

  scope :unique_requests, lambda{
    all.to_a.uniq {|sub| [sub.team_id,sub.start_time]}
  }

  scope :other_sports, lambda{ |sports|
    where.not(sport_id: sports.map(&:id)).where('start_time BETWEEN ? AND ?', Time.now, Time.now + 48.hours)
  }

  def is_waiting?
    self.status == 'open'
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
    time_to_game = (self.start_time - Time.zone.now)
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

  def get_compatible_players
    CompatibilityEngine.get_compatible_players(self)
  end

  private

    def _average_player_skill_rating
      player_ids = self.team.player_ids + self.opposing_team.player_ids

      PlayerSport.
        where(:sport_id => self.sport_id).
        where('player_id IN (?)', player_ids).
        select('skill_rating').map(&:skill_rating).
        mean
    end

    def _division_relative_skill_rating
      mean = self.division.sibling_divisions.map(&:skill_rating).mean
      return self[:skill_level] if mean.zero?
      (self.division.skill_rating / mean) * self[:skill_level]
    end

    def _league_relative_skill_rating
      mean = self.league.sibling_leagues.map(&:skill_rating).mean
      return self[:skill_level] if mean.zero?
      (self.league.skill_rating / mean) * self[:skill_level]
    end

end

