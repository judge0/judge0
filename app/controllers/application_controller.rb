class ApplicationController < ActionController::API
  before_action :authenticate_request

  def system_info
    render json: SystemInfo.sys_info
  end

  def config_info
    render json: Config.config_info
  end

  def status
    queues = Hash.new { |h, k| h[k] = [] }
    Resque.workers.each do |worker|
      worker.queues.each do |queue|
        queues[queue] << worker
      end
    end

    json = []
    status = :ok
    Resque.queues.each do |queue|
      workers = queues[queue]
      json << {
        queue: queue,
        total: ENV["COUNT"].to_i,
        available: workers.count,
        idle: workers.count { |w| w.idle? },
        working: workers.count { |w| w.working? },
        paused: workers.count { |w| w.paused? },
        failed: workers.sum { |w| w.failed }
      }
      status = :internal_server_error if ENV["COUNT"].to_i != workers.count
    end

    render json: json, status: status
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
