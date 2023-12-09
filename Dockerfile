FROM alpine
COPY watcher.sh watcher.sh
RUN chmod +x watcher.sh
RUN apk update && apk add bash curl bind-tools
CMD ["./watcher.sh"]