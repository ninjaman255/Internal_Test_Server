# 📄 `ezquests.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezquests.lua`](../../../ezlibs-scripts/ezquests.lua)  
> **Source lines:** 122  
> **SHA-256 (UTF-8):** `2c261333115cfaa94d780ad7d2e043b7d5942bc10e39b603ac9f162c79ca16d3`  
> **Named/assigned functions detected:** 9  
> **Table initializers detected:** 3

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezquests.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/ezmemory` |
| 3 | `scripts/ezlibs-scripts/helpers` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 9 | `ezquests.add_quest` | `quest` | assigned/declared |
| 28 | `ezquests.set_player_quest_flag` | `player_id,quest_name,flag_name,flag_state` | assigned/declared |
| 42 | `ezquests.get_player_quest_flag` | `player_id,quest_name,flag_name,flag_state` | assigned/declared |
| 54 | `ezquests.clear_player_quest_flags` | `player_id,quest_name` | assigned/declared |
| 65 | `ezquests.get_quest` | `quest_name` | assigned/declared |
| 74 | `ezquests.get_player_quest_state` | `player_id, quest_name` | assigned/declared |
| 83 | `ezquests.quest_event` | `player_id,quest_name,event_value` | assigned/declared |
| 98 | `handle_event_async` | `self,player_id,event_value` | assigned/declared |
| 110 | `determine_state` | `self,player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `ezquests.add_quest(quest)`

- **Line:** 9
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `quest` | Declared in this function; type not inferred. |

#### 2. `ezquests.set_player_quest_flag(player_id,quest_name,flag_name,flag_state)`

- **Line:** 28
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `quest_name` | Declared in this function; type not inferred. |
| 3 | `flag_name` | Declared in this function; type not inferred. |
| 4 | `flag_state` | Declared in this function; type not inferred. |

#### 3. `ezquests.get_player_quest_flag(player_id,quest_name,flag_name,flag_state)`

- **Line:** 42
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `quest_name` | Declared in this function; type not inferred. |
| 3 | `flag_name` | Declared in this function; type not inferred. |
| 4 | `flag_state` | Declared in this function; type not inferred. |

#### 4. `ezquests.clear_player_quest_flags(player_id,quest_name)`

- **Line:** 54
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `quest_name` | Declared in this function; type not inferred. |

#### 5. `ezquests.get_quest(quest_name)`

- **Line:** 65
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `quest_name` | Declared in this function; type not inferred. |

#### 6. `ezquests.get_player_quest_state(player_id, quest_name)`

- **Line:** 74
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `quest_name` | Declared in this function; type not inferred. |

#### 7. `ezquests.quest_event(player_id,quest_name,event_value)`

- **Line:** 83
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `quest_name` | Declared in this function; type not inferred. |
| 3 | `event_value` | Declared in this function; type not inferred. |

#### 8. `handle_event_async(self,player_id,event_value)`

- **Line:** 98
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `event_value` | Declared in this function; type not inferred. |

#### 9. `determine_state(self,player_id)`

- **Line:** 110
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 5 | `ezquests` |
| 6 | `quests` |
| 96 | `quest_get_punched` |

## Net API calls

No direct `Net.method(...)` call expression matched.
