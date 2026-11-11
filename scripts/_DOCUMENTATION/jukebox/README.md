# 🎵 Jukebox — Standalone and HP desktop usage

[🏠 Documentation home](../index.md) · [📚 Module index](index.md) · [🎮 PlayerControl API](../player-control/README.md)

## 🧭 Contents
- [Purpose](#purpose)
- [Public API](#public-api)
- [Opening modes](#opening-modes)
- [Tiled settings](#tiled-settings)
- [Events and navigation](#events-and-navigation)
- [Lifecycle](#lifecycle)
- [Files](#files)

## Purpose

`scripts/jukebox/main.lua` loads album/track data and persistence, draws a Jukebox UI, validates music requests and player unlocks, and reads controller inputs through InputController while a PlayerControl session owns capture/HUD/focus. Only the input/HUD ownership integration changed in the drop-in; music catalog rules remain in the existing source.

## Public API

The module returns this table from `main.lua`:

| Export | Parameters | Description |
|---|---|---|
| `open` | `player_id, on_close, object_id, options` | Guarded open; accepts `options` as third table argument if `object_id` omitted. Returns bool from open implementation. |
| `close` | `player_id` | Closes without invoking `on_close`. |
| `emitter` | — | Jukebox event emitter object. |
| `get_tracks` | none | Returns current `TrackItems` table. |
| `get_albums` | none | Returns array of album names. |
| `unlock_music` | `player_id, album_name, filename` | Unlocks a music entry for the player according to existing persistence rules. |
| `unlock_album` | `player_id, album_name` | Unlocks an album according to existing persistence rules. |

## Opening modes

```lua
local Jukebox = require('scripts/jukebox/main')
-- Standalone, no HP Manager parent:
local ok = Jukebox.open(player_id, function(pid) print('closed',pid) end)

-- Child of an active HP desktop session:
local ok_child = Jukebox.open(player_id, function(pid) end,
    {parent = desktop_session})

-- Explicit object id plus options:
local ok_obj = Jukebox.open(player_id, callback, object_id,
    {parent = desktop_session})
```

Standalone mode creates a `music_menu` root. HP desktop mode creates a child using `options.parent`. Opening from a world object uses the `object_interaction` handler with button `0` and object `type` or `class` `Jukebox`.

## Tiled settings

| Object property | Source handling | Meaning |
|---|---|---|
| `music_locked` | `true` boolean or string `"true"` | Filters to a player's unlocked catalog. |
| `music_perma` | `true` boolean or string `"true"` | Passes persistent-play behavior into Jukebox session. |

The exact catalog file paths and UI assets are defined by `jukebox/constants/paths.lua` and `jukebox/constants/ui-data.lua`; see their [source references](index.md).

## Events and navigation

The Jukebox emitter uses `"Jukebox Open"`, `"Jukebox Close"`, and `"Jukebox Request Song"`. Source also manages unlocked-music refresh. Its asynchronous UI navigation loop reads `Cancel`, `Left`, `Right`, `Up`, `Down`, and `Confirm`, using an approximately 0.2-second sleep between checks. Left/Right switch albums; Up/Down change track; Confirm requests selected song. InputController repeat is used for navigation.

## Lifecycle

1. `open` validates player/area/catalog, creates the session, supplies UI assets and emits **Jukebox Open**.
2. Open handler calls `PlayerControl.begin(..., {owner='jukebox', profile='music_menu', parent=...})`; this owns the HUD/capture and focus. The UI is rendered.
3. On Cancel or public `close`, **Jukebox Close** removes UI and closes its PlayerControl context.
4. In the event-emitter close chain, the context is closed **before** the optional `on_close(player_id)` callback is invoked. That lets the HP Manager resume correctly.
5. On transfer, close suppresses the return callback. On disconnect, the session and record animation are cleaned up.

**Important:** The module retains its own InputController-based async polling and does not use `PlayerControl:on_pressed`. This is intentional in the current implementation; do not document it as fully event-driven.

## Files

| File | Purpose | Reference |
|---|---|---|
| `main.lua` | Session, music database and playback | [Source reference](main/index.md) |
| `utils.lua` | Music helper functions | [Source reference](utils/index.md) |
| `constants/paths.lua` | Music asset/storage paths | [Source reference](constants/paths/index.md) |
| `constants/ui-data.lua` | UI positions/IDs | [Source reference](constants/ui-data/index.md) |

## 🪵 Shared logging

Jukebox now uses the canonical `scripts/logger/logger` module with system name `jukebox`. `main.lua` reports under subsystem `main` and `utils.lua` under `utils`, while preserving their pre-existing console message prefixes. Logs are written to `scripts/_DEBUGGING/jukebox/_FULL-LOG.log`, `_MAIN.log` and `_UTILS.log`. See the [shared logger guide](../logger/README.md).

## Initialization and duplicate registration

See [initialization guard](INITIALIZATION_GUARD.md) for repeated loads and compatibility with HP Manager.
