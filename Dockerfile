FROM judge0/api-base:vlang0.1.8

RUN curl -fSsL "https://deb.nodesource.com/setup_12.x" | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      libpq-dev \
      nodejs \
      sudo && \
    rm -rf /var/lib/apt/lists/*

ENV PATH "/usr/local/ruby-2.6.3/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"
RUN echo "gem: --no-document" > /root/.gemrc && \
    gem install \
      rails:5.0.0 \
      bundler:1.15.4 \
      pg:0.18 && \
    npm install -g --unsafe-perm aglio@2.3.0

EXPOSE 3000

WORKDIR /api
COPY Gemfile* ./
RUN RAILS_ENV=production bundle

COPY . .
RUN RAILS_ENV=production bundle && \
    ./scripts/prod-gen-api-docs

CMD ["./scripts/run-server"]

LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com"
LABEL version="1.4.0-vlang-latest"
