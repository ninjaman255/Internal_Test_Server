# `net-games/ui-suppression.lua`

> **Source reference**
>
> Refreshed from the current `net-games/ui-suppression.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Shared reference-counted suppression for engine HUD, engine input lock, and custom UI handlers. Engine HUD is separate from all sprites/text/panels created by our UI scripts.

## Module location

- **Source:** `net-games/ui-suppression.lua`
- **Reference:** `script-reference/net-games/ui-suppression.lua.md`
- **Source SHA-256 prefix:** `b1f0e2efffc8`

## Source header notes

- Shared reference-counted suppression for engine HUD, engine input lock, and custom UI handlers.
- Engine HUD is separate from all sprites/text/panels created by our UI scripts.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `state_for` | `store, pid` |
| `net_call` | `name, pid` |
| `acquire_engine` | `store, pid, owner, kind, fn_name` |
| `M.acquire_engine_hud` | `pid, owner` |
| `M.acquire_input_lock` | `pid, owner` |
| `M.register_handler` | `name, handler` |
| `M.acquire_element` | `pid, name, owner, options` |
| `M.release` | `h` |
| `M.register_profile` | `name, entries` |
| `M.acquire_profile` | `pid, name, owner, options` |
| `M.release_profile` | `b` |
| `M.cleanup_player` | `pid` |
| `M.get_debug_state` | `pid` |
| `summary` | `s` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`toggle_player_hud`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
