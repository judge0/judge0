FROM judge0/compilers:1.4.0 AS production

ENV JUDGE0_HOMEPAGE "https://judge0.com"
LABEL homepage=$JUDGE0_HOMEPAGE

ENV JUDGE0_SOURCE_CODE "https://github.com/judge0/judge0"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER "Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

ENV PATH "/usr/local/ruby-2.7.0/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"

# Debian Buster is EOL; repos moved to archive.debian.org.
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      cron \
      libpq-dev \
      sudo \
      libcap-dev \
      libcap2 \
      libseccomp-dev \
      libseccomp2 \
      pkg-config \
      gcc \
      make \
      git && \
    rm -rf /var/lib/apt/lists/* && \
    echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.1.4 && \
    npm install -g --unsafe-perm aglio@2.3.0

# Copy the compatibility header for building isolate 2.x on Buster's 4.19 headers.
# It provides clone3, CLONE_INTO_CGROUP, quotactl_fd, and struct clone_args.
COPY isolate-compat.h /tmp/isolate-compat.h

# Build isolate 2.x from the official ioi/isolate repository.
RUN cd /tmp && \
    git clone --depth 1 https://github.com/ioi/isolate.git && \
    cd isolate && \
    make CFLAGS_EXTRA="-include /tmp/isolate-compat.h" isolate && \
    install -m 4755 isolate /usr/local/bin/isolate && \
    ([ -f isolate-check-environment ] && install isolate-check-environment /usr/local/bin/ || true) && \
    mkdir -p /usr/local/etc /var/local/lib/isolate /run/isolate/locks && \
    cd / && rm -rf /tmp/isolate /tmp/isolate-compat.h

EXPOSE 2358

WORKDIR /api

COPY Gemfile* ./
RUN RAILS_ENV=production bundle

COPY cron /etc/cron.d
RUN cat /etc/cron.d/* | crontab -

COPY . .

# Install isolate 2.x config and make scripts executable
RUN cp /api/isolate.cf /usr/local/etc/isolate && \
    chmod +x /api/scripts/setup-cgroups.sh && \
    chmod +x /api/docker-entrypoint.sh

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
