#!/bin/bash

set -e

REPO_NAME=ectools
TMP_CONTAINER=build-${REPO_NAME}

docker build --build-arg REPO_NAME=${REPO_NAME} --build-arg UID=$(id -u) -t ${REPO_NAME}:latest .

# remove container if it already exists
docker container rm ${TMP_CONTAINER} || true

# create container from latest image
docker container create --name $TMP_CONTAINER ectools:latest

# copy the build
docker container cp ${TMP_CONTAINER}:/opt/${REPO_NAME}/build/ .
docker container cp ${TMP_CONTAINER}:/opt/${REPO_NAME}/dist/ .

# clean up container
docker container rm ${TMP_CONTAINER}
