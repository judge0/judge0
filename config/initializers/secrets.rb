# Compatibility layer for Rails.application.secrets (removed in Rails 7.1+)
# This loads secrets.yml and makes it available via Rails.application.secrets
require 'yaml'
require 'erb'

class Rails::Application
  def secrets
    @secrets ||= begin
      secrets_file = Rails.root.join('config', 'secrets.yml')
      if secrets_file.exist?
        yaml = ERB.new(secrets_file.read).result
        all_secrets = YAML.safe_load(yaml, permitted_classes: [], permitted_symbols: [], aliases: true) || {}
        env_secrets = all_secrets[Rails.env] || {}
        ActiveSupport::OrderedOptions.new.tap do |options|
          env_secrets.each { |key, value| options[key.to_sym] = value }
        end
      else
        ActiveSupport::OrderedOptions.new
      end
    end
  end
end
