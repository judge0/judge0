module IsolateRunner
  MAX_WAIT_TIME_S = 600

  INITIAL_WAIT_TIME_S = 2
  NEXT_WAIT_TIME_S = 1
  WAIT_TIME_FACTOR_S = 0.5

  WAITING_STATUSES = [Status.queue.id, Status.process.id, nil]

  def self.perform_now(submission)
    IsolateRunner.perform_later(submission)

    submission_id = submission.id

    total_wait_time = 0
    (0..).each do |i|
      break if total_wait_time >= MAX_WAIT_TIME_S

      if i == 0 then
        wait_time = INITIAL_WAIT_TIME_S
      elsif i == 1 then
        wait_time = NEXT_WAIT_TIME_S
      else
        wait_time = WAIT_TIME_FACTOR_S * i
      end

      sleep(wait_time)

      total_wait_time += wait_time

      break if !WAITING_STATUSES.include?(Submission.where(id: submission_id).pluck(:status_id).first)
    end
  end

  def self.perform_later(submission)
    submission.update(status: Status.queue, queued_at: DateTime.now, queue_host: ENV["HOSTNAME"])
    IsolateJob.perform_later(submission.id)
  end
end
