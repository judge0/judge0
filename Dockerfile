<<<<<<< 2274d76428aa1e9cad9a9c305df07df4c84cbe9e
FROM judge0/api-base:0.3.0
=======
FROM judge0/api-base:0.2.1
>>>>>>> Fixed DocumentService and removed unused initializers

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      libpq-dev \
      nodejs-legacy \
      npm \
      sudo && \
    rm -rf /var/lib/apt/lists/*

ENV PATH "/usr/local/ruby-2.3.3/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME "/opt/.gem/"
RUN echo "gem: --no-document" > /root/.gemrc && \
    gem install \
<<<<<<< 2274d76428aa1e9cad9a9c305df07df4c84cbe9e
      rails:5.1 \
      bundler:2.0 \
      pg:1.1 && \
=======
      rails:5.2.0 \
      bundler:1.16.1 \
      pg:1.0.0 && \
>>>>>>> Fixed DocumentService and removed unused initializers
    npm install -g aglio@2.3.0

EXPOSE 3000

WORKDIR /usr/src/api
COPY Gemfile* /usr/src/api/
RUN RAILS_ENV=production bundle

COPY . /usr/src/api
RUN RAILS_ENV=production bundle && \
    ./scripts/build-docs

CMD ./scripts/server

<<<<<<< 2274d76428aa1e9cad9a9c305df07df4c84cbe9e
LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com"
LABEL version="1.1.5"
=======
ENV JUDGE0_API_VERSION "2.0.0-rc"
LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com" \
      version="2.0.0"
>>>>>>> Fixed DocumentService and removed unused initializers
