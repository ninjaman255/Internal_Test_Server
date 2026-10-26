# `enum/enumset.lua`

> **Source reference**
>
> Refreshed from the current `enum/enumset.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

enumset.lua A container that holds multiple enums and returns a fresh copy of an enum when accessed by key. Requires enum.lua

## Module location

- **Source:** `enum/enumset.lua`
- **Reference:** `script-reference/enum/enumset.lua.md`
- **Source SHA-256 prefix:** `fff751babf8c`

## Source header notes

- enumset.lua
- A container that holds multiple enums and returns a fresh copy
- of an enum when accessed by key.
- Requires enum.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/enum/enum` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `EnumSet.new` | `definitions` |
| `keys` | `self` |
| `getOriginal` | `self, key` |
| `get` | `self, key` |
| `__index` | `tbl, key` |
| `__newindex` | `tbl, key, value` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
