FORMAT: 1A
HOST: https://api.judge0.com

# Judge0 API docs
<!-- include(hostname.html) -->
<!-- include(style.html) -->

# About
[Judge0 API](http://api.judge0.com) is an open source API for code compilation and execution.
Source code is available on [GitHub](https://github.com/judge0/api).

We have included [dummy client](/dummy-client.html) which can be used to try and test features of Judge0 API.
# Date and time formats

[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

# License
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

<br>

## Group Submissions

## Submission [/submissions/{token}]
A Submission object has following attributes:

|#|Attribute Name|Type|Unit|Required/Optional|Description|Default Value|
|:-:|:-:|:-:|:-:|:-:|-|-|
|1|`source_code`|string||*required*|Source code of your program.|
|2|`language_id`|integer||*required*|[Language](#statuses-and-languages-languages) ID.|
|3|`input`|string||*optional*|Input for your program.|
|4|`expected_output`|string||*optional*|Expected output of you program.<br>Used when you want to compare with `stdout`.|
|5|`cpu_time_limit`|float|second|*optional*|Default runtime limit for every program (in seconds). Decimal numbers are allowed. Time in which the OS assigns the processor to different tasks is not counted.|Depends on [configuration](#system-and-configuration-configuration-info)|
|6|`cpu_extra_time`|float|second|*optional*|When a time limit is exceeded, wait for extra time (in seconds), before killing the program. This has the advantage that the real execution time is reported, even though it slightly exceeds the limit.|Depends on [configuration](#system-and-configuration-configuration-info)|
|7|`wall_time_limit`|float|second|*optional*|Limit wall-clock time in seconds. Decimal numbers are allowed. This clock measures the time from the start of the program to its exit, so it does not stop when the program has lost the CPU or when it is waiting for an external event. We recommend to use `cpu_time_limit` as the main limit, but set `wall_time_limit` to a much higher value as a precaution against sleeping programs.|Depends on [configuration](#system-and-configuration-configuration-info)|
|8|`memory_limit`|integer|kilobyte|*optional*|Limit address space of the program in kilobytes.|Depends on [configuration](#system-and-configuration-configuration-info)|
|9|`stack_limit`|integer|kilobyte|*optional*|Limit process stack in kilobytes.|Depends on [configuration](#system-and-configuration-configuration-info)|
|10|`max_processes_and_or_threads`|integer||*optional*|Maximum number of processes and/or threads program can create.|Depends on [configuration](#system-and-configuration-configuration-info)|
|11|`enable_per_process_and_thread_time_limit`|boolean||*optional*|If true then `cpu_time_limit` will be used as per process and thread.|Depends on [configuration](#system-and-configuration-configuration-info)|
|12|`enable_per_process_and_thread_memory_limit`|boolean||*optional*|If true then `memory_limit` will be used as per process and thread.|Depends on [configuration](#system-and-configuration-configuration-info)|
|13|`max_file_size`|integer|kilobyte|*optional*|Limit size of files created (or modified) by the program in kilobytes.|Depends on [configuration](#system-and-configuration-configuration-info)|
|14|`number_of_runs`|integer||*optional*|Run each program that many times and take average of time and memory.|Depends on [configuration](#system-and-configuration-configuration-info)|
|15|`stdout`|string|||Output of your program to standard output after execution.|
|16|`stderr`|string|||Output of your program to standard error after execution.|
|17|`status`|object|||[Status](#statuses-and-languages-statuses) of your program.|
|18|`created_at`|datetime|||Date and time when your submission was created.|
|19|`finished_at`|datetime|||Date and time when you submission was finished.|
|20|`token`|string|||Unique token of your submission.|
|21|`time`|float|second||Run time of your program.|
|22|`memory`|integer|kilobyte||Memory used by your program.|

Attributes **#1** - **#14** are used when creating new submissions, and attributes **#15** - **#22** represent detailed information about runtime of your
submission.

Attributes **#5** - **#14** are called *configuration attributes* or *configuration variables*. Please read
more about them in [configuration](#system-and-configuration-configuration-info) section.

### Show [GET]
+ Parameters
  + `token`: `d85cd024-1548-4165-96c7-7bc88673f194` (required, string) - Token of Submission

+ Response 200 (application/json)
  + Body
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
  + Body
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

### Create [POST]
Creates new submission. Created submission waits in queue to be processed. On successful
creation, you are returned submission token which can be used to check submission status.

If `expected_output` is `null` then `stdout` won't be compared with `expected_output` at the end of
submission execution.

Attributes **#5** - **#14** can be `null`. If `null` they will get *default configuration value* for each of
*configuration variables*. For detailed information please read [configuration](#system-and-configuration-configuration-info) section.

+ Request (application/json)
  {
    "source_code": "#include \n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
    "language_id": "3"
  }

+ Response 201 (application/json)
  + Body
    {
      "token": "d85cd024-1548-4165-96c7-7bc88673f194"
    }


+ Request (application/json)
  {
    "source_code": "#include \n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}"
  }

+ Response 422 (application/json)
  {
    "language_id": [
        "can't be blank"
    ]
  }

+ Request (application/json)
  {
    "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  sc(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
    "language_id": 150000,
    "input": "world",
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
    "source_code": "#include \n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
    "language_id": "3",
    "number_of_runs": "1",
    "input": "Judge0",
    "expected_output": "hello, Judge0",
    "cpu_time_limit": "1",
    "cpu_extra_time": "0.5",
    "wall_time_limit": "100000",
    "memory_limit": "128000",
    "stack_limit": "128000",
    "enable_per_process_and_thread_time_limit": false,
    "enable_per_process_and_thread_memory_limit": false,
    "max_file_size": "1024"
  }

+ Response 422 (application/json)
  {
    "wall_time_limit": [
      "must be less than or equal to 150"
    ]
  }

# Group Statuses and Languages

## Statuses [/statuses]

### List all statuses [GET]

+ Response 200
  [
    {
      "id": 1,
      "description": "In Queue"
    },
    {
      "id": 2,
      "description": "Processing"
    },
    {
      "id": 3,
      "description": "Accepted"
    },
    {
      "id": 4,
      "description": "Wrong Answer"
    },
    {
      "id": 5,
      "description": "Time Limit Exceeded"
    },
    {
      "id": 6,
      "description": "Compilation Error"
    },
    {
      "id": 7,
      "description": "Runtime Error (SIGSEGV)"
    },
    {
      "id": 8,
      "description": "Runtime Error (SIGXFSZ)"
    },
    {
      "id": 9,
      "description": "Runtime Error (SIGFPE)"
    },
    {
      "id": 10,
      "description": "Runtime Error (SIGABRT)"
    },
    {
      "id": 11,
      "description": "Runtime Error (NZEC)"
    },
    {
      "id": 12,
      "description": "Runtime Error (Other)"
    },
    {
      "id": 13,
      "description": "Internal Error"
    }
  ]

## Languages [/languages]

### List all languages [GET]

+ Response 200 (application/json)
  [
    {
      "id": 1,
      "name": "Bash (4.4)"
    },
    {
      "id": 2,
      "name": "Bash (4.0)"
    },
    {
      "id": 3,
      "name": "C (gcc 6.3.0)"
    },
    {
      "id": 4,
      "name": "C (gcc 5.4.0)"
    },
    {
      "id": 5,
      "name": "C (gcc 4.9.4)"
    },
    {
      "id": 6,
      "name": "C (gcc 4.8.5)"
    },
    {
      "id": 7,
      "name": "C++ (g++ 6.3.0)"
    },
    {
      "id": 8,
      "name": "C++ (g++ 5.4.0)"
    },
    {
      "id": 9,
      "name": "C++ (g++ 4.9.4)"
    },
    {
      "id": 10,
      "name": "C++ (g++ 4.8.5)"
    },
    {
      "id": 11,
      "name": "C# (mono 4.8.0.472)"
    },
    {
      "id": 12,
      "name": "Haskell (ghc 8.0.2)"
    },
    {
      "id": 13,
      "name": "Java (OpenJDK 8)"
    },
    {
      "id": 14,
      "name": "Java (OpenJDK 7)"
    },
    {
      "id": 15,
      "name": "Octave (4.2.0)"
    },
    {
      "id": 16,
      "name": "Pascal (fpc 3.0.0)"
    },
    {
      "id": 17,
      "name": "Python (3.6.0)"
    },
    {
      "id": 18,
      "name": "Python (3.5.3)"
    },
    {
      "id": 19,
      "name": "Python (2.7.9)"
    },
    {
      "id": 20,
      "name": "Python (2.6.9)"
    },
    {
      "id": 21,
      "name": "Ruby (2.4.0)"
    },
    {
      "id": 22,
      "name": "Ruby (2.3.3)"
    },
    {
      "id": 23,
      "name": "Ruby (2.2.6)"
    },
    {
      "id": 24,
      "name": "Ruby (2.1.9)"
    }
  ]

# Group System and Configuration

## System Info [/system_info]
### System Info [GET]

System information gives you detailed information about system on which Judge0 API is running.

This information is result of two commands on a host system:
- `lscpu`
- `free -h`

Please note that Judge0 API consists of two systems: *web* and *worker*. *Web* system is the one who
provides you the API, and *Worker* is the one who runs (processes) your programs. They can be placed on two or more
different hosts with different system configurations. Result of this API request is always from *web* system.
This means that this request might be irrelevant to you if you as user don't know if *web* and *worker* are
hosted on the same machine. To find that out, please contact admins who host Judge0 API you are using.

+ Response

  {
    "Architecture": "x86_64",
    "CPU op-mode(s)": "32-bit, 64-bit",
    "Byte Order": "Little Endian",
    "CPU(s)": "4",
    "On-line CPU(s) list": "0-3",
    "Thread(s) per core": "2",
    "Core(s) per socket": "2",
    "Socket(s)": "1",
    "NUMA node(s)": "1",
    "Vendor ID": "GenuineIntel",
    "CPU family": "6",
    "Model": "61",
    "Model name": "Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz",
    "Stepping": "4",
    "CPU MHz": "2508.703",
    "CPU max MHz": "2700.0000",
    "CPU min MHz": "500.0000",
    "BogoMIPS": "4392.12",
    "Virtualization": "VT-x",
    "L1d cache": "32K",
    "L1i cache": "32K",
    "L2 cache": "256K",
    "L3 cache": "3072K",
    "NUMA node0 CPU(s)": "0-3",
    "Mem": "7.7G",
    "Swap": "8.0G"
  }

## Configuration Info [/config_info]
## Configuration Info [GET]

Configuration information gives you detailed information about configuration of Judge0 API.
This configuration can be changed through [judge0-api.conf](https://github.com/judge0/api/blob/master/judge0-api.conf) file by admin who hosts his Judge0 API instance.

This configuration gives every admin a flexibility to configure his Judge0 API according to his server abilities, and admin needs. It also gives users
insight of some *default configuration values* which are used when their program is run.

Each of these *configuration variables* have *default values* which we consider as recommended in case you are not sure should you change them.

We will refer to *default values* as values which Judge0 API automatically assigns to each of these *configuration variables* if admin didn't set them. For example default value of *configuration variable* `cpu_time_limit` is `1`.

|#|Configuration Variable|Type|Unit|Description|Default Value|
|:-:|:-:|:-:|:-:|-|:-:|
|1|`cpu_time_limit`|float|second|Default runtime limit for every program (in seconds). Decimal numbers are allowed. Time in which the OS assigns the processor to different tasks is not counted.|1|
|2|`cpu_extra_time`|float|second|When a time limit is exceeded, wait for extra time (in seconds), before killing the program. This has the advantage that the real execution time is reported, even though it slightly exceeds the limit.|0.5|
|3|`wall_time_limit`|float|second|Limit wall-clock time in seconds. Decimal numbers are allowed. This clock measures the time from the start of the program to its exit, so it does not stop when the program has lost the CPU or when it is waiting for an external event. We recommend to use `cpu_time_limit` as the main limit, but set `wall_time_limit` to a much higher value as a precaution against sleeping programs.|10|
|4|`memory_limit`|integer|kilobyte|Limit address space of the program in kilobytes.|128000|
|5|`stack_limit`|integer|kilobyte|Limit process stack in kilobytes.|128000|
|6|`max_processes_and_or_threads`|integer||Maximum number of processes and/or threads program can create.|15|
|7|`enable_per_process_and_thread_time_limit`|boolean||If true then `cpu_time_limit` will be used as per process and thread.|false|
|8|`enable_per_process_and_thread_memory_limit`|boolean||If true then `memory_limit` will be used as per process and thread.|false|
|9|`max_file_size`|integer|kilobyte|Limit size of files created (or modified) by the program in kilobytes.|1024|
|10|`number_of_runs`|integer||Run each program that many times and take average of time and memory.|1|

*Default configuration value* for each variable is given to you, a user, as response of this API call. For example *default configuration value*
for variable `cpu_extra_time` might be `2`, and if admin didn't set this, then it is `0.5` (*default value*).
This means that admin set `cpu_extra_time` *configuration variable* to value `2` and we say it is now *default configuration value* for this
variable `cpu_extra_time`.

Every [submission](#submissions-submission) can change each of the configuration variables according to its needs. For example,
user might create submission which has `cpu_time_limit` of `5` seconds. For security reasons we need to limit values of each of these
configuration variables. For example, we don't want user to create a submission which has `cpu_time_limit` of `100000` seconds.

For this security reason we are introducing *limit configuration variables* for each *configuration variable*.

|#|Limit Configuration Variable|Type|Unit|Description|Default Value|
|:-:|:-:|:-:|:-:|-|:-:|
|1|`max_cpu_time_limit`|float|second|Maximum custom `cpu_time_limit`.|15|
|2|`max_cpu_extra_time`|float|second|Maximum custom `cpu_extra_time`.|5|
|3|`max_wall_time_limit`|float|second|Maximum custom `wall_time_limit`.|150|
|4|`max_memory_limit`|integer|kilobyte|Maximum custom `memory_limit`.|512000|
|5|`max_stack_limit`|integer|kilobyte|Maximum custom `stack_limit`.|512000|
|6|`max_max_processes_and_or_threads`|integer||Maximum custom `max_max_processes_and_or_threads`.|30|
|7|`allow_enable_per_process_and_thread_time_limit`|boolean||If false, user won't be able to set `enable_per_process_and_thread_time_limit`.|true|
|8|`allow_enable_per_process_and_thread_memory_limit`|boolean||If false, user won't be able to set `enable_per_process_and_thread_memory_limit`.|true|
|9|`max_max_file_size`|integer|kilobyte|Maximum custom `max_file_size`|4096|
|10|`max_number_of_runs`|integer||Maximum custom `number_of_runs`|20|

For example, `max_cpu_time_limit` with value `20` means that user cannot create new submission which has `cpu_time_limit` greater than `20`.

+ Response
  {
    "cpu_time_limit": 1,
    "max_cpu_time_limit": 15,
    "cpu_extra_time": 0.5,
    "max_cpu_extra_time": 5,
    "wall_time_limit": 10,
    "max_wall_time_limit": 150,
    "memory_limit": 128000,
    "max_memory_limit": 512000,
    "stack_limit": 128000,
    "max_stack_limit": 512000,
    "max_processes_and_or_threads": 15,
    "max_max_processes_and_or_threads": 30,
    "enable_per_process_and_thread_time_limit": false,
    "allow_enable_per_process_and_thread_time_limit": true,
    "enable_per_process_and_thread_memory_limit": false,
    "allow_enable_per_process_and_thread_memory_limit": true,
    "max_file_size": 1024,
    "max_max_file_size": 4096,
    "number_of_runs": 1,
    "max_number_of_runs": 20
  }
