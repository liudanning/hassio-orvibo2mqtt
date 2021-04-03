ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ARG BUILD_VERSION

RUN apk add --no-cache --virtual .build-dependencies \
    make gcc g++ linux-headers udev git && \
    apk add --no-cache jq nodejs-npm

RUN echo "Installing ..." && \
    curl -sL -o "/app.tar.gz" \
    "https://github.com/liudanning/orvibo2mqtt/archive/master.tar.gz" && \
    tar xzvf "/app.tar.gz"  && rm "/app.tar.gz" && \
    mv -v "orvibo2mqtt-master" app

# COPY app /app

RUN cd /app && \
    npm i \
    --no-audit \
    --no-optional \
    --no-update-notifier \
    --only=production \
    --unsafe-perm && \
    apk del --no-cache --purge .build-dependencies && \
    rm -rf /root/.cache /root/.npm

COPY rootfs /
