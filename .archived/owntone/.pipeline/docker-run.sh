#!/bin/bash

#docker run --net=host --name owntone --rm -it git.sudo.is/ben/owntone:latest $*
mkdir -p /tmp/owntone-test
docker run -v /tmp/owntone-test:/srv/music -v $(pwd)/docker/owntone.conf:/etc/owntone.conf -p 3689:3689 --name owntone --rm -it git.sudo.is/ben/owntone:latest $*


