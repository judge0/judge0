threads_count = ENV.fetch("RAILS_MAX_THREADS") 
threads threads_count, threads_count
port ENV.fetch("PORT")
environment ENV.fetch("RAILS_ENV")

plugin :tmp_restart