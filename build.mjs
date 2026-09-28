// PROTOTYPE. Replaces config/webpack/*. Answers issue #580 question 3.
//
// The one piece of real logic carried over from config/webpack/environment.js:
// the Stripe stub is a test-only entry, so no build but the test one emits it.
//
// The outdir is wiped first. esbuild does not clean, and Sprockets links the
// whole builds directory, so a stub left by an earlier test build would
// otherwise be served in production.
import * as esbuild from "esbuild"
import { rm, mkdir } from "node:fs/promises"

const outdir = "app/assets/builds"
const entries = ["app/javascript/application.js"]

if (process.env.RAILS_ENV === "test") {
  entries.push("app/javascript/stripe_stub.js")
}

await rm(outdir, { recursive: true, force: true })
await mkdir(outdir, { recursive: true })

await esbuild.build({
  entryPoints: entries,
  bundle: true,
  outdir,
  sourcemap: true,
  minify: process.env.RAILS_ENV === "production",
  logLevel: "info",
})
