# Build compilers image
FROM ubuntu:22.04 AS compilers

ENV DEBIAN_FRONTEND=noninteractive

# Base system setup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        autoconf \
        bison \
        build-essential \
        ca-certificates \
        curl \
        flex \
        git \
        gnupg \
        libcap-dev \
        libffi-dev \
        libgmp-dev \
        libpq-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libyaml-dev \
        locales \
        pkg-config \
        software-properties-common \
        sqlite3 \
        sudo \
        unzip \
        wget \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

################################################################################
# ISOLATE SANDBOX
################################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends libsystemd-dev && \
    rm -rf /var/lib/apt/lists/*

ENV ISOLATE_VERSION=1.10.1
RUN cd /tmp && \
    curl -fSsL "https://github.com/ioi/isolate/archive/refs/tags/v${ISOLATE_VERSION}.tar.gz" -o isolate.tar.gz && \
    tar -xf isolate.tar.gz && \
    cd isolate-${ISOLATE_VERSION} && \
    make -j$(nproc) install && \
    rm -rf /tmp/*

################################################################################
# C/C++ COMPILERS
################################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc-12 g++-12 \
        gcc-11 g++-11 && \
    rm -rf /var/lib/apt/lists/*

# Add GCC 13 from Ubuntu toolchain PPA
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y --no-install-recommends gcc-13 g++-13 && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 130 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-13 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 120 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-12 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 110 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-11

# Clang 17
RUN curl -fSsL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/llvm-archive-keyring.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends clang-17 && \
    ln -sf /usr/bin/clang-17 /usr/bin/clang && \
    ln -sf /usr/bin/clang++-17 /usr/bin/clang++ && \
    rm -rf /var/lib/apt/lists/*

################################################################################
# ASSEMBLY
################################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends nasm && \
    rm -rf /var/lib/apt/lists/*

################################################################################
# PYTHON
################################################################################
RUN add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.11 python3.11-dev python3.11-venv \
        python3.12 python3.12-dev python3.12-venv && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 312 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 311 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.12 312

################################################################################
# RUBY (for code submissions)
################################################################################
ENV RUBY_SUBMISSIONS_VERSION=3.3.0
RUN cd /tmp && \
    curl -fSsL "https://cache.ruby-lang.org/pub/ruby/${RUBY_SUBMISSIONS_VERSION%.*}/ruby-${RUBY_SUBMISSIONS_VERSION}.tar.gz" -o ruby.tar.gz && \
    tar -xf ruby.tar.gz && \
    cd ruby-${RUBY_SUBMISSIONS_VERSION} && \
    ./configure --disable-install-doc --prefix=/usr/local && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/*

################################################################################
# NODE.JS
################################################################################
ENV NODE_VERSION=20.11.0
RUN cd /tmp && \
    curl -fSsL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" -o node.tar.xz && \
    tar -xf node.tar.xz && \
    cp -r node-v${NODE_VERSION}-linux-x64/* /usr/local/ && \
    rm -rf /tmp/*

RUN npm install -g typescript@5.3.3

################################################################################
# JAVA (OpenJDK)
################################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-21-jdk && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

################################################################################
# GO
################################################################################
ENV GO_VERSION=1.22.0
RUN cd /tmp && \
    curl -fSsL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" -o go.tar.gz && \
    tar -xf go.tar.gz -C /usr/local && \
    rm -rf /tmp/*

ENV PATH="/usr/local/go/bin:${PATH}"

################################################################################
# RUST
################################################################################
ENV RUST_VERSION=1.75.0
ENV CARGO_HOME=/opt/cargo
ENV RUSTUP_HOME=/opt/rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain ${RUST_VERSION} && \
    ln -s /opt/cargo/bin/* /usr/local/bin/

################################################################################
# KOTLIN
################################################################################
ENV KOTLIN_VERSION=1.9.22
RUN cd /tmp && \
    curl -fSsL "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" -o kotlin.zip && \
    unzip -q kotlin.zip -d /opt && \
    rm -rf /tmp/*

ENV PATH="/opt/kotlinc/bin:${PATH}"

################################################################################
# SCALA
################################################################################
ENV SCALA_VERSION=3.3.1
RUN cd /tmp && \
    curl -fSsL "https://github.com/lampepfl/dotty/releases/download/${SCALA_VERSION}/scala3-${SCALA_VERSION}.tar.gz" -o scala.tar.gz && \
    tar -xf scala.tar.gz -C /opt && \
    mv /opt/scala3-${SCALA_VERSION} /opt/scala && \
    rm -rf /tmp/*

ENV PATH="/opt/scala/bin:${PATH}"

################################################################################
# OTHER LANGUAGES
################################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ghc \
        php \
        perl \
        lua5.4 \
        r-base \
        dotnet-sdk-8.0 \
        fp-compiler \
        erlang \
        elixir \
        ocaml \
        gprolog \
        swi-prolog \
        sbcl \
        gfortran \
        gnucobol && \
    ln -sf /usr/bin/lua5.4 /usr/bin/lua && \
    rm -rf /var/lib/apt/lists/*

################################################################################
# SWIFT
################################################################################
ENV SWIFT_VERSION=5.9.2
RUN cd /tmp && \
    curl -fSsL "https://download.swift.org/swift-${SWIFT_VERSION}-release/ubuntu2204/swift-${SWIFT_VERSION}-RELEASE/swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04.tar.gz" -o swift.tar.gz && \
    tar -xf swift.tar.gz && \
    mv swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04 /opt/swift && \
    rm -rf /tmp/*

ENV PATH="/opt/swift/usr/bin:${PATH}"

################################################################################
# D (DMD)
################################################################################
RUN cd /tmp && \
    curl -fSsL "https://downloads.dlang.org/releases/2.x/2.107.0/dmd_2.107.0-0_amd64.deb" -o dmd.deb && \
    dpkg -i dmd.deb || apt-get install -f -y && \
    rm -rf /tmp/*

################################################################################
# GROOVY
################################################################################
ENV GROOVY_VERSION=4.0.18
RUN cd /tmp && \
    curl -fSsL "https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-binary-${GROOVY_VERSION}.zip" -o groovy.zip && \
    unzip -q groovy.zip -d /opt && \
    mv /opt/groovy-${GROOVY_VERSION} /opt/groovy && \
    rm -rf /tmp/*

ENV GROOVY_HOME="/opt/groovy"
ENV PATH="/opt/groovy/bin:${PATH}"

################################################################################
# CLOJURE
################################################################################
RUN cd /tmp && \
    curl -fSsL "https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh" -o install-clojure.sh && \
    chmod +x install-clojure.sh && \
    ./install-clojure.sh && \
    rm -rf /tmp/*

################################################################################
# ZIG
################################################################################
ENV ZIG_VERSION=0.11.0
RUN cd /tmp && \
    curl -fSsL "https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz" -o zig.tar.xz && \
    tar -xf zig.tar.xz && \
    mv zig-linux-x86_64-${ZIG_VERSION} /opt/zig && \
    rm -rf /tmp/*

ENV PATH="/opt/zig:${PATH}"

################################################################################
# NIM
################################################################################
ENV NIM_VERSION=2.0.2
RUN cd /tmp && \
    curl -fSsL "https://nim-lang.org/download/nim-${NIM_VERSION}-linux_x64.tar.xz" -o nim.tar.xz && \
    tar -xf nim.tar.xz && \
    mv nim-${NIM_VERSION} /opt/nim && \
    rm -rf /tmp/*

ENV PATH="/opt/nim/bin:${PATH}"

################################################################################
# DART
################################################################################
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    curl -fSsL https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/dart-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/dart-archive-keyring.gpg] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main" > /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && \
    apt-get install -y dart && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/lib/dart/bin:${PATH}"

################################################################################
# JULIA
################################################################################
ENV JULIA_VERSION=1.10.0
RUN cd /tmp && \
    curl -fSsL "https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" -o julia.tar.gz && \
    tar -xf julia.tar.gz && \
    mv julia-${JULIA_VERSION} /opt/julia && \
    rm -rf /tmp/*

ENV PATH="/opt/julia/bin:${PATH}"

################################################################################
# CLEAN UP
################################################################################
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


################################################################################
# PRODUCTION IMAGE
################################################################################
FROM compilers AS production

ENV JUDGE0_HOMEPAGE "https://judge0.com"
LABEL homepage=$JUDGE0_HOMEPAGE

ENV JUDGE0_SOURCE_CODE "https://github.com/judge0/judge0"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER "Herman Zvonimir Dosilovic <hermanz.dosilovic@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

# Install Ruby 3.4 for the Rails application (separate from Ruby 3.3 for submissions)
ENV RUBY_VERSION=3.4.1
RUN cd /tmp && \
    curl -fSsL "https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-$RUBY_VERSION.tar.gz" -o ruby.tar.gz && \
    mkdir ruby-rails && \
    tar -xf ruby.tar.gz -C ruby-rails --strip-components=1 && \
    cd ruby-rails && \
    ./configure --disable-install-doc --prefix=/usr/local/ruby-$RUBY_VERSION && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/*

ENV PATH="/usr/local/ruby-3.4.1/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME="/opt/.gem/"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      cron \
      libpq-dev && \
    rm -rf /var/lib/apt/lists/* && \
    echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.6.2 && \
    npm install -g --unsafe-perm aglio@2.3.0

EXPOSE 2358

WORKDIR /api

COPY Gemfile* ./
RUN bundle config set force_ruby_platform true && \
    RAILS_ENV=production bundle

COPY cron /etc/cron.d
RUN cat /etc/cron.d/* | crontab -

COPY . .

ENTRYPOINT ["/api/docker-entrypoint.sh"]
CMD ["/api/scripts/server"]

RUN useradd -u 1000 -m -r judge0 && \
    echo "judge0 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/judge0 && \
    chown judge0: /api/tmp/

USER judge0

ENV JUDGE0_VERSION "1.14.0"
LABEL version=$JUDGE0_VERSION


FROM production AS development

CMD ["sleep", "infinity"]
