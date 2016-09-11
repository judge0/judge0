FORMAT: 1A
HOST: http://api.judge0.com

# judge0 API docs

# About

[Judge0](http://judge0.com) is an open source online judge API for code compilation and execution on given test data.

Project source can be found at [Github](https://github.com/hermanzdosilovic/judge0).

# Date and time formats

[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

<br><br>

## Group Submissions

## Submission [/submissions/{submission_id}]

A Submission object has the following attributes:

+ `source_code`(required) - source code you want to run
+ `language_id`(required) - ID of [language](/#languages-and-statuses) in which code will be run
+ `input` - input which will be redirected to your program
+ `expected_output` - expected output of the program
+ `actual_output` - actual output of you program after it has been run
+ `status` - [status](#languages-and-statuses) or result of execution of your program
+ `created_at` - time and date denoting when your submission was created
+ `finished_at` - time and date denoting when your submission was processed and finished
+ `time` - time in seconds representing CPU time your program needed to finish
+ `memory` - memory in KB representing memory usage of your program

### Show [GET]

+ Parameters
  + `submission_id`: 36 (required, number) - ID of Submission


+ Response 200 (application/json)
  + Body

      {
        "id": 36,
        "status": {
          "id": 1,
          "description": "In Queue"
        },
        "actual_output": null,
        "created_at": "2016-09-11T14:48:01.863Z",
        "finished_at": null,
        "time": null,
        "memory": null
      }

+ Response 200 (application/json)
  + Body
      {
        "id": 36,
        "status": {
          "id": 2,
          "description": "Accepted"
        },
        "actual_output": "hello, world\n",
        "created_at": "2016-09-11T14:48:01.863Z",
        "finished_at": "2016-09-11T14:49:58.003Z",
        "time": "0.001",
        "memory": 292
      }

### Create [POST]

Create new Submission, `source_code` and `language_id` are required.

+ Request (application/json)

      {
        "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
        "language_id": 1,
        "input": "world",
        "expected_output": "hello, world"
      }

+ Response 201 (application/json)

  + Body
      
      {
        "id": 36
      }

+ Request (application/json)

      {
        "language_id": 1,
        "input": "world",
        "expected_output": "hello, world"
      }

+ Response 422 (application/json)

      {
        "source_code": [
          "can't be blank"
        ]
      }

+ Request (application/json)

      {
        "source_code": "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  sc(\"%s\", name);\n  printf(\"hello, %s\\n\", name);\n  return 0;\n}",
        "input": "world",
        "expected_output": "hello, world"
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
        "language_id": 150,
        "input": "world",
        "expected_output": "hello, world"
      }

+ Response 422 (application/json)

      {
        "language_id": [
          "language with id 150 doesn't exist"
        ]
      }

# Group Languages and Statuses

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
      "description": "Accepted"
    },
    {
      "id": 3,
      "description": "Wrong Answer"
    },
    {
      "id": 4,
      "description": "Time Limit Exceeded"
    },
    {
      "id": 5,
      "description": "Compilation Error"
    },
    {
      "id": 6,
      "description": "Runtime Error (SIGSEGV)"
    },
    {
      "id": 7,
      "description": "Runtime Error (SIGXFSZ)"
    },
    {
      "id": 8,
      "description": "Runtime Error (SIGFPE)"
    },
    {
      "id": 9,
      "description": "Runtime Error (SIGABRT)"
    },
    {
      "id": 10,
      "description": "Runtime Error (NZEC)"
    },
    {
      "id": 11,
      "description": "Runtime Error (Other)"
    },
    {
      "id": 12,
      "description": "Internal Error"
    }
  ]

## Languages [/languages]

### List all languages [GET]

+ Response 200 (application/json)

  [
    {
      "id": 1,
        "name": "C (gcc 4.7)"
    },
    {
      "id": 2,
      "name": "C (gcc 4.8)"
    },
    {
      "id": 3,
      "name": "C (gcc 4.9)"
    },
    {
      "id": 4,
      "name": "C (gcc 5.4)"
    },
    {
      "id": 5,
      "name": "C++ (g++ 4.7)"
    },
    {
      "id": 6,
      "name": "C++ (g++ 4.8)"
    },
    {
      "id": 7,
      "name": "C++ (g++ 4.9)"
    },
    {
      "id": 8,
      "name": "C++ (g++ 5.4)"
    },
    {
      "id": 9,
      "name": "Java (SE 1.6)"
    },
    {
      "id": 10,
      "name": "Java (SE 1.7)"
    },
    {
      "id": 11,
      "name": "Java (SE 1.8)"
    },
    {
      "id": 12,
      "name": "Ruby (1.9.3)"
    },
    {
      "id": 13,
      "name": "Ruby (2.2.5)"
    },
    {
      "id": 14,
      "name": "Ruby (2.3.1)"
    },
    {
      "id": 15,
      "name": "Python (2.7.12)"
    },
    {
      "id": 16,
      "name": "Python (3.5.2)"
    }
  ]
