# `ezlibs-scripts/ezconfig.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezconfig.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezconfig source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezconfig.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezconfig.lua.md`
- **Source SHA-256 prefix:** `8c4a00426e8c`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `ezlibs-config` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
