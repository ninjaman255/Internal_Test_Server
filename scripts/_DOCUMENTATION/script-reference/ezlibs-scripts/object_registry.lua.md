# `ezlibs-scripts/object_registry.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/object_registry.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Object registry source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/object_registry.lua`
- **Reference:** `script-reference/ezlibs-scripts/object_registry.lua.md`
- **Source SHA-256 prefix:** `8d4395052ef9`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezcache` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `object_registry.register_handler` | `object_type, callback, cache` |
| `object_registry.load_all` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `list_objects`, `get_object_by_id`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
