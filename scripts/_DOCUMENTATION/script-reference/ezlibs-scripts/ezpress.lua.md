# `ezlibs-scripts/ezpress.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezpress.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezpress.lua Player compression/decompression driven by Tiled object properties and area properties. Uses eztriggers for player tile events, ezbottriggers for bot tile events, ezemitter for module-local events, and ezbus for cross-module notifications. Scale states: normal     -> ScaleX/Y = 1 compressed -> ScaleX/Y = 3/8  (Minish-size) enlarged   -> ScaleX/Y = 2    (Giant-size) Area properties: "Size Mode" (enum CompressionMode: Compress | Normalize | Enlarge) Sets the default scale state for the whole area. Unset -> normal. "Size Mode Scope" (enum SizeModeScope: Player | Area Wide) "Player"    -> area default affects players only. (default) "Area Wide" -> area default also applies to NPCs / 

## Module location

- **Source:** `ezlibs-scripts/ezpress.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezpress.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezemitter` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `bot_created` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `bot_removed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `add_area_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `animate_bot_scale` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `animate_scale` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_bot_area_fallback` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emit_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.apply_area_scale_to_bots` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.apply_map_property` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.check_and_apply` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.compress` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.decompress` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.enlarge` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.get_area_scale_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.get_area_size_mode_scope` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.get_bot_scale_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.get_scale_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.get_tile_state_at` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.handle_bot_created` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.handle_bot_removed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.handle_player_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.is_compressed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.is_enlarged` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.set_bot_scale_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress.set_scale_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress:on` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezpress:once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_matching_tile` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_true` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_size_mode` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_size_mode_scope` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_bot_trigger_transition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_trigger_transition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `position_matches_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `read_tile_state_from_properties` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `reconcile_bot_from_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `reconcile_from_current_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `scan_areas` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 829 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
