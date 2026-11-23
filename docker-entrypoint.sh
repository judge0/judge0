#!/bin/bash
# Must run before anything else is started so that every process lands in the
# "init" leaf cgroup instead of the namespace root.
sudo /api/scripts/setup-cgroup-v2 || exit 1
sudo cron
exec "$@"
