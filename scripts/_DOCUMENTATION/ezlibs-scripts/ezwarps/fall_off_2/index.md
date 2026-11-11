# 📄 `fall_off_2.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/fall_off_2.lua`](../../../../ezlibs-scripts/ezwarps/fall_off_2.lua)  
> **Source lines:** 44  
> **SHA-256 (UTF-8):** `a9c3b796a0d303a7947bad8ff4833f601ec181cdcafc7ed9d1f11ba0358f4c38`  
> **Named functions detected:** 1  
> **Table initializers detected:** 5

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
| 9 | `animate` | `player_id,warp_object` | assigned/declared |

### Parameter inventory

#### 1. `animate(player_id,warp_object)`

- **Line:** 9
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `warp_object` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 2 | `fall_off_2` |
| 4 | `pre_animation_offsets` |
| 19 | `keyframes` |
| 20 | `properties` |
| 27 | `properties` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.animate_player_properties` | 1 | 34 |
| `Net.get_player_area` | 1 | 12 |
| `Net.get_player_position` | 1 | 11 |
| `Net.play_sound` | 1 | 37 |
| `Net.shake_player_camera` | 1 | 38 |
