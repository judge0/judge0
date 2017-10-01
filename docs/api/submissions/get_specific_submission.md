### Get Specific Submission [GET]
Returns details about submission.

Just like in [create submission](/#submission-submission-post) you can receive Base64 encoded data for every
text type attribute (check the [table](#submission-submission) to see which attributes are text type).
By default, this parameter is set to `false` and Judge0 API will send you raw data.

By default Judge0 API is sending you 8 attributes for submission. As you may read in [Submission](#submission-submission)
section, submission model has 27 attributes. By sending `fields` query parameter you can specify exactly which attributes
you want from Judge0 API.

+ Parameters
    + token (required, string, `d85cd024-1548-4165-96c7-7bc88673f194`) ... Token of submission. You got this token when you created submission.
    + base64_encoded (optional, boolean, `false`) ... Set to `true` if you want to receive Base64 encoded data from Judge0 API.
    + fields = `stdout,time,memory,stderr,token,compile_output,message,status` (optional, integer, `stdout,stderr,status_id,language_id`) ... Return only the desired attributes.

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
    Recieving Base64 encoded data for text type attributes. Note that in this request `base64_encoded` query parameter **must** be
    set to `true`.
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

+ Response 500 (application/json)
    If you get status `500` on this request, it is probably because some text type attribute in submission contains
    some non printable characters which cannot be used in JSON. In that case, set `base64_encoded` query parameter to `true`,
    and decode `stdout` and `stderr` on client side.
    + Body
        {
            "status": 500,
            "error": "Internal Server Error",
            "exception": "#<Encoding::UndefinedConversionError: \"\\x80\" from ASCII-8BIT to UTF-8>",
            ...
        }

<!-- include(../_unauthenticated.md) -->