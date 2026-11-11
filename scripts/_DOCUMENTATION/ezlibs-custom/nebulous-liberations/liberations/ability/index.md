# 📄 `ability.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/ability.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/ability.lua)  
> **Source lines:** 196  
> **SHA-256 (UTF-8):** `28061cae67949c5999162aa30eb1f99323ec580a57cd9c36e1ed9794f177fcce`  
> **Named/assigned functions detected:** 7  
> **Table initializers detected:** 13

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/liberations/ability.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 2 | `scripts/logger/logger` |
| 5 | `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters` |
| 6 | `scripts/ezlibs-scripts/helpers` |
| 7 | `scripts/ezlibs-scripts/ezmemory` |
| 8 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 10 | `static_shape_generator` | `offset_x, offset_y, shape` | local |
| 14 | `liberate_and_loot` | `instance, player_session, results, remove_traps, destroy_items` | local |
| 21 | `panel_search` | `instance, player_session, results, remove_traps, destroy_items` | local |
| 28 | `initiate_encounter` | `instance, player_session` | local |
| 75 | `battle_to_liberate_and_loot` | `instance, player_session, r, remove_traps, destroy_items` | local |
| 150 | `activate` | `instance, player_session` | assigned/declared |
| 185 | `Ability.resolve_for_player` | `player` | assigned/declared |

### Detailed parameter inventory

#### 1. `static_shape_generator(offset_x, offset_y, shape)`

- **Line:** 10
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `offset_x` | Declared in this function; type not inferred. |
| 2 | `offset_y` | Declared in this function; type not inferred. |
| 3 | `shape` | Declared in this function; type not inferred. |

#### 2. `liberate_and_loot(instance, player_session, results, remove_traps, destroy_items)`

- **Line:** 14
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player_session` | Declared in this function; type not inferred. |
| 3 | `results` | Declared in this function; type not inferred. |
| 4 | `remove_traps` | Declared in this function; type not inferred. |
| 5 | `destroy_items` | Declared in this function; type not inferred. |

#### 3. `panel_search(instance, player_session, results, remove_traps, destroy_items)`

- **Line:** 21
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player_session` | Declared in this function; type not inferred. |
| 3 | `results` | Declared in this function; type not inferred. |
| 4 | `remove_traps` | Declared in this function; type not inferred. |
| 5 | `destroy_items` | Declared in this function; type not inferred. |

#### 4. `initiate_encounter(instance, player_session)`

- **Line:** 28
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player_session` | Declared in this function; type not inferred. |

#### 5. `battle_to_liberate_and_loot(instance, player_session, r, remove_traps, destroy_items)`

- **Line:** 75
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player_session` | Declared in this function; type not inferred. |
| 3 | `r` | Declared in this function; type not inferred. |
| 4 | `remove_traps` | Declared in this function; type not inferred. |
| 5 | `destroy_items` | Declared in this function; type not inferred. |

#### 6. `activate(instance, player_session)`

- **Line:** 150
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player_session` | Declared in this function; type not inferred. |

#### 7. `Ability.resolve_for_player(player)`

- **Line:** 185
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 44 | `enemies` |
| 53 | `encounter_data` |
| 98 | `Ability` |
| 99 | `Guard` |
| 100 | `Shadowstep` |
| 101 | `LongSwrd` |
| 110 | `WideSwrd` |
| 119 | `GutsWave` |
| 128 | `ScrenDiv` |
| 143 | `PanelSearch` |
| 154 | `NumberSearch` |
| 163 | `HexSickle` |
| 174 | `navi_ability_map` |

## Net API calls

No direct `Net.method(...)` call expression matched.
