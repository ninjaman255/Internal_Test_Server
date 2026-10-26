# `run-gen.lua`

> **Source reference**
>
> Refreshed from the current `run-gen.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Run gen source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `run-gen.lua`
- **Reference:** `script-reference/run-gen.lua.md`
- **Source SHA-256 prefix:** `50654891474f`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/generate-ezlibs-tiled` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
