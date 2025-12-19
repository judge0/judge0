threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS', 5).presence || 5)
process_count = Integer(ENV.fetch('RAILS_SERVER_PROCESSES', 1).presence || 1)
threads threads_count, threads_count
workers process_count

port ENV.fetch('PORT', 2358)
environment ENV.fetch('RAILS_ENV', 'development')

plugin :tmp_restart