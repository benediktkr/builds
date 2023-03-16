#!/bin/bash

docker run -v /run/dbus:/run/dbus --net=host --name owntone --rm -it git.sudo.is/ben/owntone:latest


