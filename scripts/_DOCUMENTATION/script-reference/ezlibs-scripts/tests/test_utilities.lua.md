# `ezlibs-scripts/tests/test_utilities.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/tests/test_utilities.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Run from the package root with: lua tests/test_utilities.lua

## Module location

- **Source:** `ezlibs-scripts/tests/test_utilities.lua`
- **Reference:** `script-reference/ezlibs-scripts/tests/test_utilities.lua.md`
- **Source SHA-256 prefix:** `19c182d1e04b`

## Source header notes

- Run from the package root with:
- lua tests/test_utilities.lua

## Direct `require` dependencies

| Import path |
|---|
| `ezutil` |
| `ezvalidate` |
| `ezdebug` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `test` | `name, callback` |
| `sink` | `message` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
