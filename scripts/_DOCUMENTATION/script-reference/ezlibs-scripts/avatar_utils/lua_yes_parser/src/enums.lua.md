# `ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Enums source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua`
- **Reference:** `script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua.md`
- **Source SHA-256 prefix:** `3decc38959d5`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `UNSET` | `'',` |
| `COMMA` | `',',` |
| `SPACE` | `' '` |
| `STANDARD` | `'standard',` |
| `GLOBAL` | `'global',` |
| `COMMENT` | `'comment',` |
| `ATTRIBUTE` | `'attribute'` |
| `NONE` | `string.byte(''),` |
| `EQUAL` | `string.byte('='),` |
| `BANG` | `string.byte('!'),` |
| `HASH` | `string.byte('#'),` |
| `SPACE` | `string.byte(' '),` |
| `COMMA` | `string.byte(','),` |
| `QUOTE` | `string.byte('"')` |
| `BADTOKEN_AT` | `'Element using attribute prefix out-of-place.',` |
| `BADTOKEN_BANG` | `'Element using global prefix out-of-place.',` |
| `EOL_NO_DATA` | `'Nothing to parse (EOL).',` |
| `EOL_MISSING_ELEMENT` | `'Missing element identifier (EOL).',` |
| `EOL_MISSING_ATTRIBUTE` | `'Missing attribute identifier (EOL).',` |
| `EOL_MISSING_GLOBAL` | `'Missing global identifier (EOL).',` |
| `UNTERMINATED_QUOTE` | `'Missing end quote in expression.',` |
| `RUNTIME` | `'Unexpected runtime error.' -- Reserved for misc. parsing issues` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
