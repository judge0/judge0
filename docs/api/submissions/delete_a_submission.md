### Delete a Submission [DELETE]
Delete specific submission.

You need to be authorized to issue this request. Although you are
authorized you might not be able to delete submission because administrator of Judge0 instance
you are using disallowed submission deletion. So before using this feature please check [configuration](#system-and-configuration-configuration-info-get) of Judge0 you are using.

For this request query parameter `base64_encoded` is implicitly set to `true` and cannot be changed.
This guarantees you will successfully get requested submission attributes after deletion.

+ Parameters
    + token (required, string, `d85cd024-1548-4165-96c7-7bc88673f194`) ... Token of submission. You got this token when you created submission.
    + fields = `stdout,time,memory,stderr,token,compile_output,message,status` (optional, string, `stdout,stderr,status_id,language_id`) ... Return only the desired attributes.

+ Response 200 (applcation/json)
    + Body
        {
            "stdout": "aGVsbG8sIHdvcmxkCg==\n",
            "time": "0.045",
            "memory": 8556,
            "stderr": null,
            "token": "e80153f5-e7d8-4cd2-9e10-6c0ddbf9e3bf",
            "compile_output": null,
            "message": null,
            "status": {
                "id": 3,
                "description": "Accepted"
            }
        }

+ Response 400 (application/json)
If submission status is `1` or `2`.
    + Body
        {
            "error": "submission cannot be deleted because its status is 1 (In Queue)"
        }

<!-- include(../_unauthenticated.md) -->
<!-- include(../_unauthorized.md) -->