FROM judge0/compilers:1.4.0 AS production

ENV JUDGE0_HOMEPAGE "https://judge0.com"
LABEL homepage=$JUDGE0_HOMEPAGE

ENV JUDGE0_SOURCE_CODE "https://github.com/judge0/judge0"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER "Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

# Install Ruby 3.4 for the Rails application (separate from compilers Ruby 2.7.0)
ENV RUBY_VERSION=3.4.1
RUN curl -fSsL "https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-$RUBY_VERSION.tar.gz" -o /tmp/ruby.tar.gz && \
    mkdir /tmp/ruby && \
    tar -xf /tmp/ruby.tar.gz -C /tmp/ruby --strip-components=1 && \
    cd /tmp/ruby && \
    ./configure --disable-install-doc --prefix=/usr/local/ruby-$RUBY_VERSION && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/*

ENV PATH "/usr/local/ruby-3.4.1/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"

# Fix Debian Buster EOL apt sources - redirect to archive
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      cron \
      libpq-dev \
      sudo && \
    rm -rf /var/lib/apt/lists/* && \
    echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.6.2 && \
    npm install -g --unsafe-perm aglio@2.3.0

EXPOSE 2358

WORKDIR /api

COPY Gemfile* ./
# Force pg gem to compile from source (precompiled binary requires newer glibc than Buster)
RUN bundle config set force_ruby_platform true && \
    RAILS_ENV=production bundle

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
