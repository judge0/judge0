uri = URI.parse("redis://#{ENV['REDIS_HOST']}:6379")
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :thread_safe => true)
