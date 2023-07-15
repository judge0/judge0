Resque.redis = Redis.new(
  host:     ENV["REDIS_HOST"],
  port:     ENV["REDIS_PORT"],
  database: ENV["REDIS_DATABASE"],
  thread_safe: true
)

if ENV["RESQUE_NAMESPACE"].present?
  Resque.redis.namespace = ENV["RESQUE_NAMESPACE"].to_sym
end
