class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :authorize_request, only: [:authorize]

  def system_info
    render json: SystemInfo.sys_info
  end

  def config_info
    render json: Config.config_info
  end

  def authenticate
    head :ok
  end

  def authorize
    head :ok
  end

  private

  def authenticate_request
    head :unauthorized if safe_compare(Rails.application.secrets.authn_token, Rails.application.secrets.authn_header)
  end

  def authorize_request
    head :forbidden unless Rails.application.secrets.authz_token.present?
    head :forbidden if safe_compare(Rails.application.secrets.authz_token, Rails.application.secrets.authz_header)
  end

  def safe_compare(token, header)
    return false unless token.present?
    provided_token = (request.headers[header] || params[header]).to_s
    token.split.each do |value|
      return false if ActiveSupport::SecurityUtils.secure_compare(value, provided_token)
    end
    true
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }
  end
end
