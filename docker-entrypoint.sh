#!/bin/bash
set -e

# Set up cgroup v2 FIRST, before starting any daemons.
# At this point only PID 1 (this bash process) is in CG_ROOT,
# so the script can cleanly move it to the init child cgroup.
sudo /api/scripts/setup-cgroups.sh

# Start cron daemon (inherits init cgroup from PID 1).
sudo cron

exec "$@"
