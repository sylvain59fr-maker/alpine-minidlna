FROM alpine:3.18

RUN \
    apk add --no-cache \
        minidlna \
        su-exec

RUN echo "log_level=warn" >> /etc/minidlna.conf

EXPOSE 8200
EXPOSE 1900/udp

VOLUME ["/var/lib/minidlna"]

RUN echo -e "#!/bin/sh\n/sbin/su-exec minidlna /usr/sbin/minidlnad -d -R" > entrypoint.sh \
 && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
# Health check
HEALTHCHECK --interval=60s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1