module Feed
  class Processor

    attr_reader :results, :errors

    def initialize( league, data_feed_file, options={} )
      @league         = league
      @data_feed_file = data_feed_file
      @results = {:players_created => 0,
                  :players_updated => 0,
                  :players_invalid => 0,
                  :teams_created   => 0,
                  :teams_updated   => 0,
                  :teams_invalid   => 0}
      @errors = []
      @options = options
      @logger = options[:logger] || Logger.new(STDOUT)
    end

    def start
      @logger.debug("l #{@league.id}, dff #{@data_feed_file}: normalizing") if @logger

      # Probably want to add some opening/closing/uploading of
      # output files here once S3 is a go
      _pre_process
      _parse
      _process

      @logger.debug("l #{@league.id}, dff #{@data_feed_file}: finished") if @logger
    rescue Exception => e
      _output_exception(e, 'general')
    end

    def errored?
      !@errors.blank?
    end

    private

      # Pre-processes the original data feed by applying conversions to the
      # file in its entirety
      def _pre_process
        @pre_processor = @league.pre_processor.new(@data_feed_file).start

        if @pre_processor.errored?
          _output_errors(@pre_processor, 'preprocessing')
        else
          _output_success(@pre_processor, 'preprocessing')
        end
      end

      # Parses the pre-processed data feed and creates empty objects
      # for processing (such as FlyerItem, FlyerItemReview, etc.)
      def _parse
        unless errored?
          @players = @league.parser.new(
            @pre_processor.output_file,
            @league.feed_config
          ).start

          _output_parse_success('parsing')
        end
      rescue Exception => e
        _output_exception(e, 'parsing')
      end

      def _process
        @players.each do |player|
          if player.valid?
            match = Player.
              where(:name => player.name).
              where(:email => player.email).
              first

            match ||= Player.
              where(:name => player.name).
              where(:phone_number => player.phone_number).
              first

            if match
              @results[:players_updated] += 1
            else
              @results[:players_created] += 1
            end

            # If no match from our database, we will use the
            # unsaved player object that came out of the parsing
            # step and save! it into our database
            match ||= player

            # Add the player record to our database
            match.save!

            # Add the player's association with the league whose
            # data feed this is
            match.leagues.push(@league)

            unless player.potential_teams.nil?
              player.potential_teams.each do |team|
                if team.valid?
                  match = @league.teams.
                    where(:name => team.name).
                    first

                  if match
                    @results[:teams_updated] += 1
                  else
                    @results[:teams_created] += 1
                  end

                  match ||= team
                  match.save!
                else
                  @results[:teams_invalid] += 1
                end
              end
            end
          else
            @results[:players_invalid] += 1
          end
        end
      end

      def _output_exception( exception, error_type )
        @errors.push(exception)
        @logger.error("l #{@league.id}, dff #{@data_feed_file}: #{error_type} error") if @logger
        @logger.error(exception.message) if @logger
        @logger.backtrace(exception.backtrace) if @logger
        raise exception
      end

      def _output_errors( object, error_type )
        @errors += object.errors
        @logger.error("l #{@league.id}, dff #{@data_feed_file}: #{error_type} error") if @logger
        object.report_errors(@logger)
        raise "#{error_type} error: #{object.errors.inspect}"
      end

      def _output_success( object, success_type )
        @logger.info("l #{@league.id}, dff #{@data_feed_file}: #{success_type} successful") if @logger
        object.report_success(@logger)
      end

  end
end
