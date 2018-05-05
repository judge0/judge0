class HealthController < ApplicationController
  def workers
    queues = Hash.new{ |h, k| h[k] = [] }
    Resque.workers.each do |worker|
      worker.queues.each do |queue|
        queues[queue] << worker
      end
    end

    json = []
    status = :ok
    Resque.queues.each do |queue|
      workers        = queues[queue]
      per_instance   = ENV.fetch("COUNT").to_i
      available      = workers.count
      idle           = workers.count{ |w| w.idle? }
      working        = workers.count{ |w| w.working? }
      processed_jobs = workers.sum{ |w| w.processed }
      failed_jobs    = workers.sum  { |w| w.failed }

      json << {
        queue:          queue,
        per_instance:   per_instance,
        available:      available,
        idle:           idle,
        working:        working,
        processed_jobs: processed_jobs,
        failed_jobs:    failed_jobs
      }

      status = :internal_server_error if per_instance > available
    end

    render json: json, status: status
  end
end
