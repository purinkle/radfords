# Keep the 7.0 cookie metadata format

Rails 7.1's framework defaults set
`config.active_support.use_message_serializer_for_metadata = true`, which
changes how a signed or encrypted cookie stores its purpose and expiry. On the
7.1 hop we took every other 7.1 default but set it back to `false` in
`config/application.rb`.

## What broke

Checked on 2026-11-24 with Rails 7.1.6.

`spec/requests/cookie_rotation_spec.rb` signs a remember token the way Rails
6.1 did, with SHA1 keys and the old metadata envelope, and loads a page that
needs a signed-in customer. With this default on, the cookie verifies, but
its value comes back as the JSON text `[1,"…"]` rather than the array it
stored. `SessionsHelper#current_user` splats that into
`User.authenticate_with_salt`, which raises `ArgumentError`, so anyone holding
an old remember token gets an error page rather than a signed-in session.

With the default off, the same spec passes, and so does the rest of the
suite.

## Why keep the old value

Issue 613 asks that customers stay signed in across the upgrade where that is
possible. The remember token is a permanent cookie, so tokens written under
6.1 can still arrive for years. The 7.0 hop added a cookie rotator for exactly
these cookies; turning this default on would undo it.

Keeping the old format costs nothing a customer can see: Rails 7.1 still reads
and writes it, and the suite passes on it.

## When this can go

Turn the default on, and delete this ADR, when either is true:

- The cookie rotator in `config/initializers/cookie_rotator.rb` is removed,
  because tokens signed before 7.0 no longer need to read.
- Signing everyone out once is accepted, for example at a deploy that already
  resets sessions.

Run `spec/requests/cookie_rotation_spec.rb` when you do. If the rotator stays,
that spec must keep passing.
