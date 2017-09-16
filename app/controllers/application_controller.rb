class ApplicationController < ActionController::API
  before_action :authenticate_request

  def system_info
    render json: SystemInfo.sys_info
  end

  def config_info
    render json: Config.config_info
  end

  private

  def authenticate_request
    return unless Rails.application.secrets.auth_token_value.present?
    auth_token_value = (request.headers[Rails.application.secrets.auth_token_key] || params[Rails.application.secrets.auth_token_key]).to_s
    Rails.application.secrets.auth_token_value.split.each do |value|
      return if ActiveSupport::SecurityUtils.secure_compare(value, auth_token_value)
    end
    head :unauthorized
  end
end
