FROM wiserain/libtorrent:2.0.4-alpine3.14 AS builder

COPY requirements.txt /tmp
RUN apk add --no-cache gcc git libffi-dev cargo zlib-dev jpeg-dev openssl-dev py3-pip py3-wheel python3-dev \
    && pip wheel --no-cache-dir -r /tmp/requirements.txt --wheel-dir /tmp/wheels

FROM alpine:3.14.0
MAINTAINER 'Byeonghoon Isac Yoo <bh322yoo@gmail.com>'
ENTRYPOINT ["/root/.local/bin/deluged"]
EXPOSE 6881 6881/UDP

COPY --from=builder /tmp/wheels /tmp/wheels
COPY --from=builder /libtorrent-build /
RUN apk add --no-cache boost-python3 py3-pip py3-wheel \
    && pip install --force-reinstall --user --no-warn-script-location --no-cache-dir --no-deps /tmp/wheels/*.whl  \
    && rm -rf /tmp \
    && apk del py3-pip py3-wheel
