#!/bin/sh


set -e

FROM="Jellyfin"
TO="Notflix"

# sed -i "s/title = '${FROM}'/title = '${TO}'/g" src/scripts/libraryMenu.js
# sed -i "s/title = title || '${FROM}'/title = title || '${FROM}'/g" src/scripts/libraryMenu.js

sed -i "s/${FROM}/${TO}/g" src/scripts/libraryMenu.js
sed -i "s/${FROM}/${TO}/g" src/index.html
sed -i "s/${FROM}/${TO}/g" src/controllers/dashboard/dashboard.html
