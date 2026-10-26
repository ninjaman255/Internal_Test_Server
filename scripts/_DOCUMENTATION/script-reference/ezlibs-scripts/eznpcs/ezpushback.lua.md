# `ezlibs-scripts/eznpcs/ezpushback.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/eznpcs/ezpushback.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezpushback.lua A Pushback NPC uses the regular eznpcs NPC pipeline, with a moving rectangle trigger that follows its bot. On collision, a temporary bot uses the player's own avatar, plays a movement animation, and carries the player to its endpoint. Visibility during pushback: the real player's scale is set to (0, 0) with Net.animate_player_properties (duration 0). The engine exposes no reader for player scale, so on cleanup we do NOT restore a saved snapshot — instead we recompute the correct scale from world state at that moment: 1. Compression Tile at the player's current position (ezpress.get_tile_state_at) 2. Area "Size Mode" (ezpress.get_area_scale_state, or direct read) 3. Normal (1,

## Module location

- **Source:** `ezlibs-scripts/eznpcs/ezpushback.lua`
- **Reference:** `script-reference/ezlibs-scripts/eznpcs/ezpushback.lua.md`
- **Source SHA-256 prefix:** `3145abe9c34d`

## Source header notes

- ezpushback.lua
- A Pushback NPC uses the regular eznpcs NPC pipeline, with a moving rectangle
- trigger that follows its bot. On collision, a temporary bot uses the player's
- own avatar, plays a movement animation, and carries the player to its endpoint.
- Visibility during pushback: the real player's scale is set to (0, 0) with
- Net.animate_player_properties (duration 0). The engine exposes no reader for

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezemitter` |
| `scripts/ezlibs-scripts/object_registry` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `number_property` | `props, name, default, min_value` |
| `safe_call` | `fn, ...` |
| `get_area_players` | `area_id` |
| `provide_avatar_to_area` | `area_id, avatar` |
| `remove_bot` | `bot_id` |
| `event_for` | `entry, player_id, extra` |
| `emit_entry` | `entry, name, event` |
| `get_ezpress` | `` |
| `set_player_scale_immediate` | `player_id, sx, sy` |
| `read_area_size_mode_state` | `area_id` |
| `resolve_target_scale_state` | `area_id, pos` |
| `restore_player_scale` | `player_id, area_id` |
| `map_vector_to_screen` | `dx, dy` |
| `screen_vector_to_map` | `sx, sy` |
| `atan2` | `y, x` |
| `snap_to_canonical_map` | `dx, dy` |
| `direction_vector` | `direction` |
| `get_push_vector` | `entry, player_pos, npc_pos, player_direction` |
| `calculate_target` | `entry, player_pos, npc_pos, player_direction` |
| `cleanup_push` | `player_id, state, reason, restore_player` |
| `perform_pushback` | `entry, player_id` |
| `update_entry_geometry` | `entry` |
| `ezpushback.attach_behavior` | `area_id, object_id, props, bot_id, x, y, z, name` |
| `register_pushback_npc` | `area_id, object` |
| `ezpushback.get_emitter` | `area_id, object_id` |
| `ezpushback.get_emitter_for_bot` | `bot_id` |
| `ezpushback.set_collision_enabled` | `area_id, object_id, enabled` |
| `ezpushback.handle_player_move` | `player_id, x, y, z` |
| `ezpushback.on_tick` | `delta_time` |
| `ezpushback.handle_player_join` | `player_id` |
| `ezpushback.handle_player_transfer` | `player_id` |
| `ezpushback.handle_player_disconnect` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`animate_player_properties`, `list_players`, `provide_asset_for_player`, `remove_bot`, `get_area_custom_property`, `get_player_area`, `get_player_position`, `move_player_camera`, `is_player`, `unlock_player_input`, `get_bot_position`, `get_player_avatar`, `get_player_direction`, `is_player_input_locked`, `lock_player_input`, `get_player_name`, `create_bot`, `animate_bot`, `animate_bot_properties`, `move_bot`, `transfer_player`, `list_areas`

## Engine `Async` calls

`sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEFAULT_WIDTH` | `1.5` |
| `DEFAULT_HEIGHT` | `1.5` |
| `DEFAULT_PUSH_DISTANCE` | `1.0` |
| `DEFAULT_PUSH_DURATION` | `0.28` |
| `DEFAULT_MOVE_STATE` | `'MOVE'` |
| `DEFAULT_COOLDOWN` | `0.75` |
| `SCALE_STATES` | `{` |
| `ISO_TILE_WIDTH` | `64` |
| `ISO_TILE_HEIGHT` | `32` |
| `CANONICAL_DIRECTIONS` | `{` |
| `OPPOSITE_DIRECTION` | `{` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
