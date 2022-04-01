FROM alpine:latest

LABEL maintainer="viorel.ciucu@gmail.com" \
    org.label-schema.description="Docker Tor proxy (http and shell) built on Alpine Linux" \
    org.label-schema.license="MIT"

EXPOSE 8118 9050

COPY service /etc/service/

RUN apk --update add privoxy tor runit tini wget \
    && addgroup -S torprivoxy \
    && adduser -S torprivoxy -G torprivoxy \
    && chown -R torprivoxy:torprivoxy /etc/service/*

HEALTHCHECK --interval=120s --timeout=15s --start-period=120s --retries=2 \
            CMD wget --no-check-certificate -e use_proxy=yes -e https_proxy=127.0.0.1:8118 --quiet --spider 'https://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion/' && echo "HealthCheck succeeded..." || exit 1

USER torprivoxy

ENTRYPOINT ["tini", "--"]
CMD ["runsvdir", "/etc/service"]
