require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Judge0API
  class Application < Rails::Application
    config.api_only = true
    config.generators do |g|
      g.factory_girl test_framework: :rspec
    end

    config.active_job.queue_adapter = :resque

    config.middleware.insert_before 0, Rack::Cors do
      origins = []

      disallowed_origins = (ENV['DISALLOW_ORIGIN'].to_s.split - ENV['ALLOW_ORIGIN'].to_s.split).collect{ |s| s.gsub(".", "\\.") }.join("|")
      if disallowed_origins.present?
        origins.append(Regexp.new("^(?:(?!#{disallowed_origins}).)*$"))
      end

      # ALLOW_ORIGIN and DISALLOW_ORIGIN are mutually exclusive so this doesn't have any effect.
      origins += (ENV['ALLOW_ORIGIN'].presence || (origins.present? ? '' : '*')).split

      allow do
        origins origins
        resource '*', headers: :any, methods: :any
      end
    end
  end
end
