#!/bin/bash

# this file run the docker container to build web-src
#
# its set to write the output to dist/htdocs, and use the source files from owntone-server/web-src

set -x

CACHE_DIR=$HOME/.cache/npm-docker/builds/owntone/web-src
if [[ -d "$CACHE_DIR" ]] ; then
    echo "we have run before, the cache dir exists"
    ls -l $CACHE_DIR/bin
fi

mkdir -pv $CACHE_DIR
mkdir -pv dist/htdocs

#       -v $CACHEDIR:/home/node/.npm \

# the /home/node dir is explicitly owned by uid 1000, and npm wants to write to $HOME/.npm (some logs)


docker run \
       --rm \
       -w /owntone-server/web-src \
       -e "HOME=/home/node" \
       -v $(pwd)/dist/htdocs:/dist/htdocs \
       -v $(pwd)/owntone-server/web-src:/owntone-server/web-src \
       -v $(pwd)/builder:/builder \
       -v ${CACHE_DIR}:/home/node/.npm \
       --user "$(id -u):$(id -g)" \
       node:latest \
       /builder/build-web-src.sh
