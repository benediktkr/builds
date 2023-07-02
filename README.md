# builds

[![Build Status](https://jenkins.sudo.is/buildStatus/icon?job=ben%2Fbuilds%2Fmain&style=flat-square)](https://jenkins.sudo.is/job/ben/job/builds/)
[![git](docs/img/shields/git.sudo.is-ben-builds.svg)](https://git.sudo.is/ben/builds)
[![github](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/github-benediktkr.svg)](https://github.com/benediktkr/builds)
[![matrix](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/darkroom.svg)](https://matrix.to/#/#darkroom:sudo.is)
[![BSD-3-Clause-No-Military-License](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/license-BSD-blue.svg)](LICENSE)

custom builds of assorted software

## projects

these builds are working (in use in the `sudo.is` infra) and can in theory be publicly used:

 project                                | upstream                                                                           | notes
----------------------------------------|------------------------------------------------------------------------------------|----
 [`airconnect`](airconnect)             | :github: [`philippe44/AirConnect`](https://github.com/philippe44/AirConnect)       | docker only
 [`blink1`](blink1)                     | :github: [`todbot/blink1-tool`](https://github.com/todbot/blink1-tool/)            | for the [blink(1)](https://blink1.thingm.com/)
 [`emacs`](emacs)                       | :git: [`git.savannah.gnu.org/cgit/emacs.git`](https://git.savannah.gnu.org/cgit/emacs.git/)  | compiles emacs from source and publishes as `.deb` packages for ubuntu and debian (published on [`apt.sudo.is`](https://apt.sudo.is))
 [`framework-ectool`](framework-ectool) | :github: [`DHowett/framework-ec`](https://github.com/DHowett/framework-ec)         |
 [`hydrogen-web`](hydrogen-web)         | :github: [`vector-im/hydrogen-web`](https://github.com/vector-im/hydrogen-web)     | builds as static html/jss/css files, packaged as`.deb.` package (published on [`apt.sudo.is`](https://apt.sudo.is))
 [`jellyfin-tizen`](jellyfin-tizen)     | :github: [`jellyfin/jellyfin-tizen`](https://github.com/jellyfin/jellyfin-tizen)   |
 [`owntone`](owntone)                   | :github: [`owntone/owntone`](https://github.com/owntone/owntone-server)            |
 [`playonlinux`](socat)                 | [PlayOnLinux](https://www.playonlinux.com/en/)                                     |
 [`shairport`](shairport)               | :github: [`mikebrady/shairport-sync`](https://github.com/mikebrady/shairport-sync) | docker only
 [`socat-dns-docker`](socat-dns-docker) | N/A                                                                                | using `socat` to forward the dns server for a bridged docker network


### in progress / not ready

these builds are not ready yet, and are at various stages of 'in progress':

 project                                | upstream                                                                          | notes
----------------------------------------|-----------------------------------------------------------------------------------|----
 [`calibre-web`](calibre-web)           | :github: [`janeczku/calibre-web`](https://github.com/janeczku/calibre-web)        |
 [`jellyfin-web`](jellyfin-web)         | :github: [`jellyfin/jellyfin-web`](https://github.com/jellyfin/jellyfin-web)      |
 [`lldap`](lldap)                       | :github: [`nitnelave/lldap`](https://github.com/nitnelave/lldap)                  |
 [`shields`](shields)                   | :github: [`badges/shields`](https://github.com/badges/shields)                    |


## repos

 * :gitea: [`git.sudo.is/ben/builds`](https://git.sudo.is/ben/builds) | upstream
 * :github: [`benediktkr/builds`](https://github.com/benediktkr/builds) | mirror
