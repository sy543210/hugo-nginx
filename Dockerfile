FROM alpine:3.20

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo

RUN apk add inotify-tools

RUN apk add rsync

RUN mkdir /hugo/ && mkdir -p /hugo/blog/ && touch /hugo/deploy.md

COPY hugo/deployer.sh /hugo

RUN chmod +x /hugo/deployer.sh

CMD ["/hugo/deployer.sh"]
