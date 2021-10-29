"Public API re-exports"

load(
    "@ubiquitous_tech_rules_vite//vite/private:rules.bzl",
    _vite = "vite_build",
    _vite_dev = "vite_devserver_macro",
)
load(
    "@ubiquitous_tech_rules_vite//vite/private:vite-plugin-ssr-rules.bzl",
    _vite_plugin_ssr_build = "vite_plugin_ssr_build",
    _vite_plugin_ssr_dev = "vite_plugin_ssr_devserver_macro",
    # _vite_dev = "vite_devserver_macro",
)
load(
    "@ubiquitous_tech_rules_vite//vite/private:copy-rules.bzl",
    _copy_build = "copy_build",
)

vite = _vite
vite_dev = _vite_dev

vite_plugin_ssr_build = _vite_plugin_ssr_build
vite_plugin_ssr_dev = _vite_plugin_ssr_dev

copy_build = _copy_build
