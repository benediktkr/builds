#!/bin/bash

set -e

source ./.pipeline/owntone.env

# for (failed) attemps at changing the default url
source ./.pipeline/owntone-url.env

if [[ "$VITE_OWNTONE_URL" == "" ]]; then
    echo "VITE_OWNTONE_URL is not set, default will be used!"
fi

. ./.pipeline/init-git.sh

mkdir -pv ./dist/

rm -rv ./dist/target || true
rm -v ./dist/*.tar.gz || true
rm -v ./dist/*.deb || true


# first i tried adding dark-reader.css here, before 'docker build', by creating a .patch file, and modifying
# the index.html file and its Makefile before they were called (which they may not be)
#
# now its been moved to happen inside the docker container
#
# see more in builder/dark-reader.sh


# ./builder/dark-reader.sh

# if [[ -z "${OWNTONE_DOCKER_TAG}" ]]; then
#     OWNTONE_DOCKER_TAG="latest"
# fi


# in build-owntone.sh this gets used as a fallback (if 'owntone --version' doesnt work)
# but it is currently commented out, so nothing uses this.
LATEST_GIT_TAG=$(git -C owntone-server/ tag -l | egrep "^[0-9]+\." | tail -n 1 | tr -d '\n')
echo "latest git tag in 'owntone-server': $LATEST_GIT_TAG"

docker \
    build \
    --pull \
    --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" \
    --build-arg "LATEST_GIT_TAG=$LATEST_GIT_TAG" \
    --target builder \
    -t owntone:latest-builder \
    .


docker \
    run \
    -u $(id -u) \
    --name owntone-build \
    --rm \
    -it \
    -v $(pwd)/dist/:/mnt/dist/ \
    owntone:latest-builder \
    cp -r /usr/local/src/dist/. /mnt/dist/

docker build --pull --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" --build-arg "LATEST_GIT_TAG=$LATEST_GIT_TAG" -t ${DOCKER_REPO}/owntone:${OWNTONE_DOCKER_TAG} .

./builder/dark-reader-show-diff.sh

echo "VITE_OWNTONE_URL=\"${VITE_OWNTONE_URL}\""
echo "OWNTONE_DOCKER_TAG=\"${OWNTONE_DOCKER_TAG}\""
echo "[owntone/.pipeline/build.sh] done"
echo "----------------------------"
