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
      allow do
        origins Rails.env.development? ? '*' : (ENV['ALLOW_ORIGIN'].presence || '*').split
        resource '*', headers: :any, methods: :any
      end
    end

    config.after_initialize do
      puts "Running Judge0 API with configuration settings:"
      puts Config.config_info.collect{ |k, v| "#{k.upcase}: #{v}" }.join("\n")
    end
  end
end
