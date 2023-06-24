#!/bin/bash

set -e
set -x

# copy dark-reader.css file from dark-reader (firefox extension), and
# the modified index.html. both were placed in
# /usr/local/src/dark-reader during the 'docker build`, and copy them
# inside of the owntone build before we package it up

# save the diff of the index.html file in the dist/dark-reader dir for later inspection
mkdir -p ${DISTDIR}dark-reader/
ls -l ${DISTDIR}dark-reader/
# touch ${DISTDIR}dark-reader/diff-index-html.txt
# diff /usr/local/src/dark-reader/index.html ${DISTDIR}target/usr/share/owntone/htdocs/index.html >> ${DISTDIR}dark-reader/

# and save both the dark-reader findex.html file as it is included int he build, and the original index.html
cp ${DISTDIR}target/usr/share/owntone/htdocs/index.html ${DISTDIR}dark-reader/index.html.orig
cp /usr/local/src/dark-reader/index.html ${DISTDIR}dark-reader/


# copy the files into the build
cp -v /usr/local/src/dark-reader/dark-reader-full.css ${DISTDIR}/target/usr/share/owntone/htdocs/assets/dark-reader-full.css
cp -v /usr/local/src/dark-reader/index.html ${DISTDIR}/target/usr/share/owntone/htdocs/index.html

# save ls output of the htdocs/assets dir
ls -l ${DISTDIR}/target/usr/share/owntone/htdocs/assets/ > ${DISTDIR}/dark-reader/ls-htdocs-assets.txt
ls -l ${DISTDIR}/target/usr/share/owntone/htdocs/assets/dark-reader-full.css > ${DISTDIR}/dark-reader/ls-htdocs-assets-dark-reader-full.css.txt

tar -C ${DISTDIR}/target/ -czf ${DISTDIR}/owntone.tar.gz ${DISTDIR}/target/

(
    NAME="owntone"
    VERSION=$(./target/usr/sbin/owntone --version | cut -d' ' -f2)

    if [[ ! "${VERSION}" =~ "^[0-9].*$" ]]; then
        echo "using git tag for version instead"
        VERSION=${LATEST_GIT_TAG}
    fi

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
