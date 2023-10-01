#!/bin/bash


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
