#!/bin/bash
# Set up cgroup v2 hierarchy for isolate sandboxes.
#
# This script replaces isolate-cg-keeper for Docker environments where
# systemd is not available. It performs the same cgroup initialization:
#   1. Verifies cgroup v2 is mounted
#   2. Creates a child cgroup and moves ALL current processes into it
#      (required by cgroup v2's no-internal-process constraint)
#   3. Enables the cpuset and memory controllers on the parent
#   4. Writes the cgroup root path for isolate to read
#
# Must be run as root before any isolate commands, and ideally before
# any daemons (cron, etc.) are started so fewer processes need moving.

set -e

# --- Verify cgroup v2 is available ---
if [ ! -f /sys/fs/cgroup/cgroup.controllers ]; then
    echo "FATAL: cgroup v2 is not available at /sys/fs/cgroup." >&2
    echo "Judge0 requires a cgroup v2 host (Kubernetes 1.25+, Amazon Linux 2023, Ubuntu 22.04+)." >&2
    echo "If the host uses cgroup v1, you must migrate to cgroup v2 first." >&2
    exit 1
fi

if [ -f /sys/fs/cgroup/unified/cgroup.controllers ]; then
    echo "FATAL: Hybrid cgroup v1+v2 mode is not supported by isolate 2.x." >&2
    echo "Configure the host for pure cgroup v2 (systemd.unified_cgroup_hierarchy=1)." >&2
    exit 1
fi

# --- Find our cgroup ---
OUR_CGROUP=$(grep '^0::' /proc/self/cgroup 2>/dev/null | cut -d: -f3)
if [ -z "$OUR_CGROUP" ]; then
    echo "FATAL: Cannot determine own cgroup from /proc/self/cgroup." >&2
    exit 1
fi

CG_ROOT="/sys/fs/cgroup${OUR_CGROUP}"
# Strip trailing slash to avoid double-slash in path concatenation
# (happens when OUR_CGROUP is "/" in private cgroupns mode)
CG_ROOT="${CG_ROOT%/}"

if [ ! -d "$CG_ROOT" ]; then
    echo "FATAL: Cgroup directory $CG_ROOT does not exist." >&2
    exit 1
fi

echo "[setup-cgroups] Cgroup root: $CG_ROOT"

# --- Move ALL processes to a child cgroup ---
# cgroup v2 enforces the "no internal process" constraint: a cgroup with
# controllers enabled in subtree_control must not have processes directly
# in it.  We create an "init" child, move every process there, then enable
# controllers on CG_ROOT.  Isolate later creates box-N siblings of init.
mkdir -p "$CG_ROOT/init"

# Snapshot PIDs first (reading cgroup.procs while moving from it can race).
PIDS=$(cat "$CG_ROOT/cgroup.procs" 2>/dev/null || true)
for pid in $PIDS; do
    echo "$pid" > "$CG_ROOT/init/cgroup.procs" 2>/dev/null || true
done

# Retry in case a process forked between the snapshot and the moves.
REMAINING=$(cat "$CG_ROOT/cgroup.procs" 2>/dev/null | wc -l)
if [ "$REMAINING" -gt 0 ] 2>/dev/null; then
    PIDS=$(cat "$CG_ROOT/cgroup.procs" 2>/dev/null || true)
    for pid in $PIDS; do
        echo "$pid" > "$CG_ROOT/init/cgroup.procs" 2>/dev/null || true
    done
fi

REMAINING=$(cat "$CG_ROOT/cgroup.procs" 2>/dev/null | wc -l)
if [ "$REMAINING" -gt 0 ] 2>/dev/null; then
    echo "WARNING: $REMAINING process(es) could not be moved out of $CG_ROOT." >&2
    echo "         Enabling subtree_control may fail." >&2
fi

# --- Enable controllers ---
AVAILABLE=$(cat "$CG_ROOT/cgroup.controllers" 2>/dev/null || echo "")
ENABLE=""
for ctrl in cpuset memory; do
    if echo "$AVAILABLE" | grep -qw "$ctrl"; then
        ENABLE="$ENABLE +$ctrl"
    else
        echo "WARNING: Controller '$ctrl' not available in $CG_ROOT." >&2
        if [ "$ctrl" = "memory" ]; then
            echo "WARNING: Without the memory controller, --cg-mem limits will not work." >&2
        fi
    fi
done

if [ -n "$ENABLE" ]; then
    if ! echo "$ENABLE" > "$CG_ROOT/cgroup.subtree_control" 2>/dev/null; then
        echo "ERROR: Could not enable controllers ($ENABLE) in $CG_ROOT." >&2
        echo "       cgroup resource limits will not function correctly." >&2
        echo "       Check that the host delegates controllers to the container." >&2
        # Do not exit — isolate can still run without cgroups (without --cg),
        # and the error will surface when a submission actually tries to use them.
    fi
fi

# --- Write cgroup path for isolate ---
mkdir -p /run/isolate/locks
echo "$CG_ROOT" > /run/isolate/cgroup

# --- Ensure box_root exists ---
mkdir -p /var/local/lib/isolate

ENABLED=$(cat "$CG_ROOT/cgroup.subtree_control" 2>/dev/null || echo "(none)")
echo "[setup-cgroups] cgroup v2 setup complete. Active controllers: $ENABLED"
