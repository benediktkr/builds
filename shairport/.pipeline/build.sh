#!/bin/bash

set -e

source ./.pipeline/shairport.env

docker build --pull -t shairport:latest .
docker tag shairport:latest ${DOCKER_REPO}/shairport:latest
