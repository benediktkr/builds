#!/bin/bash

set -e
set -x

dark-reader.sh || true

tar -C ${DISTDIR}/target/ -czf ${DISTDIR}/owntone.tar.gz ${DISTDIR}/target/

(
    NAME="owntone"
    VERSION=$(./target/usr/sbin/owntone --version | cut -d' ' -f2)

    # if [[ ! "${VERSION}" =~ "^[0-9].*$" ]]; then
    #     # needs to be passed from the host, since we have .git in .dockeringore
    #     echo "using git tag for version instead"
    #     VERSION=${LATEST_GIT_TAG}
    # fi

    DEPS=""
    set +e
    while read -r dep; do
        DEPS="${DEPS} -d $dep"
    done </tmp/deps.txt
    set -e

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
