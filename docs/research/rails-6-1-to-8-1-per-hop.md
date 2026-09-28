# Rails 6.1.7.10 → 8.1.3 for radfords: a per-hop sizing

Research date: 2026-09-28. Every claim below carries the URL it came from.
Primary sources only: `rails/rails` files at a git tag, the official guides'
source markdown at a tag, the RubyGems API, and ruby-lang.org.

---

## Summary

The Ruby floor, not the Rails API, is what gates this project. The app runs
Ruby 2.6.10 (`/Users/purinkle/Developer/purinkle/radfords/.ruby-version`), and
every hop from 7.2 onwards needs Ruby 3.x. Rails 7.1 is the last release that
still accepts Ruby 2.7.

Per-hop weight, measured by framework defaults introduced and by how many of
this app's own config lines each hop invalidates:

| Hop | `required_ruby_version` | Defaults added | Behaviour-changing | App config lines broken |
|---|---|---|---|---|
| 6.1 → 7.0 | `>= 2.7.0` | 17 | 16 | 1 (`require "sprockets/railtie"` loses its gem) |
| 7.0 → 7.1 | `>= 2.7.0` | 24 | 20 | 1 (`show_exceptions = false` deprecated) |
| 7.1 → 7.2 | `>= 3.1.0` | 4 | 3 | 1 (`show_exceptions = false` removed) |
| 7.2 → 8.0 | `>= 3.2.0` | 2 | 2 | 1 (`read_encrypted_secrets` removed) |
| 8.0 → 8.1 | `>= 3.2.0` | 7 | 4 | 0 |

Totals: 54 framework defaults across the five hops, 45 of them
behaviour-changing by the rule stated under "Counting rule" below.

**6.1 → 7.0 and 7.0 → 7.1 are the two expensive hops**, and 7.0 → 7.1 is the
worse of the two: it adds 24 defaults to 7.0's 17, and unlike 7.0 it lands on
top of an app whose `load_defaults` is still 6.0, so the backlog compounds.

### Read this against the jsbundling prototype, not against main

`main` still carries `@rails/webpacker` 5.4.4, `webpack` 4, `webpack-cli` 3 and
a `webpack-dev-server` 3 devDependency. This research was read while the branch
`prototype/jsbundling` was being built, and that branch has since been committed
as `c4d5593`. It answers issue 580 question 3 by doing the webpacker exit and
measuring it. This document was written against that work in progress, so the
state it describes below is the prototype branch's, not main's.

On `prototype/jsbundling`:

- `Gemfile` line 33 is `gem "jsbundling-rails"`, replacing `gem "webpacker"`.
  `Gemfile.lock` has `jsbundling-rails (1.3.1)` and has dropped `webpacker
  (5.4.4)`, `rack-proxy (0.7.6)` and `semantic_range (3.0.0)`.
- `package.json` has no `@rails/webpacker`, no webpack. It depends on
  `esbuild ^0.25.0` and its `build` script is `node build.mjs`. esbuild sits in
  `dependencies`, not `devDependencies`, because jsbundling runs `yarn install`
  before every build and `NODE_ENV=production` prunes devDependencies.
- `build.mjs` is an esbuild script writing to `app/assets/builds`. Its header
  reads `// PROTOTYPE. Replaces config/webpack/*. Answers issue #580 question 3.`
- `config/webpacker.yml`, `config/webpack/*.js`, `bin/webpack` and
  `bin/webpack-dev-server` are all deleted; `app/javascript/packs/*` has moved
  up to `app/javascript/*`.
- `app/assets/config/manifest.js` has gained `//= link_directory ../builds .js`,
  so Sprockets serves the esbuild output.
- `Rakefile` has gained a `build_javascript_for_test` task that runs `yarn
  build` with `RAILS_ENV=test`, and `default` is now
  `%i[build_javascript_for_test spec]`.
- Views call `javascript_include_tag`, never `javascript_pack_tag`
  (`app/views/application/_javascript.html.erb`, `app/views/orders/new.html.erb`).

Turbolinks and `@rails/ujs` are still real and unchanged:
`app/javascript/application.js` is `import Rails from "@rails/ujs"` /
`import Turbolinks from "turbolinks"` / `import * as ActiveStorage from
"@rails/activestorage"`.

