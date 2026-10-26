# `enum/predefined-enums.lua`

> **Source reference**
>
> Refreshed from the current `enum/predefined-enums.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

predefined_enums.lua Central place to define your enums for easy reuse. You can add as many as you like.

## Module location

- **Source:** `enum/predefined-enums.lua`
- **Reference:** `script-reference/enum/predefined-enums.lua.md`
- **Source SHA-256 prefix:** `5a85616b034d`

## Source header notes

- predefined_enums.lua
- Central place to define your enums for easy reuse.
- You can add as many as you like.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/enum/enum` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `ACTIVE` | `"active",` |
| `INACTIVE` | `"inactive",` |
| `PENDING` | `{ code = 0, label = "pending" },` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
