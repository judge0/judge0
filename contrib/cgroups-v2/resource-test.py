#!/usr/bin/env python3
"""Bounded resource checks against the local lab only."""
import importlib.util
import json
from pathlib import Path

root = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('smoke', root / 'smoke-test.py')
smoke = importlib.util.module_from_spec(spec)
spec.loader.exec_module(smoke)
py = next(x['id'] for x in smoke.request('/languages') if x['name'].startswith('Python (3'))

memory = smoke.run_case('Memory limit 32 MiB', py,
    'x = bytearray(64 * 1024 * 1024)\nprint("UNLIMITED")',
    expected_status=(7, 11, 12), memory_limit=32768)
# A runtime error alone is insufficient evidence of a memory limit.
r = memory.get('result', {})
memory['passed'] = memory['passed'] and (
    'MemoryError' in (r.get('stderr') or '') or
    'memory' in (r.get('message') or '').lower() or
    r.get('status', {}).get('id') == 7 or
    (r.get('status', {}).get('id') == 11 and
     '137' in (r.get('message') or '') and
     r.get('memory', 0) >= 32768 and 'Killed' in (r.get('stderr') or '')))

source = '''import os, time
children = []
blocked = False
try:
    for i in range(24):
        try:
            pid = os.fork()
        except BlockingIOError:
            blocked = True
            break
        if pid == 0:
            time.sleep(1)
            os._exit(0)
        children.append(pid)
finally:
    for pid in children:
        os.waitpid(pid, 0)
print("BLOCKED" if blocked else "UNLIMITED")
'''
processes = smoke.run_case('Process limit 8', py, source,
    expected_output='BLOCKED\n', max_processes_and_or_threads=8)
recovery = smoke.run_case('Worker recovery after resource limits', py,
    'print("OK")', expected_output='OK\n')
results = [memory, processes, recovery]
(root / 'resource-results.json').write_text(json.dumps(results, ensure_ascii=False, indent=2))
for result in results:
    print(result['name'], 'PASS' if result['passed'] else 'FAIL')
raise SystemExit(0 if all(x['passed'] for x in results) else 1)
