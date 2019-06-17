Resque.redis = Redis.new(
  host:     ENV["REDIS_HOST"].presence || "localhost",
  port:     ENV["REDIS_PORT"].presence || 6379,
  password: ENV["REDIS_PASSWORD"],
  thread_safe: true
)
