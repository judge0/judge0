FROM judge0/api-base:0.3.0

ENV JUDGE0_HOMEPAGE="https://judge0.com"
LABEL homepage=$JUDGE0_HOMEPAGE

ENV JUDGE0_SOURCE_CODE="https://github.com/judge0/api"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

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

ENV JUDGE0_VERSION="1.4.0"
LABEL version=$JUDGE0_VERSION