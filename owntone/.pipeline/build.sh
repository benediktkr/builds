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
rm -rv ./dist/dark-reader || true
rm -rv ./dist/target || true
rm -v ./dist/*.tar.gz || true
rm -v ./dist/*.deb || true


# try adding dark-reader generated css file. this applies a patch that adds it to
# the Makefile that builds htdocs, and adds it to index.html after the original
# index.css file loads
#
# create the .patch file with (dont include the huge css file):
#   git diff --patch > ../dark-reader-css.patch

# # chdir into the git tree to apply the patch
# (
#     # copy into the git tree and apply the patch
#     cd owntone-server/
#     git apply ../dark-reader-css.patch
# )

# # then copy the css file
# cp dark-reader.css owntone-server/htdocs/assets


# git --no-pager diff --color=always
# cp ../

docker build --pull --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" --target builder -t owntone:latest-builder .
docker run -u $(id -u) --name owntone-build --rm -it -v $(pwd)/dist/:/mnt/dist/ owntone:latest-builder cp -r /usr/local/src/dist/. /mnt/dist/

docker build --pull --build-arg "VITE_OWNTONE_URL=$VITE_OWNTONE_URL" -t ${DOCKER_REPO}/owntone:${OWNTONE_DOCKER_TAG} .

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
echo "[owntone/.pipeline/build.sh] done"
echo "----------------------------"
