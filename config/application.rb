require_relative 'boot'

require 'rails/all'

require 'application_insights'
require 'pry'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.middleware.use ApplicationInsights::Rack::TrackRequest, 'a056a552-5c5a-42e5-bf48-121a6432fae3', 1
    
    config.log_level = :info
    config.logger = ActFluentLoggerRails::Logger.new

    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Json.new
  end
end
