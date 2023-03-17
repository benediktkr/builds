# owntone

a custom docker container for [`owntone`](https://github.com/owntone/owntone-server)
since the upstream repo points to a docker container from linuximage.io, which are
terrible because the run as root an run a whole init system for some inexplicable
reason.

## notes on the build

this builds a `.deb` file (that will be available on
[`apt.sudo.is`](https://apt.sudo.is) in the future (when pipelines for
this repo has been figured out), following [the build section of the
documentation](https://owntone.github.io/owntone-server/building/).

this image is based on the `ubuntu:latest` base image, because of the
complex dependencies, and i was not able to figure out how to compile
a static binary. i tried following the github pipeline they have to
build a `.deb` but found it too complex and built a simple `.deb` with
`fpm`. the image compiles owntone and builds the `.deb` package in the
`builder` stage, and then copies te `.deb` file over in the `final`
stage and installs it.

the dependencies are listed in [`deps.txt`](builds/deps.txt) to install them in
the `base` stage in docker, so that they wouldnt get re-installed every time
the build has changed. the dependencies for running are slightly slammer than
the dependencies for building.

## run

```
docker run --name owntone -it --net=host \
   -v owntone.conf:/etc/owntone.conf \
   -v owntone.log:/var/log/owntone.log \
   -v cache/:/var/cache/owntone \
   -v music/:/srv/music \
   git.sudo.is/ben/owntone
```

note that you can change the defaults paths `/srv/music` and
`/var/cache/owntone` in `owntone.conf` to better suit your needs, if
you want.

the container starts as root, and then the `owntone` binary `setuid`s
itself down to the user that you have specified in
`owntone.conf`. note that this username (cant specify uid) has to
exist in the container. if you want to change it you can rebuild the
container with different `UID` and `GID` build args, or create a new
user in a custom `entrypoint.sh` script. you can also start the
container as non-root, as long as you make sure that the paths that
owntone wants to write to are writable to that user (mounts).
