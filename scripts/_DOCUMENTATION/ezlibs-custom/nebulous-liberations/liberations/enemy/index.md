# 📄 `enemy.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/enemy.lua)  
> **Source lines:** 191  
> **SHA-256 (UTF-8):** `37c04849b235f196873822df4d149534b782c544537895f5aa227d3e3ca1206b`  
> **Named functions detected:** 4  
> **Table initializers detected:** 3

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
| 3 | `scripts/logger/logger` |
| 6 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates` |
| 7 | `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect` |
| 8 | `scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators` |

## Event hooks

No static literal subscriptions detected.

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 12 | `apply_bot_scale_after_spawn` | `enemy, requested_scale` | local |
| 97 | `Enemy.from` | `instance, position, direction, name, spawn_options` | assigned/declared |
| 113 | `Enemy.is_alive` | `enemy` | assigned/declared |
| 127 | `Enemy.destroy` | `instance, enemy` | assigned/declared |

### Parameter inventory

#### 1. `apply_bot_scale_after_spawn(enemy, requested_scale)`

- **Line:** 12
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `enemy` | Declared directly in the current Lua. Type not inferred. |
| 2 | `requested_scale` | Declared directly in the current Lua. Type not inferred. |

#### 2. `Enemy.from(instance, position, direction, name, spawn_options)`

- **Line:** 97
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `position` | Declared directly in the current Lua. Type not inferred. |
| 3 | `direction` | Declared directly in the current Lua. Type not inferred. |
| 4 | `name` | Declared directly in the current Lua. Type not inferred. |
| 5 | `spawn_options` | Declared directly in the current Lua. Type not inferred. |

#### 3. `Enemy.is_alive(enemy)`

- **Line:** 113
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `enemy` | Declared directly in the current Lua. Type not inferred. |

#### 4. `Enemy.destroy(instance, enemy)`

- **Line:** 127
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `enemy` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 10 | `Enemy` |
| 40 | `keyframes` |
| 41 | `properties` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.move_player_camera` | 1 | 163 |
| `Net.remove_bot` | 1 | 177 |
| `Net.set_bot_name` | 1 | 102 |
| `Net.slide_player_camera` | 2 | 162 |
| `Net.unlock_player_camera` | 1 | 165 |
