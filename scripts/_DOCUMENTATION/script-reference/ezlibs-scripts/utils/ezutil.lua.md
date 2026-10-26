# `ezlibs-scripts/utils/ezutil.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/utils/ezutil.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezutil.lua Small, dependency-free helpers for Lua 5.2. This module does not depend on ezlibs host APIs.

## Module location

- **Source:** `ezlibs-scripts/utils/ezutil.lua`
- **Reference:** `script-reference/ezlibs-scripts/utils/ezutil.lua.md`
- **Source SHA-256 prefix:** `8fce621f2fd2`

## Source header notes

- ezutil.lua
- Small, dependency-free helpers for Lua 5.2.
- This module does not depend on ezlibs host APIs.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezutil.clamp` | `value, minimum, maximum` |
| `ezutil.table_contains` | `list, value` |
| `ezutil.table_remove_value` | `list, value, remove_all` |
| `ezutil.table_count` | `value` |
| `ezutil.table_is_empty` | `value` |
| `ezutil.shallow_copy` | `source` |
| `ezutil.deep_copy` | `source, seen` |
| `ezutil.table_merge` | `target, source` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
