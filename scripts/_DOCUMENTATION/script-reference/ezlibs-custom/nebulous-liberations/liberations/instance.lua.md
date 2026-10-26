# `ezlibs-custom/nebulous-liberations/liberations/instance.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/nebulous-liberations/liberations/instance.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

instance.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/instance.lua`
- **Relative reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/instance.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-custom/compression` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/camera_sequence` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/loot` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/player_session` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/libs/emotes` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Mission:begin` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:clean_up` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:cleaning_up` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:get_enemy_at` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:get_next_spawn_from_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:get_panel_at` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:get_players` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:get_spawn_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:handle_object_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:handle_player_avatar_change` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:handle_tile_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:on_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Mission:remove_panel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `boot_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `convert_indestructible_panels` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `includes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_adjacent` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_panel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `liberate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `liberate_panel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `take_enemy_turn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`BASIC_PANEL_GID_LIST`, `BONUS_PANEL_GID_LIST`, `DARK_HOLE_GID_LIST`, `FIRST_PANEL_GID`, `INDESTRUCTIBLE_PANEL_GID_LIST`, `ITEM_PANEL_GID_LIST`, `LAST_PANEL_GID`, `MAX_ORDER_POINTS`, `PANEL_GATE_GID_LIST`, `TOTAL_PANEL_GIDS`, `TRAP_PANEL_GID_LIST`

## Source notes

- Approximate source size: 777 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)

## Encounter Resolution

Encounter definitions are resolved through `PanelEncounters`, which delegates name/path lookup to `ezencounters`. A mission keeps both `area_id` (the cloned runtime map) and `base_area_id` (the source map). The `Liberation Encounters` default is selected using `base_area_id`, so cloned instance IDs do not accidentally change the encounter table lookup.

For enemy-specific encounters, dark-hole encounters, and per-panel `EncounterPath` overrides, a registered ezencounters name is resolved to its canonical definition. The definition's `path` is passed to the existing NebuLibs player session, and the remaining definition fields are merged with liberation-specific `terrain` and `health` data. This preserves NebuLibs' battle result semantics (`results.success`, enemy health synchronization, panel liberation and loot) while sharing encounter definitions.
