## Get a Language [GET]
+ Parameters
    + id (required, integer, `1`) ... Language ID.

+ Response 200 (application/json)
    + Body
        {
            "id": 1,
            "name": "Bash (4.4)",
            "is_archived": true,
            "source_file": "script.sh",
            "compile_cmd": null,
            "run_cmd": "/usr/local/bash-4.4/bin/bash script.sh"
        }