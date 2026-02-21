### Get a Submission [GET]
Returns details about submission.

Just like in [create submission](/#submission-submission-post) you can receive Base64 encoded data for every text type attribute (check the [table](#submission-submission) to see which attributes are text type). By default, this parameter is set to `false` and Judge0 will send you raw data.

By default Judge0 is sending 8 attributes for submission. By sending `fields` query parameter you can specify exactly which attributes you want from Judge0. Special value `*` will return all available attributes.

+ Parameters
    + token (required, string, `d85cd024-1548-4165-96c7-7bc88673f194`) ... Token of submission. You got this token when you created submission.
    + base64_encoded (optional, boolean, `false`) ... Set to `true` if you want to receive Base64 encoded data from Judge0. You should set this to `true` if you expect the program's stdout to contain non-printable characters or if you expect the compiler to output non-printable characters during a compile error (GCC does this, for instance).
    + fields = `stdout,time,memory,stderr,token,compile_output,message,status` (optional, string, `stdout,stderr,status_id,language_id`) ... Return only the desired attributes.

+ Response 200 (applicatiion/json)
    {
        "stdout": "hello, world\n",
        "status_id": 5,
        "language_id": 4,
        "stderr": null
    }

+ Response 200 (application/json)
    This is the default response. Leave `fields` parameter empty if you want to get default response.
    + Body
        {
            "stdout": "hello, Judge0\n",
            "time": "0.001",
            "memory": 376,
            "stderr": null,
            "token": "8531f293-1585-4d36-a34c-73726792e6c9",
            "compile_output": null,
            "message": null,
            "status": {
                "id": 3,
                "description": "Accepted"
            }
        }

+ Response 200 (application/json)
    Receiving Base64 encoded data for text type attributes. Note that in this request `base64_encoded` query parameter **must** be set to `true`.
    + Body
        {
            "stdout": "aGVsbG8sIEp1ZGdlMAo=\n",
            "time": "0.002",
            "memory": 376,
            "stderr": null,
            "token": "4e00f214-b8cb-4fcb-977b-429113c81ece",
            "compile_output": null,
            "message": null,
            "status": {
                "id": 3,
                "description": "Accepted"
            }
        }

+ Response 400 (application/json)
    + Body
        {
            "error": "some attributes for this submission cannot be converted to UTF-8, use base64_encoded=true query parameter"
        }

<!-- include(../_unauthenticated.md) -->
