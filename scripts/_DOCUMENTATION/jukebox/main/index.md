# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/jukebox/main.lua`](../../../jukebox/main.lua)  
> **Source lines:** 1517  
> **SHA-256 (UTF-8):** `4cae9464bc36b31e68b52824cefaa4fa6a5f8f7332162b6c425bc89f23b1a4c6`  
> **Named/assigned functions detected:** 43

> **Static reference:** Declarations, parameters, event hooks, and Net calls are extracted from this complete Lua file. Locals are not public APIs.

## Dependencies

| Line | Module |
|---:|---|
| 7 | `scripts/logger/logger` |
| 15 | `scripts/jukebox/utils` |
| 16 | `scripts/net-games/main` |
| 17 | `scripts/utils/event-emitter` |
| 18 | `scripts/jukebox/constants/ui-data` |
| 19 | `scripts/player-control/main` |
| 20 | `scripts/displayer/displayer` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 1340 | `Jukebox` | `Jukebox Open` |
| 1412 | `Jukebox` | `Jukebox Close` |
| 1423 | `Jukebox` | `Jukebox Request Song` |
| 1428 | `Net` | `player_area_transfer` |
| 1435 | `Net` | `tick` |
| 1462 | `Net` | `object_interaction` |
| 1480 | `Net` | `player_disconnect` |

## Functions

| Line | Function | Arguments |
|---:|---|---|
| 40 | `load_catalog` | `(none)` |
| 127 | `music_checksum` | `content` |
| 139 | `write_music_file` | `path, content` |
| 170 | `read_music_file` | `path` |
| 225 | `load_music_data` | `(none)` |
| 244 | `save_music_data` | `(none)` |
| 289 | `get_music_user_key` | `player_id` |
| 307 | `read_users_music_file` | `path` |
| 370 | `load_users_music` | `(none)` |
| 399 | `save_users_music` | `(none)` |
| 459 | `is_music_unlocked` | `user_key, track` |
| 468 | `get_unlocked_albums` | `user_key` |
| 539 | `notify_unlocks_changed` | `user_key` |
| 553 | `unlock_music` | `player_id, album_name, filename` |
| 600 | `unlock_album` | `player_id, album_name` |
| 648 | `apply_music_data` | `(none)` |
| 690 | `navigation_pressed` | `ctrl, owner, action` |
| 693 | `acquire_input` | `player_id` |
| 711 | `clear_title` | `player_id` |
| 716 | `draw_album_title` | `player_id, album_name` |
| 743 | `record_art_path` | `album_name, kind` |
| 752 | `provide_base_ui_assets` | `player_id` |
| 755 | `provide` | `path` |
| 777 | `add_static_ui` | `player_id, name` |
| 784 | `add_record_ui` | `player_id, album_name, kind` |
| 849 | `slow_record` | `player_id, sprite_id` |
| 868 | `rotate_record` | `player_id` |
| 890 | `update_list_window` | `session` |
| 903 | `clear_track_list` | `player_id` |
| 910 | `draw_track_list` | `player_id` |
| 955 | `select_preview` | `player_id, index` |
| 1004 | `refresh_unlocked_sessions` | `user_key` |
| 1077 | `change_album` | `player_id, direction` |
| 1103 | `change_track` | `player_id, direction` |
| 1116 | `requestJukeboxSong` | `player_id, index` |
| 1180 | `spawnJukeboxUI` | `player_id` |
| 1206 | `removeJukeboxUI` | `player_id, session` |
| 1231 | `openJukeboxMenu` | `player_id, area_id, object_id, on_close, options` |
| 1290 | `closeJukeboxMenu` | `player_id, suppress_callback` |
| 1315 | `open_jukebox_ui` | `player_id, on_close, object_id, options` |
| 1331 | `close_jukebox_ui` | `player_id` |
| 1500 | `get_tracks` | `(none)` |
| 1503 | `get_albums` | `(none)` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.get_object_by_id` | 3 | 657 |
| `Net.get_player_area` | 4 | 1117 |
| `Net.get_song` | 1 | 917 |
| `Net.list_areas` | 2 | 649 |
| `Net.list_objects` | 1 | 656 |
| `Net.on` | 4 | 1428 |
| `Net.provide_asset` | 1 | 675 |
| `Net.set_song` | 1 | 661 |
