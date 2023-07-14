[![Judge0 Wallpaper](./.github/judge0-colored.png)](https://ce.judge0.com)
# Judge0 for waffledotcom-server

## Installation (Tentative)

Make sure you are running linux. In M1 macs, `isolate` won't work.

```bash
docker build -t waffledotcom-judge-compilers -f Dockerfile-compilers . && docker build -t waffledotcom-judge -f Dockerfile-server .
docker-compose up -d # or docker compose up -d
```

### Changing to Cgroup V1 for mac

```bash
# Stop running Docker
test -z "$(docker ps -q 2>/dev/null)" && osascript -e 'quit app "Docker"'
# Install jq and moreutils so we can merge into the existing json file
brew install jq moreutils
# Add the needed cgroup config to docker settings.json
echo '{"deprecatedCgroupv1": true}' | \
  jq -s '.[0] * .[1]' ~/Library/Group\ Containers/group.com.docker/settings.json - | \
  sponge ~/Library/Group\ Containers/group.com.docker/settings.json
# Restart docker desktop
open --background -a Docker
```

## License
Judge0 is licensed under the [GNU General Public License v3.0](LICENSE).
