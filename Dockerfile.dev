FROM hermanzdosilovic/judge0-api

RUN apt-get update && apt-get install -y \
  sudo \
  vim

ENV TERM xterm
CMD sleep infinity

ARG DEV_USER
ARG DEV_USER_ID

RUN useradd -u $DEV_USER_ID -m -r $DEV_USER && \
  echo "$DEV_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

USER $DEV_USER
