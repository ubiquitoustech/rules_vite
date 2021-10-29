"""
vite-plugin-ssr actions
"""

load("@build_bazel_rules_nodejs//:providers.bzl", "run_node")

def vite_plugin_ssr_build_action(ctx, srcs, out, clientpath, serverpath):
    """Run a production build of the vite project

    Args:
        ctx: arguments description, can be
        multiline with additional indentation.
        srcs: source files
        out: output directory
        clientpath: path to the client dir for vite-plugin-ssr
        serverpath: path to the server dir for vite-plugin-ssr
    """

    # setup the args passed to vite-plugin-ssr
    launcher_args = ctx.actions.args()

    launcher_args.add_all([
        "prerender",
        "--outDir",
        clientpath,
        "--serverDir",
        serverpath,
        "--writeOutDir",
        out.path,
    ])

    launcher_args.add_all(ctx.attr.args)

    outputs = []
    outputs.append(out)

    execution_requirements = {}
    if "no-remote-exec" in ctx.attr.tags:
        execution_requirements = {"no-remote-exec": "1"}

    run_node(
        ctx = ctx,
        inputs = depset(srcs),
        outputs = outputs,
        arguments = [launcher_args],
        execution_requirements = execution_requirements,
        mnemonic = "vitepluginssr",
        executable = "_vite_plugin_ssr",
        link_workspace_root = True,
    )
