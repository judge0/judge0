## Configuration Info [/config_info]
Configuration information gives you detailed information about configuration of Judge0 API.
This configuration can be changed through [judge0-api.conf](https://github.com/judge0/api/blob/master/judge0-api.conf) file by admin who hosts Judge0 API instance.

This configuration gives every admin a flexibility to configure Judge0 API according to server abilities and needs. It also gives users
insight on some *default configuration values* which are used when their submission is run.

Each of these *configuration variables* have *default values* which we consider as recommended in case you are not sure should you change them.

We will refer to *default values* as values which Judge0 API automatically assigns to each of these *configuration variables*, if admin didn't set them. For example default value of *configuration variable* `cpu_time_limit` is `1`.

Following configuration variables are available:

#### 1. `cpu_time_limit`
- **Type**: float
- **Unit**: second
- **Description**: Default runtime limit for every submission. Time in which the OS assigns the processor to different tasks is not counted.
- **Default Value**: 1

#### 2. `cpu_extra_time`
- **Type**: float
- **Unit**: second
- **Description**: Extra wait time after `cpu_time_limit` has been exceeded. This has the advantage that
the real execution time is reported, even though it slightly exceeds time limit.
- **Default Value**: 0.5

#### 3. `wall_time_limit`
- **Type**: float
- **Unit**: second
- **Description**: Wall-clock time limit for submission. This clock measures time from the start of the submission to its exit,
so it does not stop when submission lost the CPU or when it is waiting for an external event. We recommend to use `cpu_time_limit` as the main
limit, but set `wall_time_limit` to a much higher value as a precaution against sleeping programs.
- **Default Value**: 10

#### 4. `memory_limit`
- **Type**: integer
- **Unit**: kilobyte
- **Description**: Address space limit for submission.
- **Default Value**: 128000

#### 5. `stack_limit`
- **Type**: integer
- **Unit**: kilobyte
- **Description**: Stack space limit for submission.

#### 6. `max_processes_and_or_threads`
- **Type**: integer
- **Description**: Maximum number of processes and/or threads submission can create.
- **Default Value**: 15

#### 7. `enable_per_process_and_thread_time_limit`
- **Type**: boolean
- **Description**: If `true` then `cpu_time_limit` will be used as per process and thread.
- **Default Value**: false

#### 8. `enable_per_process_and_thread_memory_limit`
- **Type**: boolean
- **Description**: If `true` then `memory_limit` will be used as per process and thread.
- **Default Value**: false

#### 9. `max_file_size`
- **Type**: integer
- **Description**: Limit file size created or modified by submission
- **Default Value**: 1024

#### 10. `number_of_runs`
- **Type**: integer
- **Description**: Run each submission `number_of_runs` times and take average of time and memory.
- **Default Value**: 1

*Default configuration value* for each variable is given to you as response of this API call. For example *default configuration value*
for variable `cpu_extra_time` might be `2`, and if admin didn't set this, then it is `0.5` (*default value*).
This means that admin set `cpu_extra_time` *configuration variable* to value `2` and we say it is now *default configuration value* for this
variable `cpu_extra_time`.

Every [submission](#submissions-submission) can change each of the configuration variables according to its needs. For example,
user might create submission which has `cpu_time_limit` of `5` seconds. For security reasons we need to limit values of each of these
configuration variables. For example, we don't want user to create a submission which has `cpu_time_limit` of `100000` seconds.

For this security reason we are introducing *limit configuration variables* for each *configuration variable*.

#### 1. `max_cpu_time_limit`
- **Type**: float
- **Unit**: second
- **Description**: Maximum custom `cpu_time_limit`.
- **Default Value**: 15

#### 2. `max_cpu_extra_time`
- **Type**: float
- **Unit**: second
- **Description**: Maximum custom `cpu_extra_time`.
- **Default Value**: 5

#### 3. `max_wall_time_limit`
- **Type**: float
- **Unit**: second
- **Description**: Maximum custom `wall_time_limit`.
- **Default Value**: 150

#### 4. `max_memory_limit`
- **Type**: integer
- **Unit**: kilobyte
- **Description**: Maximum custom `memory_limit`.
- **Default Value**: 512000

#### 5. `max_stack_limit`
- **Type**: integer
- **Unit**: kilobyte
- **Description**: Maximum custom `stack_limit`.
- **Default Value**: 512000

#### 6. `max_max_processes_and_or_threads`
- **Type**: integer
- **Description**: Maximum custom `max_processes_and_or_threads`.
- **Default Value**: 30

#### 7. `allow_enable_per_process_and_thread_time_limit`
- **Type**: integer
- **Description**: If `false`, user won't be able to set `enable_per_process_and_thread_time_limit`.
- **Default Value**: `true`

#### 8. `allow_enable_per_process_and_thread_memory_limit`
- **Type**: integer
- **Description**: If `false`, user won't be able to set `enable_per_process_and_thread_memory_limit`.
- **Default Value**: `true`

#### 9. `max_max_file_size`
- **Type**: integer
- **Unit**: kilobyte
- **Description**: Maximum custom `max_file_size`
- **Default Value**: 4096

#### 10. `max_number_of_runs`
- **Type**: integer
- **Description**: Maximum custom `number_of_runs`
- **Default Value**: 20

For example, `max_cpu_time_limit` with value `20` means that user cannot create new submission which has `cpu_time_limit` greater than `20`.

## Configuration Info [GET]
+ Response 200 (application/json)
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