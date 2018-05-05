ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup'

require 'dotenv'

Dotenv.load("judge0-api.conf")

DEFAULT_ENV = {
    "RAILS_ENV"                                        => "development",
    "RAILS_LOG_TO_STDOUT"                              => "true",
    "HOST"                                             => "0.0.0.0",
    "PORT"                                             => "3000",
    "RAILS_MAX_THREADS"                                => 5,
    "SECRET_KEY_BASE"                                  => (0...128).map { [*'0'..'9', *'a'..'z', *'A'..'Z'].sample }.join,
    "ALLOW_ORIGIN"                                     => "*",
    "AUTHN_HEADER"                                     => "X-Auth-Token",
    "AUTHN_TOKEN"                                      => "", # DO NOT PUT YOUR AUTHENTICATION TOKENS HERE
    "AUTHZ_HEADER"                                     => "X-Auth-User",
    "AUTHZ_TOKEN"                                      => "", # DO NOT PUT YOUR AUTHORIZATION TOKENS HERE
    "INTERVAL"                                         => 2.0,
    "COUNT"                                            => 1,
    "REDIS_HOST"                                       => "localhost", # DO NOT PUT YOUR REDIS HOST HERE
    "REDIS_PORT"                                       => 6379,        # DO NOT PUT YOUR REDIS PORT HERE
    "REDIS_PASSWORD"                                   => "",          # DO NOT PUT YOUR REDIS PASSWORD HERE
    "POSTGRES_HOST"                                    => "localhost", # DO NOT PUT YOUR POSTGRES HOST HERE
    "POSTGRES_PORT"                                    => 5432,        # DO NOT PUT YOUR POSTGRES PORT HERE
    "POSTGRES_DB"                                      => "postgres",  # DO NOT PUT YOUR POSTGRES DATABASE NAME HERE
    "POSTGRES_USER"                                    => "postgres",  # DO NOT PUT YOUR POSTGRES USER HERE
    "POSTGRES_PASSWORD"                                => "",          # DO NOT PUT YOUR POSTGRES PASSWORD HERE
    "AWS_ACCESS_KEY_ID"                                => "DO NOT PUT YOUR KEY ID HERE",
    "AWS_SECRET_ACCESS_KEY"                            => "DO NOT PUT YOUR ACCESS KEY HERE",
    "AWS_BUCKET"                                       => "DO NOT PUT NAME OF YOUR BUCKET HERE",
    "AWS_ENDPOINT"                                     => "https://minio.judge0.com",
    "ENABLE_WAIT_RESULT"                               => true,
    "CPU_TIME_LIMIT"                                   => 2.0,
    "MAX_CPU_TIME_LIMIT"                               => 15.0,
    "CPU_EXTRA_TIME"                                   => 0.5,
    "MAX_CPU_EXTRA_TIME"                               => 2.0,
    "WALL_TIME_LIMIT"                                  => 5.0,
    "MAX_WALL_TIME_LIMIT"                              => 20.0,
    "MEMORY_LIMIT"                                     => 128000,
    "MAX_MEMORY_LIMIT"                                 => 256000,
    "STACK_LIMIT"                                      => 64000,
    "MAX_STACK_LIMIT"                                  => 128000,
    "MAX_PROCESSES_AND_OR_THREADS"                     => 30,
    "MAX_MAX_PROCESSES_AND_OR_THREADS"                 => 60,
    "ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT"         => false,
    "ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT"   => true,
    "ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT"       => true,
    "ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT" => true,
    "MAX_FILE_SIZE"                                    => 1024,
    "MAX_MAX_FILE_SIZE"                                => 4096,
    "NUMBER_OF_RUNS"                                   => 1,
    "MAX_NUMBER_OF_RUNS"                               => 20
}

DEFAULT_ENV.each do |key, value|
    if value.is_a?(String)
        ENV[key] = value if ENV.fetch(key).to_s.strip.empty?
    elsif value.is_a?(Numeric)
        ENV[key] = value.to_s if ENV.fetch(key).to_s.strip.empty?
    else
        if ENV.fetch(key) != "false" && ENV.fetch(key) != "true"
            ENV[key] = value.to_s
        end
    end
end
