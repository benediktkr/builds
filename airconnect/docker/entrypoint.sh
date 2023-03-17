#!/bin/sh


if [ "$1" = "airupnp" ]; then
    PROG="airupnp"
    shift
    if [ "$1" = "" ]; then
        ARGS="-x /etc/airupnp.xml"
    else
        ARGS="$*"
    fi
elif [ "$1" = "aircast" ]; then
    shift
    PROG="aircast"
elif [ "$1" = "sh" ] || [ "$1" == "/bin/sh" ]; then
    /bin/sh
else
    echo "usage $0 <airupnp|airupnp> [args]"
    exit 1
fi

set -x
/usr/local/bin/${PROG} $ARGS
