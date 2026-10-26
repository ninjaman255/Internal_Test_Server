# `ezlibs-scripts/utils/ezvalidate.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/utils/ezvalidate.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezvalidate.lua Dependency-free validation helpers for Lua 5.2.

## Module location

- **Source:** `ezlibs-scripts/utils/ezvalidate.lua`
- **Reference:** `script-reference/ezlibs-scripts/utils/ezvalidate.lua.md`
- **Source SHA-256 prefix:** `612295c86e05`

## Source header notes

- ezvalidate.lua
- Dependency-free validation helpers for Lua 5.2.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezvalidate.is_type` | `value, expected_type` |
| `ezvalidate.number_range` | `value, minimum, maximum` |
| `ezvalidate.required_fields` | `value, fields` |
| `ezvalidate.table_field_types` | `value, expected` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
