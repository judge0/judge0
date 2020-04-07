threads_count = ENV['RAILS_MAX_THREADS']
threads threads_count, threads_count

port ENV['PORT']
environment ENV['RAILS_ENV']

plugin :tmp_restart