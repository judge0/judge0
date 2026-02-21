#!/bin/bash
if [[ -f /api/judge0.conf ]]; then
    CONFIG_FILE=/api/judge0.conf
elif [[ -f /judge0.conf ]]; then
    CONFIG_FILE=/judge0.conf
fi

if [[ -v CONFIG_FILE ]]; then
    set -o allexport

    source $CONFIG_FILE # Source the configuration file.

    set +o allexport
fi

# Now set defaults if needed...

# Judge0
export MAINTENANCE_MESSAGE=${MAINTENANCE_MESSAGE:-Judge0 is currently in maintenance.}
export RESTART_MAX_TRIES=${RESTART_MAX_TRIES:-10}

# Rails
export RAILS_ENV=${RAILS_ENV:-production}
export RAILS_MAX_THREADS=${RAILS_MAX_THREADS:-$(nproc)}
export RAILS_SERVER_PROCESSES=${RAILS_SERVER_PROCESSES:-2}
export SECRET_KEY_BASE=${SECRET_KEY_BASE:-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 128 | head -n 1)}
export PORT=${PORT:-2358} # This option is not available in judge0.conf
export RAILS_LOG_TO_STDOUT=true # This options is not available in judge0.conf

# Authentication
export AUTHN_HEADER=${AUTHN_HEADER:-X-Auth-Token}

# Authorization
export AUTHZ_HEADER=${AUTHZ_HEADER:-X-Auth-User}

# Workers
export INTERVAL=${INTERVAL:-0.1}
export COUNT=${COUNT:-$(( $(nproc) * 2 ))}
export QUEUE=${JUDGE0_VERSION:-unknown} # This option is not available in judge0.conf

# Database
export REDIS_HOST=${REDIS_HOST:-localhost}
export REDIS_PORT=${REDIS_PORT:-6379}
export POSTGRES_HOST=${POSTGRES_HOST:-localhost}
export POSTGRES_PORT=${POSTGRES_PORT:-5432}
export POSTGRES_DB=${POSTGRES_DB:-postgres}
export POSTGRES_USER=${POSTGRES_USER:-postgres}

# Other
export RUBYOPT=-W:no-deprecated
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1
