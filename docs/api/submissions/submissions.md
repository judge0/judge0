## Group Submissions
## Submission [/submissions/{token}{?base64_encoded}]
Submission has following attributes:

#### 1. `source_code`
- **Type**: string
- **Required/Optional**: required
- **Description**: Source code of submission.

#### 2. `language_id`
- **Type**: integer
- **Required/Optional**: required
- **Description**: [Language](#statuses-and-languages-languages) ID.

#### 3. `input`
- **Type**: string
- **Required/Optional**: optional
- **Description**: Input for submission.
- **Default Value**: `null`. Submission won't recieve anything to standard input.

#### 4. `expected_output`
- **Type**: string
- **Required/Optional**: optional
- **Description**: Expected output of submission. Used when you want to compare with `stdout`.
- **Default Value**: `null`. Submission result `stdout` won't be compared with `expected_output`. 

#### 5. `cpu_time_limit`
- **Type**: float
- **Unit**: second
- **Required/Optional**: optional
- **Description**: Runtime limit for submission.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 6. `cpu_extra_time`
- **Type**: float
- **Unit**: second
- **Required/Optional**: optional
- **Description**: Extra wait time after `cpu_time_limit` has been exceeded.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 7. `wall_time_limit`
- **Type**: float
- **Unit**: second
- **Required/Optional**: optional
- **Description**: Wall-clock time limit for submission.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 8. `memory_limit`
- **Type**: integer
- **Unit**: kilobyte
- **Required/Optional**: optional
- **Description**: Address space limit for submission.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 9. `stack_limit`
- **Type**: ineger
- **Unit**: kilobyte
- **Required/Optional**: optional
- **Description**: Stack limit for submission.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).


#### 10. `max_processes_and_or_threads`
- **Type**: integer
- **Required/Optional**: optional
- **Description**: Maximum number of processes and/or threads submission can create.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 11. `enable_per_process_and_thread_time_limit`
- **Type**: boolean
- **Required/Optional**: optional
- **Description**: If `true` then `cpu_time_limit` will be used as per process and thread.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 12. `enable_per_process_and_thread_memory_limit`
- **Type**: boolean
- **Required/Optional**: optional
- **Description**: If `true` then `memory_limit` will be used as per process and thread.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 13. `max_file_size`
- **Type**: integer
- **Unit**: kilobyte
- **Required/Optional**: optional
- **Description**: Limit file size created or modified by submission.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 14. `number_of_runs`
- **Type**: integer
- **Required/Optional**: optional
- **Description**: Run each submission `number_of_runs` times and take average of time and memory.
- **Default Value**: Depends on [configuration](#system-and-configuration-configuration-info).

#### 15. `stdout`
- **Type**: string
- **Description**: Standard output of submission after execution.

#### 16. `stderr`
- **Type**: string
- **Description**: Standard error of submission after execution.

#### 17. `status`
- **Type**: object
- **Description**: [Status](#statuses-and-languages-statuses) of submission.

#### 18. `created_at`
- **Type**: datetime
- **Description**: Date and time when submission was created.

#### 19. `finished_at`
- **Type**: datetime
- **Description**: Date and time when submission was processed.
- **Default Value**: `null` if submission is still in queue or if submission is processing.

#### 20. `token`
- **Type**: string
- **Description**: Unique token of submission. Used to access submission results asynchronically.

#### 21. `time`
- **Type**: float
- **Unit**: second
- **Description**: Run time of submission.

#### 22. `memory`
- **Type**: float
- **Unit**: second
- **Description**: Memory used by submission.

---

Attributes **#1** - **#14** are used when creating new submissions, and attributes **#15** - **#22** represent detailed information about runtime of submission.

Attributes **#5** - **#14** are called *configuration attributes* or *configuration variables*. Please read
more about them in [configuration](#system-and-configuration-configuration-info) section.

<!-- include(create.md) -->
<!-- include(show.md) -->