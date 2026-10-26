# `ezlibs-custom/nebulous-liberations/main.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

main.lua Nebulous Liberations ezlibs custom plugin entry point. This module follows scripts/ezlibs-scripts/main.lua's plugin contract: it returns a table of handle_* functions and does not register its own Net event listeners. The ezlibs dispatcher passes event fields to these methods.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/main.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/main.lua.md`
- **Source SHA-256 prefix:** `3b962389a058`

## Source header notes

- main.lua
- Nebulous Liberations ezlibs custom plugin entry point.
- This module follows scripts/ezlibs-scripts/main.lua's plugin contract:
- it returns a table of handle_* functions and does not register its own Net
- event listeners. The ezlibs dispatcher passes event fields to these methods.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/player` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/instance` |
| `scripts/ezlibs-custom/nebulous-liberations/utils/parties` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/validation` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `find_available_instance_id` | `start_id` |
| `transfer_players_to_new_instance` | `base_area, player_ids` |
| `LibPlugin.start_game_for_player` | `player_id, liberation_id` |
| `detect_door_interaction` | `player_id, object_id, button` |
| `leave_party` | `player` |
| `remove_instance` | `area_id` |
| `LibPlugin.on_tick` | `delta_time` |
| `LibPlugin.handle_tile_interaction` | `player_id, x, y, z, button` |
| `LibPlugin.handle_object_interaction` | `player_id, object_id, button` |
| `LibPlugin.handle_actor_interaction` | `player_id, actor_id, button` |
| `LibPlugin.handle_textbox_response` | `player_id, response` |
| `LibPlugin.handle_battle_results` | `player_id, stats` |
| `LibPlugin.handle_player_avatar_change` | `player_id, details` |
| `LibPlugin.handle_player_transfer` | `player_id` |
| `LibPlugin.handle_player_request` | `player_id, data` |
| `LibPlugin.handle_player_disconnect` | `player_id` |
| `LibPlugin.handle_player_move` | `player_id, x, y, z` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`transfer_player`, `get_player_name`, `get_area_name`, `get_object_by_name`, `get_spawn_position`, `on`, `get_player_area`, `is_bot`, `get_player_position`, `list_areas`, `get_area_custom_properties`, `list_objects`, `get_object_by_id`, `get_tileset`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
