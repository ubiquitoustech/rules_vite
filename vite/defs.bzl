"Public API re-exports"

load(
    "@ubiquitous_tech_rules_vite//vite/private:rules.bzl",
    _vite = "vite_build",
    _vite_dev = "vite_devserver_macro",
)

vite = _vite
vite_dev = _vite_dev
