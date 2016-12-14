FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  git \
  make \
  software-properties-common \
  wget


# Install C
RUN apt-get update && apt-get install -y \
    gcc-4.7 \
    gcc-4.8 \
    gcc-4.9 \
    gcc-5 \
    gcc


# Install Isolate
WORKDIR /tmp
RUN git clone https://github.com/ioi/isolate.git && \
  cd isolate && \
  echo "num_boxes = 2147483647" >> default.cf && \
  make install

ENV BOX_ROOT /var/local/lib/isolate


# Install C++
RUN apt-get install -y \
    g++-4.7 \
    g++-4.8 \
    g++-4.9 \
    g++-5 \
    g++


# Install Java
RUN echo | add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get install -y oracle-java6-installer \
                       oracle-java7-installer \
                       oracle-java8-installer


# Install Ruby
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
RUN wget http://gd.tuwien.ac.at/languages/ruby/ruby-1.9-stable.tar.gz && \
    tar -xzf ruby-1.9-stable.tar.gz && \
    cd ruby-1.9.3-p448 && \
    ./configure --prefix /usr/lib/ruby/1.9.3 && \
    make && \
    make install

WORKDIR /tmp
RUN wget https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.5.tar.gz && \
    tar -xzf ruby-2.2.5.tar.gz && \
    cd ruby-2.2.5 && \
    ./configure --prefix /usr/lib/ruby/2.2.5 && \
    make && \
    make install

WORKDIR /tmp
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz && \
    tar -xzf ruby-2.3.1.tar.gz && \
    cd ruby-2.3.1 && \
    ./configure --prefix /usr/lib/ruby/2.3.1 && \
    make && \
    make install

ENV PATH /usr/lib/ruby/2.3.1/bin:$PATH


# Install Python
RUN apt-get install -y \
  python \
  python3


# Install Pascal
RUN apt-get install -y \
  fp-compiler-3.0.0


# ADD HERE MORE COMPILERS ...

RUN cd /tmp && rm -rf *
WORKDIR /root
