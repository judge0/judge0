# vX.Y.Z (YYYY-MM-DD)
## API Changes

## New Features

## Improvements

## Security Improvements

## Bug Fixes

## Security Fixes

## Other Changes

## Deployment Procedure
Judge0 is collecting telemetry data to help understand how to improve the product and to better understand how Judge0 is used in various production environments. Read more about telemetry [here](https://github.com/judge0/api/blob/vX.Y.Z/TELEMETRY.md).

### With HTTPS (SSL/TLS)
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/vX.Y.Z/judge0-vX.Y.Z-https.zip
unzip judge0-vX.Y.Z-https.zip
```

3. Change directory to `judge0-vX.Y.Z-https`:
```
cd judge0-vX.Y.Z-https
```
4. Edit `docker-compose.yml` and change variables `VIRTUAL_HOST`, `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL`.
5. Run all services and wait few seconds until everything is initialized:
```
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

6. Your instance of Judge0 vX.Y.Z is now available at `https://<YOUR DOMAIN>`.

### With HTTP
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/vX.Y.Z/judge0-vX.Y.Z.zip
unzip judge0-vX.Y.Z.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-vX.Y.Z
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

4. Your instance of Judge0 vX.Y.Z is now available at `http://<IP ADDRESS OF YOUR SERVER>`.