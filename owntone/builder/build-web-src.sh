#!/bin/bash

# this should inside of a 'node:latest' docker container
#
# this script assumes that the 'owntone-server/web-src' directory is mounted as /owntone-server/web-src
# we set the output directory in the build command, we use '/dist/htdocs'
#
# it also expects our builder dir to be mounted as /builder, where it executes this script from
#
# so the container expects these mounts
# ./owntone-server/web-src:/owntone-server/web-src
# ./dist/htdocs/:/dist/htdocs

set -e
set -x


env
id

# the script expects to have /owntone-server/web-src as its WORKDIR, but we cd there anyway

cd /owntone-server/web-src
pwd

patch -p1 -t -i /builder/wsurl.patch

npm install
npm run build -- --minify=false --outDir=/dist/htdocs --emptyOutDir
