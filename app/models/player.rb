require 'sorcery'

class Player < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :player_cities
  has_many :cities, :through => :player_cities
  has_many :player_leagues
  has_many :leagues, :through => :player_leagues
  has_many :player_sports
  has_many :sports, :through => :player_sports
  has_many :player_teams
  has_many :teams, :through => :player_teams
  has_many :availabilities,
    :class_name => '::Player::Availability',
    :foreign_key => :player_id

  has_many :sub_requests,
    :class_name => "::SubRequest",
    :foreign_key => :poster_id

  has_many :reviews,
    :class_name => "::Player::Feedback",
    :foreign_key => :player_id

  has_many :subs,
    :class_name => '::SubRequest',
    :foreign_key => :sub_id

  has_one :stats,
    :class_name => '::Player::Stat',
    :foreign_key => :player_id

  validates :first_name, :last_name, :email, :presence => true
  validates :email, :uniqueness => true
  validates :password, confirmation: true, if: :should_validate_password?
  validates :password_confirmation, presence: true, if: :should_validate_password?
  validate :_phone_number_or_email_required

  accepts_nested_attributes_for :player_sports,
    :allow_destroy => true,
    :reject_if => lambda {|a| a[:skill_rating].blank?}

  accepts_nested_attributes_for :availabilities,
    :allow_destroy => true,
    :reject_if => lambda {|a| a[:available_from].blank?}

  accepts_nested_attributes_for :player_teams,
    :allow_destroy => true,
    :reject_if => lambda {|a| a[:team_id].blank?}

  scope :active_in, lambda{ |city_id|
    joins(:player_cities).
    where('`player_cities`.`city_id` = :cid', :cid => city_id)
  }
  scope :plays, lambda{ |sport_id|
    joins(:player_sports).
    where('`player_sports`.`sport_id` = :sid', :sid => sport_id)
  }
  scope :plays_at_level, lambda{ |sport_id, skill_level|
    joins(:player_sports).
    where('`player_sports`.`sport_id` = :sid AND
           `player_sports`.`skill_level` = :skill',
          :sid => sport_id, :skill => ::PlayerSport.skill_levels[skill_level])
  }
  scope :plays_within_range, lambda{ |sport_id, skill_range|
    joins(:player_sports).
    where('`player_sports`.`sport_id` = :sid AND
           `player_sports`.`skill_rating` BETWEEN :low AND :high',
          :sid => sport_id, :low => skill_range.first, :high => skill_range.last)
  }
  scope :available_for, lambda{ |datetime|
    joins(:availabilities).
    where('`player_availabilities`.`day` = :day AND
           `player_availabilities`.`available_from` <= :time AND
           `player_availabilities`.`available_to` >= :time',
           :day => datetime.wday+1, :time => datetime.strftime("%H:%M:%S"))
  }
  scope :does_not_play_on_teams, lambda{ |sub_request|
    joins(:teams).
    where('`teams`.`id` NOT IN (?)', [sub_request.team_id, sub_request.opposing_team_id])
  }
  
  # Updates the average review score ratings of all players in the database
  # based on a computed average of data collected by the front-end
  #
  # @return [Integer] the number of rows updated
  def self.recompute_all_scores!
    # Done in raw SQL to save on query time
    averages = Player::Feedback.connection.select_all(
      "SELECT
         player_id,
         AVG(`fit_score`) AS avg_fit_score,
         AVG(`punctuality_score`) AS avg_punctuality_score,
         AVG(`personality_score`) AS avg_personality_score,
         AVG(`skill_score`) AS avg_skill_score,
         (AVG(`fit_score`) * #{Player::Feedback::FIT_WEIGHT} +
          AVG(`punctuality_score`) * #{Player::Feedback::PUNC_WEIGHT} +
          AVG(`personality_score`) * #{Player::Feedback::PERS_WEIGHT} +
          AVG(`skill_score`) * #{Player::Feedback::SKILL_WEIGHT}) AS `weighted_overall_score`
       FROM player_feedbacks"
    ).to_hash

    update_hash = {}

    averages.each do |hsh|
      update_hash[hsh["player_id"]] = hsh.except("player_id")
    end

    Player.update(update_hash.keys, update_hash.values)
  end

  # Whether or not this player plays the given sport
  #
  # @param sport [Sport] the sport to check against
  # @return [Boolean]
  def plays?(sport)
    self.player_sports.
      where(:sport_id => sport.id).
      present?
  end

  # See if a player plays a sport at a given level
  #
  # @param sport [Sport] the sport to query
  # @param skill_level [Symbol] the skill level from lib/skill_level.rb
  # @return [Boolean]
  def plays_at_level?(sport, skill_level)
    self.player_sports.
      where(:sport_id => sport.id).
      where(:skill_level => ::PlayerSport.skill_levels[skill_level]).
      present?
  end

  # Checks whether this player is available during the datetime
  # passed in (do they have any availabilities that match the
  # day and time)
  #
  # @param game_datetime [DateTime] the date/time of the game
  # @return [Boolean]
  def available?(game_datetime)
    self.availabilities.
      where(:day => game_datetime.wday).
      where('available_from <= ?', game_datetime.to_time).
      where('available_to >= ?', game_datetime.to_time).
      present?
  end

  # See if a player is active in a city or not (have they said they
  # would like to attend games in that city?)
  #
  # @param city [City] the city to check against
  # @return [Boolean]
  def active_in?(city)
    self.player_cities.
      where(:city_id => city.id).
      present?
  end

  # Add a city to a player's list based on that city's name.
  #
  # @param city_name [String] the name of the city to add
  def add_city(city_name='Toronto')
    city = City.find_by(name: city_name)
    self.cities << city
  end

  # Check if a player recently had a game that requires feedback
  #
  # @return [Boolean]
  def pending_feedback
    self.sub_requests.waiting_for_feedback.present?
  end

  # Convenience method for getting the skill rating for this player
  # for a certain sport
  #
  # @param [Sport] the sport to query
  # @return [Float] the rating for the sport
  def skill_rating_for_sport(sport)
    self.player_sports.where(:sport_id => sport.id).
      select('skill_rating').
      map(&:skill_rating).first
  end

  # Determine whether a player is a good fit for a sub request
  #
  # @param sub_request [SubRequest] the game to query against
  # @return [Boolean]
  def compatible_with?(sub_request)
    CompatibilityEngine.compute_compatibility(self, sub_request)
  end

  # Get all of the sub requests that this player fits all of the
  # requirements for and thus might be a good match for
  #
  # @return [Array<SubRequest>] SubRequests that this player is a candidate for
  def potential_sub_games
    CompatibilityEngine.get_compatible_games(self)
  end

  # Returns the weighted overall score (based on weights combined with the
  # fit_score, punctuality_score, etc. from reviews) to determine how a player
  # should be sorted if they match with a particular sub request.
  #
  # @return [Float] a floating point number representing a player's ranking
  #                 compared to other players with regard to review ratings
  def compute_weighted_overall_score
    (Player::Feedback::FIT_WEIGHT * avg_fit_score +
     Player::Feedback::PUNC_WEIGHT * avg_punctuality_score +
     Player::Feedback::SKILL_WEIGHT * avg_skill_score +
     Player::Feedback::PERS_WEIGHT * avg_personality_score)
  end

  # Returns all SubRequests that this player either requested a sub for, or
  # participated in by subbing into the game.
  #
  # @return [Array<SubRequest>] the requests that the player was involved with
  def past_games
    SubRequest.past_games(self)
  end

  def upcoming_subs
    self.subs.upcoming_games
  end

  # Returns an array of arrays with all of the teams that this player is a
  # part of, each element being the name and ID of that team.
  #
  # @return [Array<Array<String, Integer>>] an array of team names and IDs
  def teams_with_ids
    team_array = []

    self.teams.all.each do |team|
      team_array << [team.name, team.id]
    end

    team_array
  end

  # XXX bcone - this should probably be in a helper since it's only used for
  # display, as far as I can tell.
  # Collects all of the sports that a player belongs to, and organizes them
  # into a hash for use by the front-end
  #
  # @param user_id [Integer] the ID of the player to prepare sports for
  # @return [String] a json string specifying the sports for this player
  def self.prepare_sports(user_id)
    sports = []
    player = Player.find(user_id)

    player.player_sports.each do |player_sport|
      hash = {}
      hash[:sport] = player_sport.sport.name.split(' ').join('_')
      hash[:sport_id] = player_sport.sport.id
      hash[:skill] = player_sport.skill_level
      hash[:play_coed] = player_sport.play_coed
      sports.push(hash)
    end

    sports.to_json
  end

  # XXX bcone - this should probably be in a helper since it's only used for
  # display, as far as I can tell.
  # Collects all of the availabilities that this player has to determine when
  # they are available to play games for display on the front-end.
  #
  # @return [String] json string specifying availability
  def self.prepare_availabilities(user_id)
    days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun']
    avails = []
    player = Player.find(user_id)

    player.availabilities.each do |avail|
      hash = {}
      hash[:day] = days[avail.day - 1]
      hash[:section] = Availability.section(avail.available_from.strftime("%H"))
      hash[:from] = avail.available_from.strftime("%H:%M:%S")
      hash[:to] = avail.available_to.strftime("%H:%M:%S")
      avails.push(hash)
    end

    avails.to_json
  end

  # Enable this customer for use with the Stripe API.
  #
  # @param token [String] the token representing this user's credit card
  # @return [Boolean] whether the Stripe customer_id was successfully stored
  #                   with the player.
  def create_stripe_customer(token)
    Stripe.api_key = 'sk_test_xvxhe0dUKfbGI2MJOWOg1N8j'

    begin 
      customer = Stripe::Customer.create(
        card: token,
        description: self.email
      )

      self.update(stripe_customer_id: customer.id)
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to sub_request_path
    end
  end

  # XXX bcone -
  # You probably want the amount to be explicit here, don't default to a particular
  # charge amount as this can get extremely dangerous when you start using stripe
  # more often throughout the app.
  # Charges a user's credit card using Stripe
  #
  # @param amount [Float] the amount to charge the user's credit card
  # @return [Stripe::Charge] the charge to their credit card
  def create_charge(amount)
    raise 'No amount specified for credit card charge!' if amount.nil?
    Stripe.api_key = 'sk_test_xvxhe0dUKfbGI2MJOWOg1N8j'

    charge = Stripe::Charge.create(
      amount: amount,
      currency: 'cad',
      customer: self.stripe_customer_id
    )

    charge
  end

  def should_validate_password?
    new_record?
  end

private
  # For any player, re-caches the average values of all of the scores that a
  # player has received as feedback throughout their time in the Subzie system
  #
  def recompute_average_scores!
    # Done in raw SQL to save on query time
    averages = Player::Feedback.connection.select_all(
      "SELECT
         AVG(`fit_score`) AS avg_fit_score,
         AVG(`punctuality_score`) AS avg_punctuality_score,
         AVG(`personality_score`) AS avg_personality_score,
         AVG(`skill_score`) AS avg_skill_score,
         (AVG(`fit_score`) * #{Player::Feedback::FIT_WEIGHT} +
          AVG(`punctuality_score`) * #{Player::Feedback::PUNC_WEIGHT} +
          AVG(`personality_score`) * #{Player::Feedback::PERS_WEIGHT} +
          AVG(`skill_score`) * #{Player::Feedback::SKILL_WEIGHT}) AS `weighted_overall_score`
       FROM player_feedbacks
       WHERE player_id = #{self.id}"
    ).first.to_hash

    self.update_attributes!(averages)
  end

  private

    def _phone_number_or_email_required
      if self.phone_number.nil? && self.email.nil?
        errors.add(:phone_number, "phone number or email required")
      end
    end

end
