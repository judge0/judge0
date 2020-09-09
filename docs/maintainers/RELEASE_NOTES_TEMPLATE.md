# vX.Y.Z-extra (YYYY-MM-DD)
## API Changes

## New Features

## Improvements

## Security Improvements

## Bug Fixes

## Security Fixes

## Other Changes

## Deployment Procedure
Judge0 is collecting telemetry data to help understand how to improve the product and to better understand how Judge0 is used in various production environments. Read more about telemetry [here](https://github.com/judge0/judge0/blob/vX.Y.Z-extra/TELEMETRY.md).

Please note that Judge0 has only been tested on **Linux** and might not work on Windows or macOS, thus we do not provide support for these systems.

### With HTTP
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/judge0/releases/download/vX.Y.Z-extra/judge0-vX.Y.Z-extra.zip
unzip judge0-vX.Y.Z-extra.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-vX.Y.Z-extra
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

4. Your instance of Judge0 vX.Y.Z-extra is now available at `http://<IP ADDRESS OF YOUR SERVER>`.

### With HTTPS (SSL/TLS)
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/judge0/releases/download/vX.Y.Z-extra/judge0-vX.Y.Z-extra-https.zip
unzip judge0-vX.Y.Z-extra-https.zip
```

3. Change directory to `judge0-vX.Y.Z-extra-https`:
```
cd judge0-vX.Y.Z-extra-https
```
4. Edit `docker-compose.yml` and change variables `VIRTUAL_HOST`, `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL`.
5. Run all services and wait few seconds until everything is initialized:
```
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

6. Your instance of Judge0 vX.Y.Z-extra is now available at `https://<YOUR DOMAIN>`.
