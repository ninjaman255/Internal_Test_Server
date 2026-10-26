# `net-games/ui-suppression-examples.lua`

> **Source reference**
>
> Refreshed from the current `net-games/ui-suppression-examples.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Usage examples for scripts/net-games/ui-suppression.lua. This file is documentation only; it is not required by the framework.

## Module location

- **Source:** `net-games/ui-suppression-examples.lua`
- **Reference:** `script-reference/net-games/ui-suppression-examples.lua.md`
- **Source SHA-256 prefix:** `b0e7b91a540b`

## Source header notes

- Usage examples for scripts/net-games/ui-suppression.lua.
- This file is documentation only; it is not required by the framework.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/ui-suppression` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `acquire` | `pid, owner, options` |
| `release` | `pid, token` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
