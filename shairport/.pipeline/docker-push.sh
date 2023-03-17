#!/bin/bash

set -e

source ./.pipeline/shairport.env

docker push ${DOCKER_REPO}/shairport:latest
