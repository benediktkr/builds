# airconnect

a simple and small docker container for
[AirConnect](https://github.com/philippe44/AirConnect).

the container that the repo itself points to uses a linuxserver.io
base image for some reason which runs as root and runs a whole init
system for some reason.

did not build the binaries myself, this container just uses the precompiled
binaries from the upstream repo (see the [Dockerfile](Dockerfile)).

## running

since we dont want to run an init system in a docker container and
AirConnect has separate binaries for UPnP and Chromecast, just run two
containers:

for `airupnp` (UPnP/Sonos):

```shell
# pass cmdline args:
docker run --name airconnect-airupnp -it --net=host \
    git.sudo.is/ben/airconnect airupnp -l 1000:2000

# if you want to mount an /etc/airupnp.xml config file instead:
docker run --name airconnect-airupnp -it --net=host \
    -v airupnp.xml:/etc/airupnp.xml \
    git.sudo.is/ben/airconnect airupnp
```

for `aircast` (Chromecast):

```shell
docker run --name airconnect-aircast -it --net=host \
    git.sudo.is/ben/airconnect aircast
```
