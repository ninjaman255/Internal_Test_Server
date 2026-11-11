# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/avatar_utils/main.lua`](../../../../ezlibs-scripts/avatar_utils/main.lua)  
> **Source lines:** 204  
> **SHA-256 (UTF-8):** `309cebe2c2b3cfae32bfb6de74d1317842279e11d20419350268754d47de9d13`  
> **Named/assigned functions detected:** 9  
> **Table initializers detected:** 8

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/avatar_utils/main.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 6 | `scripts/logger/logger` |
| 7 | `scripts/ezlibs-scripts/avatar_utils/avatar_utils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 87 | `Net` | `player_avatar_change` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 22 | `get_player_secret` | `player_id` | local |
| 29 | `resolve_secret` | `input` | local |
| 43 | `update_player_avatar` | `player_id` | local |
| 99 | `get_player_avatar_paths` | `input` | local |
| 111 | `refresh_player_avatar` | `player_id` | local |
| 120 | `parse_player_animation` | `input, type` | local |
| 149 | `register_bot_avatar` | `bot_id, sheet_texture_path, sheet_animation_path, mug_texture_path, mug_animation_path` | local |
| 167 | `get_bot_avatar_paths` | `bot_id` | local |
| 175 | `parse_bot_animation` | `bot_id, type` | local |

### Detailed parameter inventory

#### 1. `get_player_secret(player_id)`

- **Line:** 22
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 2. `resolve_secret(input)`

- **Line:** 29
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `input` | Declared in this function; type not inferred. |

#### 3. `update_player_avatar(player_id)`

- **Line:** 43
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 4. `get_player_avatar_paths(input)`

- **Line:** 99
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `input` | Declared in this function; type not inferred. |

#### 5. `refresh_player_avatar(player_id)`

- **Line:** 111
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 6. `parse_player_animation(input, type)`

- **Line:** 120
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `input` | Declared in this function; type not inferred. |
| 2 | `type` | Declared in this function; type not inferred. |

#### 7. `register_bot_avatar(bot_id, sheet_texture_path, sheet_animation_path, mug_texture_path, mug_animation_path)`

- **Line:** 149
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `sheet_texture_path` | Declared in this function; type not inferred. |
| 3 | `sheet_animation_path` | Declared in this function; type not inferred. |
| 4 | `mug_texture_path` | Declared in this function; type not inferred. |
| 5 | `mug_animation_path` | Declared in this function; type not inferred. |

#### 8. `get_bot_avatar_paths(bot_id)`

- **Line:** 167
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |

#### 9. `parse_bot_animation(bot_id, type)`

- **Line:** 175
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `type` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 13 | `player_cache` |
| 20 | `bot_cache` |
| 71 | `entry` |
| 72 | `sheet` |
| 76 | `mug` |
| 150 | `entry` |
| 151 | `sheet` |
| 155 | `mug` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_secret` | 1 | 23 |
| `Net.on` | 1 | 87 |
