#!/bin/bash

set -e

(
    #cd /usr/local/dist/
    #mkdir -v bin target


    #cp -v /usr/local/src/blink1-tool/blink1-tool bin/
    #cp -v /usr/local/src/blink1-tool/blink1-tiny-server bin/

    #VERSION=$(bin/blink1-tool --version | awk  '{print $3}' | cut -d'-' -f1 | sed -e '1s/^v//')
    #echo "version: $VERSION"

    NAME="owntone"
    VERSION="0.1.0"

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

    #        --deb-custom-control debian/control \
    #--deb-auto-config-files \
    #etc/21-blink1.rules=/etc/udev/rules.d/21-blink1.rules

        # --deb-systemd-auto-start \
        # --deb-systemd-enable \
        # --deb-systemd-restart-after-upgrade \

    # mv -v *.deb target/
    dpkg-deb -I *.deb
    ls -lah *.deb


)


# ls /usr/local/src/owntone-apt/
# cp -rv /usr/local/src/owntone-apt/owntone-server/debian/ /usr/local/src/owntone-server/
# echo "1"
# sudo OS=debian DIST=buster ARCH=amd64 pbuilder create --configfile /usr/local/src/owntone-apt/pbuilderrc
# DEBEMAIL=systems@sudo.is dch --create --package owntone --newversion 28.6.125.gitf9c50b8-1+buster --distribution buster --force-distribution "Dummy changelog @commit f9c50b80fc5a18e1c39dd7639be9ee178110f2b3"

# echo "2"
# OS=debian DIST=buster ARCH=amd64 DEB_BUILD_OPTIONS="parallel=$(nproc) nocheck" pdebuild --configfile /usr/local/src/owntone-apt/pbuilderrc

#dpkg-deb -c *.deb


#        -d libavformat-dev \
#        -d libasound2-dev \
#        -d libplist-dev \
#        -d libevent-dev \
#        -d libcurl4-openssl-dev \
#        -d libconfuse-dev \
#        -d libprotobuf-c-dev \
#        -d libavahi-client-dev \
#        -d libwebsockets-dev \
#        -d libpulse-dev \
#        -d libasound2-dev \
#        -d avahi-daemon \
#        -d sqlite3 \
#        -d libavcodec-dev \
#        -d libavfilter-dev \
#        -d systemd \
#        -d libmxml-dev \

