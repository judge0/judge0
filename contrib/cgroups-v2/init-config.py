#!/usr/bin/env python3
import os
import secrets
from pathlib import Path

path = Path(__file__).resolve().parent / 'judge0.conf'
config = '''POSTGRES_HOST=db
POSTGRES_DB=judge0
POSTGRES_USER=judge0
REDIS_HOST=redis
RAILS_ENV=production
RAILS_MAX_THREADS=2
RAILS_SERVER_PROCESSES=1
COUNT=2
JUDGE0_CGROUPS_VERSION=2
ENABLE_WAIT_RESULT=false
ENABLE_NETWORK=false
ALLOW_ENABLE_NETWORK=false
ENABLE_CALLBACKS=false
ENABLE_ADDITIONAL_FILES=false
ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT=false
ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT=false
ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT=false
ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT=false
JUDGE0_TELEMETRY_ENABLE=false
'''
for key in ('POSTGRES_PASSWORD', 'REDIS_PASSWORD', 'SECRET_KEY_BASE', 'AUTHN_TOKEN'):
    config += f'{key}={secrets.token_hex(32)}\n'
with os.fdopen(os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600), 'w') as f:
    f.write(config)
print('Created judge0.conf; credentials were not printed.')
