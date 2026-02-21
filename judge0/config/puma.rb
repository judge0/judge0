threads_count = Integer(ENV['RAILS_MAX_THREADS'])
process_count = Integer(ENV['RAILS_SERVER_PROCESSES'])
threads threads_count, threads_count
workers process_count

port ENV['PORT']
environment ENV['RAILS_ENV']

plugin :tmp_restart