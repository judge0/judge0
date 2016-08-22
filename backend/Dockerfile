FROM hermanzdosilovic/judge0-cli

RUN apt-get update && apt-get install -y \
  libpq-dev

RUN gem install --no-document \
    rails:5.0 \
    bundler \
    pg

COPY . /usr/src/judge0/backend
WORKDIR /usr/src/judge0/backend
RUN bundle
CMD rails s -b 0.0.0.0
