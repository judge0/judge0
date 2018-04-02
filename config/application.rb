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
    config.before_initialize do
      config.api = config_for(:configuration).deep_symbolize_keys
    end

    config.api_only = true

    config.active_job.queue_adapter = :resque

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV.fetch("ALLOW_ORIGIN")
        resource "*", headers: :any, methods: :any
      end
    end

    config.after_initialize do
      puts "Running Judge0 API with configuration settings:"
      puts Rails.configuration.api.collect{ |k, v| "#{k.upcase}: #{v}" }.join("\n")
    end
  end
end
