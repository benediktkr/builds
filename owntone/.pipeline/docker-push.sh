#!/bin/bash

set -e

source ./.pipeline/owntone.env

# if [[ -z "${OWNTONE_DOCKER_TAG}" ]]; then
#     OWNTONE_DOCKER_TAG="latest"
# fi

docker push ${DOCKER_REPO}/owntone:${OWNTONE_DOCKER_TAG}
