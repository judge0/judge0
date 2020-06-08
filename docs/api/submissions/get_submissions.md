### Get Submissions [GET]
+ Parameters
    + base64_encoded = `false` (optional, boolean, `false`) ... Set to `true` if you want to receive Base64 encoded data from Judge0.
    + page = `1` (optional, integer, `4`) ... Pagination page number.
    + per_page = `20` (optional, integer, `2`) ... Number of submissions to return per page.
    + fields = `stdout,time,memory,stderr,token,compile_output,message,status` (optional, string, `status,language,time`) ... Return only the desired attributes.

+ Response 200 (application/json)
    {
        "submissions": [
            {
                "time": "0.001",
                "status": {
                    "id": 3,
                    "description": "Accepted"
                },
                "language": {
                    "id": 4,
                    "name": "C (gcc 7.2.0)"
                }
            },
            {
                "time": "0.001",
                "status": {
                    "id": 3,
                    "description": "Accepted"
                },
                "language": {
                    "id": 4,
                    "name": "C (gcc 7.2.0)"
                }
            }
        ],
        "meta": {
            "current_page": 4,
            "next_page": 5,
            "prev_page": 3,
            "total_pages": 31,
            "total_count": 62
        }
    }

+ Response 200 (application/json)
    When `base64_encoded` is set to `true`.
    + Body
        {
            "submissions": [
                {
                    "stdout": "aGVsbG8sIEp1ZGdlMAo=\n",
                    "time": "0.001",
                    "memory": 376,
                    "stderr": null,
                    "token": "a1133bc6-a0f6-46bf-a2d8-6157418c6fe2",
                    "compile_output": null,
                    "message": null,
                    "status": {
                        "id": 3,
                        "description": "Accepted"
                    }
                },
                {
                    "stdout": "aGVsbG8sIEp1ZGdlMAo=\n",
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
            ],
            "meta": {
                "current_page": 4,
                "next_page": 5,
                "prev_page": 3,
                "total_pages": 31,
                "total_count": 62
            }
        }

+ Response 400 (application/json)
    When `page` parameter is invalid.
    + Body
        {
            "error": "invalid page: -4"
        }

+ Response 400 (application/json)
    When `per_page` parameter is invalid.
    + Body
        {
            "error": "invalid per_page: -2"
        }

+ Response 400 (application/json)
    + Body
        {
            "error": "some attributes for one or more submissions cannot be converted to UTF-8, use base64_encoded=true query parameter"
        }

<!-- include(../_unauthenticated.md) -->
<!-- include(../_unauthorized.md) -->
