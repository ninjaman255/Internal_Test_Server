# `ezlibs-scripts/ezwarps/main.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezwarps/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Main source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezwarps/main.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezwarps/main.lua.md`
- **Source SHA-256 prefix:** `65d511df3bce`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/json` |
| `scripts/ezlibs-scripts/ezwarps/arrow_animation_factory` |
| `scripts/ezlibs-scripts/ezwarps/log_in_animation` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| `scripts/ezlibs-scripts/object_registry` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezcache` |
| `scripts/ezlibs-scripts/ezwarps/fall_in_animation` |
| `scripts/ezlibs-scripts/ezwarps/lev_beast_in_animation` |
| `scripts/ezlibs-scripts/ezwarps/lev_beast_out_animation` |
| `scripts/ezlibs-scripts/ezwarps/fall_off_2` |
| `scripts/ezlibs-scripts/ezpress` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `table_has_value` | `table, val` |
| `log` | `message` |
| `property_is_true` | `value` |
| `add_landing` | `area_id, incoming_data, x, y, z, direction, warp_in, arrival_animation` |
| `doAnimationForWarp` | `player_id,animation_name,is_leave_animation,warp_object` |
| `add_interact_warp` | `object, object_id, area_id, area_name` |
| `add_radius_warp` | `object, object_id, area_id, area_name` |
| `add_custom_warp` | `object, object_id, area_id, area_name` |
| `process_warp_object` | `area_id, object` |
| `prepare_player_arrival` | `player_id,x,y,z,special_animation_name` |
| `ezwarps.handle_player_request` | `player_id, data` |
| `use_warp` | `player_id,warp_object,warp_meta` |
| `ezwarps.handle_custom_warp` | `player_id, object_id` |
| `ezwarps.handle_player_join` | `player_id` |
| `ezwarps.player_is_in_animation` | `player_id` |
| `ezwarps.handle_player_transfer` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lock_player_input`, `unlock_player_input`, `get_area_name`, `transfer_player`, `get_player_area`, `transfer_server`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
