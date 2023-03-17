#!/bin/bash

set -e
patch -u web-src/src/mystyles.scss -i /usr/local/src/dark.patch
autoreconf -i

# --enable-static  --disable-shared
# -enable-prefairplay2
./configure --with-pulseaudio --with-avahi \
  --enable-chromecast --enable-lastfm \
  --prefix=/usr --sysconfdir=/etc --localstatedir=/var \

make

mkdir ${DISTDIR}/target
DESTDIR=${DISTDIR}/target make install

tar -C ${DISTDIR}/target/ -czf ${DISTDIR}/owntone.tar.gz ${DISTDIR}/target/
