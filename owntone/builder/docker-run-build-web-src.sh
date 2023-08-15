#!/bin/bash

# this file run the docker container to build web-src
#
# its set to write the output to dist/htdocs, and use the source files from owntone-server/web-src

mkdir -p dist/htdocs

docker run \
       --rm \
       -w /owntone-server/web-src \
       -v $(pwd)/dist/htdocs:/dist/htdocs \
       -v $(pwd)/owntone-server/web-src:/owntone-server/web-src \
       -v $(pwd)/builder:/builder \
       --user "$(id -u):$(id -g)" \
       node:latest \
       /builder/build-web-src.sh

rm -v dist/htdocs.zip
(
    cd dist/htdocs
    zip -r ../htdocs.zip .
)
