## Group Submissions
## Submission [/submissions/{token}{?base64_encoded,wait,fields,page,per_page}]
Submission represents a model for running source code in specific programming language under
certain runtime constraints.

Submission model has **27** attributes. Attributes **1**-**14** (listed below) are used when creating new submissions - you can set them. Out of those 14 attributes only **2** are required - `source_code` and `language_id`. Attributes **15**-**27** represent detailed information about runtime of submission after it's execution.

With attributes **5**-**14** you can configure submission runtime constraints. Those attributes are called *configuration attributes* or *configuration variables*. Please read more about them in [configuration](#system-and-configuration-configuration-info) section.

Submission model has following attributes:
|#    |Name |Type  |Unit  |Description |Default Value |
|:---:|:----|:----:|:----:|:-----------|:-------------|
|1|**`source_code`**|text||Program's source code.|No default. This attribute is **required**.|
|2|**`language_id`**|integer||[Language](#statuses-and-languages-languages) ID.|No default. This attribute is **required**|
|3|`stdin`|text||Input for program.|`null`. Program won't receive anything to standard input.|
|4|`expected_output`|text||Expected output of program. Used when you want to compare with `stdout`.|`null`. Program's `stdout` won't be compared with `expected_output`.|
|5|`cpu_time_limit`|float|second|Default runtime limit for every program. Time in which the OS assigns the processor to different tasks is not counted.|Depends on [configuration](#system-and-configuration-configuration-info).|
|6|`cpu_extra_time`|float|second|When a time limit is exceeded, wait for extra time, before killing the program. This has the advantage that the real execution time is reported, even though it slightly exceeds the limit.|Depends on [configuration](#system-and-configuration-configuration-info).|
|7|`wall_time_limit`|float|second|Limit wall-clock time in seconds. Decimal numbers are allowed. This clock measures the time from the start of the program to its exit, so it does not stop when the program has lost the CPU or when it is waiting for an external event. We recommend to use `cpu_time_limit` as the main limit, but set `wall_time_limit` to a much higher value as a precaution against sleeping programs.|Depends on [configuration](#system-and-configuration-configuration-info).|
|8|`memory_limit`|float|second|Limit address space of the program.|Depends on [configuration](#system-and-configuration-configuration-info).|
|9|`stack_limit`|integer|kilobyte|Limit process stack.|Depends on [configuration](#system-and-configuration-configuration-info).|
|10|`max_processes_and_or_threads`|integer||Maximum number of processes and/or threads program can create.|Depends on [configuration](#system-and-configuration-configuration-info).|
|11|`enable_per_process_and_thread_time_limit`|boolean||If `true` then `cpu_time_limit` will be used as per process and thread.|Depends on [configuration](#system-and-configuration-configuration-info).|
|12|`enable_per_process_and_thread_memory_limit`|boolean||If `true` then `memory_limit` will be used as per process and thread.|Depends on [configuration](#system-and-configuration-configuration-info).|
|13|`max_file_size`|integer|kilobyte|Limit file size created or modified by the program.|Depends on [configuration](#system-and-configuration-configuration-info).|
|14|`number_of_runs`|integer||Run each program `number_of_runs` times and take average of `time` and `memory`.|Depends on [configuration](#system-and-configuration-configuration-info).|
|15|`stdout`|text||Standard output of the program after execution.||
|16|`stderr`|text||Standard error of the program after execution.||
|17|`compile_output`|text||Compiler output after compilation.||
|18|`message`|text||Sandbox's message. Can contain error messages.||
|19|`exit_code`|integer||The program's exit code.||
|20|`exit_signal`|integer||Signal code that the program recieved before exiting.||
|21|`status`|object||Submission [status](#statuses-and-languages-statuses).||
|22|`created_at`|datetime||Date and time when submission was created.||
|23|`finished_at`|datetime||Date and time when submission was processed.|`null` if submission is still in queue or if submission is processing.|
|24|`token`|string||Unique submission token used for [getting specific submission](#submission-submission-get).||
|25|`time`|float|second|Program's runtime.||
|26|`wall_time`|float|second|Program's wall time. Should be greater or equal to `time`.||
|27|`memory`|float|kilobyte|Memory used by the program after execution.||

<!-- include(create_submission.md) -->
<!-- include(get_specific_submission.md) -->
<!-- include(get_all_submissions.md) -->