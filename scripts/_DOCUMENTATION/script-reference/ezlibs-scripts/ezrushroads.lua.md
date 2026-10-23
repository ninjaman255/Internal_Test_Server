# `ezlibs-scripts/ezrushroads.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezrushroads.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezrushroads.lua Rush Roads minigame integrated with ezlibs Uses eztriggers for tile detection and ezmemory for persistence

## Module location

- **Source:** `ezlibs-scripts/ezrushroads.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezrushroads.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `rush_tile_departed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `rush_tile_entered` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clear_active_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_permanent_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_temp_bots_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `dfs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.add_food` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.get_food` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.handle_object_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezrushroads.remove_food` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_anim_state_from_direction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_food_item_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_player_rush_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_table_length` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `group_rush_roads_in_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `process_rush_road` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_temp_bots_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_food_item` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_visibility_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 675 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
