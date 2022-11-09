# shields 

for making a build with a base url other than `/`. 

## approaches

uses something called gatsbyjs. 

docs: 

 * https://www.gatsbyjs.com/docs/how-to/previews-deploys-hosting/path-prefix/#build
 * https://github.com/badges/shields/blob/master/doc/self-hosting.md#separate-frontend-hosting
 * https://www.gatsbyjs.com/docs/reference/built-in-components/gatsby-link/

code: 

 * https://github.com/badges/shields/blob/master/frontend/constants.ts#L1
 * https://github.com/badges/shields/blob/master/.circleci/config.yml#L120 (set in ci tests)
 * https://github.com/badges/shields/blob/master/services/github/auth/acceptor.js#L6
 * search for `baseUrl` (what the variable is called): https://github.com/badges/shields/search?q=baseUrl

 > No support for baseUrl or pathso use the `.js` or `.ts` files inside tsconfig.json

https://www.gatsbyjs.com/docs/how-to/custom-configuration/typescript/
in `Dockerfile`:

```Dockerfile
RUN GATSBY_BASE_URL=https://git.sudo.is/shieldsio/ npm prune --production
```


