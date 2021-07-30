FROM alpine:3.14.0 AS builder

COPY requirements.txt /tmp
RUN apk add --no-cache boost-dev boost-build g++ git libffi-dev cargo zlib-dev jpeg-dev openssl-dev py3-pip py3-wheel python3-dev \
    && tag=$(wget -qO - https://api.github.com/repos/arvidn/libtorrent/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') \
    && git clone -qb "$tag" https://github.com/arvidn/libtorrent.git  \
    && cd libtorrent  \
    && git submodule --quiet update --init \
    && cd bindings/python/ \
    && python3 setup.py build bdist_wheel \
    && mkdir -p /tmp/wheels \
    && cp dist/*.whl /tmp/wheels \
    && pip wheel --no-cache-dir -r /tmp/requirements.txt --wheel-dir /tmp/wheels

FROM alpine:3.14.0
MAINTAINER 'Byeonghoon Isac Yoo <bh322yoo@gmail.com>'
ENTRYPOINT ["/root/.local/bin/deluged"]
EXPOSE 6881 6881/UDP

COPY --from=builder /tmp/wheels /tmp/wheels
RUN apk add --no-cache boost-python3 py3-pip py3-wheel \
    && pip install --force-reinstall --user --no-warn-script-location --no-cache-dir --no-deps /tmp/wheels/*.whl  \
    && rm -rf /tmp \
    && apk del py3-pip py3-wheel
