FROM judge0/api-base:nim-latest

ENV JUDGE0_HOMEPAGE="https://judge0.com"
LABEL homepage=$JUDGE0_HOMEPAGE

ENV JUDGE0_SOURCE_CODE="https://github.com/judge0/api"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

ENV PATH "/usr/local/ruby-2.7.0/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libpq-dev \
      sudo && \
    rm -rf /var/lib/apt/lists/* && \
    echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.0.2 && \
    npm install -g --unsafe-perm aglio@2.3.0

EXPOSE 3000

WORKDIR /api

COPY Gemfile* ./
RUN RAILS_ENV=production bundle

COPY . .
RUN ./scripts/prod-gen-api-docs

CMD ["./scripts/run-server"]

ENV JUDGE0_VERSION="1.5.0-nim-latest"
LABEL version=$JUDGE0_VERSION
