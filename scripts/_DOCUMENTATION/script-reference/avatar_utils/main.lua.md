# `avatar_utils/main.lua`

> **Source reference**
>
> Refreshed from the current `avatar_utils/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

NaviSpot.lua Module to cache player and bot avatar/mugshot assets. For players: copies assets from engine to local files on avatar change. For bots: registers existing local asset paths (no copying).

## Module location

- **Source:** `avatar_utils/main.lua`
- **Reference:** `script-reference/avatar_utils/main.lua.md`
- **Source SHA-256 prefix:** `68f89af462e5`

## Source header notes

- NaviSpot.lua
- Module to cache player and bot avatar/mugshot assets.
- For players: copies assets from engine to local files on avatar change.
- For bots: registers existing local asset paths (no copying).

## Direct `require` dependencies

| Import path |
|---|
| `scripts/avatar_utils/avatar_utils` |

## `Net:on` subscriptions

| Event |
|---|
| `player_avatar_change` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `get_player_secret` | `player_id` |
| `update_player_avatar` | `player_id` |
| `get_player_avatar_paths` | `secret` |
| `refresh_player_avatar` | `player_id` |
| `register_bot_avatar` | `bot_id, sheet_texture_path, sheet_animation_path, mug_texture_path, mug_animation_path` |
| `get_bot_avatar_paths` | `bot_id` |
| `parse_bot_animation` | `bot_id, type` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_secret`, `on`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `assets/avatars/sheet/` |
| `assets/avatars/mug/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
