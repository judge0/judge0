FROM judge0/api-base
#LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com" \
#      version="0.1.2"

RUN apt-get update && \
    apt-get install -y \
      libpq-dev \
      nodejs-legacy \
      npm \
      sudo

ENV PATH /usr/local/ruby-2.3.3/bin/:$PATH
RUN echo "gem: --no-document" > /root/.gemrc && \
    gem install \
      rails:5.0 \
      bundler \
      pg && \
    npm install -g aglio

EXPOSE 3000

WORKDIR /usr/src/api
COPY Gemfile* /usr/src/api/
RUN bundle

COPY . /usr/src/api
RUN bundle && \
    ./scripts/prod-gen-api-docs

CMD rm -f tmp/pids/server.pid && \
    rails db:create db:migrate db:seed && \
    rails s -b 0.0.0.0

LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com" \
      version="0.1.2"