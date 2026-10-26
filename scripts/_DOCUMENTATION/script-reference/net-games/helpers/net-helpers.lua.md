# `net-games/helpers/net-helpers.lua`

> **Source reference**
>
> Refreshed from the current `net-games/helpers/net-helpers.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== scripts/net-games/helpers/net-helpers.lua EZLIBS compatibility helpers for net-games Adds: Net:create_timer(seconds, callback) -> handle handle:cancel() Why: EZLIBS ships timer helpers; base net-games typically doesn't. We implement it in the net-games style: driven by Net:on("tick"). =====================================================

## Module location

- **Source:** `net-games/helpers/net-helpers.lua`
- **Reference:** `script-reference/net-games/helpers/net-helpers.lua.md`
- **Source SHA-256 prefix:** `53a5dd55e9a5`

## Source header notes

- scripts/net-games/helpers/net-helpers.lua
- EZLIBS compatibility helpers for net-games
- Adds:
- Net:create_timer(seconds, callback) -> handle
- handle:cancel()
- Why:

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `attach_tick_listener` | `` |
| `NetHelpers.create_timer` | `seconds, callback` |
| `handle:cancel` | `` |
| `NetHelpers.safe_require` | `path` |
| `NetHelpers.patch_net` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`create_timer`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `ATTACHED` | `false` |
| `NEXT_ID` | `1` |
| `TIMERS` | `{} -- id -> { remaining, cb, cancelled }` |
| `ATTACHED` | `true` |
| `NEXT_ID` | `NEXT_ID + 1` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
