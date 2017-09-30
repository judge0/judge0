class HealthController < ApplicationController
  def workers
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
end