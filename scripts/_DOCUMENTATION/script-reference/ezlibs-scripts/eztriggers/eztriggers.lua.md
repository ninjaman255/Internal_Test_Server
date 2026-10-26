# `ezlibs-scripts/eztriggers/eztriggers.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/eztriggers/eztriggers.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Eztriggers source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/eztriggers/eztriggers.lua`
- **Reference:** `script-reference/ezlibs-scripts/eztriggers/eztriggers.lua.md`
- **Source SHA-256 prefix:** `ac3eb7a74421`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/object_registry` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `is_button_trigger` | `trigger_info` |
| `eztriggers.add_location_event_trigger` | `area_id,object` |
| `eztriggers.add_interact_trigger` | `area_id,trigger_object` |
| `eztriggers.add_radius_trigger` | `area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id` |
| `eztriggers.add_rectangle_trigger` | `area_id, trigger_object, width, height, trigger_id` |
| `eztriggers.handle_object_interaction` | `player_id,object_id,button` |
| `set_player_overlap` | `trigger_info, player_id, is_inside, reason` |
| `eztriggers.add_event` | `event_object` |
| `eztriggers.clear_radius_overlaps_for_player` | `player_id, reason` |
| `eztriggers.clear_rectangle_overlaps_for_player` | `player_id, reason` |
| `eztriggers.handle_player_transfer` | `player_id` |
| `eztriggers.handle_player_disconnect` | `player_id` |
| `tick_check_player_triggers` | `` |
| `eztriggers.handle_player_move` | `player_id, x, y, z` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`EventEmitter`, `get_player_area`, `get_player_position`, `list_areas`, `list_players`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEBUG_BUTTON_TRIGGER_GEOMETRY` | `false` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
