#!/bin/bash

set -e

usage() {
    echo "$0 <project>"
    exit 1
}

if [ "$1" = "" ]; then
    usage
else
    PROJECT=$1
    PROJECT_PIPELINE=./${PROJECT}/.pipeline
    shift
fi

for f in ${PROJECT_PIPELINE}/*.env; do
    echo "sourcing: $f"
    source $f
    cat $f
done
echo && echo

if [ "${DOCKER_REPO}" = "" ]; then
    # default if not explicitly set in project
    DOCKER_REPO="git.sudo.is/ben"
fi

if [ -f "${PROJECT_PIPELINE}/init-git.sh" ]; then
    echo "running 'init-git.sh' for ${PROJECT}"
    (
        set -e
        cd ./${PROJECT} && echo "cd $(pwd)"
        . .pipeline/init-git.sh
    )
else
    echo "git repos not pulled/updated, ${PROJECT} has no 'git-init.sh' file."
fi
echo && echo

echo "cleaning up ${PROJECT}/dist"
mkdir -pv ./${PROJECT}/dist

if [ -d ./${PROJECT}/dist/target ]; then
    echo "removing directory '${PROJECT}/dist/target'"
    rm -r ${PROJECT}/dist/target
fi

if [ -f "./${PROJECT}/dist/*.tar.gz" ]; then
    rm -v ./${PROJECT}/dist/*.tar.gz
fi
if [ -f "./${PROJECT}/dist/*.tar.gz2" ]; then
    rm -v ./${PROJECT}/dist/*.tar.gz2
fi
if [ -f "./${PROJECT}/dist/*.deb" ]; then
    rm -v ./${PROJECT}/dist/*.deb
fi
echo && echo

BUILD_ARGS_FILE="${PROJECT_PIPELINE}/docker-build-args"
if [ -f "$BUILD_ARGS_FILE" ]; then
   echo "found docker-build-args file"
   cat $BUILD_ARGS_FILE

   while read -r item; do
       BUILD_ARGS="$BUILD_ARGS --build-arg \"${item}\""
   done < $BUILD_ARGS_FILE
   echo && echo
fi

(
    set -e
    cd ./${PROJECT} && echo "cd $(pwd)"

    if grep -q "as builder" Dockerfile; then
        echo "Dockerfile has a 'build' stage"
        docker build --pull $BUILD_ARGS --target builder -t ${PROJECT}:latest-builder .
        docker run -u $(id -u) --name owntone-build --rm -it -v $(pwd)/dist/:/mnt/dist/ ${PROJECT}:latest-builder cp -r /usr/local/src/dist/. /mnt/dist/

        echo && echo
    fi

    docker build --pull ${BUILD_ARGS} -t ${DOCKER_REPO}/${PROJECT}:latest .

)

echo && echo
echo "DONE: ${PROJECT}"
