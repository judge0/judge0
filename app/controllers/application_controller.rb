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
    return unless Rails.application.secrets.authn_token.present?
    authn_token = (request.headers[Rails.application.secrets.authn_header] || params[Rails.application.secrets.authn_header]).to_s
    Rails.application.secrets.authn_token.split.each do |value|
      return if ActiveSupport::SecurityUtils.secure_compare(value, authn_token)
    end
    head :unauthorized
  end
end
