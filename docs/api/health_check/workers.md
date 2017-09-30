## Workers Health Check [/workers]
### Workers Health Check [GET]
For each queue you will get:
- `queue` name
- `total` number of workers that has been initially run
- `available` number of workers
- how many workers are `idle`
- how many workers are currently `working`
- how many workers are `paused`
- how many jobs `failed`

+ Response 200 (application/json)
    [
        {
            "queue": "default",
            "total": 1,
            "available": 1,
            "idle": 1,
            "working": 0,
            "paused": 0,
            "failed": 0
        }
    ]

+ Response 500 (application/json)
    If `total` is not equal to `available`. This means that some workers died.
    + Body
        [
            {
                "queue": "default",
                "total": 3,
                "available": 1,
                "idle": 1,
                "working": 0,
                "paused": 0,
                "failed": 0
            }
        ]