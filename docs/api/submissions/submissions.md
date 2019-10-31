## Group Submissions
## Submission [/submissions/{token}{?base64_encoded,wait,fields,page,per_page}]
Submission represents a model for running source code in specific programming language under
certain runtime constraints.

Submission model has **29** attributes. Attributes **1**-**16** (listed below) are used when creating new submissions - you can set them. Out of those 16 attributes only **2** are required - `source_code` and `language_id`. Attributes **17**-**29** represent detailed information about runtime of submission after it's execution.

With attributes **7**-**16** you can configure submission runtime constraints. Those attributes are called *configuration attributes* or *configuration variables*. Please read more about them in [configuration](#system-and-configuration-configuration-info) section.

Submission model has following attributes:
|#    |Name |Type  |Unit  |Description |Default Value |
|:---:|:----|:----:|:----:|:-----------|:-------------|
|1|**`source_code`**|text||Program's source code.|No default. This attribute is **required**.|
|2|**`language_id`**|integer||[Language](#statuses-and-languages-languages) ID.|No default. This attribute is **required**|
|3|`compiler_options`|string (max. 128 chars)||Options for the compiler (i.e. compiler flags).|`null`|
|4|`command_line_arguments`|string (max. 128 chars)||Command line arguments for the program.|`null`|
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
|16|`number_of_runs`|integer||Run each program `number_of_runs` times and take average of `time` and `memory`.|Depends on [configuration](#system-and-configuration-configuration-info).|
|17|`stdout`|text||Standard output of the program after execution.||
|18|`stderr`|text||Standard error of the program after execution.||
|19|`compile_output`|text||Compiler output after compilation.||
|20|`message`|text||If submission status is `Internal Error` then this message comes from Judge0 API itself, otherwise this is status message from Isolate.||
|21|`exit_code`|integer||The program's exit code.||
|22|`exit_signal`|integer||Signal code that the program recieved before exiting.||
|23|`status`|object||Submission [status](#statuses-and-languages-statuses).||
|24|`created_at`|datetime||Date and time when submission was created.||
|25|`finished_at`|datetime||Date and time when submission was processed.|`null` if submission is still in queue or if submission is processing.|
|26|`token`|string||Unique submission token used for [getting specific submission](#submission-submission-get).||
|27|`time`|float|second|Program's runtime.||
|28|`wall_time`|float|second|Program's wall time. Will be greater or equal to `time`.||
|29|`memory`|float|kilobyte|Memory used by the program after execution.||

<!-- include(create_submission.md) -->
<!-- include(get_specific_submission.md) -->
<!-- include(get_all_submissions.md) -->
