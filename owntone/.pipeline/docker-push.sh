#!/bin/bash

set -e

source ./.pipeline/owntone.env

docker push ${DOCKER_REPO}/owntone:latest

