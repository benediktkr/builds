#!/bin/bash

mkdir /var/cache/owntone
chown owntone:owntone /var/cache/owntone

/etc/init.d/dbus start
/etc/init.d/avahi-daemon start
/usr/sbin/owntone -f
