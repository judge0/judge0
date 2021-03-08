## Configuration Info [/config_info]
## Configuration Info [GET]
Configuration information gives you detailed information about configuration of Judge0.
This configuration can be changed through [judge0.conf](https://github.com/judge0/judge0/blob/master/judge0.conf)
file by admin who hosts Judge0 instance.

This configuration gives every admin a flexibility to configure Judge0 according to server abilities and needs. It also gives users
insight on some *default configuration values* which are used when their programs are run.

Each of these *configuration variables* have *default values* which we consider as recommended in case you are not sure should you change them.

We will refer to *default values* as values which Judge0 automatically assigns to each of these *configuration variables*,
if admin didn't set them. For example, default value of *configuration variable* `cpu_time_limit` is `2`.

|#    |Name|Type |Unit |Description|Default Value|
|:---:|:---|:---:|:---:|:----------|:------------|
|1|`enable_wait_result`|boolean||If enabled user can request to synchronously wait for submission result on submission create.|true|
|2|`enable_compiler_options`|boolean||If enabled user can set `compiler_options`.|true|
|3|`allowed_languages_for_compile_options`|list of strings||Languages for which setting compiler options is allowed.|Empty, i.e. for all languages it is allowed to set compiler options.|
|4|`enable_command_line_arguments`|boolean||If enabled user can set `command_line_arguments`.|true|
|5|`enable_submission_delete`|boolean||If enabled authorized user can [delete a submission](#submissions-submission-delete).|false|
|6|`max_queue_size`|integer||Maximum number of submissions that can wait in queue.|100|
|7|`cpu_time_limit`|float|second|Default runtime limit for every program (in seconds). Decimal numbers are allowed. Time in which the OS assigns the processor to different tasks is not counted.|2|
|8|`cpu_extra_time`|float|second|When a time limit is exceeded, wait for extra time, before killing the program. This has the advantage that the real execution time is reported, even though it slightly exceeds the limit.|0.5|
|9|`wall_time_limit`|float|second|Limit wall-clock time in seconds. Decimal numbers are allowed. This clock measures the time from the start of the program to its exit, for an external event. We recommend to use `cpu_time_limit` as the main limit, but set `wall_time_limit` to a much higher value as a precaution against sleeping programs.|5|
|10|`memory_limit`|integer|kilobyte|Limit address space of the program in kilobytes.|128000|
|11|`stack_limit`|integer|kilobyte|Limit process stack in kilobytes.|64000|
|12|`max_processes_and_or_threads`|integer||Maximum number of processes and/or threads program can create.|60|
|13|`enable_per_process_and_thread_time_limit`|boolean||If `true` then `cpu_time_limit` will be used as per process and thread.|false|
|14|`enable_per_process_and_thread_memory_limit`|boolean||If `true` then `memory_limit` will be used as per process and thread.|true|
|15|`max_file_size`|integer|kilobyte|Limit size of files created (or modified) by the program.|1024|
|16|`allow_enable_network`|boolean||If enabled user can set `enable_network`.|true|
|17|`enable_network`|boolean||If enabled program will have network access.|true|
|18|`number_of_runs`|integer||Run each program this many times and take average of time and memory.|1|

*Default configuration value* for each variable is given to you as response of this API call. For example, *default configuration value*
for variable `cpu_extra_time` might be `2`, and if admin didn't set this, then it is `0.5` (*default value*).
This means that admin set `cpu_extra_time` *configuration variable* to value `2` and we say it is now *default configuration value* for this
variable `cpu_extra_time`.

Every [submission](#submissions-submission) can change each of the configuration variables according to its needs. For example,
user might create submission which has `cpu_time_limit` of `5` seconds. For security reasons we need to limit values of each of these
configuration variables. For example, we don't want user to create a submission which has `cpu_time_limit` of `100000` seconds.

For this security reason we are introducing *limit configuration variables* for each *configuration variable*.

|#    |Name|Type |Unit |Description|Default Value|
|:---:|:---|:---:|:---:|:----------|:------------|
|1|`max_cpu_time_limit`|float|second|Maximum custom `cpu_time_limit`|15|
|2|`max_cpu_extra_time`|float|second|Maximum custom `cpu_extra_time`|2|
|3|`max_wall_time_limit`|float|second|Maximum custom `wall_time_limit`|20|
|4|`max_memory_limit`|integer|kilobyte|Maximum custom `memory_limit`|256000|
|5|`max_stack_limit`|integer|kilobyte|Maximum custom `stack_limit`|128000|
|6|`max_max_processes_and_or_threads`|integer||Maximum custom `max_processes_and_or_threads`|120|
|7|`allow_enable_per_process_and_thread_time_limit`|boolean||If `false` user won't be able to set `enable_per_process_and_thread_time_limit` to `true`|true|
|8|`allow_enable_per_process_and_thread_memory_limit`|boolean||If `false` user won't be able to set `enable_per_process_and_thread_memory_limit` to `true`|true|
|9|`max_max_file_size`|integer|kilobyte|Maximux custom `max_file_size`|4096|
|10|`max_number_of_runs`|integer||Maximum custom `number_of_runs`|20|

For example, `max_cpu_time_limit` with value `20` means that user cannot create new submission which has `cpu_time_limit` greater than `20`.

+ Response 200 (application/json)
    {
        "enable_wait_result": true,
        "enable_compiler_options": true,
        "allowed_languages_for_compile_options": [],
        "enable_command_line_arguments": true,
        "enable_submission_delete": false,
        "max_queue_size": 100,
        "cpu_time_limit": 2,
        "max_cpu_time_limit": 15,
        "cpu_extra_time": 0.5,
        "max_cpu_extra_time": 2,
        "wall_time_limit": 5,
        "max_wall_time_limit": 20,
        "memory_limit": 128000,
        "max_memory_limit": 256000,
        "stack_limit": 64000,
        "max_stack_limit": 128000,
        "max_processes_and_or_threads": 60,
        "max_max_processes_and_or_threads": 120,
        "enable_per_process_and_thread_time_limit": false,
        "allow_enable_per_process_and_thread_time_limit": true,
        "enable_per_process_and_thread_memory_limit": true,
        "allow_enable_per_process_and_thread_memory_limit": true,
        "max_file_size": 1024,
        "max_max_file_size": 4096,
        "number_of_runs": 1,
        "max_number_of_runs": 20
    }