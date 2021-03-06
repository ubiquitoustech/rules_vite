# Bazel rules for vite

## Installation

Include this in your WORKSPACE file:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
VITE_COMMIT = "2790cd1964bf8a8c70c77ddc7ea32220ff000744"

VITE_SHA256 = "55f97743ec28e1b3ef24547d7f171a381cca46c8c296267bac32f77faec25075"

http_archive(
    name = "ubiquitous_tech_rules_vite",
    sha256 = VITE_SHA256,
    strip_prefix = "rules_vite-%s" % VITE_COMMIT,
    urls = ["https://github.com/ubiquitoustech/rules_vite/archive/%s.zip" % VITE_COMMIT],
)

load("@ubiquitous_tech_rules_vite//vite:repositories.bzl", "rules_vite_dependencies")

# This fetches the rules_vite dependencies, which are:
# - bazel_skylib
# - rules_nodejs
# If you want to have a different version of some dependency,
# you should fetch it *before* calling this.
# Alternatively, you can skip calling this function, so long as you've
# already fetched these dependencies.
rules_vite_dependencies()
```

> note, in the above, replace the VITE_COMMIT and VITE_SHA256 with the one indicated
> in the release notes for rules_vite or one of your choosing
> In the future, our release automation should take care of this.

## Examples

The examples/vite-project folder has a working example that can be run.

```
# Run the dev server and make quick changes to files in src of that folder and the changes are shown in browser right away and the state of the browser is kept
$ bazel run dev

# build the production bundle
$ bazel build prod

# run the production bundle
$ bazel run prodserver
```

## TODO

1. clean up how the end website is packaged use https://github.com/bazelbuild/rules_pkg when it's available for directories
2. remove toolchain files that are not used
