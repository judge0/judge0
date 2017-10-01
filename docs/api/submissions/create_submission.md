### Create Submission [POST]
Creates new submission. Created submission waits in queue to be processed. On successful
creation, you are returned submission token which can be used to check submission status.

If submission's `source_code`, `stdin` or `expected_output` contains non printable characters, or
characters which cannot be send with JSON, then set `base64_encoded` parameter to `true` and
send these attributes Base64 encoded. Your responsibility is to encode each of mentioned attributes
(`source_code`, `stdin` and `expected_output`) even if just one of them contains non printable
characters. By default, this parameter is set to `false` and Judge0 API assumes you are sending raw data.

By default you are returned submission token on successful submission creation. With this token
you can [check submission status](#submission-submission-get). Instead of checking submission status with second request, you can wait for submission result
by sending `wait` query parameter and setting it to `true`. With this feature you will get submission result immediately after submission has been created. Please note that this feature may or may not be
enabled on all Judge0 API hosts. So before using this feature please check [configuration](#system-and-configuration-configuration-info-get)
of Judge0 API you are using. On a [official Judge0 API](https://api.judge0.com) this feature **is enabled**.

+ Parameters
    + base64_encoded = `false` (optional, boolean, `false`) ... Set to `true` if you want to send Base64 encoded data to Judge0 API.
    + wait = `false` (optional, boolean, `false`) ... Set to `true` to immediately get submission result.

+ Request (application/json)
    {
        "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
        "language_id": 4,
        "stdin": "world"
    }

+ Response 201 (application/json)
    {
        "token": "d85cd024-1548-4165-96c7-7bc88673f194"
    }


+ Request (application/json)
    {
        "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}"
    }

+ Response 422 (application/json)
    {
        "language_id": [
            "can't be blank"
        ]
    }


+ Request (application/json)
    {
        "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
        "language_id": 150000,
        "stdin": "world",
        "expected_output": "hello, world"
    }

+ Response 422 (application/json)
    {
        "language_id": [
            "language with id 150000 doesn't exist"
        ]
    }


+ Request (application/json)
    {
        "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
        "language_id": 4,
        "number_of_runs": 1,
        "stdin": "Judge0",
        "expected_output": "hello, Judge0",
        "cpu_time_limit": 1,
        "cpu_extra_time": 0.5,
        "wall_time_limit": 100000,
        "memory_limit": 128000,
        "stack_limit": 128000,
        "enable_per_process_and_thread_time_limit": false,
        "enable_per_process_and_thread_memory_limit": false,
        "max_file_size": 1024
    }

+ Response 422 (application/json)
    {
        "wall_time_limit": [
            "must be less than or equal to 150"
        ]
    }


+ Request (appliction/json)
    Sending Base64 encoded `source_code` and `stdin`. Note that in this request `base64_encoded` query parameter **must** be
    set to `true`.
    + Body
        {
            "source_code": "I2luY2x1ZGUgPHN0ZGlvLmg+CgppbnQgbWFpbih2b2lkKSB7CiAgY2hhciBuYW1lWzEwXTsKICBzY2FuZigiJXMiLCBuYW1lKTsKICBwcmludGYoImhlbGxvLCAlc1xuIiwgbmFtZSk7CiAgcmV0dXJuIDA7Cn0=",
            "language_id": 4,
            "input": "SnVkZ2Uw"
        }

+ Response 201 (application/json)
    {
        "token": "f3fe0215-72f3-4fe6-97f5-353df6682db4"
    }

+ Request (application/json)
    Waiting for submission to finish. Note that in this request `wait` query parameter **must** be set to `true`.
    + Body
        {
            "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
            "language_id": "4",
            "stdin": "Judge0",
            "expected_output": "hello, Judge0"
        }

+ Response 201 (application/json)
    {
        "stdout": "hello, Judge0\n",
        "time": "0.001",
        "memory": 380,
        "stderr": null,
        "token": "eb0dd001-66db-47f4-8a69-b736c9bc23f6",
        "compile_output": null,
        "message": null,
        "status": {
            "id": 3,
            "description": "Accepted"
        }
    }

+ Response 400 (application/json)
    If wait is not allowed.
    + Body
        {
            "error": "wait not allowed"
        }

<!-- include(../_unauthenticated.md) -->