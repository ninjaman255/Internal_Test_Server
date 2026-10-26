# `ezlibs-custom/nebulous-liberations/liberations/selection.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/selection.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Selection source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/selection.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/selection.lua.md`
- **Source SHA-256 prefix:** `01b5eadf2432`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `generate_selection_object` | `self` |
| `Selection:new` | `instance` |
| `Selection:set_filter` | `filter` |
| `Selection:set_indicator` | `indicator` |
| `Selection:set_shape` | `shape, shape_offset_x, shape_offset_y` |
| `Selection:move` | `position, direction` |
| `Selection:is_within` | `x, y, z` |
| `Selection:indicate` | `` |
| `Selection:remove_indicators` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`create_object`, `remove_object`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
