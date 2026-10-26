# `ezlibs-custom/nebulous-liberations/liberations/validation.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/validation.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

validation.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/validation.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/validation.lua.md`
- **Source SHA-256 prefix:** `fc94238f6de2`

## Source header notes

- validation.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `log` | `level, message` |
| `validate_object` | `area_id, object` |
| `Validation.validate_area` | `area_id` |
| `Validation.report` | `area_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_objects`, `get_object_by_id`, `get_area_name`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
