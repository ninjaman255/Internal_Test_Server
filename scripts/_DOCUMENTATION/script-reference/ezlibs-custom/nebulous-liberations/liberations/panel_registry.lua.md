# `ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

panel_registry.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua.md`
- **Source SHA-256 prefix:** `d6a830cd3aff`

## Source header notes

- panel_registry.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `PanelRegistry.register` | `type_name, definition` |
| `PanelRegistry.get_type_by_gid` | `gid` |
| `PanelRegistry.get_definition` | `type_name` |
| `PanelRegistry.is_type` | `gid, type_name` |
| `PanelRegistry.is_liberatable` | `gid` |
| `PanelRegistry.is_walkable` | `gid` |
| `PanelRegistry.is_shadowstep` | `gid` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
