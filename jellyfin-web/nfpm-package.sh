#!/bin/sh

set -e

export name=$(yq .name build.yaml)
export version=$(yq .version build.yaml)

echo "${name} v${version}"

mv /sudois/jellyfin-web/dist /sudois/dist/webpack

mkdir /sudois/dist/etc/
mv /sudois/dist/webpack/config.json /sudois/dist/etc/config.json

nfpm package --config /sudois/dist/nfpm.yaml --packager deb --target /sudois/dist/
