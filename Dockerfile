FROM alpine:3.18

RUN apk add --no-cache minidlna curl

#EXPOSE 8200
#EXPOSE 1900/udp

ENTRYPOINT ["/usr/sbin/minidlnad", "-S", "-r"]
# Health check
HEALTHCHECK --interval=60s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1