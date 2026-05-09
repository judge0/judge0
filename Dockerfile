# Use the compilers image as base (contains all language compilers/interpreters + isolate sandbox)
# For development with local compilers image, use: rogerheykoop/compilers:2.0.0
# For production, use: judge0/compilers:2.0.0 (once merged)
FROM rogerheykoop/compilers:2.0.0 AS production

ENV JUDGE0_HOMEPAGE "https://judge0.com"
LABEL homepage=$JUDGE0_HOMEPAGE

ENV JUDGE0_SOURCE_CODE "https://github.com/judge0/judge0"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER "Herman Zvonimir Dosilovic <hermanz.dosilovic@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

################################################################################
# RUBY FOR RAILS APPLICATION
# Note: Ruby 3.3.0 is already in the compilers image for user submissions.
# We install Ruby 3.4.1 separately for running the Rails application.
################################################################################
ENV RUBY_VERSION=3.4.1
RUN cd /tmp && \
    curl -fSsL "https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-$RUBY_VERSION.tar.gz" -o ruby.tar.gz && \
    mkdir ruby-rails && \
    tar -xf ruby.tar.gz -C ruby-rails --strip-components=1 && \
    cd ruby-rails && \
    ./configure --disable-install-doc --prefix=/usr/local/ruby-$RUBY_VERSION && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/*

ENV PATH="/usr/local/ruby-${RUBY_VERSION}/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME="/opt/.gem/"

################################################################################
# RAILS APPLICATION DEPENDENCIES
################################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      cron \
      libpq-dev && \
    rm -rf /var/lib/apt/lists/* && \
    echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.6.2 && \
    npm install -g --unsafe-perm aglio@2.3.0

EXPOSE 2358

WORKDIR /api

COPY Gemfile* ./
RUN bundle config set force_ruby_platform true && \
    RAILS_ENV=production bundle

COPY cron /etc/cron.d
RUN cat /etc/cron.d/* | crontab -

COPY . .

ENTRYPOINT ["/api/docker-entrypoint.sh"]
CMD ["/api/scripts/server"]

RUN useradd -u 1000 -m -r judge0 && \
    echo "judge0 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/judge0 && \
    chown judge0: /api/tmp/

USER judge0

ENV JUDGE0_VERSION "1.14.0"
LABEL version=$JUDGE0_VERSION


FROM production AS development

CMD ["sleep", "infinity"]
