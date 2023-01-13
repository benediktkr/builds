# jellyfin-tizen

upstream repo: [github.com/jellyfin/jellyfin-tizen](https://github.com/jellyfin/jellyfin-tizen).

builds the current version of the jellyfin app for samsung tv's
running tizen, using the (slighlty annoying)
[tizen studio](https://docs.tizen.org/application/tizen-studio/setup/install-sdk/).

this builds a `Jellyfin.wgt` file in a docker container, that are
added to the pacakges for this repo:
[ben/-/packages/generic/jellyfin-tizen](https://git.sudo.is/ben/-/packages/generic/jellyfin-tizen/)

# installing

prerequisite: turn on the tv and [activate developer
mode](https://developer.samsung.com/tv/develop/getting-started/using-sdk/tv-device).
probably will also have to set `Permit to install applications` on the
TV using "Device Manager" fromtize studio, or using `sdb` somehow.

then build or download the `Jellyfin.wgt` file:

```
wget https://git.sudo.is/api/packages/ben/generic/jellyfin-tizen/latest/Jellyfin.wgt
```

use `sdb` to connect to your tv and find the target/model name, and
install with `tizen`


```
sdb connect ${TV_IP}

# find $TV_MODEL
sdb devices

tizen install -n Jellyfin.wgt -t ${TV_MODEL}
```

both `sdb` and `tizen` are from tizen studio, so that needs to be
installed. more complete info is in the upstream projects `README.md`
file.
