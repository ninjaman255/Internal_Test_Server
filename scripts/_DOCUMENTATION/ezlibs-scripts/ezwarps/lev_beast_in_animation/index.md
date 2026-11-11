# 📄 `lev_beast_in_animation.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`](../../../../ezlibs-scripts/ezwarps/lev_beast_in_animation.lua)  
> **Source lines:** 118  
> **SHA-256 (UTF-8):** `03ea6d3c1840958637074a3e0c2d6c47998a7eaf8a9cfc5cb5771beeefc7b424`  
> **Named functions detected:** 1  
> **Table initializers detected:** 10

> **Static reference:** Function signatures, dependency paths, and event names are extracted from current Lua. The listing does not establish runtime reachability or public API exposure. See the authored guide for semantics.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

| Line | `require` path |
|---:|---|
| 1 | `scripts/player-control/main` |

## Event hooks

No static literal subscriptions detected.

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 9 | `animate` | `player_id` | assigned/declared |

### Parameter inventory

#### 1. `animate(player_id)`

- **Line:** 9
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 2 | `lev_beast_in_animation` |
| 4 | `pre_animation_offsets` |
| 29 | `player_keyframes` |
| 30 | `properties` |
| 40 | `properties` |
| 52 | `beast_keyframes` |
| 53 | `properties` |
| 63 | `properties` |
| 75 | `properties` |
| 85 | `properties` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.animate_bot_properties` | 1 | 99 |
| `Net.animate_player` | 1 | 97 |
| `Net.animate_player_properties` | 1 | 98 |
| `Net.create_bot` | 1 | 15 |
| `Net.get_player_area` | 1 | 12 |
| `Net.get_player_position` | 1 | 11 |
| `Net.play_sound` | 3 | 102 |
| `Net.remove_bot` | 1 | 113 |
| `Net.shake_player_camera` | 2 | 96 |
