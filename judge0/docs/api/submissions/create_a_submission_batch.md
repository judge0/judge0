### Create a Submission Batch [POST]
Create multiple submissions at once.

+ Parameters
    + base64_encoded = `false` (optional, boolean, `false`) ... Set to `true` if you are sending Base64 encoded data.

+ Request (application/json)
    {
        "submissions":
        [
            {
                "language_id": 46,
                "source_code": "echo hello from Bash"
            },
            {
                "language_id": 71,
                "source_code": "print(\"hello from Python\")"
            },
            {
                "language_id": 72,
                "source_code": "puts(\"hello from Ruby\")"
            }
        ]
    }

+ Response 201 (application/json)
    [
        {
            "token": "db54881d-bcf5-4c7b-a2e3-d33fe7e25de7"
        },
        {
            "token": "ecc52a9b-ea80-4a00-ad50-4ab6cc3bb2a1"
        },
        {
            "token": "1b35ec3b-5776-48ef-b646-d5522bdeb2cc"
        }
    ]

+ Request (application/json)
    {
        "submissions":
        [
            {
                "language_id": 46,
                "source_code": "echo hello from Bash"
            },
            {
                "language_id": 123456789,
                "source_code": "print(\"hello from Python\")"
            },
            {
                "language_id": 72,
                "source_code": ""
            }
        ]
    }

+ Response 201 (application/json)
    [
        {
            "token": "c2dd8881-644b-462d-b1f9-73dd3bb0118a"
        },
        {
            "language_id": [
                "language with id 123456789 doesn't exist"
            ]
        },
        {
            "source_code": [
                "can't be blank"
            ]
        }
    ]