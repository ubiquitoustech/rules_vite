workspace(
    name = "ubiquitous_tech_rules_vite",
)

# Install our "runtime" dependencies which users install as well
load("@ubiquitous_tech_rules_vite//vite:repositories.bzl", "rules_vite_dependencies")

rules_vite_dependencies()

load(":internal_deps.bzl", "rules_vite_internal_deps")

rules_vite_internal_deps()

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories")

node_repositories(
    node_version = "16.10.0",
)
