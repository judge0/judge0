# Isolate 2.x supports cgroup v2 (Isolate 1.x, shipped in judge0/compilers,
# only supports cgroup v1). Built statically so it runs on the older base image.
# isolate does no NSS lookups, so static glibc linking is safe.
FROM debian:bookworm-slim AS isolate-builder
ARG ISOLATE_VERSION=v2.7
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential ca-certificates git libcap-dev libseccomp-dev && \
    rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 --branch "$ISOLATE_VERSION" https://github.com/ioi/isolate.git /isolate
WORKDIR /isolate
RUN make isolate \
      CFLAGS_HARDEN="-O2 -D_FORTIFY_SOURCE=2 -fstack-protector-strong -fstack-clash-protection" \
      LDFLAGS_HARDEN="-static -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now" && \
    ./isolate --version

FROM judge0/compilers:1.4.0 AS production

ENV JUDGE0_HOMEPAGE "https://judge0.com"
LABEL homepage=$JUDGE0_HOMEPAGE

ENV JUDGE0_SOURCE_CODE "https://github.com/judge0/judge0"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER "Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

ENV PATH "/usr/local/ruby-2.7.0/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"

# Debian 10 (buster) is end-of-life and its packages moved to archive.debian.org.
RUN printf '%s\n' \
      "deb http://archive.debian.org/debian buster main" \
      "deb http://archive.debian.org/debian-security buster/updates main" \
      > /etc/apt/sources.list && \
    rm -f /etc/apt/sources.list.d/mono-official-stable.list /etc/apt/sources.list.d/nodesource.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y --no-install-recommends \
      cron \
      libpq-dev \
      sudo && \
    rm -rf /var/lib/apt/lists/* && \
    echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.1.4 && \
    npm install -g --unsafe-perm aglio@2.3.0

EXPOSE 2358

WORKDIR /api

COPY Gemfile* ./
RUN RAILS_ENV=production bundle

COPY --from=isolate-builder /isolate/isolate /usr/local/bin/isolate
COPY docker/isolate.cf /usr/local/etc/isolate
RUN chown root:root /usr/local/bin/isolate /usr/local/etc/isolate && \
    chmod 4755 /usr/local/bin/isolate && \
    chmod 644 /usr/local/etc/isolate && \
    mkdir -p /var/local/lib/isolate

COPY cron /etc/cron.d
RUN cat /etc/cron.d/* | crontab -

COPY . .

ENTRYPOINT ["/api/docker-entrypoint.sh"]
CMD ["/api/scripts/server"]

RUN useradd -u 1000 -m -r judge0 && \
    echo "judge0 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chown judge0: /api/tmp/

USER judge0

ENV JUDGE0_VERSION "1.13.1"
LABEL version=$JUDGE0_VERSION


FROM production AS development

CMD ["sleep", "infinity"]
