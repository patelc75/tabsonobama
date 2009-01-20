
# Be sure to restart your server when you modify this file
# This is a test of github post commit hook  
# Uncomment below to force Rails into production mode when

# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
   config.frameworks -= [ :active_resource ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the <tt>:lib</tt> option for libraries, where the Gem name (<em>sqlite3-ruby</em>) differs from the file itself (_sqlite3_)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "capistrano-ext", :lib => "capistrano"
  # config.gem 'rubyist-aasm', :lib => 'aasm', :source => 'http://gems.github.com', :version => '2.0.2'
  # config.gem 'mislav-will_paginate', :version => '2.3.6', :lib => 'will_paginate', :source => 'http://gems.github.com'
  
  # These cause problems with irb. Left in for reference
  # config.gem 'rspec-rails', :lib => 'spec/rails', :version => '1.1.11'
  # config.gem 'rspec', :lib => 'spec', :version => '1.1.11'
  
  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
 #config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_bort_session',
    :secret      => 'a3e2a51a371bb964a4250c21f8d083f9ddb224d455171dcba55518e74af43366e52e3f239773f90aed0ab6caf6554f051504ce7232599d066150dbabff0f1654'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  config.active_record.observers = :user_observer
end

# recaptcha gem constants
# gem install --source http://www.loonsoft.com/recaptcha/pkg/ recaptcha
RCC_PUB  = '6LfRqgQAAAAAALWpxhD_Qt13QBD_pPFyISEzTnhu'
RCC_PRIV = '6LfRqgQAAAAAAOMNBL1_vyglxaHyPVqjlN9ItX_w'


module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Rated
      module RateMethods

# Rate the object with or without a rater - create new or update as needed
#
# * <tt>value</tt> - the value to rate by, if a rating range was specified will be checked that it is in range
# * <tt>rater</tt> - an object of the rater class. Must be valid and with an id to be used.
#                    If the acts_as_rated was passed :with_rater => false, this parameter is not required
        def rate value, rater = nil
          # Sanity checks for the parameters
          rating_class = acts_as_rated_options[:rating_class].constantize
          with_rater = rating_class.column_names.include? "rater_id"
          raise RateError, "rating with no rater cannot accept a rater as a parameter" if !with_rater && !rater.nil?
          if with_rater && !(acts_as_rated_options[:rater_class].constantize === rater)
            raise RateError, "the rater object must be the one used when defining acts_as_rated (or a descendent of it). other objects are not acceptable"
          end
          raise RateError, "rating with rater must receive a rater as parameter" if with_rater && (rater.nil? || rater.id.nil?)
          r = with_rater ? ratings.find(:first, :conditions => ['rater_id = ?', rater.id]) : nil
          raise RateError, "value is out of range!" unless acts_as_rated_options[:rating_range].nil? || acts_as_rated_options[:rating_range] === value
  
          # Find the place to store the rating statistics if any...
          # Take care of the case of a separate statistics table
          unless acts_as_rated_options[:stats_class].nil? || @rating_statistic.class.to_s == acts_as_rated_options[:stats_class]
            self.rating_statistic = acts_as_rated_options[:stats_class].constantize.new    
          end
          target = self if attributes.has_key? 'rating_total'
          target ||= self.rating_statistic if acts_as_rated_options[:stats_class]
          rating_class.transaction do
            # if r.nil?
            rate = rating_class.new
            rate.rater_id = rater.id if with_rater
            if target
              target.rating_count = (target.rating_count || 0) + 1 
              target.rating_total = (target.rating_total || 0) + value
              target.rating_avg = target.rating_total.to_f / target.rating_count
            end
            ratings << rate
            # else
            #              rate = r
            #              if target
            #                target.rating_total += value - rate.rating # Update the total rating with the new one
            #                target.rating_avg = target.rating_total.to_f / target.rating_count
            #              end
            #            end
    
            # Remove the actual ratings table entry
            rate.rating = value
            if !new_record?
              rate.save
              target.save if target
            end
          end
        end
      end
    end
  end
end