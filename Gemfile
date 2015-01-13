source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Bulk data inserts using ActiveRecord
gem "activerecord-import", "~> 0.5.0"
# MySQL
#gem "mysql2",              "~> 0.3.16"
gem 'pg'
# AWS
# General cloud services library
gem "fog",       "~> 1.23.0"
# Library for generating unique UUIDs
gem "uuidtools", "2.1.5"
#stripe
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
# DynamoDB interaction
# gem "dynamoid", "~> 0.7.1"
gem 'jquery-datetimepicker-rails'
gem 'jquery-ui-rails'
#whenever gem for scheduling cron jobs
gem 'whenever', require: false
# Asynchronous processing
# Basic delayed job - asynchronously execute long tasks in the background
gem "delayed_job",  "~> 4.0.2"
# ActiveRecord backend for DelayedJob
gem "delayed_job_active_record", "~> 4.0.1"
#to start delayed jobs automaticall
gem 'daemons'
# Use a "translations" table to localize arbitrary fields in an ActiveRecord
# adds the "translates" method to models
gem "globalize",   "~> 4.0.2"
gem 'cocoon'
# Simple interface for HTTP requests
gem "httparty",     "~> 0.13.1"
# XML parsing library
gem "libxml-ruby",  "~> 2.7.0"
# Helpers for pagination in views
gem 'will_paginate'
# Wishabi-developed library for jQuery UI helper methods
gem 'jqr-helpers', '1.0.54'
# Automate website interaction - used to access pages and manage cookies etc. in flyer verification
gem "mechanize",    "~> 2.6.0"
# Caches results of database methods
gem "memoist",      "~> 0.10.0"
# ImageMagick wrapper
gem "mini_magick",  "~> 3.8.0"
# HTML and XML reader and parser
gem "nokogiri",     "~> 1.6.3.1"
# Multi-provider authentication - used for user management
gem "omniauth",     "~> 1.2.2"
# Used for easy user-authentication setup
gem "sorcery",      "~> 0.8.6"
gem "oauth",        "~> 0.4.7"
gem "oauth2",       "~> 0.9.4"
# Uses a table of global key/value pairs for settings (used for zip code updating)
gem "rails-settings", "~> 1.0.0"
gem "rails-settings-cached", "~> 0.4.1"
# Used for sending notifications to mobile devices
gem 'rpush', "~> 1.0.0"
# Use figaro to handle api keys
gem 'figaro'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0.beta1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

gem 'font-awesome-rails'
gem 'bourbon'
gem 'neat'
gem 'geocoder'

group :development do
  # Annotate models on migrate
  gem 'annotate', "~> 2.6.5"
  # Better error reporting on a crash, including source code highlighting,
  # variable inspection etc.
  # gem 'better_errors', '~> 1.1.0'
  # For better_errors - REPL etc.
  gem 'binding_of_caller', ' ~> 0.7.2'
  # Command-line debugger.
  # gem "debugger"
  # Needed for YARD
  gem "redcarpet", "~> 3.1.2", :require => false
  # YARD documentation - https://github.com/lsegal/yard
  gem "yard", "~> 0.8.7.4", :require => false
  # YARD for ActiveRecord - attributes etc.
  gem "yard-activerecord", "~> 0.0.11", :require => false
  # YARD for Rails - attr_accessor etc.
  gem "yard-rails", "~> 0.3.0", :require => false
  gem 'pry'
  gem 'pry-byebug'
end

group :development, :test, :testing do
  # Run RSpec tests with Rails and Spork
  gem "rspec-rails", "~> 3.0.2"
  # "Distributed" Ruby server allowing for fast RSpec execution
  gem "spork-rails", "~> 4.0.0"
  # Spec gem to mock the current time, allowing to test things like updated_at comparisons.
  gem "timecop", "~> 0.7.1"
  # Mock objects with FactoryGirl
  gem "factory_girl_rails", "~> 4.4.1"
  # Compare test result string and display the differences
end
