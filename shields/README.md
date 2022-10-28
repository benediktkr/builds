# shields 

for making a build with a base url other than `/`. 

## approaches

uses something called gatsbyjs. 

docs: https://www.gatsbyjs.com/docs/how-to/previews-deploys-hosting/path-prefix/#build

in `Dockerfile`:

```Dockerfile
RUN GATSBY_BASE_URL=https://git.sudo.is/shieldsio/ npm prune --production
```


