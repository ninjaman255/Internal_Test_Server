# `enum/enum.lua`

> **Source reference**
>
> Refreshed from the current `enum/enum.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

enum.lua A reusable Lua 5.2 module for creating enum-like tables. Supports custom key-value definitions, active value validation, and copying for independent instances. No external dependencies.

## Module location

- **Source:** `enum/enum.lua`
- **Reference:** `script-reference/enum/enum.lua.md`
- **Source SHA-256 prefix:** `e3b1e7c9fb55`

## Source header notes

- enum.lua
- A reusable Lua 5.2 module for creating enum-like tables.
- Supports custom key-value definitions, active value validation,
- and copying for independent instances.
- No external dependencies.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Enum.new` | `...` |
| `getName` | `self, value` |
| `getValue` | `self, key` |
| `isValid` | `self, value` |
| `names` | `self` |
| `values` | `self` |
| `getActive` | `self` |
| `setActive` | `self, value` |
| `random` | `self` |
| `new` | `self` |
| `copy` | `self` |
| `__index` | `tbl, key` |
| `__newindex` | `tbl, key, value` |
| `__tostring` | `tbl` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
