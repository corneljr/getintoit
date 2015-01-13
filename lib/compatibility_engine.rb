class CompatibilityEngine
  # Skill within range
  # Availability includes gametime
  # League

  class << self

    # For individual calculations, to determine if a player
    # is a good fit for a game or not
    #
    # @param player [Player] the player to check against
    # @param game [Game] the game to be subbed into
    # @return [Boolean] whether the player could sub into
    #                   the game or not
    #
    def compute_compatibility(player, game)
      return false unless player.plays_at_level?(game.sport, game.skill_level)
      return false unless player.active_in?(game.city)
      return false unless player.available?(game.starts_at)
      true
    end

    # To query compatible games for a player
    #
    # @param player [Player] the player to get games for
    # @return [ActiveRecord::Relation] the games that player might like
    def get_compatible_games(player)
      games = SubRequest.
        near(player.address, player.availability_radius).
        is_waiting_for_sub.
        matches_player_sports(player.player_sports).
        coincides_with(player.availabilities).
        takes_place_in(player.cities).
        does_not_include_teams(player).
        unique_requests
    end

    # To query subs for a sub request
    # @param sub_request [SubRequest] the sub request to query
    #
    def get_compatible_players(sub_request)
      # Get all players
      players = Player.
        available_for(sub_request.start_time.in_time_zone(sub_request.city.timezone)).
        active_in(sub_request.city).
        plays_within_range(sub_request.sport, sub_request.optimal_skill_range).
        does_not_play_on_teams(sub_request)

      # Return the players in the order based on their weighted overall score
      # from review ratings - the ones that score highest based on our weighted
      # averages will be the ones that we present to the sub requester first.
      players.sort_by{ |p| -1 * p.weighted_overall_score }
    end

  end
end
