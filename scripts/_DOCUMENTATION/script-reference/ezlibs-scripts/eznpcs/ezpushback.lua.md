# `ezlibs-scripts/eznpcs/ezpushback.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/eznpcs/ezpushback.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezpushback.lua A Pushback NPC uses the regular eznpcs NPC pipeline, with a moving rectangle trigger that follows its bot. On collision, a temporary bot uses the player's own avatar, plays a movement animation, and carries the player to its endpoint. Visibility during pushback: the real player's scale is set to (0, 0) with Net.animate_player_properties (duration 0). The engine exposes no reader for player scale, so on cleanup we do NOT restore a saved snapshot — instead we recompute the correct scale from world state at that moment: 1. Compression Tile at the player's current position (ezpress.get_tile_state_at) 2. Area "Size Mode" (ezpress.get_area_scale_state, or direct read) 3. Normal (1, 

## Module location

- **Source:** `ezlibs-scripts/eznpcs/ezpushback.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/eznpcs/ezpushback.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezemitter` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/eztiledutils` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `bot_removed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `ezpushback_` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `npc_spawned_from_spawner` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `atan2` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `build_pushback_entry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `calculate_target` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cleanup_push` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `direction_vector` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emit_entry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `event_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.get_emitter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.get_emitter_for_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.handle_player_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.on_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpushback.set_collision_enabled` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_area_players` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_ezpress` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_push_vector` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `map_vector_to_screen` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `number_property` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `perform_pushback` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide_avatar_to_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `read_area_size_mode_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `register_pushback_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_target_scale_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `restore_player_scale` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_call` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `screen_vector_to_map` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_player_scale_immediate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `snap_to_canonical_map` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_entry_geometry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 826 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
