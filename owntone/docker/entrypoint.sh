#!/bin/bash


/etc/init.d/dbus start
/etc/init.d/avahi-daemon start

echo $VITE_OWNTONE_URL

/usr/sbin/owntone $*
