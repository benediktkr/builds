#!/bin/bash

set -e

source ./.pipeline/owntone.env

. ./.pipeline/init-git.sh

mkdir -pv ./dist/
rm -rv ./dist/target || true
rm -v ./dist/*.tar.gz || true
rm -v ./dist/*.deb || true

docker build --target builder -t owntone:latest-builder .
docker run -u $(id -u) --name owntone-build --rm -it -v $(pwd)/dist/:/mnt/dist/ owntone:latest-builder cp -r /usr/local/src/dist/. /mnt/dist/

docker build -t ${DOCKER_REPO}/owntone:latest .
