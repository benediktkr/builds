FROM ubuntu:22.04
MAINTAINER Ben K <ben@sudo.is>
ENV DEBIAN_FRONTEND=noninteractive

ARG UID=1000
ARG REPO_NAME=ectools

RUN apt-get update && \
    apt-get install -y gcc-arm-none-eabi libftdi1-dev build-essential pkg-config && \
    mkdir /opt/${REPO_NAME} && \
    chown ${UID}:${UID} /opt/${REPO_NAME}/


USER $UID
COPY --chown=${UID} framework-ec/ /opt/framework-ec
WORKDIR /opt/framework-ec
RUN make utils

RUN mkdir -p /opt/${REPO_NAME}/dist && \
    cp -r /opt/framework-ec/build /opt/${REPO_NAME}/ && \
    cp -r /opt/framework-ec/build/bds/util/ectool /opt/${REPO_NAME}/dist/
