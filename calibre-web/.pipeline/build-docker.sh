#!/bin/bash

echo "build: docker"
docker build  --build-arg UID=$(id -u) -t ${NAME}:latest .
