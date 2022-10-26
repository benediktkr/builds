# build-jellyfin-web

custom build of [`jellyfin-web`](https://github.com/jellyfin/jellyfin-web). 

moved from [`build-jellyfil-web`](https://git.sudo.is/ben/build-jellyfin-web)

## TODO

* set `outDir`:

  ```
  $ jq .compilerOptions.outDir jellyfin-web/tsconfig.json
  "./dist/"
  ```
