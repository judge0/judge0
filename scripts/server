#!/bin/bash
# Script for running Judge0 server.
#
# Usage: ./scripts/server
#
source ./scripts/load-config
export | sudo tee /api/environment

for i in $(seq 1 $RESTART_MAX_TRIES); do
    [[ -f tmp/pids/server.pid ]] && rm -f tmp/pids/server.pid

    rails db:create db:migrate db:seed
    rails s -b 0.0.0.0
    [[ $? -eq 0 ]] && break
    sleep 2s
done
