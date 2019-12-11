FROM judge0/api-base:0.3.0

RUN echo "deb http://deb.debian.org/debian jessie main" > /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list && \
    rm -rf /etc/apt/sources.list.d/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      libpq-dev \
      nodejs-legacy \
      npm \
      sudo && \
    rm -rf /var/lib/apt/lists/*

ENV PATH "/usr/local/ruby-2.3.3/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"

RUN echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.0.2 && \
    npm install -g aglio@2.3.0

EXPOSE 3000

WORKDIR /api

COPY Gemfile* ./
RUN RAILS_ENV=production bundle

COPY . .
RUN ./scripts/prod-gen-api-docs

CMD ["./scripts/run-server"]

LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com"
LABEL version="1.4.0"
