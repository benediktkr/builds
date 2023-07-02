# clone hass repo, build their Dockerfile
# "stable" is probably a branch

FROM ghcr.io/home-assistant/home-assistant:stable

RUN apk add python3-dev cups-dev gcc libc-dev bluez-headers bluez mysql-client

ENTRYPOINT /init
