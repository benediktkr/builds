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
 [`framework-ectool`](framework-ectool) | :github: [`DHowett/framework-ec`](https://github.com/DHowett/framework-ec)         |
 [`jellyfin-tizen`](jellyfin-tizen)     | :github: [`jellyfin/jellyfin-tizen`](https://github.com/jellyfin/jellyfin-tizen)   |
 [`owntone`](owntone)                   | :github: [`owntone/owntone`](https://github.com/owntone/owntone-server)            |
 [`shairport`](shairport)               | :github: [`mikebrady/shairport-sync`](https://github.com/mikebrady/shairport-sync) | docker only


### in progress / not ready

these builds are not ready yet, and are at various stages of 'in progress':

 project                                | upstream                                                                          | notes
----------------------------------------|-----------------------------------------------------------------------------------|----
 [`calibre-web`](calibre-web)           | :github: [`janeczku/calibre-web`](https://github.com/janeczku/calibre-web)        |
 [`jellyfin-web`](jellyfin-web)         | :github: [`jellyfin/jellyfin-web`](https://github.com/jellyfin/jellyfin-web)      |
 [`lldap`](lldap)                       | :github: [`nitnelave/lldap`](https://github.com/nitnelave/lldap)                  |
 [`shields`](shields)                   | :github: [`badges/shields`](https://github.com/badges/shields)                    |

## other build repos

 * [`ben/emacs-docker`](https://git.sudo.is/ben/emacs-docker): compiles emacs from source and publishes as `.deb` packages for ubuntu and debian on `apt.sudo.is`.
 * [`ben/hydrogen-docker`](https://git.sudo.is/ben/hydrogen-docker): builds [hydrogen](https://matrix.org/docs/projects/client/hydrogen) as static html/jss/cs files as a `.deb.` package, published on `apt.sudo.is`.
 * [`ben/playonlinux-docker`](https://git.sudo.is/ben/socat-dns-docker): play windows games in docker with [PlayOnLinux](https://www.playonlinux.com/en/).

## repos

 * :gitea: [`git.sudo.is/ben/builds`](https://git.sudo.is/ben/builds) | upstream
 * :github: [`benediktkr/builds`](https://github.com/benediktkr/builds) | mirror
