# 📄 `log_in_animation.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/log_in_animation.lua`](../../../../ezlibs-scripts/ezwarps/log_in_animation.lua)  
> **Source lines:** 81  
> **SHA-256 (UTF-8):** `5ec9bf0cd188dfc0f20013b48ca4f3ee7eb049c77b48ea7c695d155cfd43ef1b`  
> **Named/assigned functions detected:** 2  
> **Table initializers detected:** 5

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezwarps/log_in_animation.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 2 | `create_jack_in_out_animation` | `is_arriving` | assigned/declared |
| 10 | `animate` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `create_jack_in_out_animation(is_arriving)`

- **Line:** 2
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `is_arriving` | Declared in this function; type not inferred. |

#### 2. `animate(player_id)`

- **Line:** 10
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 3 | `log_in_animation` |
| 5 | `pre_animation_offsets` |
| 37 | `player_keyframes` |
| 38 | `properties` |
| 48 | `properties` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.animate_bot` | 2 | 28 |
| `Net.animate_player_properties` | 1 | 60 |
| `Net.create_bot` | 1 | 18 |
| `Net.exclude_actor_for_player` | 1 | 68 |
| `Net.get_player_area` | 1 | 13 |
| `Net.get_player_position` | 1 | 12 |
| `Net.include_actor_for_player` | 1 | 66 |
| `Net.list_players` | 1 | 63 |
| `Net.play_sound` | 2 | 29 |
| `Net.provide_asset` | 2 | 14 |
| `Net.remove_bot` | 1 | 73 |
| `Net.unlock_player_camera` | 1 | 72 |
