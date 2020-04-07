Resque.redis = Redis.new(
  host:     ENV["REDIS_HOST"],
  port:     ENV["REDIS_PORT"],
  password: ENV["REDIS_PASSWORD"],
  thread_safe: true
)
