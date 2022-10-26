FROM node:lts-alpine as base

ARG UID=1000
ARG GID=1000

# from: https://github.com/jellyfin/jellyfin-web/blob/84c007fa0b2c37d86440554f7aa1875000f529dc/deployment/Dockerfile.docker
ARG JFWEB_DEPS="autoconf g++ make libpng-dev gifsicle alpine-sdk automake libtool make gcc musl-dev nasm python3"

RUN apk add --update --no-cache $JFWEB_DEPS} nfpm yq

RUN deluser --remove-home node && \
    addgroup -g ${GID} -S sudois && \
    adduser -u ${UID} -S sudois -G sudois -h /sudois

USER sudois

COPY --chown=sudois jellyfin-web /sudois/jellyfin-web
WORKDIR /sudois/jellyfin-web

# fail if this has changed ad then redirect it from the upstream
# default to our file
RUN grep --color -q "webpack\.prod\.js" scripts/prepare.js && \
    sed -i 's/webpack\.prod\.js/webpack\.sudois\.js/g' scripts/prepare.js
COPY --chown=sudois webpack.sudois.js /sudois/jellyfin-web/
RUN grep --color "exec.*webpack\.sudois\.js" scripts/prepare.js

COPY --chown=sudois change-title.sh /usr/local/bin
RUN /usr/local/bin/change-title.sh

# this calls scripts/prepare.js, that now calls our script
RUN npm ci --no-audit

COPY --chown=sudois entrypoint.sh nfpm-package.sh /usr/local/bin/
COPY --chown=sudois nfpm.yaml /sudois/dist/
RUN nfpm-package.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
