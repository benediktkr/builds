# clone hass repo, build their Dockerfile
# "stable" is probably a branch

FROM ghcr.io/home-assistant/home-assistant:stable

# RUN apk add libc-dev bluez-headers bluez mysql-client

# mysql-clielent is so hass wont use the slower pymysql
RUN apk add libc-dev python3-dev cups-dev gcc mysql-client

# fix pybluez dependency, dependencies to build wheel
#RUN apk add musl-dev bluez-dev

ENTRYPOINT /init
