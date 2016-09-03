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

    ActiveModelSerializers.config.adapter = :json_api
  end
end
