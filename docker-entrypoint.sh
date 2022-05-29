#!/bin/bash
if [[ "$(which cron)" != "" ]]; then
    cron
fi
exec "$@"
