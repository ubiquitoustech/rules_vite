"""
copy rule
"""

load(":copy-actions.bzl", "copy_build_action")
load(":providers.bzl", "ViteInfo")
load("@build_bazel_rules_nodejs//:providers.bzl", "ExternalNpmPackageInfo", "JSEcmaScriptModuleInfo", "JSModuleInfo", "node_modules_aspect")

def _copy_build_impl(ctx):
    deps_depsets = []
    path_alias_mappings = dict()

    for dep in ctx.attr.deps:
        if JSEcmaScriptModuleInfo in dep:
            deps_depsets.append(dep[JSEcmaScriptModuleInfo].sources)

        if JSModuleInfo in dep:
            deps_depsets.append(dep[JSModuleInfo].sources)
        elif hasattr(dep, "files"):
            deps_depsets.append(dep.files)

        if DefaultInfo in dep:
            deps_depsets.append(dep[DefaultInfo].data_runfiles.files)

        if ExternalNpmPackageInfo in dep:
            deps_depsets.append(dep[ExternalNpmPackageInfo].sources)

    deps_inputs = depset(transitive = deps_depsets).to_list()

    inputs = deps_inputs + ctx.files.srcs

    inputs = [d for d in inputs if not (d.path.endswith(".d.ts") or d.path.endswith(".tsbuildinfo"))]

    prefix = ctx.label.name + "/"

    main_archive = ctx.actions.declare_directory(prefix)

    folders_to_copy = ctx.actions.args()

    up = ctx.attr.server_build[ViteInfo].info.output_directory_path.count("/")

    folders_to_copy.add("-u")
    folders_to_copy.add(up)

    for dep in ctx.attr.client_build:
        folders_to_copy.add("%s/**" % dep[ViteInfo].info.output_directory_path)

    folders_to_copy.add("%s/**" % ctx.attr.server_build[ViteInfo].info.output_directory_path)

    copy_build_action(
        ctx,
        srcs = inputs,
        folders_to_copy = folders_to_copy,
        out = main_archive,
    )

    return [DefaultInfo(
        files = depset([main_archive]),
        # might need to add this back
        runfiles = ctx.runfiles(collect_data = True),
        executable = main_archive,
    )]

copy_build = rule(
    _copy_build_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            doc = "Source files to compile for the main package of this binary",
        ),
        "deps": attr.label_list(
            default = [],
            aspects = [node_modules_aspect],
            doc = "A list of direct dependencies that are required to build the bundle",
        ),
        "data": attr.label_list(
            allow_files = True,
            doc = "Data files available to binaries using this library",
        ),
        "_copy": attr.label(
            doc = "An executable target that runs Vite",
            default = Label("@npm//copyfiles/bin:copyfiles"),
            executable = True,
            cfg = "host",
        ),
        "client_build": attr.label_list(
            providers = [ViteInfo],
            # aspects = [node_modules_aspect],
            # allow_single_file = [".ts", ".mjs", ".js"],
            mandatory = True,
        ),
        "server_build": attr.label(
            providers = [ViteInfo],
            # allow_single_file = [".ts", ".mjs", ".js"],
            mandatory = True,
        ),
        "args": attr.string_list(
            default = [],
            doc = """Command line arguments to pass to Rollup vite""",
        ),
    },
    doc = "Builds an executable program from vite source code",
)
