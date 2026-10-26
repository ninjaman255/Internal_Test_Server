# `jukebox/main.lua`

> **Source reference**
>
> Refreshed from the current `jukebox/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `jukebox/main.lua`
- **Reference:** `script-reference/jukebox/main.lua.md`
- **Source SHA-256 prefix:** `db0b1fd4ead5`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/jukebox/utils` |
| `scripts/jukebox/constants/paths` |
| `scripts/net-games/main` |
| `scripts/displayer/text-layout` |
| `scripts/utils/event-emitter` |
| `scripts/jukebox/constants/ui-data` |
| `scripts/input-controller/main` |
| `scripts/net-games/ui-suppression` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `object_interaction` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `async` | `p` |
| `await` | `v` |
| `gatherDirectoryContents` | `path` |
| `gatherAllMusic` | `` |
| `gatherAllMapsAndObjects` | `` |
| `gatherAllJukeboxes` | `maps` |
| `sorted_albums` | `` |
| `first_album` | `` |
| `record_art_path` | `album_name, kind` |
| `track_path_for` | `track` |
| `compileTracks` | `song_list` |
| `strip_extension` | `title` |
| `measure_title_width` | `title` |
| `clear_title` | `player_id` |
| `draw_track_title` | `player_id, track` |
| `update_title_display` | `player_id, track` |
| `input_owner` | `player_id` |
| `any_action_pressed` | `ctrl, owner, actions` |
| `any_action_repeated` | `ctrl, owner, actions` |
| `acquire_input` | `player_id` |
| `release_input_for` | `player_id` |
| `provide_base_ui_assets` | `player_id, initial_album` |
| `add_record_ui` | `player_id, album_name` |
| `spawnJukeboxUI` | `player_id` |
| `removeJukeboxUI` | `player_id` |
| `openJukeboxMenu` | `player_id, area_id, object_id` |
| `closeJukeboxMenu` | `player_id` |
| `select_preview` | `player_id, index` |
| `requestJukeboxSong` | `player_id, index, should_close` |
| `open_jukebox_ui` | `player_id, on_close` |
| `close_jukebox_ui` | `player_id` |
| `get_tracks` | `` |
| `get_albums` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `list_objects`, `get_object_by_id`, `on`, `provide_asset`, `provide_asset_for_player`, `get_player_area`, `set_song`, `is_player`

## Engine `Async` calls

`promisify`, `await`, `sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `SCREEN_W` | `240` |
| `SCREEN_H` | `160` |
| `TITLE_TEXT_ID` | `"Jukebox Title"` |
| `TITLE_FONT` | `"THICK"` |
| `TITLE_SCALE` | `2.0` |
| `TITLE_Z` | `5` |
| `MARQUEE_X` | `76` |
| `MARQUEE_Y` | `96` |
| `MARQUEE_W` | `90   -- 183 - 56` |
| `MARQUEE_H` | `20    -- 112 - 93` |
| `MARQUEE_SPEED` | `60  -- pixels per second` |
| `CURSOR_TEXTURE` | `"/server/assets/net-games/cursors/text_cursor.png"` |
| `CURSOR_ANIMATION` | `"/server/assets/net-games/cursors/text_cursor.animation"` |
| `CURSOR_SCALE` | `2.0` |
| `CURSOR_WIDTH` | `16   -- 8x8 base at scale 2` |
| `CURSOR_GAP` | `4` |
| `CURSOR_Y` | `MARQUEE_Y + math.floor((MARQUEE_H - CURSOR_WIDTH) / 2)` |
| `CURSOR_LEFT_X` | `MARQUEE_X - CURSOR_GAP - CURSOR_WIDTH   -- 36` |
| `CURSOR_RIGHT_X` | `MARQUEE_X + MARQUEE_W + CURSOR_GAP       -- 187` |
| `INPUT_OWNER_PREFIX` | `"jukebox:"` |
| `LEFT_ACTIONS` | `{ "Left",     "UpLeft",    "DownLeft" }` |
| `RIGHT_ACTIONS` | `{ "Right",    "UpRight",   "DownRight" }` |
| `CANCEL_ACTIONS` | `{ "Cancel" }` |
| `CONFIRM_ACTIONS` | `{ "Confirm" }` |
| `BASE_UI_ASSETS` | `{` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/jukebox/tracks/` |
| `/server/assets/jukebox/records/` |
| `/server/assets/net-games/cursors/text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |
| `/server/assets/jukebox/ui-sprites/shade-screen.png` |
| `/server/assets/jukebox/ui-sprites/jukebox-backdrop.png` |
| `/server/assets/jukebox/ui-sprites/jukebox-frame.png` |
| `/server/assets/jukebox/ui-sprites/records/record.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
