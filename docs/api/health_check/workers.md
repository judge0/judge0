## Workers Health Check [/workers]
### Workers Health Check [GET]
For each queue you will get:
- `queue` name
- `available` number of workers
- how many workers are `idle`
- how many workers are currently `working`
- how many workers are `paused`
- how many jobs `failed`

+ Response 200 (application/json)
    [
        {
            "queue": "default"
            "available": 1,
            "idle": 1,
            "working": 0,
            "paused": 0,
            "failed": 0
        }
    ]