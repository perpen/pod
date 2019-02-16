FROM wetty:latest
WORKDIR /usr/src/app
COPY . /pod
RUN set -x \
    && apk add vim bash sudo tmux git openssh gnupg ncurses figlet at \
    && > /etc/motd \
    && ln -s /pod/pod /bin \
    && adduser -D -h /home/pair -s /pod/pod-pairing pair \
    && ( echo "pair:pair" | chpasswd ) \
    && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
ENTRYPOINT ["/pod/entrypoint"]
