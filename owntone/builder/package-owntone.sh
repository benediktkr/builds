#!/bin/bash

set -e

# copy dark-reader.css file from dark-reader (firefox extension), and
# the modified index.html. both were placed in
# /usr/local/src/dark-reader during the 'docker build`, and copy them
# inside of the owntone build before we package it up

cp -v /usr/local/src/dark-reader/dark-reader.css ${DISTDIR}/target/usr/share/owntone/htdocs/assets/dark-reader.css
cp -v /usr/local/src/dark-reader/index.html ${DISTDIR}/target/usr/share/owntone/htdocs/index.html

echo "cat index.html"

cat ${DISTDIR}/target/usr/share/owntone/htdocs/index.html

tar -C ${DISTDIR}/target/ -czf ${DISTDIR}/owntone.tar.gz ${DISTDIR}/target/

(
    NAME="owntone"
    VERSION=$(./target/usr/sbin/owntone --version | cut -d' ' -f2)

    DEPS=""
    while read -r dep; do
        DEPS="${DEPS} -d $dep"
    done </tmp/deps.txt

    fpm \
        -t deb $DEPS\
        --deb-default target/etc/owntone.conf \
        --deb-systemd target/etc/systemd/system/owntone.service \
        --config-files /etc/owntone.conf \
        --after-install /usr/local/src/after-install.sh \
        -n ${NAME} \
        -v ${VERSION} \
        -a $(dpkg --print-architecture) \
        -s dir target/=/

    dpkg-deb -I *.deb
    ls -lah *.deb


)
