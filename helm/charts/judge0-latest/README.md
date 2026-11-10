judge0
======
Helm implementation of Judge0 | Free ,robust and scalable open-source online code execution system.

Current chart version is `1.0.0`

Source code can be found [here](https://api.judge0.com)

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-charts.storage.googleapis.com/ | postgresql | 7.7.2 |
| https://kubernetes-charts.storage.googleapis.com/ | redis | 10.2.0 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| COUNT | int | `3` |  |
| MAINTENANCE_MODE | bool | `false` |  |
| RAILS_MAX_THREADS | int | `10` |  |
| external.postgresql.host | string | `"localhost"` |  |
| external.postgresql.port | int | `5432` |  |
| external.postgresql.postgresqlDatabase | string | `"judge"` |  |
| external.postgresql.postgresqlPassword | string | `""` |  |
| external.postgresql.postgresqlUsername | string | `"judge"` |  |
| external.redis.host | string | `"localhost"` |  |
| external.redis.password | string | `""` |  |
| external.redis.port | int | `6379` |  |
| image.registry | string | `"docker.io"` |  |
| image.repository | string | `"judge0/api"` |  |
| image.tag | string | `"1.5.0"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.tag | float | `9.6` |  |
| postgresql.postgresqlDatabase | string | `"judge"` |  |
| postgresql.postgresqlPassword | string | `"uaeyjbzuyq"` |  |
| postgresql.postgresqlUsername | string | `"judgemaster"` |  |
| redis.cluster.enabled | bool | `false` |  |
| redis.enabled | bool | `true` |  |
| redis.password | string | `"a8iuw23iuizy"` |  |
| service.annotations | string | `nil` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.nodePorts.http | string | `""` |  |
| service.port | int | `80` |  |
| service.type | string | `"LoadBalancer"` |  |
