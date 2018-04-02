Resque.redis = Redis.new(host: ENV.fetch("REDIS_HOST"), port: 6379, thread_safe: true)
