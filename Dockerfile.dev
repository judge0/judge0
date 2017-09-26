FROM judge0/api
LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com"

RUN apt-get update && apt-get install -y vim

ENV TERM xterm
CMD sleep infinity

ARG DEV_USER
ARG DEV_USER_ID

RUN useradd -u $DEV_USER_ID -m -r $DEV_USER && \
    echo "$DEV_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    echo "set -a" >> /home/$DEV_USER/.bashrc && \
    echo "source /usr/src/api/judge0-api.conf" >> /home/$DEV_USER/.bashrc

USER $DEV_USER
