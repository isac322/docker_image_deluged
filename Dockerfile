# syntax=docker/dockerfile:1
# check=error=true

FROM python:3.13.1-alpine AS builder

ARG VERSION

RUN apk add --update gcc musl-dev geoip-dev
RUN pip wheel -w /tmp/wheel deluge==${VERSION} libtorrent==2.0.11 GeoIP==1.3.2 chardet==5.2.0 ifaddr==0.2.0


FROM python:3.13.1-alpine
ENV DELUGED_USER='deluged' \
    DELUGED_UID=1000 \
    DELUGED_GID=1000
VOLUME ["/usr/share/GeoIP"]
EXPOSE 58846
CMD ["--do-not-daemonize", "--port", "58846", "--ui-interface", "0.0.0.0", "--interface", "0.0.0.0", "--user", "deluged", "--group", "deluged", "--config", "/home/deluged/.config/deluge"]
ENTRYPOINT ["/entrypoint.sh"]

RUN --mount=type=bind,target=/tmp/wheel,from=builder,source=/tmp/wheel \
    apk add --update --no-cache libtorrent-rasterbar geoip \
    && rm -rf /var/cache/apk \
    && pip install --root-user-action=ignore --no-index --compile /tmp/wheel/*.whl

COPY --link=true entrypoint.sh /
