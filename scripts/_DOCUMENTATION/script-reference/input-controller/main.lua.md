# `input-controller/main.lua`

> **Source reference**
>
> Refreshed from the current `input-controller/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

main.lua – Unified input API

## Module location

- **Source:** `input-controller/main.lua`
- **Reference:** `script-reference/input-controller/main.lua.md`
- **Source SHA-256 prefix:** `f5522cd74635`

## Source header notes

- main.lua – Unified input API
- Keep one API registry and one set of Net event handlers if this module is
- evaluated more than once in the same Lua global environment.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/utils/utility` |
| `scripts/input-controller/d-pad` |
| `scripts/input-controller/input-controller` |
| `scripts/input-controller/buttons` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `player_disconnect` |
| `virtual_input` |
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `make_controller` | `player_id, opts` |
| `API.set_controller_class` | `class` |
| `API.get_controller_class` | `` |
| `API.get_controller` | `player_id` |
| `API.get_controller_identity` | `player_id` |
| `API.create_controller` | `player_id, opts` |
| `API.spawn_controller` | `player_id, opts` |
| `API.reload_controller` | `player_id, opts` |
| `API.set_repeat_delays` | `player_id, first_repeat_delay, repeat_delay` |
| `API.restore_repeat_delays` | `player_id` |
| `API.activate_controller` | `player_id` |
| `API.deactivate_controller` | `player_id` |
| `API.destroy_controller` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `SINGLETON_KEY` | `"__internal_test_server_input_controller_api_v1"` |
| `API` | `{}` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
