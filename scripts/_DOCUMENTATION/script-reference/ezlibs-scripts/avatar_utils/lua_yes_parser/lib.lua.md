# `ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Lib source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua`
- **Reference:** `script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua.md`
- **Source SHA-256 prefix:** `176424700ed3`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums` |
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `parse` | `path` |
| `Collector.new` | `` |
| `self.handleLine` | `line` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
