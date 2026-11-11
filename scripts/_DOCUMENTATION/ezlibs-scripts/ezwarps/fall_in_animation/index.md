# 📄 `fall_in_animation.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/fall_in_animation.lua`](../../../../ezlibs-scripts/ezwarps/fall_in_animation.lua)  
> **Source lines:** 40  
> **SHA-256 (UTF-8):** `bf701bc598d779d44606cc5494f38b3778391fb12bcd9eab1e04a624696fbf67`  
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
| 2 | `fall_in_animation` |
| 4 | `pre_animation_offsets` |
| 15 | `keyframes` |
| 16 | `properties` |
| 23 | `properties` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.animate_player_properties` | 1 | 30 |
| `Net.get_player_area` | 1 | 12 |
| `Net.get_player_position` | 1 | 11 |
| `Net.play_sound` | 1 | 33 |
| `Net.shake_player_camera` | 1 | 34 |
