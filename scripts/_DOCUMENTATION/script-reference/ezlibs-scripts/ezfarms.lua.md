# `ezlibs-scripts/ezfarms.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezfarms.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezfarms source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezfarms.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezfarms.lua.md`
- **Source SHA-256 prefix:** `ddb7e714c3b9`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezconfig` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/ezweather` |
| `scripts/ezlibs-scripts/ezmemory` |
| `table` |
| `scripts/ezlibs-scripts/helpers` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `calculate_plant_sell_price` | `plant_name` |
| `calculate_plant_gid` | `plant_name, growth_stage` |
| `determine_growth_stage` | `plant_name, elapsed_since_planted, elpased_since_water, death_time` |
| `update_tile` | `current_time, loc_string, area_weather` |
| `load_farm` | `` |
| `update_all_tiles` | `` |
| `ezfarms.handle_player_join` | `player_id` |
| `ezfarms.on_tick` | `delta_time` |
| `ezfarms.handle_post_selection` | `player_id, post_id` |
| `ezfarms.handle_board_close` | `player_id` |
| `try_buy_seed` | `player_id, plant_name` |
| `list_plants` | `player_id` |
| `ezfarms.list_player_tools` | `player_id` |
| `ezfarms.open_held_item_select` | `player_id` |
| `get_location_string` | `x, y, z` |
| `till_tile` | `tile, x, y, z, player_id` |
| `ezfarms.handle_object_interaction` | `player_id, object_id` |
| `water_tile` | `tile, tile_loc_string, player_id, safe_secret` |
| `plant` | `tile_loc_string, player_id, seed, current_time` |
| `deleet_plant` | `tile_loc_string, current_time` |
| `scythe_plant` | `tile_loc_string, current_time, prexisting_plant, player_id` |
| `harvest` | `tile_loc_string, player_id, safe_secret, current_time` |
| `describe_growth_state` | `growth_stage` |
| `try_harvest` | `tile_loc_string, prexisting_plant, player_id, safe_secret, current_time` |
| `try_plant_seed` | `tile, tile_loc_string, player_id, seed` |
| `ezfarms.handle_tile_interaction` | `player_id, x, y, z, button` |
| `action` | `npc, player_id, dialogue` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_object_by_name`, `create_object`, `set_object_data`, `remove_object`, `set_tile`, `provide_asset_for_player`, `message_player`, `close_bbs`, `remove_post`, `play_sound_for_player`, `open_board`, `get_player_area`, `get_object_by_id`, `get_player_mugshot`, `get_tile`, `play_sound`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `CONFIG` | `require('scripts/ezlibs-scripts/ezconfig')` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/item_get.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/card_error.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/hoe.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/rain.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/scythe.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/swap_tool.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/water_tile.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/wind.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
