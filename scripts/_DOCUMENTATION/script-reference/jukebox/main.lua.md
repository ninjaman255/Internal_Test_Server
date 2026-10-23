# `jukebox/main.lua`

> **Source reference**
>
> Generated from `jukebox/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `jukebox/main.lua`
- **Relative reference:** `script-reference/jukebox/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/text-layout` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/jukebox/constants/paths` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/jukebox/constants/ui-data` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/jukebox/utils` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/utils/event-emitter` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `object_interaction` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `acquire_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_record_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `any_action_pressed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `any_action_repeated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clear_title` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `closeJukeboxMenu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `close_jukebox_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `compileTracks` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_track_title` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `first_album` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `gatherAllJukeboxes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `gatherAllMapsAndObjects` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `gatherAllMusic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `gatherDirectoryContents` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_albums` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_tracks` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `input_owner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `measure_title_width` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `openJukeboxMenu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_jukebox_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide_base_ui_assets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_art_path` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `release_input_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `removeJukeboxUI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `requestJukeboxSong` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `select_preview` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `sorted_albums` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `spawnJukeboxUI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `strip_extension` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `track_path_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_title_display` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 623 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
