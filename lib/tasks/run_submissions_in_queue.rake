desc "Run all submission with status 'In Queue'."

namespace :judge0 do
  task :run_in_queue => :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    Submission.where(status_id: Status.queue).each do |s|
      if ARGV[1].to_s == "now"
        IsolateJob.perform_now(s.id)
      else
        IsolateJob.perform_later(s.id)
      end
    end
  end
end