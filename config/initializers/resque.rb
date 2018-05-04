Resque.redis = Redis.new(host: ENV.fetch("REDIS_HOST"), port: ENV.fetch("REDIS_PORT"), thread_safe: true)
