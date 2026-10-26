# `ezlibs-scripts/ezrushroads.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezrushroads.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezrushroads.lua Rush Roads minigame integrated with ezlibs Uses eztriggers for tile detection and ezmemory for persistence

## Module location

- **Source:** `ezlibs-scripts/ezrushroads.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezrushroads.lua.md`
- **Source SHA-256 prefix:** `87468ce9d3f2`

## Source header notes

- ezrushroads.lua
- Rush Roads minigame integrated with ezlibs
- Uses eztriggers for tile detection and ezmemory for persistence

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| `scripts/ezlibs-scripts/ezbus` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `get_table_length` | `tbl` |
| `get_anim_state_from_direction` | `direction` |
| `get_food_item_id` | `player_id` |
| `get_player_rush_memory` | `player_id` |
| `update_food_item` | `player_id, count` |
| `ezrushroads.get_food` | `player_id` |
| `ezrushroads.add_food` | `player_id, amount` |
| `ezrushroads.remove_food` | `player_id, amount` |
| `group_rush_roads_in_area` | `area_id` |
| `dfs` | `start_id, group_id` |
| `create_permanent_bot` | `area_id, road_id, linked_obj, direction` |
| `process_rush_road` | `area_id, object` |
| `ezrushroads.init` | `` |
| `update_visibility_for_player` | `player_id, area_id` |
| `create_temp_bots_for_player` | `player_id` |
| `remove_temp_bots_for_player` | `player_id` |
| `clear_active_animation` | `player_id` |
| `ezrushroads.handle_player_join` | `player_id` |
| `ezrushroads.handle_player_disconnect` | `player_id` |
| `ezrushroads.handle_player_transfer` | `player_id` |
| `ezrushroads.handle_object_interaction` | `player_id, object_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`remove_player_item`, `create_item`, `give_player_item`, `create_bot`, `get_object_by_id`, `list_areas`, `list_objects`, `exclude_object_for_player`, `include_object_for_player`, `include_actor_for_player`, `exclude_actor_for_player`, `remove_bot`, `move_bot`, `get_player_name`, `get_player_area`, `message_player`, `lock_player_input`, `unlock_player_input`, `animate_bot_properties`

## Engine `Async` calls

`promisify`, `await`, `question_player`, `sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `OFFMAP_X` | `-1000` |
| `OFFMAP_Y` | `-1000` |
| `FED_RUSH_TEXTURE` | `"/server/assets/ezlibs-assets/ezrushroads/fed_rush.png"` |
| `RUSH_DL_ANIM` | `"/server/assets/ezlibs-assets/ezrushroads/rush_dl.anim"` |
| `RUSH_DR_ANIM` | `"/server/assets/ezlibs-assets/ezrushroads/rush_dr.anim"` |
| `BASE_FOOD_NAME` | `"Rush Food"` |
| `BASE_FOOD_DESC` | `"You have %d Rush Food."` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/ezrushroads/rushy.png` |
| `/server/assets/ezlibs-assets/ezrushroads/rushy.anim` |
| `/server/assets/ezlibs-assets/ezrushroads/fed_rush.png` |
| `/server/assets/ezlibs-assets/ezrushroads/rush_dl.anim` |
| `/server/assets/ezlibs-assets/ezrushroads/rush_dr.anim` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
