# `ezlibs-scripts/ezpress.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezpress.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezpress.lua Player compression/decompression driven by Tiled object properties and area properties. Uses eztriggers for player tile events, ezbottriggers for bot tile events, ezemitter for module-local events, and ezbus for cross-module notifications. Scale states: normal     -> ScaleX/Y = 1 compressed -> ScaleX/Y = 3/8  (Minish-size) enlarged   -> ScaleX/Y = 2    (Giant-size) Area properties: "Size Mode" (enum CompressionMode: Compress | Normalize | Enlarge) Sets the default scale state for the whole area. Unset -> normal. "Size Mode Scope" (enum SizeModeScope: Player | Area Wide) "Player"    -> area default affects players only. (default) "Area Wide" -> area default also applies to NPCs /

## Module location

- **Source:** `ezlibs-scripts/ezpress.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezpress.lua.md`
- **Source SHA-256 prefix:** `860a07bc97c6`

## Source header notes

- ezpress.lua
- Player compression/decompression driven by Tiled object properties and area
- properties. Uses eztriggers for player tile events, ezbottriggers for bot
- tile events, ezemitter for module-local events, and ezbus for cross-module
- notifications.
- Scale states:

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezemitter` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `is_true` | `value` |
| `normalize_size_mode` | `value` |
| `normalize_size_mode_scope` | `value` |
| `emit_event` | `name, payload` |
| `ezpress:on` | `event_name, callback` |
| `ezpress:once` | `event_name, callback` |
| `ezpress.get_area_scale_state` | `area_id` |
| `ezpress.get_area_size_mode_scope` | `area_id` |
| `animate_scale` | `player_id, scale, immediate` |
| `ezpress.set_scale_state` | `player_id, state, immediate, metadata` |
| `ezpress.get_scale_state` | `player_id` |
| `ezpress.is_compressed` | `player_id` |
| `ezpress.is_enlarged` | `player_id` |
| `ezpress.compress` | `player_id, immediate, metadata` |
| `ezpress.decompress` | `player_id, immediate, metadata` |
| `ezpress.enlarge` | `player_id, immediate, metadata` |
| `animate_bot_scale` | `bot_id, scale, immediate` |
| `ezpress.set_bot_scale_state` | `bot_id, state, immediate, metadata` |
| `ezpress.get_bot_scale_state` | `bot_id` |
| `position_matches_trigger` | `pos, trigger` |
| `get_matching_tile` | `area_id, pos` |
| `ezpress.get_tile_state_at` | `area_id, pos` |
| `ezpress.check_and_apply` | `player_id, area_id, pos, immediate` |
| `reconcile_from_current_position` | `player_id, source, immediate` |
| `on_trigger_transition` | `area_id, trigger, transition, event` |
| `apply_bot_area_fallback` | `bot_id, area_id, immediate, source` |
| `reconcile_bot_from_position` | `bot_id, area_id, pos, source, immediate` |
| `on_bot_trigger_transition` | `area_id, trigger, transition, event` |
| `add_area_trigger` | `area_id, object_id, obj, target_state` |
| `read_tile_state_from_properties` | `props` |
| `ezpress.apply_area_scale_to_bots` | `area_id, immediate, metadata` |
| `ezpress.apply_map_property` | `player_id, area_id, immediate, extra_metadata` |
| `ezpress.handle_bot_created` | `bot_id, area_id, x, y, z` |
| `ezpress.handle_bot_removed` | `bot_id` |
| `ezpress.handle_player_join` | `player_id` |
| `ezpress.handle_player_transfer` | `player_id` |
| `ezpress.handle_player_move` | `player_id, x, y, z` |
| `ezpress.handle_player_disconnect` | `player_id` |
| `scan_areas` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_area_custom_property`, `animate_player_properties`, `play_sound_for_player`, `get_player_area`, `animate_bot_properties`, `set_bot_scale`, `get_player_position`, `get_bot_area`, `get_bot_position`, `provide_asset_for_player`, `list_areas`, `list_objects`, `get_object_by_id`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `SCALE_NORMAL` | `1` |
| `SCALE_COMPRESSED` | `3 / 8` |
| `SCALE_ENLARGED` | `2` |
| `SCALE_STATES` | `{` |
| `ANIMATION_DURATION` | `0.15` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/compress.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
