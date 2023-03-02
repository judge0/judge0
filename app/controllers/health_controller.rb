class HealthController < ApplicationController
  def workers
    Resque.workers.first.try(:prune_dead_workers) if params[:prune_dead_workers] == "true"

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
        size: Resque.size(queue),
        available: workers.count,
        idle: workers.count { |w| w.idle? },
        working: workers.count { |w| w.working? },
        paused: workers.count { |w| w.paused? }
      }
    end

    render json: json
  end
end
