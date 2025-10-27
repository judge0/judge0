#!/bin/bash

# Ensure directories exist for isolate
mkdir -p /run/isolate/locks

# Run cgroup detection for isolate 2.x (auto-detect pod/container cgroup)
if [ ! -f /run/isolate/cgroup ]; then
    echo "Detecting cgroup for isolate..."
    /usr/local/sbin/isolate-cg-keeper &

    # Wait for cgroup detection to complete (max 5 seconds)
    for i in {1..10}; do
        if [ -f /run/isolate/cgroup ]; then
            echo "Cgroup detected: $(cat /run/isolate/cgroup)"
            break
        fi
        sleep 0.5
    done

    # Verify detection succeeded
    if [ ! -f /run/isolate/cgroup ]; then
        echo "ERROR: Failed to detect cgroup for isolate" >&2
        exit 1
    fi
fi

sudo cron
exec "$@"
