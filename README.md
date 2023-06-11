[![Judge0 Wallpaper](./.github/judge0-colored.png)](https://ce.judge0.com)
# Judge0 for waffledotcom-server

## Installation (Tentative)

Make sure you are running linux. In M1 macs, `isolate` won't work.

```bash
docker build -t waffledotcom-judge-compilers -f Dockerfile-compilers . && docker build -t waffledotcom-judge -f Dockerfile .
docker-compose up -d
```

## License
Judge0 is licensed under the [GNU General Public License v3.0](LICENSE).
