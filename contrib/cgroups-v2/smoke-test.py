#!/usr/bin/env python3
"""Small bounded functional check. Never targets the public Judge0 service."""
import concurrent.futures
import json
import base64
import os
from pathlib import Path
import time
import urllib.request

ROOT = Path(__file__).resolve().parent
CONFIG = dict(line.split('=', 1) for line in (ROOT / 'judge0.conf').read_text().splitlines() if '=' in line)
URL = 'http://127.0.0.1:' + str(int(os.environ.get('JUDGE0_TEST_PORT', '2358')))

def request(path, data=None):
    body = None if data is None else json.dumps(data).encode()
    req = urllib.request.Request(URL + path, data=body, headers={
        'Content-Type': 'application/json', 'X-Auth-Token': CONFIG['AUTHN_TOKEN']})
    with urllib.request.urlopen(req, timeout=10) as response:
        return json.load(response)

def run_case(name, language, source, expected_status=3, stdin='', expected_output=None, **limits):
    start = time.monotonic()
    payload = dict(language_id=language, source_code=source, stdin=stdin, cpu_time_limit=2,
                   wall_time_limit=5, memory_limit=128000)
    payload.update(limits)
    token = request('/submissions?wait=false', payload)['token']
    deadline = start + 90
    while time.monotonic() < deadline:
        result = request('/submissions/' + token + '?base64_encoded=true')
        for field in ('stdout', 'stderr', 'compile_output', 'message'):
            if result.get(field) is not None:
                result[field] = base64.b64decode(result[field]).decode('utf-8', errors='replace')
        if result['status']['id'] > 2:
            allowed = expected_status if isinstance(expected_status, tuple) else (expected_status,)
            ok = result['status']['id'] in allowed
            if expected_output is not None:
                ok = ok and result.get('stdout') == expected_output
            return dict(name=name, passed=ok, elapsed=round(time.monotonic()-start, 2), result=result)
        time.sleep(0.5)
    return dict(name=name, passed=False, error='90 second deadline exceeded', token=token)

def main():
    languages = request('/languages')
    py = next(x['id'] for x in languages if x['name'].startswith('Python (3'))
    cpp = next(x['id'] for x in languages if x['name'].startswith('C++ (GCC'))
    results = []
    cases = [
        ('Python stdin', py, 'a,b=map(int,input().split()); print(a+b)', 3, '2 5\n', '7\n'),
        ('C++ compilation', cpp, '#include <iostream>\nint main(){std::cout << 42 << "\\n";}', 3, '', '42\n'),
        ('CPU limit', py, 'while True: pass', 5, '', None),
        ('Compilation error', cpp, 'this is not C++', 6, '', None),
        ('Network blocked', py, 'import socket\ns=socket.socket();s.settimeout(1)\ntry:\n s.connect(("1.1.1.1",443));print("OPEN")\nexcept OSError:\n print("BLOCKED")', 3, '', 'BLOCKED\n'),
        ('Host file hidden', py, 'import os; print(os.path.exists("/api/environment"))', 3, '', 'False\n'),
        ('UTF-8 output', py, 'print("Привет, Judge0!")', 3, '', 'Привет, Judge0!\n'),
    ]
    for case in cases:
        result = run_case(*case)
        results.append(result)
        print(result['name'], 'PASS' if result['passed'] else 'FAIL', flush=True)
        if result.get('result', {}).get('status', {}).get('id') == 13:
            break
    if all(x['passed'] for x in results):
        for i in range(7):
            results.append(run_case('Test ' + str(i+1), py, 'print(int(input())*2)',
                                    stdin=str(i), expected_output=str(i*2)+'\n'))
        with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
            results.extend(executor.map(lambda i: run_case('Parallel '+str(i), py,
                           'print("OK")', expected_output='OK\n'), range(4)))
    (ROOT / 'test-results.json').write_text(json.dumps(results, ensure_ascii=False, indent=2))
    print(f"Passed {sum(x['passed'] for x in results)}/{len(results)}")
    raise SystemExit(0 if all(x['passed'] for x in results) else 1)

if __name__ == '__main__':
    main()
