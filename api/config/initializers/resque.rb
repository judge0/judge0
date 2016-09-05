uri = URI.parse("redis://#{ENV['JUDGE0API_REDIS_HOST']}:6379")
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :thread_safe => true)
