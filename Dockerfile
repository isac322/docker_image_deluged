# syntax=docker/dockerfile:1.2

FROM python:3.11.0-alpine AS builder

ARG VERSION

RUN apk add --update gcc musl-dev geoip-dev
RUN if ! [ "$(uname -m)" = 'x86_64' ]; then apk add --update libtorrent-rasterbar-dev libffi-dev; fi
RUN pip wheel -w /tmp/wheel deluge==${VERSION} libtorrent GeoIP


FROM python:3.11.0-alpine
MAINTAINER 'Byeonghoon Isac Yoo <bhyoo@bhyoo.com>'
CMD ["--do-not-daemonize", "--port", "58846", "--ui-interface", "0.0.0.0", "--interface", "0.0.0.0"]
RUN adduser deluged -D \
    && su - deluged -c 'mkdir -p ~/.config/deluge' \
    && apk add --update --no-cache libtorrent-rasterbar geoip \
    && rm -rf /var/cache/apk
USER deluged
ENTRYPOINT ["/home/deluged/.local/bin/deluged"]
ENV PATH="${PATH}:/home/deluged/.local/bin"
VOLUME ["/home/deluged/.config/deluge", "/usr/share/GeoIP"]
EXPOSE 58846

RUN --mount=type=bind,target=/tmp/wheel,from=builder,source=/tmp/wheel \
    pip install --user --no-cache-dir --no-warn-script-location --no-index --compile /tmp/wheel/*.whl
