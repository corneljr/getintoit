require 'memoist'

module LeagueModules::FeedProcessing
  extend Memoist

  # Returns the configuration data for this league and how their
  # data feeds can be processed to be merged into our database.
  #
  def feed_config
    config = YAML::load(
      File.open(::Rails.root.to_s + '/config/feed_processing.yml')
    )

    config[self.feed_config_name]
  end
  memoize :feed_config

  # The pre-processor class for this league, which allows us to
  # perform actions such as converting from XLS to CSV and other
  # preparatory actions before parsing takes place
  #
  def pre_processor
    begin
      "Feed::PreProcessors::#{self.feed_config_name}".classify.constantize
    rescue NameError
      Feed::PreProcessors::Base
    end
  end

  # The parser class for this league, which determines how to parse
  # the data feeds that they give us
  #
  def parser
    begin
      "Feed::Parsers::#{self.feed_config_name}".classify.constantize
    rescue NameError
      Feed::PreProcessors::Base
    end
  end

end
