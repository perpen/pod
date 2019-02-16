FROM wetty:latest
WORKDIR /usr/src/app
COPY . /pod
ENTRYPOINT ["/pod/entrypoint"]
# ENTRYPOINT ["node", "."]
