FROM judge0/api-base:0.2.1

RUN apt-get update && \
    apt-get install -y \
      libpq-dev \
      nodejs-legacy \
      npm \
      sudo

ENV PATH "/usr/local/ruby-2.3.3/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"
RUN echo "gem: --no-document" > /root/.gemrc && \
    gem install \
      rails:5.2.0 \
      bundler:1.16.1 \
      pg:1.0.0 && \
    npm install -g aglio@2.3.0

EXPOSE 3000

WORKDIR /usr/src/api
COPY Gemfile* /usr/src/api/
RUN RAILS_ENV=production bundle

COPY . /usr/src/api
RUN RAILS_ENV=production bundle && \
    ./scripts/build-docs

CMD ./scripts/server

ENV JUDGE0_API_VERSION "2.0.0-rc"
LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com" \
      version="2.0.0"
