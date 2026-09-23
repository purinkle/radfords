# Continuous integration: CircleCI

CI runs on CircleCI. The committed `.circleci/config.yml` is not the thing
CircleCI runs, so a claim about CI that rests on the committed file alone is
weaker than it looks. Read the processed config for a real build instead.

## Read the processed config for a build

```sh
build=1139
curl -s "https://circleci.com/api/v1.1/project/github/purinkle/radfords/$build" \
  | jq -r '.circle_yml.string'
```

This needs no token and no login.

The `circle_yml.string` field holds the config **as CircleCI processed it**.
Build 1139 shows how far that is from the committed file: the top-level
`references:` block is gone, its five YAML anchors are expanded in place inside
the job steps, and the version reads `version: 2` where the committed file says
`version: 2.1`.

Use `jq` to pull the field out. It is the house tool for JSON in this
repository, because `docs/agents/issue-tracker.md` already reads `gh` output
through the `--jq` flag.

## Schema violations sit at the top of that string

When the config breaks the schema, CircleCI prepends the complaint as comment
lines. Build 1132 opens like this:

```
# -------- WARNING ---------
# Your config does not conform to the schema.
# Violations are listed below:
#
# ERROR IN CONFIG FILE:
# [#] required key [version] not found
```

That is how to tell a live problem from a stale quote out of an older build.
Build 1135 opens with `version: 2` and no warning block, so the fix landed.

## List recent builds

Drop the build number:

```sh
curl -s "https://circleci.com/api/v1.1/project/github/purinkle/radfords" \
  | jq -r '.[] | "\(.build_num) \(.branch) \(.status)"'
```

Each entry carries `build_num`, `branch` and `status`, which is enough to pick
the build you want.

## Prove a config change altered nothing else

Save the processed config for a build before the change and one after, then
diff them:

```sh
for build in 1132 1135; do
  curl -s "https://circleci.com/api/v1.1/project/github/purinkle/radfords/$build" \
    | jq -r '.circle_yml.string' > "$build.yml"
done
diff -u 1132.yml 1135.yml
```

A green tick says the build passed. This says what CircleCI actually ran, so
it can show that the six steps came through the change untouched, which no
amount of green ticks would.

Read every hunk before crediting it to your change. That pair gives two: the
warning block becomes `version: 2`, which is what the change set out to do,
and a `CIRCLE_COMPARE_URL` entry disappears from the job environment, which
looks like a side effect and is not one. CircleCI injects that value per push,
and it is absent from build 1133 onwards regardless of branch, while build
1134 still carries the schema warning. Picking a build between the two is what
settles a question like that, and it is cheap.

## Read what a step printed

A build number and a step name are enough to fetch the text that step printed.
List the steps first:

```sh
build=1148
curl -s "https://circleci.com/api/v1.1/project/github/purinkle/radfords/$build" \
  | jq -r '.steps[].actions[] | "\(.step) | \(.name) | \(.status)"'
```

Each entry in `steps` holds an `actions` array, and each action carries a
`step` number, a `name` and a `status`. Every step in the build above has one
action, so a name out of that listing picks a single log.

Then fetch that step's output:

```sh
build=1148
url=$(curl -s "https://circleci.com/api/v1.1/project/github/purinkle/radfords/$build" \
  | jq -r '.steps[].actions[]
      | select(.name == "Set up the environment")
      | .output_url')
curl -s "$url" | jq -r '.[].message'
```

The `output_url` points at a JSON array whose entries hold the printed text in
a `message` field. Neither command needs a token or a login, for the reason
the "Why the endpoint answers at all" section below gives.

A passing build says every step exited zero. The log says what the step did
on the way there, and the two can differ. Builds 1145 and 1148 both passed, and
their `Set up the environment` steps disagree. In 1145, bundler finds that the
version running is not the one the lockfile was generated with, so it installs
the lockfile's version part way through the step and restarts itself. In 1148
it installs that version in the step's opening lines and then uses it, with no
restart anywhere. Only the log tells the two apart.

## Why the endpoint answers at all

This project still runs the legacy GitHub OAuth integration, which is why its
build URLs take the `circleci.com/gh/...` form and why the v1.1 API answers
without credentials. The same integration explains the checkout key, covered
in issue #552. A project moved to the GitHub App would not behave this way, so
treat this note as true of radfords rather than of CircleCI in general.
