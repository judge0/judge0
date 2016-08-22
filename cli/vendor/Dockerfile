FROM gcc:5.2.0

RUN apt-get update && apt-get install -y \
  make

COPY isolate /tmp/isolate
WORKDIR /tmp/isolate

RUN make install && \
    rm -rf /tmp/isolate

ENV BOX_ROOT /var/local/lib/isolate
WORKDIR /
