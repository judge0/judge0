### Show [GET]
Returns details about submission execution result.

If you expect non printable characters in submission's `stdout` or `stderr` after it's execution, you can
request Judge0 API to return you Base64 encoded `stdout` and `stderr` by setting
`base64_encoded` query parametar to `true`. Your responsibility is to decode each of
menitioned attributes (`stdout` and `stderr`) on client side.
By default, this parameter is set to `false` and Judge0 API will send you raw data (decoded data).

+ Parameters
    + `token`: `d85cd024-1548-4165-96c7-7bc88673f194` (required, string) - Token of submission. You got this token when you created submission.
    + `base64_encoded`: `false` (optional, boolean) - Set to `true` if you want to recieve Base64 encoded data from Judge0 API.

+ Response 200 (application/json)
    {
        "token": "d85cd024-1548-4165-96c7-7bc88673f194",
        "status": {
            "id": 1,
            "description": "In Queue"
        },
        "stdout": null,
        "stderr": null,
        "created_at": "2017-02-04T22:11:05.590Z",
        "finished_at": null,
        "time": null,
        "memory": null,
        "number_of_runs": 1,
        "cpu_time_limit": "1.0",
        "cpu_extra_time": "0.5",
        "wall_time_limit": "10.0",
        "memory_limit": 128000,
        "stack_limit": 128000,
        "enable_per_process_and_thread_time_limit": false,
        "enable_per_process_and_thread_memory_limit": false,
        "max_file_size": 1024
    }

+ Response 200 (application/json)
    {
        "token": "d85cd024-1548-4165-96c7-7bc88673f194",
        "status": {
            "id": 3,
            "description": "Accepted"
        },
        "stdout": "hello, Judge0\n",
        "stderr": "",
        "created_at": "2017-02-04T22:11:05.590Z",
        "finished_at": "2017-02-04T22:11:08.564Z",
        "time": "0.002",
        "memory": 248,
        "number_of_runs": 1,
        "cpu_time_limit": "1.0",
        "cpu_extra_time": "0.5",
        "wall_time_limit": "10.0",
        "memory_limit": 128000,
        "stack_limit": 128000,
        "enable_per_process_and_thread_time_limit": false,
        "enable_per_process_and_thread_memory_limit": false,
        "max_file_size": 1024
    }

+ Response 200 (application/json)
Recieving Base64 encoded `stdout` and `stderr`. Note that in this request `base64_encoded` query parameter **must** be
set to `true`.

    + Body
        {
            "token": "f3fe0215-72f3-4fe6-97f5-353df6682db4",
            "status": {
                "id": 3,
                "description": "Accepted"
            },
            "stdout": "aGVsbG8sIEp1ZGdlMAo=\n",
            "stderr": "",
            "created_at": "2017-04-22T23:42:34.451Z",
            "finished_at": "2017-04-22T23:42:34.770Z",
            "time": "0.002",
            "memory": 288,
            "number_of_runs": 1,
            "cpu_time_limit": "1.0",
            "cpu_extra_time": "0.5",
            "wall_time_limit": "10.0",
            "memory_limit": 128000,
            "stack_limit": 128000,
            "max_processes_and_or_threads": 30,
            "enable_per_process_and_thread_time_limit": true,
            "enable_per_process_and_thread_memory_limit": true,
            "max_file_size": 1024
        }

+ Response 500 (application/json)
If you get status `500` on this request, it is probably because your submission `stdout` or `stderr` contains
some non printable characters which cannot be used in JSON. In that case, set `base64_encoded` query parameter to `true`,
and decode `stdout` and `stderr` on client side.

    + Body
      {
          "status": 500,
          "error": "Internal Server Error",
          "exception": "#<Encoding::UndefinedConversionError: \"\\x80\" from ASCII-8BIT to UTF-8>",
          ...
      }