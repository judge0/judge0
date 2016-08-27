FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  curl \
  libpq-dev \
  git \
  make \
  software-properties-common \
  vim \
  wget

RUN apt-get update

################################################################################
# Install C
################################################################################
RUN apt-get install -y \
    gcc-4.7 \
    gcc-4.8 \
    gcc-4.9 \
    gcc-5 \
    gcc


################################################################################
# Install C++
################################################################################
RUN apt-get install -y \
    g++-4.7 \
    g++-4.8 \
    g++-4.9 \
    g++-5 \
    g++


################################################################################
# Install Java JDK
################################################################################
RUN echo | add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get install -y oracle-java6-installer && \
    apt-get install -y oracle-java7-installer && \
    apt-get install -y oracle-java8-installer

RUN echo "echo 1 | update-alternatives --config java &> /dev/null" >> /usr/bin/use-java-6 && \
    echo "echo 2 | update-alternatives --config java &> /dev/null" >> /usr/bin/use-java-7 && \
    echo "echo 3 | update-alternatives --config java &> /dev/null" >> /usr/bin/use-java-8 && \
    chmod 755 /usr/bin/use-java-6 /usr/bin/use-java-7 /usr/bin/use-java-8


################################################################################
# Install Ruby
################################################################################
RUN apt-get install -y \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm3 \
    libgdbm-dev

WORKDIR /tmp
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz && \
    tar -xzf ruby-2.3.1.tar.gz && \
    cd ruby-2.3.1 && \
    ./configure --prefix /opt/ruby/2.3.1 && \
    make && \
    make install && \
    cd ..

RUN wget https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.5.tar.gz && \
    tar -xzf ruby-2.2.5.tar.gz && \
    cd ruby-2.2.5 && \
    ./configure --prefix /opt/ruby/2.2.5 && \
    make && \
    make install && \
    cd ..

RUN wget http://gd.tuwien.ac.at/languages/ruby/ruby-1.9-stable.tar.gz && \
    tar -xzf ruby-1.9-stable.tar.gz && \
    cd ruby-1.9.3-p448 && \
    ./configure --prefix /opt/ruby/1.9.3 && \
    make && \
    make install && \
    cd ..

RUN rm -rf /tmp/*

ENV RUBY_HOME /opt/ruby/2.3.1/
ENV PATH $RUBY_HOME/bin:$PATH


################################################################################
# Install Python
################################################################################
RUN apt-get install -y \
  python \
  python3


################################################################################
# Install Isolate
################################################################################
COPY vendor/isolate/ /opt/isolate
WORKDIR /opt/isolate
RUN make install
ENV BOX_ROOT /var/local/lib/isolate


################################################################################
# Install Rails Environment
################################################################################
RUN echo "gem: --no-document" > /root/.gemrc && \
  gem install \
  rails:5.0 \
  bundler \
  pg

COPY . /usr/src/judge0
WORKDIR /usr/src/judge0
RUN bundle
CMD rails s -b 0.0.0.0
