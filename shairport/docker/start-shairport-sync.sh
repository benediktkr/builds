#!/bin/sh

set -e

echo -ne "whoami: "
whoami
echo -ne "id: "
id

ls -lah /pipes/

/usr/local/bin/shairport-sync
