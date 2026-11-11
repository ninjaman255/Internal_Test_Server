# 📄 `main.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/avatar_utils/main.lua`](../../../avatar_utils/main.lua)  
> **Source lines:** 158  
> **SHA-256 (UTF-8):** `68f89af462e5afc52d321499ed9911847778d567415b8a188874940f78a87cda`  
> **Named/assigned functions detected:** 7  
> **Table initializers detected (simple pattern):** 8

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/avatar_utils/main.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 6 | `scripts/avatar_utils/avatar_utils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 72 | `Net` | `player_avatar_change` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 21 | `get_player_secret` | `player_id` | local |
| 28 | `update_player_avatar` | `player_id` | local |
| 83 | `get_player_avatar_paths` | `secret` | local |
| 90 | `refresh_player_avatar` | `player_id` | local |
| 104 | `register_bot_avatar` | `bot_id, sheet_texture_path, sheet_animation_path, mug_texture_path, mug_animation_path` | local |
| 122 | `get_bot_avatar_paths` | `bot_id` | local |
| 130 | `parse_bot_animation` | `bot_id, type` | local |

### Detailed parameter inventory

#### 1. `get_player_secret(player_id)`

- **Line:** 21
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 2. `update_player_avatar(player_id)`

- **Line:** 28
- **Declaration:** local
- **Nearby code comment:** Copies the player's current avatar and mugshot to local files and registers them as assets. @param player_id string @return table\|nil cached entry or nil on failure

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 3. `get_player_avatar_paths(secret)`

- **Line:** 83
- **Declaration:** local
- **Nearby code comment:** Public API: retrieve cached player avatar paths for a given player secret. @param secret string the player's secret (from Net.get_player_secret) @return table\|nil the cached sheet/mug paths or nil if not yet cached

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `secret` | Declared by this function; type not inferred. |

#### 4. `refresh_player_avatar(player_id)`

- **Line:** 90
- **Declaration:** local
- **Nearby code comment:** Public API: force an immediate refresh for a player ID (useful if you need the data right away). @param player_id string @return table\|nil the updated cached entry

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 5. `register_bot_avatar(bot_id, sheet_texture_path, sheet_animation_path, mug_texture_path, mug_animation_path)`

- **Line:** 104
- **Declaration:** local
- **Nearby code comment:** @param sheet_animation_path string Path to the bot's sheet animation file @param mug_texture_path string Path to the bot's mugshot texture @param mug_animation_path string Path to the bot's mugshot animation file @return table the stored entry

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared by this function; type not inferred. |
| 2 | `sheet_texture_path` | Declared by this function; type not inferred. |
| 3 | `sheet_animation_path` | Declared by this function; type not inferred. |
| 4 | `mug_texture_path` | Declared by this function; type not inferred. |
| 5 | `mug_animation_path` | Declared by this function; type not inferred. |

#### 6. `get_bot_avatar_paths(bot_id)`

- **Line:** 122
- **Declaration:** local
- **Nearby code comment:** Retrieve cached bot avatar paths. @param bot_id string @return table\|nil the cached sheet/mug paths or nil if not registered

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared by this function; type not inferred. |

#### 7. `parse_bot_animation(bot_id, type)`

- **Line:** 130
- **Declaration:** local
- **Nearby code comment:** Optionally parse a bot's animation file to get frame data. @param bot_id string @param type string "sheet" or "mug" to specify which animation to parse @return table\|nil parsed animation structure or nil if missing/error

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared by this function; type not inferred. |
| 2 | `type` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 12 | `player_cache` |
| 19 | `bot_cache` |
| 56 | `entry` |
| 57 | `sheet` |
| 61 | `mug` |
| 105 | `entry` |
| 106 | `sheet` |
| 110 | `mug` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_secret` | 1 | 22 |
| `Net.on` | 1 | 72 |
