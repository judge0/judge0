module IsolateRunner
  def self.perform_now(submission)
    submission.update(status: Status.queue, queued_at: DateTime.now)
    IsolateJob.perform_now(submission.id)
  end

  def self.perform_later(submission)
    submission.update(status: Status.queue, queued_at: DateTime.now)
    IsolateJob.perform_later(submission.id)
  end
end
