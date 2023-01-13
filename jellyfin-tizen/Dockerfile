FROM node:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV TERM=xterm-256color

ARG UID=1337
ARG TIZEN_VERSION="5.0"

# create a user, and download the tizen binary (separate stage to use cache)
RUN set -x && \
    apt-get update -y && \
    apt-get install -y wget && \
    useradd -u ${UID} -ms /bin/bash tizen && \
    wget --progress=bar:force:noscroll https://download.tizen.org/sdk/Installer/tizen-studio_${TIZEN_VERSION}/web-cli_Tizen_Studio_${TIZEN_VERSION}_ubuntu-64.bin -P /tmp && \
    chown tizen:tizen /tmp/web-cli_Tizen_Studio_${TIZEN_VERSION}_ubuntu-64.bin && \
    chmod +x /tmp/web-cli_Tizen_Studio_${TIZEN_VERSION}_ubuntu-64.bin

# install jdk and dependencies for tizen studio
RUN set -x && \
    apt-get update -y && \
    apt-get install -y default-jdk-headless gettext rpm2cpio make cpio

# switch to the non-privileged user for the build of jellyfin-tizen
USER tizen

# install tizen studio
RUN set -x && \
    /tmp/web-cli_Tizen_Studio_${TIZEN_VERSION}_ubuntu-64.bin --accept-license --no-java-check /home/tizen/tizen-studio && \
    rm /tmp/web-cli_Tizen_Studio_${TIZEN_VERSION}_ubuntu-64.bin
ENV PATH /home/tizen/tizen-studio/tools/ide/bin:$PATH

# to install tizen studio package manager (doesnt seem to be needed)
# /home/tizen/tizen-studio/package-manager/package-manager-cli.bin install --accept-license -d official -s Tizen_Studio_${TIZEN_VERSION} NativeIDE

# build jellyfin-tizen
COPY --chown=tizen:tizen jellyfin-web /usr/local/src/jellyfin-web/
WORKDIR /usr/local/src/jellyfin-web
ENV SKIP_PREPARE=1
RUN set -x && \
    npm ci --no-audit && \
    npm run build:production

COPY --chown=tizen:tizen jellyfin-tizen /usr/local/src/jellyfin-tizen/
WORKDIR /usr/local/src/jellyfin-tizen
ENV JELLYFIN_WEB_DIR=/usr/local/src/jellyfin-web/dist
RUN set -x && \
    npm ci --no-audit && \
    tizen build-web -e ".*" -e gulpfile.js -e README.md -e "node_modules/*" -e "package*.json" -e "yarn.lock" && \
    tizen package -t wgt -o . -- .buildResult

# builds:
# /usr/local/src/jellyfin-tizen/Jellyfin.wgt
#
# mkdir -p dist/
# docker run -u $(id -u) --rm -it -v $(pwd)/dist/:/mnt/dist/ jellyfin-tizen cp /usr/local/src/jellyfin-tizen/Jellyfin.wgt /mnt/dist/
