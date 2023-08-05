# owntone

[![Build Status](https://jenkins.sudo.is/buildStatus/icon?job=builds%2Fowntone%2Fmain&style=flat-square)](https://jenkins.sudo.is/job/builds/job/owntone/job/main/)
[![git](../docs/img/shields/git.sudo.is-ben-builds.svg)](https://git.sudo.is/ben/builds/src/branch/main/owntone)
[![github](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/github-benediktkr.svg)](https://github.com/benediktkr/builds/tree/main/owntone)
[![matrix](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/matrix-ben-sudo.is.svg)](https://matrix.to/#/@ben:sudo.is)


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

```shell
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

## partial filescans

there is an open PR [`owntone-server#1179`](https://github.com/owntone/owntone-server/pull/1179)
from [:github: whatdoineed2do](https://github.com/whatdoineed2dothat) that
adds support for partial library file scans (very useful when you mainly listen to podcasts). my builds are currently
rebasing that branch onto the main owntone branch before building, meaning that these builds currently have support
for partial filescans.

they can be triggered through the api with:

```shell
scan_path=/media/audio/podcasts
curl -X PUT "https://${owntone_url}/api/update?kind=files&path=${scan_path}"
```

this branch also includes some rather nice UI improvements.

## own improvements of the web ui

 * try to get the dark-reader css to work
 * when clicking a podcast, default to adding it to the queue instead of replacing the queue.
   probably: [`/src/webapi/index.js#L92`](https://github.com/owntone/owntone-server/blob/master/web-src/src/webapi/index.js#L78-L112)
   should at least provide enough clues to find it in the html (?)

clicking on an item sends a `POST` request `/api/queue/items/add?uris=library:track:40397&shuffle=false&clear=true&playback=start`.

the request paramaters translate to a more readable:

```json
{
  "uris": "library:track:1234",
  "shuffle": false,
  "clear": true,
  "playback": start
}
```

so `"clear"` is the issue.
