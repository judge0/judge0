## Group Submissions
## Submission [/submissions/{token}{?base64_encoded,wait,fields,page,per_page}]
Submission is used for running arbitrary source code in one of
the [available programming languages](#statuses-and-languages-language-get) with specified runtime constraints.

Submission has 33 attributes. Attributes 1-20 are used for creating a new submissions, whereas
attributes 21-33 give detailed information of submission after it's execution.

Attributes 7-18 are called [*configuration variables*](#system-and-configuration-configuration-info)
and can be used to configure submission runtime constraints such as time and memory limits.

|#    |Name |Type  |Unit  |Description |Default Value |
|:---:|:----|:----:|:----:|:-----------|:-------------|
|1|**`source_code`**|text||Program's source code.|No default. This attribute is **required** for [single-file programs](#header-single-file-programs-and-multi-file-programs).|
|2|**`language_id`**|integer||[Language](#statuses-and-languages-language) ID.|No default. This attribute is **required**.|
|3|`compiler_options`|string (max. 512 chars)||Options for the compiler (i.e. compiler flags).|`null`|
|4|`command_line_arguments`|string (max. 512 chars)||Command line arguments for the program.|`null`|
|5|`stdin`|text||Input for program.|`null`. Program won't receive anything to standard input.|
|6|`expected_output`|text||Expected output of program. Used when you want to compare with `stdout`.|`null`. Program's `stdout` won't be compared with `expected_output`.|
|7|`cpu_time_limit`|float|second|Default runtime limit for every program. Time in which the OS assigns the processor to different tasks is not counted.|Depends on [configuration](#system-and-configuration-configuration-info).|
|8|`cpu_extra_time`|float|second|When a time limit is exceeded, wait for extra time, before killing the program. This has the advantage that the real execution time is reported, even though it slightly exceeds the limit.|Depends on [configuration](#system-and-configuration-configuration-info).|
|9|`wall_time_limit`|float|second|Limit wall-clock time in seconds. Decimal numbers are allowed. This clock measures the time from the start of the program to its exit, so it does not stop when the program has lost the CPU or when it is waiting for an external event. We recommend to use `cpu_time_limit` as the main limit, but set `wall_time_limit` to a much higher value as a precaution against sleeping programs.|Depends on [configuration](#system-and-configuration-configuration-info).|
|10|`memory_limit`|float|kilobyte|Limit address space of the program.|Depends on [configuration](#system-and-configuration-configuration-info).|
|11|`stack_limit`|integer|kilobyte|Limit process stack.|Depends on [configuration](#system-and-configuration-configuration-info).|
|12|`max_processes_and_or_threads`|integer||Maximum number of processes and/or threads program can create.|Depends on [configuration](#system-and-configuration-configuration-info).|
|13|`enable_per_process_and_thread_time_limit`|boolean||If `true` then `cpu_time_limit` will be used as per process and thread.|Depends on [configuration](#system-and-configuration-configuration-info).|
|14|`enable_per_process_and_thread_memory_limit`|boolean||If `true` then `memory_limit` will be used as per process and thread.|Depends on [configuration](#system-and-configuration-configuration-info).|
|15|`max_file_size`|integer|kilobyte|Limit file size created or modified by the program.|Depends on [configuration](#system-and-configuration-configuration-info).|
|16|`redirect_stderr_to_stdout`|boolean||If `true` standard error will be redirected to standard output.|Depends on [configuration](#system-and-configuration-configuration-info).|
|17|`enable_network`|boolean||If `true` program will have network access.|Depends on [configuration](#system-and-configuration-configuration-info).|
|18|`number_of_runs`|integer||Run each program `number_of_runs` times and take average of `time` and `memory`.|Depends on [configuration](#system-and-configuration-configuration-info).|
|19|**`additional_files`**|Base64 Encoded String||Additional files that should be available alongside the source code. Value of this string should represent the content of a `.zip` that contains additional files. This attribute is **required** for [multi-file programs](#header-single-file-programs-and-multi-file-programs).|`null`|
|20|`callback_url`|string||URL on which Judge0 will issue `PUT` request with the submission in a request body after submission has been done.|`null`|
|21|`stdout`|text||Standard output of the program after execution.||
|22|`stderr`|text||Standard error of the program after execution.||
|23|`compile_output`|text||Compiler output after compilation.||
|24|`message`|text||If submission status is `Internal Error` then this message comes from Judge0 itself, otherwise this is status message from [isolate](https://github.com/ioi/isolate).||
|25|`exit_code`|integer||The program's exit code.||
|26|`exit_signal`|integer||Signal code that the program recieved before exiting.||
|27|`status`|object||Submission [status](#statuses-and-languages-status).||
|28|`created_at`|datetime||Date and time when submission was created.||
|29|`finished_at`|datetime||Date and time when submission was processed.|`null` if submission is still in queue or if submission is processing.|
|30|`token`|string||Unique submission token which can be used to [get a specific submission](#submissions-submission-get).||
|31|`time`|float|second|Program's run time.||
|32|`wall_time`|float|second|Program's wall time. Will be greater or equal to `time`.||
|33|`memory`|float|kilobyte|Memory used by the program after execution.||

### Single-file programs and multi-file programs
Judge0 can run both single-file and multi-file programs in a sandboxed environment with specified resource limitations.
The usage of multi-file programs is slightly different from single-file programs and this section explains their differences and when they should be used.

#### Single-file programs
This is the simplest way to run a program with Judge0. Pick a [language](#statuses-and-languages-language-get) with `language_id`, provide a `source_code` and Judge0 will use predefined compilation and execution scripts for specified language. Additionally you can set custom compile flags, provide command line arguments and send `additional_files` that will be available in the sandbox alongside your single-file program.

With `additional_files` you can send, for example, Python modules which are imported by your main program that you provided in `source_code` attribute. For C or C++ programs with `additional_files` you can send header files which are included by your main program that you provided in `source_code` attribute.

Even though you can send and use multiple Python modules or C and C++ header files, we call this *single-file programs* because for compiled languages only **one** source file is compiled with predefined compilation scripts.

#### Multi-file programs
Multi-file programs are available since [v1.10.0](https://github.com/judge0/judge0/tree/v1.10.0) and they allow you specify your own compilation and execution scripts that Judge0 will use.

To use multi-file program feature you need to choose a language called *Multi-file program* whoose ID is **89**. Moreover, you need to send all program files with `additional_files` attribute. With multi-file programs attribute `source_code` cannot be used, i.e. all files should be sent with `additional_files` attribute.

As mentioned in the table above, `additional_files` attribute should be a content of a Base64 encoded `.zip` archive. This archive will be extracted in the sandbox before compilation and execution.

For the Judge0 to know how to compile and execute your multi-file program you need to provide two special files that should be available in the root of the `.zip` archive that you are sending with `additional_files` attribute. These files should be named `compile` and `run`, and are expected to be Bash scripts that know how to compile and execute your multi-file program. If your multi-file program does not need compilation step, then you don't need to provide `compile` script. Take a look at [this example](https://github.com/judge0/examples/tree/master/cpp-and-cmake-01) to learn how to use this feature to compile and run multi-file C++ project that uses CMake.

<!-- include(create_a_submission.md) -->
<!-- include(get_a_submission.md) -->
<!-- include(get_submissions.md) -->
<!-- include(delete_a_submission.md) -->

## Submission Batch [/submissions/batch{?tokens,base64_encoded,fields}]

<!-- include(create_a_submission_batch.md) -->
<!-- include(get_a_submission_batch.md) -->
