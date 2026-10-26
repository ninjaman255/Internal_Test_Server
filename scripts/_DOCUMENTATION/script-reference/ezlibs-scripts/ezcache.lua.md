# `ezlibs-scripts/ezcache.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezcache.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezcache source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezcache.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezcache.lua.md`
- **Source SHA-256 prefix:** `10baf11108a3`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezcache.add_cacheable_type` | `type_name` |
| `ezcache.object_is_of_type` | `object` |
| `ezcache.cache_object` | `area_id, object` |
| `ezcache.get_object_by_id_cached` | `area_id, object_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`remove_object`, `get_object_by_id`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
