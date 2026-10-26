# `ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Element source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua`
- **Reference:** `script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua.md`
- **Source SHA-256 prefix:** `4f05a8dba6fe`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums` |
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval` |
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Element.new` | `` |
| `this.setAttributes` | `attrs` |
| `this.upsert` | `keyval` |
| `this.hasKey` | `key` |
| `this.hasKeys` | `keyList` |
| `this.getKeyValue` | `key, orValue` |
| `this.getKeyValueAsInt` | `key, orValue` |
| `this.getKeyValueAsBool` | `key, orValue` |
| `this.getKeyValueAsNumber` | `key, orValue` |
| `this.printArgs` | `` |
| `ElementParser.new` | `` |
| `self.parseTokens` | `input, start` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
