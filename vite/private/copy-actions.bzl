"""
copy actions
"""

load("@build_bazel_rules_nodejs//:providers.bzl", "run_node")

def copy_build_action(ctx, srcs, folders_to_copy, out):
    """copy files for output of a vite project

    Args:
        ctx: arguments description, can be
        multiline with additional indentation.
        srcs: source files
        folders_to_copy: the deps to copy
        out: output directory
    """

    folders_to_copy.add_all([
        "%s/" % out.path,
    ])

    outputs = []
    outputs.append(out)

    execution_requirements = {}
    if "no-remote-exec" in ctx.attr.tags:
        execution_requirements = {"no-remote-exec": "1"}

    run_node(
        ctx = ctx,
        inputs = depset(srcs),
        outputs = outputs,
        arguments = [folders_to_copy],
        execution_requirements = execution_requirements,
        mnemonic = "copy",
        executable = "_copy",
        link_workspace_root = True,
    )
