#!/bin/sh

set -e

rm -vr /mnt/dist/*.deb || true
( rm -r /mnt/dist/webpack && echo "removed '/mnt/dist/webpack'" ) || true
rm -vr /mnt/dist/nfpm.yaml || true

echo
cp -r /sudois/dist/* /mnt/dist/
ls -1 /mnt/dist/