So the question "which hop makes webpacker stop working" has stopped being
load-bearing for this app. The answer, for the record, is **none of them** — see
**Webpacker** under Gem hazards for the evidence. The upgrade planning should
be done on the assumption that the jsbundling work lands; `jsbundling-rails` 1.3.1 declares only `railties >= 6.0.0`
(<https://rubygems.org/api/v2/rubygems/jsbundling-rails/versions/1.3.1.json>),
so it spans every hop in this document.

### Counting rule

A default is **cosmetic** only if its effect is confined to rendered-attribute
markup, log text formatting, or pure performance with byte-identical output.
Everything else — HTTP headers, digests, serialization formats, SQL,
callback ordering, raising where it previously did not, test-harness behaviour
— is **behaviour-changing**. The per-hop sections mark each one B or C.

---

## Hop 1: Rails 6.1 → 7.0

### `required_ruby_version`

`>= 2.7.0`, read from
<https://raw.githubusercontent.com/rails/rails/v7.0.0/rails.gemspec>
(line: `s.required_ruby_version     = ">= 2.7.0"`).

The app is on Ruby 2.6.10
(`/Users/purinkle/Developer/purinkle/radfords/.ruby-version`, and `ruby
"2.6.10"` in the Gemfile). **Ruby must move before Rails can.** This is the
first hard gate.

### Breaking changes named in the upgrade guide

Guide page: <https://guides.rubyonrails.org/upgrading_ruby_on_rails.html>,
section "Upgrading from Rails 6.1 to Rails 7.0". Source read at tag:
<https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/upgrading_ruby_on_rails.md>

1. **`button_to` changed behaviour** — renders a form with the `patch` verb if
   a persisted Active Record object is used to build the URL.
2. **Spring must be ≥ 3.0.0**, otherwise `undefined method 'mechanism=' for
   ActiveSupport::Dependencies:Module`. The guide also says to make sure
   `config.cache_classes` is `false` in `config/environments/test.rb`.
3. **Sprockets is now an optional dependency** — "The gem `rails` doesn't
   depend on `sprockets-rails` anymore. If your application still needs to use
   Sprockets, make sure to add `sprockets-rails` to your Gemfile."
4. **Applications must run in `zeitwerk` mode**; `config.autoloader=` deleted.
5. **`ActiveSupport::Dependencies` private API deleted** (`hook!`, `unhook!`,
   `depend_on`, `require_or_load`, `mechanism`, `constantize`, `verbose=`, and
   the auxiliary classes).
6. **Autoloading during initialization** is now a `NameError`, not a
   deprecation. Custom inflections that the `once` autoloader must see have to
   move from `config/initializers/inflections.rb` into the application class
   body.
7. **`config.autoload_once_paths` is frozen** after the environment config is
   processed.
8. **`ActionDispatch::Request#content_type` now returns the header verbatim**,
   charset included. Use `#media_type` for the bare MIME type.
9. **Key generator digest SHA1 → SHA256 requires a cookie rotator**, or "users
   having their sessions invalidated during the upgrade". The guide ships the
   rotator initializer verbatim.
10. **`ActiveSupport::Digest` SHA1 → SHA256** — ETags and cache keys change.
11. **New `ActiveSupport::Cache` serialization format** — deploy with
    `cache_format_version = 6.1` first, flip on a later deploy.
12. **Active Storage video preview** now needs FFmpeg v3.4+.
13. **Active Storage default variant processor is `:vips`** — the guide lists
    seven concrete code migrations (`resize` → `resize_to_limit`, array crops,
    clamped crop values, `resize_and_pad` background, EXIF rotation,
    `monochrome` → `colourspace`, compression options) plus cache invalidation
    for variant URLs.
14. **Rails version is now in the schema dump** — run `bin/rails app:update`
    *before* loading the schema for the first time under 7.0, so the dump
    becomes `ActiveRecord::Schema[6.1].define(...)`.

### Framework defaults this hop introduces

Authoritative source, the `when "7.0"` branch of `load_defaults`:
<https://raw.githubusercontent.com/rails/rails/v8.1.3/railties/lib/rails/application/configuration.rb>
Template:
<https://raw.githubusercontent.com/rails/rails/v7.0.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_7_0.rb.tt>

| Setting | B/C | Note for this app |
|---|---|---|
| `action_dispatch.default_headers` (adds `X-XSS-Protection "0"`, `Referrer-Policy`, …) | B | |
| `action_dispatch.cookies_serializer = :json` | B | **No-op.** `config/initializers/cookies_serializer.rb` already sets `:json`. |
| `action_view.button_to_generates_button_tag = true` | B | `<input>` becomes `<button>`; eight `button_to` call sites in `app/views`. |
| `action_view.apply_stylesheet_media_default = false` | C | |
| `active_support.hash_digest_class = SHA256` | B | |
| `active_support.key_generator_hash_digest_class = SHA256` | B | **Signs sessions out.** App has a `SessionsController`; needs the rotator. |
| `active_support.cache_format_version = 7.0` | B | Low risk: no `Rails.cache` call anywhere in `app/` or `lib/`; test env is `:null_store`. |
| `active_support.executor_around_test_case = true` | B | |
| `action_mailer.smtp_timeout = 5` | B | App delivers via `:smtp` in production (`config/environments/production.rb`). |
| `active_storage.video_preview_arguments` | B | Not applicable, no video. |
| `active_storage.variant_processor = :vips` | B | Not applicable *today*; matters once PR 607 lands Active Storage. |
| `active_storage.multiple_file_field_include_hidden = true` | B | |
| `active_record.verify_foreign_keys_for_fixtures = true` | B | Not applicable, app uses factory_bot not fixtures. |
| `active_record.partial_inserts = false` | B | |
| `active_record.automatic_scope_inversing = true` | B | |
| `action_controller.action_on_open_redirect = :raise` | B | See below. |
| `action_controller.wrap_parameters_by_default = true` | B | App already has `config/initializers/wrap_parameters.rb`. |

17 defaults, 16 behaviour-changing.

Note the naming drift: the 7.0-era template calls the open-redirect setting
`raise_on_open_redirects = true`, while `configuration.rb` at v8.1.3 spells it
`action_controller.action_on_open_redirect = :raise`. Use the modern spelling.

### Removed in this hop that a 6.1 app might still be using

Source:
<https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/7_0_release_notes.md>

- Action Mailer: `ActionMailer::DeliveryJob` and
  `ActionMailer::Parameterized::DeliveryJob`, in favour of
  `ActionMailer::MailDeliveryJob`. The app's
  `config/initializers/new_framework_defaults_6_0.rb` still has the
  `action_mailer.delivery_job` line **commented out**, so the app is on the old
  job today. `load_defaults 6.0` sets it to `MailDeliveryJob`, and the app does
  call `config.load_defaults 6.0`, so this is already covered.
- Active Model: the whole deprecated `ActiveModel::Errors` Hash API — `to_h`,
  `slice!`, `values`, `keys`, `to_xml`, hash-style enumeration, `messages`
  mutation.
- Active Support: `URI.parser`, `config.active_support.use_sha1_digests`,
  `ActiveSupport::Multibyte::Unicode.default_normalization_form`,
  `Range#include?` for datetime ranges.
- Active Record: `db:structure:dump` / `db:structure:load` /
  `db:test:load_structure` rake tasks, `ActiveRecord::Base.connection_config`,
  `arel_attribute`, `allow_unsafe_raw_sql`, `Model.reorder(nil).first`
  non-deterministic ordering, and PostgreSQL `:interval` columns now returning
  `ActiveSupport::Duration` instead of a `String`.
- Action Pack: `fixture_file_upload` paths relative to `fixture_path`.
- Active Job: the `:return_false_on_aborted_enqueue` option — which the app's
  `config/initializers/new_framework_defaults_6_0.rb` still lists, commented
  out. That comment block is now dead and should be deleted.

### What will actually hurt radfords on this hop

1. **Ruby 2.6.10 → 2.7 minimum.** Nothing else can happen first.
2. **`sprockets-rails` is not declared in the Gemfile.** The Gemfile has `gem
   "sprockets"` but not `gem "sprockets-rails"`. `config/application.rb` does
   `require "sprockets/railtie"`, which lives in sprockets-rails, and
   `app/assets/config/manifest.js` plus `stylesheet_link_tag` mean Sprockets is
   genuinely in use. Today `sprockets-rails (3.5.2)` reaches the lock as a
   transitive dependency of `rails (6.1.7.10)`; from 7.0 the `rails` gem stops
   supplying it. It would still arrive via `sassc-rails` 2.1.2, which declares
   `sprockets-rails >= 0`
   (<https://rubygems.org/api/v2/rubygems/sassc-rails/versions/2.1.2.json>) —
   but sassc-rails is itself on the dead-ends list below, so that backstop is
   the wrong thing to lean on. Add `gem "sprockets-rails"` explicitly, as the
   guide instructs. One line, and a boot failure if it is missed.
3. **`spring (2.1.1)` in the lock is below the 3.0.0 floor** the guide names.
   The app pulls it in via `spring-commands-rspec` and `spring-watcher-listen`.
   Compounded by the known local hazard that a stale Spring server hangs
   `bin/rails` — bump spring in the same commit.
4. **Session invalidation** from the key generator digest change. Real: the app
   has sign-in (`app/helpers/sessions_helper.rb`,
   `app/controllers/sessions_controller.rb`). Either ship the guide's rotator
   or accept signing everyone out.
5. **`db/schema.rb` header is the pre-7.0 form** —
   `ActiveRecord::Schema.define(version: 2024_07_28_114918)` with no `[6.1]`.
   Run `bin/rails app:update` before the first schema load on 7.0.
6. **`button_to` output changes shape.** The eight call sites all pass a path
   helper or an explicit `method:`, so the *verb* does not change. The *DOM*
   does: `<input type="submit">` becomes `<button>`. That is enough to break
   CSS and any Capybara selector keyed on `input`. The browser specs added in
   `ff7fddc` are the thing to watch.
7. **Open-redirect raising is a non-event here.** `app/helpers/sessions_helper.rb`
   does `redirect_to(session[:return_to] || default)` and sets
   `session[:return_to] = request.fullpath`, which is always a same-host path.
   `raise_on_open_redirects` targets cross-host redirects only.

---

## Hop 2: Rails 7.0 → 7.1

### `required_ruby_version`

`>= 2.7.0`, read from
<https://raw.githubusercontent.com/rails/rails/v7.1.0/rails.gemspec>
(line: `s.required_ruby_version     = ">= 2.7.0"`).

Unchanged from 7.0. This is the last hop that does not force Ruby 3.

### Breaking changes named in the upgrade guide

<https://guides.rubyonrails.org/upgrading_ruby_on_rails.html>, "Upgrading from
Rails 7.0 to Rails 7.1".

1. **`tmp/development_secret.txt` renamed to `tmp/local_secret.txt`** — a new
   secret invalidates dev/test sessions and Active Storage / Action Text
   attachment signatures.
2. **New `ActiveSupport::Cache` 7.1 format** — same rolling-deploy dance as 7.0.
3. **Autoloaded paths are no longer in `$LOAD_PATH`** — a manual `require` of
   an autoloaded file stops working. Opt back in with
   `config.add_autoload_paths_to_load_path = true`.
4. **`config.autoload_lib` / `config.autoload_lib_once`** replace hand-rolled
   `config.autoload_paths << config.root.join("lib")`.
5. **`ActiveStorage::BaseController` no longer includes the streaming concern**
   — subclasses must `include ActiveStorage::Streaming` explicitly.
6. **`MemCacheStore` and `RedisCacheStore` use connection pooling by default**;
   `connection_pool` becomes an `activesupport` dependency.
7. **`SQLite3Adapter` runs in strict strings mode.** Not applicable, the app is
   Postgres (`gem "pg"`).
8. **`config.action_mailer.preview_path` deprecated** in favour of
   `preview_paths`.
9. **`config.i18n.raise_on_missing_translations = true` now raises on *any*
   missing translation**, not just in a view or controller. `I18n.t("missing.key")`
   from anywhere now raises. `AbstractController::Translation.raise_on_missing_translations`
   was removed outright.
10. **`bin/rails test` now runs the `test:prepare` task** first.
11. **`@rails/ujs` import syntax changed** — `import { fileInputSelector } from
    "@rails/ujs"` fails; you must `import Rails from "@rails/ujs"` and reach
    through the `Rails` object.
12. **`Rails.logger` returns an `ActiveSupport::BroadcastLogger`** —
    `ActiveSupport::Logger.broadcast` is gone, use `Rails.logger.broadcast_to`.
13. **Active Record Encryption moves to SHA-256** — two migration scenarios
    depending on `key_generator_hash_digest_class`, plus the new
    `support_sha1_for_non_deterministic_encryption` flag for a known bug
    (<https://github.com/rails/rails/issues/42922>).
14. **`config.action_dispatch.show_exceptions` values change** from `true` /
    `false` to `:all` / `:rescuable` / `:none`. `true` and `false` are
    deprecated here and removed in 7.2.

### Framework defaults this hop introduces

`when "7.1"` branch of
<https://raw.githubusercontent.com/rails/rails/v8.1.3/railties/lib/rails/application/configuration.rb>,
template at
<https://raw.githubusercontent.com/rails/rails/v7.1.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_7_1.rb.tt>

| Setting | B/C |
|---|---|
| `add_autoload_paths_to_load_path = false` | B |
| `precompile_filter_parameters = true` | C |
| `dom_testing_default_html_version = :html5` | B |
| `log_file_size = 100MB` (local envs only) | C |
| `active_record.run_commit_callbacks_on_first_saved_instances_in_transaction = false` | B |
| `active_record.sqlite3_adapter_strict_strings_by_default = true` | B (n/a, Postgres) |
| `active_record.query_log_tags_format = :sqlcommenter` | C |
| `active_record.raise_on_assign_to_attr_readonly = true` | B |
| `active_record.belongs_to_required_validates_foreign_key = false` | B |
| `active_record.before_committed_on_all_records = true` | B |
| `active_record.default_column_serializer = nil` | B |
| `active_record.encryption.hash_digest_class = SHA256` | B (n/a) |
| `active_record.encryption.support_sha1_for_non_deterministic_encryption = false` | B (n/a) |
| `active_record.marshalling_format_version = 7.1` | B |
| `active_record.run_after_transaction_callbacks_in_order_defined = true` | B |
| `active_record.generate_secure_token_on = :initialize` | B |
| `action_dispatch.default_headers` (drops `X-Download-Options`) | B |
| `action_dispatch.debug_exception_log_level = :error` | C |
| `active_support.cache_format_version = 7.1` | B |
| `active_support.message_serializer = :json_allow_marshal` | B |
| `active_support.use_message_serializer_for_metadata = true` | B |
| `active_support.raise_on_invalid_cache_expiration_time = true` | B |
| `action_view.sanitizer_vendor = Rails::HTML::Sanitizer.best_supported_vendor` | B |
| `action_text.sanitizer_vendor = …` | B (n/a, no Action Text) |

24 defaults, 20 behaviour-changing. **This is the largest single batch of the
five hops.**

Two of these also carry rolling-deploy warnings in the template itself
(`use_message_serializer_for_metadata`, `marshalling_format_version`), and
`cache_format_version = 7.1` is the one the template tells you to set in
`config/application.rb` rather than in the defaults file.

### Removed in this hop that a 6.1 app might still be using

<https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/7_1_release_notes.md>

- Active Support: `ActiveSupport::PerThreadRegistry`, the `Enumerable#sum`
  override, `active_support/core_ext/uri`, format arguments to `#to_s` on
  `Array` / `Range` / `Date` / `DateTime` / `Time` / `BigDecimal` / `Float` /
  `Integer` (use `#to_fs`), the `ActiveSupport::TimeWithZone.name` override,
  and implicit `String` conversion by `ActiveSupport::SafeBuffer`.
- Action Pack: the old `Request#content_type` behaviour, single-value
  `config.action_dispatch.trusted_proxies`, and the `poltergeist` /
  `webkit` system-test driver registrations.
- Action View: the `ActionView::Path` constant, and passing instance variables
  as partial locals.
- Active Record: `ActiveRecord.legacy_connection_handling`,
  `config.active_record.partial_writes`, `:include_replicas` on `configs_for`.
- Active Storage: appending on assignment to an attachment collection (it now
  replaces), and `purge` / `purge_later` on the attachments association.
- Active Job: the `QueAdapter`.
- Railties: `bin/rails secrets:setup`, and the default `X-Download-Options`
  header.
- Deprecated here, removed in 7.2: the **singleton `ActiveSupport::Deprecation`**.

I grepped `app/` and `lib/` for `.to_time`, `to_s(:format)`, `alias_attribute`,
`serialize`, `Rails.cache` and `cookies[` and found none, so most of that list
is theoretical for this app.

### What will actually hurt radfords on this hop

1. **`config/environments/test.rb` has `config.action_dispatch.show_exceptions
   = false`.** Deprecated here. It becomes a hard error one hop later. Change
   it to `:none`, or to `:rescuable` to get the modern generated behaviour.
2. **`config/environments/test.rb` has `config.i18n.raise_on_missing_translations
   = true`.** Its blast radius widens to every `I18n.t` call. The app is
   i18n-heavy. Expect new test failures that are genuine missing keys.
3. **`@rails/ujs` import style.** Already compliant:
   `app/javascript/application.js` is `import Rails from "@rails/ujs"` and
   `Rails.start()`. No work.
4. **`config/environments/production.rb` builds a logger by hand**
   (`ActiveSupport::TaggedLogging.new(logger)` assigned to `config.logger`).
   The guide says a custom `config.logger` is wrapped and proxied, "No changes
   on your side are required". It does not use the removed
   `ActiveSupport::Logger.broadcast`. No work.
5. **`config/initializers/active_job.rb` monkey-patches
   `ActiveJob::Logging::LogSubscriber`** to silence enqueue logs. I verified the
   target survives: `class LogSubscriber` with `def enqueue(event)` exists in
   `activejob/lib/active_job/log_subscriber.rb` at every tag from v6.1.7.10
   through v8.1.3
   (<https://raw.githubusercontent.com/rails/rails/v8.1.3/activejob/lib/active_job/log_subscriber.rb>).
   So no removal breaks it. But 7.1 adds an `enqueue_all` event that this
   initializer does not unsubscribe, so enqueue logging partly comes back.
6. **`dom_testing_default_html_version = :html5`** switches the parser under
   Capybara / rails-dom-testing. Combined with the `button_to` markup change
   from 7.0, the feature specs are where this hop's cost lands.

---

## Hop 3: Rails 7.1 → 7.2

### `required_ruby_version`

`>= 3.1.0`, read from
<https://raw.githubusercontent.com/rails/rails/v7.2.0/rails.gemspec>
(line: `s.required_ruby_version     = ">= 3.1.0"`).

**This is the Ruby 3 gate.** And Ruby 3.1 is itself past end of life
(2025-03-26, <https://www.ruby-lang.org/en/downloads/branches/>), so in practice
this hop means Ruby 3.3 or newer — see "The real Ruby floor" below.

### Breaking changes named in the upgrade guide

<https://guides.rubyonrails.org/upgrading_ruby_on_rails.html>, "Upgrading from
Rails 7.1 to Rails 7.2". The guide names exactly two:

1. **All tests now respect the `active_job.queue_adapter` config.** Previously
   some tests silently used `TestAdapter` even when you had configured
   something else. "This may cause test errors, if you had set the
   `queue_adapter` config to something other than `:test`, but written tests in
   a way that was dependent on the `TestAdapter`."
2. **`alias_attribute` now bypasses custom methods on the original attribute**
   and reads the raw database value. Announced by deprecation in 7.1.

### Framework defaults this hop introduces

`when "7.2"` branch of
<https://raw.githubusercontent.com/rails/rails/v8.1.3/railties/lib/rails/application/configuration.rb>,
template at
<https://raw.githubusercontent.com/rails/rails/v7.2.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_7_2.rb.tt>

| Setting | B/C |
|---|---|
| `yjit = true` | C (perf; the template warns about memory-constrained deploys) |
| `active_storage.web_image_content_types` gains `image/webp` | B |
| `active_record.postgresql_adapter_decode_dates = true` | B |
| `active_record.validate_migration_timestamps = true` | B |

4 defaults, 3 behaviour-changing. The lightest hop by default count.

Note `active_job.enqueue_after_transaction_commit` appears in the 7.2 template
but **not** in the 7.2 branch of `load_defaults` at v8.1.3, because Rails 8.1
removed the setting entirely (see hop 5's removals). Do not carry it forward.

### Removed in this hop that a 6.1 app might still be using

<https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/7_2_release_notes.md>

- **Action View: `@rails/ujs` removed in favour of Turbo.** This is the removal
  of the npm package Rails itself ships, not of the gem-side behaviour.
- **Action Pack: `config.action_dispatch.show_exceptions` can no longer be
  `true` or `false`.** Now a hard error.
- Active Support: the **singleton `ActiveSupport::Deprecation` delegation**, and
  calling `deprecate` / `assert_deprecated` / the deprecation proxies without
  passing a deprecator. Also `config.active_support.cache_format_version = 6.1`.
- Active Record: `clear_active_connections!`, `clear_all_connections!`,
  `flush_idle_connections!`, `ActiveRecord::Migration.check_pending`,
  `TestFixtures.fixture_path`, referring to a singular association by its
  plural name, passing coder+class to `serialize`, and — notable — "behavior
  that would rollback a transaction block when exited using `return`, `break`
  or `throw`".
- Action Mailer: `config.action_mailer.preview_path`.
- Railties: `Rails.application.secrets`, `Rails.config.enable_dependency_loading`.
- Active Job: `:exponentially_longer` as a `retry_on` `:wait` value.

### What will actually hurt radfords on this hop

1. **Ruby 3.** This is the whole cost of the hop for this app. Memory (not
   re-verified today) records that the Ruby 3 blockers here are five named
   gems, paperclip being the one no bump fixes — which PR 607 exists to solve.
2. **`config.action_dispatch.show_exceptions = false` in
   `config/environments/test.rb` becomes fatal.** Fix it during hop 2.
3. **`postgresql_adapter_decode_dates = true`** is live for this app: it is a
   Postgres app (`gem "pg"`, `pg (1.5.4)`), and any manual `select_value` of a
   date column starts returning `Date` instead of `String`.
4. **The queue-adapter test change is a near-no-op here.**
   `config/application.rb` sets `config.active_job.queue_adapter =
   :delayed_job` and `config/environments/test.rb` overrides it to `:inline`.
   A grep of `spec/` found no `have_enqueued_job`, `enqueued_jobs`,
   `perform_enqueued_jobs`, `ActiveJob::TestHelper` or `deliver_later`, so
   nothing in the suite depends on `TestAdapter`. The only mail sends are
   `deliver_now` (`app/models/order_builder.rb`,
   `app/controllers/fulfilments_controller.rb`).
5. **`alias_attribute` is unused** — grep of `app/` and `lib/` found none.
6. **`@rails/ujs` removal is a non-event.** The npm dependency is pinned at
   `^7.1.3-4` in `package.json`, resolved from npm, not from the gem. It keeps
   working; it just stops receiving updates. Moving to Turbo is a separate,
   optional project, made larger here by Turbolinks 5.2.0 still being in play.

---

## Hop 4: Rails 7.2 → 8.0

### `required_ruby_version`

`>= 3.2.0`, read from
<https://raw.githubusercontent.com/rails/rails/v8.0.0/rails.gemspec>
(line: `s.required_ruby_version     = ">= 3.2.0"`).

### Breaking changes named in the upgrade guide

<https://guides.rubyonrails.org/upgrading_ruby_on_rails.html>, "Upgrading from
Rails 7.2 to Rails 8.0". **The section is empty.** It contains only the line
"For more information on changes made to Rails 8.0 please see the release
notes." Verified against the guide source at v8.1.3, lines 89–93:

```
Upgrading from Rails 7.2 to Rails 8.0
-------------------------------------

For more information on changes made to Rails 8.0 please see the [release notes](8_0_release_notes.html).
```

Everything that matters for this hop therefore comes from the release notes,
not the upgrade guide.

### Framework defaults this hop introduces

`when "8.0"` branch of
<https://raw.githubusercontent.com/rails/rails/v8.1.3/railties/lib/rails/application/configuration.rb>

| Setting | B/C |
|---|---|
| `action_dispatch.strict_freshness = true` | B |
| `Regexp.timeout ||= 1` | B |

2 defaults, both behaviour-changing. The lightest hop overall.

The 8.0 template at v8.0.0
(<https://raw.githubusercontent.com/rails/rails/v8.0.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_8_0.rb.tt>)
lists a third, `active_support.to_time_preserves_timezone = :zone`. That
setting is **not** in the 8.0 branch of `load_defaults` at v8.1.3, because 8.1
removed the old behaviour and deprecated the config (see hop 5). If you land on
8.1 you can skip it; if you stop at 8.0 you cannot.

`Regexp.timeout ||= 1` is the one to watch operationally: any regular
expression in the app or in a gem that takes more than a second on some input
now raises `Regexp::TimeoutError` at runtime rather than hanging.

### Removed in this hop that a 6.1 app might still be using

<https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/8_0_release_notes.md>

- **Railties: `config.read_encrypted_secrets`.** Also `rails/console/app`,
  `rails/console/helpers`, and extending the console via
  `Rails::ConsoleMethods`.
- Action Pack: `config.action_controller.allow_deprecated_parameters_hash_equality`.
- Action View: passing `nil` to the `model:` argument of `form_with`; passing
  content to void tag elements.
- Active Record: `config.active_record.warn_on_records_fetched_greater_than`,
  `config.active_record.sqlite3_deprecated_warning`,
  `ConnectionPool#connection`, `ENV["SCHEMA_CACHE"]`, defining `enum` with
  keyword arguments, finding unregistered database adapters.
- Active Job: `config.active_job.use_big_decimal_serializer`.
- Active Storage: the Azure backend is deprecated here (removed in 8.1).

### What will actually hurt radfords on this hop

**One concrete, verified break.**
`/Users/purinkle/Developer/purinkle/radfords/config/environments/production.rb`
contains `config.read_encrypted_secrets = true`. That accessor is removed in
8.0, and I confirmed it is absent from
<https://raw.githubusercontent.com/rails/rails/v8.1.3/railties/lib/rails/application/configuration.rb>
(grep for `read_encrypted_secrets` returns nothing). Boot of the production
environment will raise `NoMethodError`. Delete the line.

For contrast, `config.cache_classes` — used in both `production.rb` and
`test.rb` — is **still present** at v8.1.3 (`configuration.rb` line 15 lists it
among the config attributes, and lines 376–384 define `enable_reloading` as its
inverse). No work there.

`config.assets.raise_runtime_errors = true` in `test.rb` has no counterpart in
sprockets-rails v3.5.2's railtie
(<https://raw.githubusercontent.com/rails/sprockets-rails/v3.5.2/lib/sprockets/railtie.rb>
— no `raise_runtime_errors` anywhere). But `config.assets` is declared there as
an `OrderedOptions` subclass (line 95, `config.assets = OrderedOptions.new`), so
assigning an unknown key is silently accepted. It is dead config, not a break.

---

## Hop 5: Rails 8.0 → 8.1

### `required_ruby_version`

`>= 3.2.0`, read from
<https://raw.githubusercontent.com/rails/rails/v8.1.0/rails.gemspec> and
<https://raw.githubusercontent.com/rails/rails/v8.1.3/rails.gemspec>
(both: `s.required_ruby_version     = ">= 3.2.0"`).

Unchanged from 8.0.

A note on the target: per the RubyGems API
(<https://rubygems.org/api/v1/versions/rails.json>), 8.1.3 was released
2026-03-24 and has since been superseded by **8.1.3.1** (2026-07-29, which the
`.1` suffix marks as a security release) and **8.1.4** (2026-09-24). Pick 8.1.4
as the target unless something specifically requires 8.1.3.

### Breaking changes named in the upgrade guide

<https://guides.rubyonrails.org/upgrading_ruby_on_rails.html>, "Upgrading from
Rails 8.0 to Rails 8.1". The guide names exactly one:

1. **`schema.rb` table columns are now sorted alphabetically.** "Active Record
   now alphabetically sorts table columns in `schema.rb` by default, so dumps
   are consistent across machines and don't flip-flop with migration order […]
   `structure.sql` can still be leveraged to preserve exact column order."
   Reference given: <https://github.com/rails/rails/pull/53281>

### Framework defaults this hop introduces

`when "8.1"` branch of
<https://raw.githubusercontent.com/rails/rails/v8.1.3/railties/lib/rails/application/configuration.rb>,
template at
<https://raw.githubusercontent.com/rails/rails/v8.1.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_8_1.rb.tt>

| Setting | B/C |
|---|---|
| `yjit = !Rails.env.local?` | C (narrows 7.2's unconditional `true`) |
| `action_controller.escape_json_responses = false` | B |
| `action_controller.action_on_path_relative_redirect = :raise` | B |
| `active_record.raise_on_missing_required_finder_order_columns = true` | B |
| `active_support.escape_js_separators_in_json = false` | B |
| `action_view.render_tracker = :ruby` | C |
| `action_view.remove_hidden_field_autocomplete = true` | C (drops an attribute) |

7 defaults, 4 behaviour-changing.

`raise_on_missing_required_finder_order_columns` is the one with teeth: the
template says "The current behavior of not raising an error has been
deprecated, and this configuration option will be removed in Rails 8.2."

### Removed in this hop that a 6.1 app might still be using

<https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/8_1_release_notes.md>

- **Active Support: `to_time` no longer preserves the system local time; it
  always preserves the receiver's timezone.** Also: passing a `Time` object to
  `Time#since`, `Benchmark.ms` (moved to the `benchmark` gem), and adding a
  `Time` to an `ActiveSupport::TimeWithZone`.
- **Action Pack: leading brackets in parameter names are no longer skipped**
  (`"[foo]=bar"` now parses to `{"[foo]" => "bar"}`), and **semicolons are no
  longer a query-string separator**.
- Action Pack: routing a route to multiple paths.
- Active Record: the SQLite3 `:retries` option; MySQL `:unsigned_float` and
  `:unsigned_decimal`.
- Active Storage: the `:azure` service.
- Active Job: `enqueue_after_transaction_commit` and its config; the internal
  `SuckerPunch` adapter.
- Railties: `bin/rake stats`, `STATS_DIRECTORIES`, `rails/console/methods.rb`.
- Newly deprecated here: `String#mb_chars` / `ActiveSupport::Multibyte::Chars`,
  `ActiveSupport::Configurable`, `ActiveRecord::Base.signed_id_verifier_secret`,
  the built-in `sidekiq` adapter, and order-dependent finders without `order`.

### What will actually hurt radfords on this hop

Essentially nothing in the app's own code, which is why 8.0 → 8.1 is cheap.

- **`action_on_path_relative_redirect = :raise` is a non-event.** It raises only
  for relative URLs *without* a leading slash (the template's examples are
  `redirect_to "example.com"` and `redirect_to "@attacker.com"`). Every
  `redirect_to` in `app/` uses a path or URL helper or an Active Record object,
  and the one dynamic case, `redirect_to(session[:return_to] || default)`, is
  fed by `session[:return_to] = request.fullpath`, which always starts with `/`.
- **`escape_json_responses = false` is a non-event.** Grep of `app/` found no
  `render json`.
- **`raise_on_missing_required_finder_order_columns`**: one candidate,
  `app/models/find_basket.rb` line 3, `Basket.where(options).first ||
  EmptyBasket.new`. That model has a `primary_key`, and the template says the
  raise happens only when the model "does not have any order columns
  (`implicit_order_column`, `query_constraints`, or `primary_key`) to fall back
  on". So it will not raise. Worth a quick suite run to confirm nothing else in
  the app calls `.first` on an orderless relation.
- **The `schema.rb` column re-sort produces one large, noisy, harmless diff.**
  Commit it on its own.

---

## Gem hazards

Read from `/Users/purinkle/Developer/purinkle/radfords/Gemfile` and
`Gemfile.lock`. Latest versions and dependency constraints from the RubyGems
API (`https://rubygems.org/api/v1/versions/<gem>/latest.json` and
`https://rubygems.org/api/v2/rubygems/<gem>/versions/<version>.json`), queried
2026-09-28.

### Blocks Rails 8.1 at the locked version, fixed by a bump

| Gem | Locked | Latest | Constraint at latest |
|---|---|---|---|
| `delayed_job` | 4.1.11 (`activesupport >= 3.0, < 8.0`) | **4.2.0** (2025-12-29) | `activesupport >= 3.0, < 9.0` |
| `delayed_job_active_record` | 4.1.8 (`activerecord >= 3.0, < 8.0`) | **4.1.11** (2024-11-09) | `activerecord >= 3.0, < 9.0` |

The locked pair is the app's **only hard `< 8.0` Rails ceiling**, and it comes
from the lockfile, not the Gemfile — the Gemfile declares
`gem "delayed_job_active_record"` unversioned. Both upstream gems have already
lifted the ceiling to `< 9.0`, so this is a `bundle update` away.
`config.active_job.queue_adapter = :delayed_job` in `config/application.rb` and
`worker: bundle exec rake jobs:work` in the `Procfile` mean this is load-bearing.

### Blocks Rails 8.1 at the locked version, needs a real jump

| Gem | Locked | Latest | Latest requires |
|---|---|---|---|
| `rspec-rails` | 4.1.2 (Gemfile pins `~> 4.1`) | **8.0.4** | `actionpack/activesupport/railties >= 7.2`, Ruby `>= 3.0.0` |
| `shoulda-matchers` | 3.1.3 | **8.0.1** | `activesupport >= 7.2`, **Ruby `>= 3.3`** |
| `skylight` | 4.3.2 (2020-12-15) | **7.1.1** | `activesupport >= 7.2`, Ruby `>= 3.1` |
| `web-console` | 3.4.0 | **4.3.0** | `actionview`/`railties >= 8.0.0`, Ruby `>= 3.2` |
| `money-rails` | 1.15.0 | **3.0.0** | `activesupport >= 7.0`, `railties >= 7.0`, `money ~> 7.0`, `monetize ~> 2.0`, Ruby `>= 3.1` |
| `simple_form` | 5.0.3 | **5.4.1** | `actionpack`/`activemodel >= 7.0` |
| `factory_bot_rails` | 4.8.2 | **6.5.1** | |
| `spring` | 2.1.1 | **4.7.0** | Guide names 3.0.0 as the Rails 7.0 floor |

`shoulda-matchers` 3.1.3 → 8.0.1 is a five-major-version jump with real matcher
API churn, and its Ruby `>= 3.3` floor is the single highest Ruby requirement
in the whole dependency set — it, not Rails, sets the practical Ruby floor.
`money-rails` 1.15 → 3.0 drags `money` 6 → 7 and `monetize` 1 → 2 with it;
`config/initializers/money.rb` will need review.

### Dead ends — no release supports Rails 8.1 and none is coming

| Gem | Locked | Latest | Last released |
|---|---|---|---|
| `paperclip` | 5.3.0 | **6.1.0** | **2018-07-27** |
| `aws-sdk` (v2 line) | 2.11.632 | 3.3.0 is the v3 meta-gem | |
| `sass-rails` | 6.0.0 | **6.0.0** | 2019-08-16 |
| `sassc-rails` | 2.1.2 | **2.1.2** | 2019-06-18 |
| `sassc` | 2.4.0 | **2.4.0** | 2020-06-02 |
| `webdrivers` | 5.3.1 | **5.3.1** | pins `selenium-webdriver ~> 4.0, < 4.11` |
| `webpacker` | at HEAD only | **5.4.4** | 2023-01-31, officially retired |
| `heroku-deflater` | 0.7.0 | **0.7.0** | 2023-10-19 |
| `suspenders` | 0.2.4 | 20260325.0 | see below |

- **`paperclip`.** Latest is 6.1.0 from 2018-07-27, i.e. more than two years
  before Ruby 3.0 shipped. It also depends on `mimemagic ~> 0.3.0`, and
  `mimemagic` itself last released 0.4.3 / 0.3.10 on 2021-03-26. The Gemfile
  comment already ties `paperclip "< 6"` to the `aws-sdk "< 3"` ceiling. PR 607
  replacing it with Active Storage is the correct and only fix; it is a
  prerequisite for Ruby 3, not merely a nice-to-have.
- **`aws-sdk "< 3"`.** The locked 2.11.632 is the v2 line. There is no v2
  release that supports Ruby 3 or Rails 8; the successor is the v3 family
  (`aws-sdk-s3` etc.), which Active Storage uses natively. Lifting this ceiling
  and dropping paperclip is one job, not two.
- **`sass-rails` / `sassc-rails` / `sassc`.** All three are frozen at 2019–2020
  releases. `sassc` is a native extension; nothing in Rails removes it, but
  nothing maintains it either, and it is the usual first casualty of a new Ruby.
  `bourbon 7.3.0` and `refills` sit on top of this stack. The app already has
  esbuild in `package.json`, so a CSS bundler is the natural exit.
- **`webdrivers` 5.3.1** pins `selenium-webdriver ~> 4.0, < 4.11` while
  `selenium-webdriver` is at 4.49.0. Modern Selenium ships Selenium Manager and
  needs no `webdrivers` gem at all. Drop `webdrivers`, drop the
  `selenium-webdriver "~> 4.1.0"` pin, and delete the Gemfile comment that
  justifies it (it cites Ruby 2.6, which will no longer be true).
- **`suspenders`.** Locked at 0.2.4, whose runtime deps are `rails >= 3.0.3`
  and `trout >= 0.3.0`. Latest is 20260325.0 with **no runtime dependencies**
  and Ruby `>= 3.2.0`. Those are two entirely different things sharing a name;
  Bundler picks the old one today only because Ruby 2.6 excludes the new one.
  The moment Ruby moves, `bundle update` will swap in a different gem. Pin or
  remove `gem "suspenders"` deliberately before bumping Ruby.

### Fine, or fine after a routine bump

`pg` 1.5.4, `puma` (Gemfile ceiling `< 6.0`; latest is 8.0.2), `bootsnap`,
`honeybadger`, `stripe` 12.2.0, `geocoder`, `friendly_id` (5.5.1 → 5.7.0,
`activerecord >= 4.0.0`), `kaminari` (1.2.2 is current), `jquery-rails`
(4.6.0 → 4.6.1), `inline_svg` (1.9.0 → 1.10.0), `flutie` (2.2.0 → 2.2.1),
`title` (0.0.10 → 0.1.0), `formulaic` (0.4.1 → 0.4.2), `high_voltage`
(3.1.2 → 5.0.0, Ruby `>= 3.1`), `bullet` (7.1.6 → 8.2.0), `dotenv-rails`
(2.8.1 → 3.2.0, `railties >= 6.1` — note the dotenv 2 → 3 major), `sprockets-rails`
3.5.2, `database_cleaner-active_record` 2.2.1, `timecop`, `vcr`, `webmock`,
`simplecov`, `rack-canonical-host`, `rack-timeout`, `rack-mini-profiler`,
`bundler-audit`, `recipient_interceptor`, `autoprefixer-rails`,
`jsbundling-rails` 1.3.1 (`railties >= 6.0.0`, no upper bound — spans every hop
here).

`puma < 6.0` is a Gemfile ceiling with no stated reason in the file. It is not
a Rails constraint; puma 8.0.2 is current.

### Webpacker: which hop breaks it?

**None of them, on the evidence.** I checked the actual gem, not a blog post.
This matters only for HEAD — the working tree has already replaced webpacker
with `jsbundling-rails` plus esbuild, as set out in the summary. Recorded here
because the brief asked the question directly.

- `webpacker` 5.4.4's declared dependencies are `activesupport >= 5.2`,
  `railties >= 5.2`, `rack-proxy >= 0.6.1`, `semantic_range >= 2.3.0` — **no
  upper bound on Rails** (<https://rubygems.org/api/v2/rubygems/webpacker/versions/5.4.4.json>).
  So it resolves against Rails 8.1.
- I unpacked the v5.4.4 tarball
  (<https://codeload.github.com/rails/webpacker/tar.gz/refs/tags/v5.4.4>) and
  grepped `lib/` for `ActiveSupport::Deprecation`: **zero hits**. The 7.2
  removal of the deprecation singleton, which kills many old gems, does not
  touch it.
- The Rails APIs it does use — `Rails::Engine`, `ActiveSupport::OrderedOptions`,
  `ActiveSupport::TaggedLogging`, `ActiveSupport.on_load`, `Rack::Proxy`,
  `Rake::Task#enhance` — all still exist at 8.1.3.
- `rack-proxy`, its only non-Rails runtime dependency, is at 2.0.1 and declares
  `rack >= 2.0, < 4` (<https://rubygems.org/api/v2/rubygems/rack-proxy/versions/2.0.1.json>),
  so it spans rack 2 and rack 3.

So the honest answer is: webpacker is retired, not broken. The official
statement is the repository README's first line, "Webpacker has been retired",
which says the Rails team "will continue to address security issues on the Ruby
side of the gem according to the normal maintenance schedule of Rails […] But
we will not be updating the gem to include newer versions of the JavaScript
libraries" (<https://raw.githubusercontent.com/rails/webpacker/master/README.md>).
The risk is the JavaScript side — webpack 4 and webpack-cli 3, per
`package.json` in that tarball — not the Ruby side.

And for this app it is moot. **The action — delete `gem "webpacker"`, which
takes `rack-proxy` and `semantic_range` out of the lock with it and removes a
retired railtie from the boot path — is already staged in the working tree.**
It is independent of any Rails hop, so it can and should land on its own.

### The real Ruby floor

Rails 8.1.3's `required_ruby_version` is `>= 3.2.0`. That is not the operative
number.

- Ruby 3.2 reached end of life on **2026-04-01** and is listed as `eol` at
  <https://www.ruby-lang.org/en/downloads/branches/>.
- Ruby 3.3 is in **security maintenance** (not normal maintenance) until
  2027-03-31, per the same page.
- Ruby 3.4 is in normal maintenance; Ruby 4.0 is in normal maintenance.

The brief gives 3.3 as the practical floor. The primary source supports a
stronger statement: 3.3 gets security fixes only, so **3.4 is the lowest
version still in normal maintenance**. `shoulda-matchers` 8.0.1's `>= 3.3`
floor is consistent with either.

There is also a local trap worth repeating: Ruby resolves differently by
directory on this machine — inside the repo `ruby` is 2.6.10, but the
scratchpad silently gives 4.0.7. Any version check must be run from inside the
repo.

---

## Unverified

Everything here is a gap I could not close from a primary source today. None of
it is guessed at above.

1. **Whether paperclip 6.1.0 actually fails on Ruby 3.x, as opposed to merely
   predating it.** What I verified: paperclip's last release is 6.1.0 on
   2018-07-27 and it depends on `mimemagic ~> 0.3.0`
   (<https://rubygems.org/api/v2/rubygems/paperclip/versions/6.1.0.json>). What
   I did not verify: an actual `LoadError` or `ArgumentError` under Ruby 3. A
   prior session's memory records paperclip as "the one no bump fixes", but a
   memory records what was true when written. **What would settle it:** a
   `bundle install` plus `bin/rake` under Ruby 3.3 on the PR 607 branch, or the
   absence of paperclip from that branch's lockfile.
2. **Which exact skylight version first supports each Rails hop.** I have the
   endpoints: 4.3.2 is locked (2020-12-15) and 7.1.1 requires `activesupport >=
   7.2`. I did not enumerate the 5.x and 6.x constraints, so I cannot say which
   skylight version to pair with Rails 7.0 or 7.1 if the upgrade is done in
   discrete deployed steps. **What would settle it:** the RubyGems v2 API for
   skylight 5.3.5 and 6.0.4.
3. **Whether any gem in the lock has an undeclared Rails 8.1 incompatibility.**
   Gem metadata only tells you what a gem *declares*. `friendly_id`, `kaminari`,
   `inline_svg`, `title` and `formulaic` all declare loose floors
   (`activerecord >= 4.0.0`, `activesupport >= 3.0`, and so on) with no upper
   bound, which is not evidence that they work on 8.1. **What would settle it:**
   a dual-boot `Gemfile.next` resolve against Rails 8.1 plus a green suite.
4. **`sassc` / `sassc-rails` under Ruby 3.4+.** `sassc` 2.4.0 is a native
   extension last released 2020-06-02. I did not find a primary statement about
   which Ruby it stops compiling on. **What would settle it:** `gem install
   sassc -v 2.4.0` under the target Ruby.
5. **Whether `delayed_job` 4.2.0 works with Rails 8.1 beyond resolving.** Its
   `activesupport < 9.0` constraint permits 8.1; I found no upstream statement
   confirming 8.1 support. **What would settle it:** the delayed_job CHANGELOG
   or CI matrix at the 4.2.0 tag.
6. **The behaviour of `config/initializers/active_job.rb` on 7.1+.** I verified
   that the constant and the `enqueue` method it patches still exist at v8.1.3.
   I did not verify that the initializer still achieves its intent once 7.1's
   `enqueue_all` event exists. **What would settle it:** boot on 7.1 and check
   whether enqueue lines reappear in the log.
7. **Whether Rails 6.1 is still receiving security fixes.** I did not fetch the
   maintenance policy page. It bears on how much urgency the first hop carries.
   **What would settle it:**
   <https://guides.rubyonrails.org/maintenance_policy.html>.
8. **Whether the staged jsbundling work will land as staged.** Every
   working-tree finding above is measured against 22 staged, uncommitted paths
   (the `build.mjs` header calls itself a PROTOTYPE answering issue #580
   question 3). If that work is reworked or abandoned, the webpacker analysis
   reverts to the HEAD picture and the brief's original framing is right again.
   **What would settle it:** the merge state of whatever PR carries it.
9. **Whether `bin/rails assets:precompile` still passes with the staged
   jsbundling change.** A prior session's memory records that verifying a bump
   needs `assets:precompile` as well as `bin/rake`, because three entry points
   load Rails in three orders. I did not run either — the brief forbids
   touching the tree, and a build writes to `app/assets/builds`. **What would
   settle it:** `bin/rake` plus `bin/rails assets:precompile` on that branch.
10. **The classification boundary between "behaviour-changing" and "cosmetic"**
   is mine, stated under "Counting rule". Rails publishes no such split. A
   reader who counts `button_to_generates_button_tag` or `yjit` the other way
   will get a total between roughly 42 and 47 rather than 45.

---

## Sources used

Rails source and guides, read at a git tag:

- <https://raw.githubusercontent.com/rails/rails/v7.0.0/rails.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v7.1.0/rails.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v7.2.0/rails.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v8.0.0/rails.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v8.1.0/rails.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/rails.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/railties/lib/rails/application/configuration.rb>
- <https://raw.githubusercontent.com/rails/rails/v7.0.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_7_0.rb.tt>
- <https://raw.githubusercontent.com/rails/rails/v7.1.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_7_1.rb.tt>
- <https://raw.githubusercontent.com/rails/rails/v7.2.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_7_2.rb.tt>
- <https://raw.githubusercontent.com/rails/rails/v8.0.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_8_0.rb.tt>
- <https://raw.githubusercontent.com/rails/rails/v8.1.0/railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_8_1.rb.tt>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/upgrading_ruby_on_rails.md>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/7_0_release_notes.md>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/7_1_release_notes.md>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/7_2_release_notes.md>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/8_0_release_notes.md>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/guides/source/8_1_release_notes.md>
- <https://raw.githubusercontent.com/rails/rails/v6.1.7.10/activejob/lib/active_job/logging.rb>
- <https://raw.githubusercontent.com/rails/rails/v6.1.7.10/activejob/lib/active_job/log_subscriber.rb>
- <https://raw.githubusercontent.com/rails/rails/v7.0.0/activejob/lib/active_job/log_subscriber.rb>
- <https://raw.githubusercontent.com/rails/rails/v7.1.0/activejob/lib/active_job/log_subscriber.rb>
- <https://raw.githubusercontent.com/rails/rails/v7.2.0/activejob/lib/active_job/log_subscriber.rb>
- <https://raw.githubusercontent.com/rails/rails/v8.0.0/activejob/lib/active_job/log_subscriber.rb>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/activejob/lib/active_job/log_subscriber.rb>
- <https://raw.githubusercontent.com/rails/rails/v7.0.0/actionpack/actionpack.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v7.1.0/actionpack/actionpack.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v7.2.0/actionpack/actionpack.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v8.0.0/actionpack/actionpack.gemspec>
- <https://raw.githubusercontent.com/rails/rails/v8.1.3/actionpack/actionpack.gemspec>

Published guide (the page named in the brief):

- <https://guides.rubyonrails.org/upgrading_ruby_on_rails.html>

Other project sources:

- <https://raw.githubusercontent.com/rails/webpacker/master/README.md>
- <https://codeload.github.com/rails/webpacker/tar.gz/refs/tags/v5.4.4>
- <https://raw.githubusercontent.com/rails/sprockets-rails/v3.5.2/lib/sprockets/railtie.rb>
- <https://github.com/rails/rails/pull/53281>
- <https://github.com/rails/rails/issues/42922>

RubyGems API:

- <https://rubygems.org/api/v1/versions/rails.json>
- <https://rubygems.org/api/v1/versions/rack.json>
- <https://rubygems.org/api/v1/versions/rack-session.json>
- <https://rubygems.org/api/v1/versions/skylight.json>
- <https://rubygems.org/api/v1/versions/mimemagic.json>
- <https://rubygems.org/api/v1/versions/puma/latest.json>
- <https://rubygems.org/api/v1/versions/sassc/latest.json>
- <https://rubygems.org/api/v1/versions/rack-proxy/latest.json>
- `https://rubygems.org/api/v1/versions/<gem>/latest.json` for: delayed_job,
  delayed_job_active_record, paperclip, aws-sdk, webpacker, spring, rspec-rails,
  shoulda-matchers, factory_bot_rails, simple_form, skylight, web-console,
  sass-rails, sassc-rails, money-rails, kaminari, friendly_id, suspenders,
  heroku-deflater, webdrivers, selenium-webdriver, dotenv-rails, jquery-rails,
  high_voltage, inline_svg, flutie, title, bourbon, refills, database_cleaner,
  formulaic, capybara-selenium, bullet, sprockets-rails
- `https://rubygems.org/api/v2/rubygems/<gem>/versions/<version>.json` for:
  delayed_job 4.2.0, delayed_job_active_record 4.1.11, paperclip 6.1.0,
  money-rails 3.0.0, kaminari 1.2.2, sassc-rails 2.1.2, sass-rails 6.0.0,
  sassc 2.4.0, webpacker 5.4.4, heroku-deflater 0.7.0, skylight 7.1.1,
  rspec-rails 8.0.4, shoulda-matchers 8.0.1, high_voltage 5.0.0,
  jquery-rails 4.6.1, simple_form 5.4.1, web-console 4.3.0, friendly_id 5.7.0,
  inline_svg 1.10.0, flutie 2.2.1, title 0.1.0, formulaic 0.4.2, bullet 8.2.0,
  dotenv-rails 3.2.0, sprockets-rails 3.5.2, suspenders 20260325.0,
  database_cleaner-active_record 2.2.1, aws-sdk 3.3.0, rack-proxy 2.0.1,
  rack-session 1.0.2 / 2.0.0 / 2.1.1, jsbundling-rails 1.3.1

Ruby:

- <https://www.ruby-lang.org/en/downloads/branches/>

Working tree, read only (no file was modified; the staged changes described in
the summary were already present and are not mine). Also read: `git status
--porcelain`, `git diff --cached -- Gemfile Gemfile.lock Rakefile
app/assets/config/manifest.js`, and `git show HEAD:package.json`.

- `/Users/purinkle/Developer/purinkle/radfords/Gemfile`
- `/Users/purinkle/Developer/purinkle/radfords/Gemfile.lock`
- `/Users/purinkle/Developer/purinkle/radfords/package.json`
- `/Users/purinkle/Developer/purinkle/radfords/build.mjs`
- `/Users/purinkle/Developer/purinkle/radfords/Rakefile`
- `/Users/purinkle/Developer/purinkle/radfords/.ruby-version`
- `/Users/purinkle/Developer/purinkle/radfords/Procfile`
- `/Users/purinkle/Developer/purinkle/radfords/config/application.rb`
- `/Users/purinkle/Developer/purinkle/radfords/config/environments/production.rb`
- `/Users/purinkle/Developer/purinkle/radfords/config/environments/test.rb`
- `/Users/purinkle/Developer/purinkle/radfords/config/initializers/` (all files;
  quoted above: `cookies_serializer.rb`, `new_framework_defaults_5_2.rb`,
  `new_framework_defaults_6_0.rb`, `assets.rb`, `active_job.rb`,
  `wrap_parameters.rb`)
- `/Users/purinkle/Developer/purinkle/radfords/app/assets/config/manifest.js`
- `/Users/purinkle/Developer/purinkle/radfords/app/javascript/application.js`
- `/Users/purinkle/Developer/purinkle/radfords/app/helpers/sessions_helper.rb`
- `/Users/purinkle/Developer/purinkle/radfords/app/models/find_basket.rb`
- `/Users/purinkle/Developer/purinkle/radfords/app/views/` (grepped for
  `button_to`, `javascript_pack_tag`, `javascript_include_tag`)
- `/Users/purinkle/Developer/purinkle/radfords/db/schema.rb` (header only)
- `/Users/purinkle/Developer/purinkle/radfords/spec/rails_helper.rb`
