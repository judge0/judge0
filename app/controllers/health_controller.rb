class HealthController < ApplicationController
  def workers
    queues = Hash.new { |h, k| h[k] = [] }
    Resque.workers.each do |worker|
      worker.queues.each do |queue|
        queues[queue] << worker
      end
    end

    json = []
    Resque.queues.each do |queue|
      workers = queues[queue]
      json << {
        queue: queue,
        available: workers.count,
        idle: workers.count { |w| w.idle? },
        working: workers.count { |w| w.working? },
        paused: workers.count { |w| w.paused? },
        failed: workers.sum { |w| w.failed }
      }
    end

    render json: json
  end
end