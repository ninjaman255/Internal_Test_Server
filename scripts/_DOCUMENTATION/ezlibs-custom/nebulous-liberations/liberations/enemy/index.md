# 📄 `enemy.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/enemy.lua)  
> **Source lines:** 191  
> **SHA-256 (UTF-8):** `7ee4bca6aca5444a83645eca50079f62448dfd1283d9d69374826b17dc545090`  
> **Named/assigned functions detected:** 4  
> **Table initializers detected:** 3

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 3 | `scripts/logger/logger` |
| 6 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates` |
| 7 | `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect` |
| 8 | `scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 12 | `apply_bot_scale_after_spawn` | `enemy, requested_scale` | local |
| 97 | `Enemy.from` | `instance, position, direction, name, spawn_options` | assigned/declared |
| 113 | `Enemy.is_alive` | `enemy` | assigned/declared |
| 127 | `Enemy.destroy` | `instance, enemy` | assigned/declared |

### Detailed parameter inventory

#### 1. `apply_bot_scale_after_spawn(enemy, requested_scale)`

- **Line:** 12
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `enemy` | Declared in this function; type not inferred. |
| 2 | `requested_scale` | Declared in this function; type not inferred. |

#### 2. `Enemy.from(instance, position, direction, name, spawn_options)`

- **Line:** 97
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `position` | Declared in this function; type not inferred. |
| 3 | `direction` | Declared in this function; type not inferred. |
| 4 | `name` | Declared in this function; type not inferred. |
| 5 | `spawn_options` | Declared in this function; type not inferred. |

#### 3. `Enemy.is_alive(enemy)`

- **Line:** 113
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `enemy` | Declared in this function; type not inferred. |

#### 4. `Enemy.destroy(instance, enemy)`

- **Line:** 127
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `enemy` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 10 | `Enemy` |
| 40 | `keyframes` |
| 41 | `properties` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.move_player_camera` | 1 | 163 |
| `Net.remove_bot` | 1 | 177 |
| `Net.set_bot_name` | 1 | 102 |
| `Net.slide_player_camera` | 2 | 162 |
| `Net.unlock_player_camera` | 1 | 165 |
