"NPM Public API re-exports"

load(
    "@ubiquitous_tech_rules_vite//vite:defs.bzl",
    _copy_build = "copy_build",
    _vite = "vite",
    _vite_dev = "vite_dev",
    _vite_plugin_ssr_build = "vite_plugin_ssr_build",
    _vite_plugin_ssr_dev = "vite_plugin_ssr_dev",
)

vite = _vite
vite_dev = _vite_dev

vite_plugin_ssr_build = _vite_plugin_ssr_build
vite_plugin_ssr_dev = _vite_plugin_ssr_dev

copy_build = _copy_build
