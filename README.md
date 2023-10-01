# builds

[![Build Status](https://jenkins.sudo.is/buildStatus/icon?job=ben%2Fbuilds%2Fmain&style=flat-square)](https://jenkins.sudo.is/job/ben/job/builds/)
[![git](docs/img/shields/git.sudo.is-ben-builds.svg)](https://git.sudo.is/ben/builds)
[![github](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/github-benediktkr.svg)](https://github.com/benediktkr/builds)
[![matrix](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/darkroom.svg)](https://matrix.to/#/#darkroom:sudo.is)
[![BSD-3-Clause-No-Military-License](https://git.sudo.is/ben/infra/media/branch/main/docs/img/shields/license-BSD-blue.svg)](LICENSE)

Custom builds of assorted software. Some smaller projects live directly in this repo,
but most have their own repos. It is a lot easier to work with CI systems that expect a
1:1 relationship between builds/projects and git repos.

## projects

these builds are working (in use in the `sudo.is` infra) and can in theory be publicly used:

 project                                                                  | upstream                                                                           | notes
--------------------------------------------------------------------------|------------------------------------------------------------------------------------|----
 [`airconnect`](https://git.sudo.is/ben/build-airconnect)                 | :github: [`philippe44/AirConnect`](https://github.com/philippe44/AirConnect)       | docker only
 [`blink1`](https://git.sudo.is/ben/build-blink1)                         | :github: [`todbot/blink1-tool`](https://github.com/todbot/blink1-tool/)            | for the [blink(1)](https://blink1.thingm.com/)
 [`emacs`](https://git.sudo.is/ben/emacs-docker)                          | :git: [`git.savannah.gnu.org/cgit/emacs.git`](https://git.savannah.gnu.org/cgit/emacs.git/)  | compiles emacs from source and publishes as `.deb` packages for ubuntu and debian (published on [`apt.sudo.is`](https://apt.sudo.is))
 [`hass`](https://git.sudo.is/ben/build-hass)                             | :github: [`home-assistant/core`](https://github.com/home-assistant/core)
 [`hydrogen-web`](https://git.sudo.is/ben/hydrogen-docker)                | :github: [`vector-im/hydrogen-web`](https://github.com/vector-im/hydrogen-web)     | builds as static html/jss/css files, packaged as`.deb.` package (published on [`apt.sudo.is`](https://apt.sudo.is))
 [`jellyfin-tizen`](jellyfin-tizen)                                       | :github: [`jellyfin/jellyfin-tizen`](https://github.com/jellyfin/jellyfin-tizen)   |
 [`jenkins`](https://git.sudo.is/ben/jenkins-docker)                      | :github: [`jenkinsci/jenkins`](https://github.com/jenkinsci/jenkins)               |
 [`owntone`](owntone)                                                     | :github: [`owntone/owntone-server`](https://github.com/owntone/owntone-server)            |
 [`playonlinux`](https://git.sudo.is/ben/playonlinux-docker)              | [PlayOnLinux](https://www.playonlinux.com/en/)                                     |
 [`shairport`](shairport)                                                 | :github: [`mikebrady/shairport-sync`](https://github.com/mikebrady/shairport-sync) | docker only
 [`socat-dns`](https://git.sudo.is/ben/socat-dns-docker)                  | N/A                                                                                | using `socat` to forward the dns server for a bridged docker network
 [`synapse-admin`](https://git.sudo.is/ben/synapse-admin-docker)          | :github: [`Awesome-Technologies/synapse-admin`](https://github.com/Awesome-Technologies/synapse-admin) |

### in progress / not ready

these builds are not ready yet, and are at various stages of 'in progress':

 project                                | upstream                                                                          | notes
----------------------------------------|-----------------------------------------------------------------------------------|----
 [`calibre-web`](calibre-web)           | :github: [`janeczku/calibre-web`](https://github.com/janeczku/calibre-web)        |
 [`framework-ectool`](framework-ectool) | :github: [`DHowett/framework-ec`](https://github.com/DHowett/framework-ec)         |
 [`jellyfin-web`](jellyfin-web)         | :github: [`jellyfin/jellyfin-web`](https://github.com/jellyfin/jellyfin-web)      |
 [`lldap`](lldap)                       | :github: [`nitnelave/lldap`](https://github.com/nitnelave/lldap)                  |
 [`shields`](shields)                   | :github: [`badges/shields`](https://github.com/badges/shields)                    |


## Adding submodules


New submodule:

```shell
branch=main

# add submodule to track a branch
git submodule add -b $branch $url

# update submodule
git submodule update --remote
```

change existing submodule to track a branch

```shell
submodule=foo
branch=main

# change the submodule defintion in the parent repo
git config -f .gitmodules submodule.${submodule}.branch $branch

# and make sure the submodule itself is actually at that branch
cd $submodule
git checkout $branch
git branch -u origin/$branch $branch
```

## repos

 * :gitea: [`git.sudo.is/ben/builds`](https://git.sudo.is/ben/builds) | upstream
 * :github: [`benediktkr/builds`](https://github.com/benediktkr/builds) | mirror
