# Keep webpack 4 behind the OpenSSL legacy provider

Moving the app from Node 16 to Node 24 brings OpenSSL 3, which dropped the md4
hash, and the asset build still asks for md4. We kept webpack 4 and turned md4
back on, by setting `NODE_OPTIONS=--openssl-legacy-provider` in `bin/webpack`
and `bin/webpack-dev-server`, rather than leave webpacker for a build that does
not need the flag.

## What actually needs the flag

Checked on 2026-09-25 under Node 24.21.0.

Webpack itself does not need it. Webpack 4.47.0 still defaults
`output.hashFunction` to md4 and names md4 in six other modules, but each of
those calls goes through `lib/util/createHash.js`, and since 4.47.0 that file
answers md4 from a WebAssembly implementation it ships, whenever Node is 18 or
newer. A development build finishes on Node 24 with no flag set, and emits the
same content hashes either way.

One build plugin does need it. `compression-webpack-plugin` 4.0.1 calls
`crypto.createHash("md4")` directly, at `dist/index.js:163`, to build a cache
key, and that goes to OpenSSL. The call sits on the webpack 4 branch of the
plugin and only runs when assets are compressed, so the failure is a production
one. A clean `RAILS_ENV=production bin/rails assets:precompile` on Node 24
without the flag ends in:

```
Compilation failed:
Error: error:0308010C:digital envelope routines::unsupported
```

With the flag, the same command completes. `terser-webpack-plugin` asks for md4
too, but tries webpack's own `createHash` before falling back to `crypto`, so
it needs nothing.

## Considered options

The flag exists because `@rails/webpacker` 5.4.4 pins webpack 4. Leaving it
means moving to shakapacker or jsbundling-rails, which is a project of its own,
overlaps with the Rails upgrade, and is being sized separately. That migration
also clears the `webpack-dev-server` security alerts, which this decision does
not: those are first patched in 5.2.x, and `webpack-dev-server` 5.2.6 asks for
webpack 5. So the flag buys a supported Node runtime now and leaves the webpack
question open.

## Consequences

The flag lives in the two binstubs rather than in a Procfile, a CI file and a
shell profile. Webpacker's compiler shells out to `bin/webpack`, so one place
covers a bare run, `bin/rails assets:precompile`, CI and the Heroku slug build,
which is where the assets are compiled. A reader who finds the flag finds this
file beside it.

The flag is not free. It re-enables OpenSSL's legacy provider for the whole
build process, which is more than md4. Nothing in the build signs or verifies
anything, so the risk is confined to a cache key, but the flag should go when
webpack 4 does.

One side effect is useful: Node 16 rejects `--openssl-legacy-provider` in
`NODE_OPTIONS` outright, so the build now stops dead on the runtime this app no
longer supports, instead of quietly working.
