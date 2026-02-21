desc "Run all submission with status 'In Queue'."

namespace :judge0 do
  task :run_in_queue => :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    Submission.where(status_id: Status.queue).each do |s|
      if ARGV[1].to_s == "now"
        IsolateRunner.perform_now(s)
      else
        IsolateRunner.perform_later(s)
      end
    end
  end
end
