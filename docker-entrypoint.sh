#!/bin/bash
set -e

# cgroupv2 delegation setup — required by isolate v2.
# Idempotent: safe to run on every container start. The host must mount the
# unified cgroupv2 hierarchy at /sys/fs/cgroup (Docker / Kubernetes do this
# automatically on cgroupv2 hosts). On cgroupv1 hosts the controllers file
# below is absent, so the entire block is skipped.
if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
    sudo mkdir -p /sys/fs/cgroup/init
    echo $$ | sudo tee /sys/fs/cgroup/init/cgroup.procs >/dev/null 2>&1 || true
    for c in cpu memory pids io cpuset; do
        if grep -qw "$c" /sys/fs/cgroup/cgroup.controllers 2>/dev/null; then
            echo "+$c" | sudo tee /sys/fs/cgroup/cgroup.subtree_control >/dev/null 2>&1 || true
        fi
    done
    sudo mkdir -p /sys/fs/cgroup/isolate
    for c in cpu memory pids io cpuset; do
        if grep -qw "$c" /sys/fs/cgroup/isolate/cgroup.controllers 2>/dev/null; then
            echo "+$c" | sudo tee /sys/fs/cgroup/isolate/cgroup.subtree_control >/dev/null 2>&1 || true
        fi
    done
    sudo mkdir -p /run/isolate/locks
fi

sudo cron
exec "$@"
