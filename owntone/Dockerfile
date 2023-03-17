FROM ubuntu:latest as base

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV TERM=xterm-256color

ARG UID=1337
ARG GID=${UID}

COPY deps.txt /tmp/deps.txt
RUN set -x && \
    groupadd -g ${GID} owntone && \
    useradd -u ${UID} -g ${GID} -ms /bin/bash owntone && \
    apt-get -y update && \
    apt-get install -y $(sed 's/\n/ /g' /tmp/deps.txt)

FROM base as builder
RUN set -x && \
    apt-get install -y \
    build-essential git autotools-dev autoconf automake libtool gettext gawk \
    gperf bison flex libconfuse-dev libunistring-dev libsqlite3-dev \
    libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev \
    libasound2-dev libmxml-dev libgcrypt20-dev libavahi-client-dev zlib1g-dev \
    libevent-dev libplist-dev libsodium-dev libjson-c-dev libwebsockets-dev \
    libcurl4-openssl-dev libprotobuf-c-dev libpulse-dev libgnutls*-dev \
    ruby ruby-dev rubygems && \
    gem install --no-document fpm && \
    chown -R owntone:owntone /usr/local/src/


USER owntone
ENV DISTDIR=/usr/local/src/dist/
RUN mkdir ${DISTDIR} 

COPY --chown=owntone:owntone owntone-apt/ /usr/local/src/owntone-apt/
COPY --chown=owntone:owntone owntone-server/ /usr/local/src/owntone-server/
COPY --chown=owntone:owntone build-owntone.sh /usr/local/bin/build-owntone.sh
WORKDIR /usr/local/src/owntone-server/
RUN /usr/local/bin/build-owntone.sh

COPY --chown=owntone:owntone package-owntone.sh /usr/local/bin/package-owntone.sh
COPY --chown=owntone:owntone after-install.sh /usr/local/src/after-install.sh
COPY deps.txt /tmp/deps.txt
WORKDIR /usr/local/src/dist

RUN /usr/local/bin/package-owntone.sh 


FROM base as final
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV TERM=xterm-256color

COPY --from=builder /usr/local/src/dist/owntone.tar.gz /tmp/
COPY --from=builder /usr/local/src/dist/owntone_0.1.0_amd64.deb /tmp/
RUN dpkg -i /tmp/owntone_0.1.0_amd64.deb && \
    apt-get clean && \
    chown owntone:owntone /var/cache/owntone && \
    echo touch /var/log/owntone.log && \
    echo chown owntone:owntone /var/log/owntone.log

    
# RUN ldd /usr/sbin/owntone && dpkg-deb -c /tmp/owntone_0.1.0_amd64.deb && ls -ld /var/cache/owntone
COPY docker/owntone.conf /etc/owntone.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
#USER owntone
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["-f"]

