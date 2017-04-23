threads_count = (ENV['RAILS_MAX_THREADS'].presence || '5').to_i
threads threads_count, threads_count
port (ENV['PORT'].presence || '3000')
environment (ENV['RAILS_ENV'].presence || 'development')

plugin :tmp_restart