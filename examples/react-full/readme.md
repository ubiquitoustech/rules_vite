Example of using `vite-plugin-ssr` with React that showcases many features.

For a simpler example, check out [/examples/react/](/examples/react/).

Features:

- Client Routing (+ usage of `navigate()`)
- Data Fetching (server-side fetching + isomorphic fetching)
- Pre-rendering (+ usage of the `prerender()` hook)
- Route Function
- TypeScript
- Markdown
- Error Page
- Active Links
- Access `pageContext` from any React component (using React Context)
- HTML streaming

To run it:

```bash
git clone git@github.com:brillout/vite-plugin-ssr
cd vite-plugin-ssr/examples/react-full/
npm install
npm run start
```

npx vite build --outDir=testClient

npx vite build --ssr --outDir=testServer

npx vite-plugin-ssr prerender --outDir=testClient --serverDir=testServer --writeOutDir=testOut

then move the assets folder from testClient to testOut

// "vite-plugin-ssr": "npm:@ubiquitoustech/vite-plugin-ssr@^0.3.13"

currently this example uses a version of vite-plugin-ssr with some changes to how inputs are read and outputs are written
