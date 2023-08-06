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
rm -rv ./dist/dark-reader || true
rm -rv ./dist/target || true
rm -v ./dist/*.tar.gz || true
rm -v ./dist/*.deb || true


# try adding dark-reader generated css file. this applies a patch that adds it to
# the Makefile that builds htdocs, and adds it to index.html after the original
# index.css file loads
#
# create the .patch file with (dont include the huge css file):
#   git diff --patch > ../dark-reader/dark-reader-css.patch

# # chdir into the git tree to apply the patch
# (
#     # copy into the git tree and apply the patch
#     cd owntone-server/
#     git apply ../dark-reader/dark-reader-css.patch
# )

# # then copy the css file
# cp dark-reader/dark-reader.css owntone-server/htdocs/assets


# git --no-pager diff --color=always
# cp ../

# if [[ -z "${OWNTONE_DOCKER_TAG}" ]]; then
#     OWNTONE_DOCKER_TAG="latest"
# fi


cd owntone-server/
LATEST_GIT_TAG=$(git tag -l | egrep "^[0-9]+\." | tail -n 1 | tr -d '\n')
cd ..

docker build --pull --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" --build-arg "LATEST_GIT_TAG=$LATEST_GIT_TAG" --target builder -t owntone:latest-builder .
docker run -u $(id -u) --name owntone-build --rm -it -v $(pwd)/dist/:/mnt/dist/ owntone:latest-builder cp -r /usr/local/src/dist/. /mnt/dist/

docker build --pull --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" --build-arg "LATEST_GIT_TAG=$LATEST_GIT_TAG" -t ${DOCKER_REPO}/owntone:${OWNTONE_DOCKER_TAG} .

if [[ -d "./dist/dark-reader/" && -f "./dist/dark-reader/index.html" ]]; then
    echo
    echo
    (
        set -x
        diff --color=always ./dist/dark-reader/index.html ./dist/dark-reader/index.html.orig
    ) || true
    echo
    echo
fi

echo "VITE_OWNTONE_URL=\"${VITE_OWNTONE_URL}\""
echo "OWNTONE_DOCKER_TAG=\"${OWNTONE_DOCKER_TAG}\""
echo "[owntone/.pipeline/build.sh] done"
echo "----------------------------"
