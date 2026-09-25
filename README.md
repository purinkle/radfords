# Radfords

## Getting Started

A local run needs:

* Ruby 2.6.10, pinned in both `.ruby-version` and the `Gemfile`
* Bundler 2.2.15, pinned by `Gemfile.lock`
* Node 24.21.0, pinned in `.tool-versions`
* Yarn 1.x, which is what `yarn.lock` was written by
* PostgreSQL, running and accepting connections

The [thoughtbot laptop script][laptop] will give you Postgres and a version
manager if you do not have them already.

[laptop]: https://github.com/thoughtbot/laptop

### Versions

With [asdf], install the two pinned runtimes:

    % asdf install ruby 2.6.10
    % asdf install nodejs 24.21.0

[asdf]: https://asdf-vm.com

Yarn is not pinned here, so asdf will not choose a version for you in this
directory. Install one and select it globally:

    % asdf plugin add yarn
    % asdf install yarn 1.22.22
    % asdf set --home yarn 1.22.22

Any 1.x release will do, since `yarn.lock` is a version 1 lockfile. The
`set --home` spelling is what asdf 0.20 wants. If yours disagrees, ask it with
`asdf set --help`.

asdf reads the Ruby version from `.ruby-version`, but only when your
`~/.asdfrc` contains `legacy_version_file = yes`. Without that line asdf never
looks at the file, and `ruby` fails in this directory even after 2.6.10 is
installed. The error names `.tool-versions`, which makes the missing entry look
guilty when the real problem is elsewhere.

`.tool-versions` carries no Ruby line on purpose. The version is already
written down twice, in `.ruby-version` and in the `Gemfile`, and a third copy
would be one more place to forget. The price is the `legacy_version_file`
setting above, which lives on your machine rather than in the repo. Weighed and
settled in [issue 558][]. Take it up there if you want it revisited.

[issue 558]: https://github.com/purinkle/radfords/issues/558

### Setup

Run the setup script, which installs bundler and the gems, then creates and
seeds the databases:

    % ./bin/setup

Finally, install the JavaScript dependencies:

    % yarn install

The test suite needs them. `config/webpacker.yml` sets `compile: true` for the
test environment, so the first feature spec that renders the layout shells out
to webpack. With no `node_modules`, that compile produces an empty manifest and
every feature spec fails.

### Running

Run the test suite with:

    % bin/rake

Run the application with [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    % ./bin/deploy staging
    % ./bin/deploy production
