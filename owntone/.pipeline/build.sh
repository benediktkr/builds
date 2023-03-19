#!/bin/bash

set -e

source ./.pipeline/owntone.env
source ./.pipeline/owntone-url.env

if [ "$VITE_OWNTONE_URL" = "" ]; then
    echo "VITE_OWNTONE_URL is not set, default will be used!"
    sleep 10
fi

. ./.pipeline/init-git.sh

mkdir -pv ./dist/
rm -rv ./dist/target || true
rm -v ./dist/*.tar.gz || true
rm -v ./dist/*.deb || true

docker build --pull --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" --target builder -t owntone:latest-builder .
docker run -u $(id -u) --name owntone-build --rm -it -v $(pwd)/dist/:/mnt/dist/ owntone:latest-builder cp -r /usr/local/src/dist/. /mnt/dist/

docker build --pull --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" -t ${DOCKER_REPO}/owntone:latest .

echo "$VITE_OWNTONE_URL"
