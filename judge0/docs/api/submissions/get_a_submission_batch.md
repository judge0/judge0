### Get a Submission Batch [GET]
Get multiple submissions at once.

+ Parameters
    + tokens (required, string, `db54881d-bcf5-4c7b-a2e3-d33fe7e25de7,ecc52a9b-ea80-4a00-ad50-4ab6cc3bb2a1,1b35ec3b-5776-48ef-b646-d5522bdeb2cc`) ... Submission tokens separeted with `,`.
    + base64_encoded = `false` (optional, boolean, `false`) ... Set to `true` if you want to receive Base64 encoded data.
    + fields = `stdout,time,memory,stderr,token,compile_output,message,status` (optional, string, `token,stdout,stderr,status_id,language_id`) ... Return only the desired attributes.

+ Response 200 (application/json)
    {
        "submissions": [
            {
                "language_id": 46,
                "stdout": "hello from Bash\n",
                "status_id": 3,
                "stderr": null,
                "token": "db54881d-bcf5-4c7b-a2e3-d33fe7e25de7"
            },
            {
                "language_id": 71,
                "stdout": "hello from Python\n",
                "status_id": 3,
                "stderr": null,
                "token": "ecc52a9b-ea80-4a00-ad50-4ab6cc3bb2a1"
            },
            {
                "language_id": 72,
                "stdout": "hello from Ruby\n",
                "status_id": 3,
                "stderr": null,
                "token": "1b35ec3b-5776-48ef-b646-d5522bdeb2cc"
            }
        ]
    }