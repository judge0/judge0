FROM judge0/judge0@sha256:6b5d6a66aa19a8e878a52ea3c6a560afc1086734d96e2885b561fd5c6018f082
USER root
RUN git clone https://github.com/ioi/isolate.git /opt/isolate-source \
    && git -C /opt/isolate-source checkout 9c84554464d2aa9161a424e70af67f4210a12c45
COPY contrib/cgroups-v2/old-headers.patch /tmp/old-headers.patch
RUN cd /opt/isolate-source && git apply /tmp/old-headers.patch \
    && make isolate CFLAGS_HARDEN='-D_FORTIFY_SOURCE=2 -fstack-protector-strong -fPIE -pie' \
    && install -o root -g root -m 4755 isolate /usr/local/bin/isolate
COPY contrib/cgroups-v2/isolate.conf /usr/local/etc/isolate
COPY contrib/cgroups-v2/bootstrap /usr/local/sbin/bootstrap-cgroup2
COPY contrib/cgroups-v2/entrypoint /api/cgroup2-entrypoint
COPY Gemfile Gemfile.lock /api/
RUN cd /api && RAILS_ENV=production bundle install
COPY . /api/
RUN chmod 755 /usr/local/sbin/bootstrap-cgroup2 /api/cgroup2-entrypoint /api/scripts/server /api/scripts/workers
RUN mkdir -p /api/tmp /api/log && chown -R judge0:judge0 /api/tmp /api/log
ENV JUDGE0_CGROUPS_VERSION=2
USER judge0
ENTRYPOINT ["/api/cgroup2-entrypoint"]
CMD ["/api/scripts/server"]
