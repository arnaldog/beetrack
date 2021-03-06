require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Beetrack
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.log_level = :debug
    config.log_tags = [:subdomain, :uuid]

    config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

    config.cache_store = :redis_store, ENV['CACHE_URL'],
        {namespace: 'drkiq::cache'}

    config.active_job.queue_adapter = :sidekiq

    config.middleware.insert_before(Rack::Runtime, Rack::ReverseProxy) do
      reverse_proxy_options preserve_host: true
      reverse_proxy '/geoserver', 'http://geoserver:8080/geoserver'
    end

  end
end
