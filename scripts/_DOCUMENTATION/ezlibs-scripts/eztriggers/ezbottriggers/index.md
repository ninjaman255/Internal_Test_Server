# 📄 `ezbottriggers.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/eztriggers/ezbottriggers.lua`](../../../../ezlibs-scripts/eztriggers/ezbottriggers.lua)  
> **Source lines:** 292  
> **SHA-256 (UTF-8):** `a2ce8db5b5762ec195af47e78f88c48bc0989de4b45b8fcb1ace56a0f4bba8bc`  
> **Named/assigned functions detected:** 9  
> **Table initializers detected:** 7

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/eztriggers/ezbottriggers.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 19 | `scripts/logger/logger` |
| 20 | `scripts/ezlibs-scripts/ezbus` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 276 | `ezbus` | `bot_created` |
| 281 | `ezbus` | `bot_moved` |
| 286 | `ezbus` | `bot_removed` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 29 | `resolve_trigger_key` | `trigger_object, trigger_id` | local |
| 35 | `ezbottriggers.add_radius_trigger` | `area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id` | assigned/declared |
| 86 | `ezbottriggers.add_rectangle_trigger` | `area_id, trigger_object, width, height, trigger_id` | assigned/declared |
| 135 | `set_bot_overlap` | `trigger_info, bot_id, is_inside, reason, x, y, z` | local |
| 166 | `ezbottriggers.handle_bot_move` | `bot_id, x, y, z, area_id` | assigned/declared |
| 238 | `ezbottriggers.clear_radius_overlaps_for_bot` | `bot_id, reason` | assigned/declared |
| 246 | `ezbottriggers.clear_rectangle_overlaps_for_bot` | `bot_id, reason` | assigned/declared |
| 254 | `ezbottriggers.handle_bot_created` | `bot_id, area_id, x, y, z` | assigned/declared |
| 269 | `ezbottriggers.handle_bot_removed` | `bot_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `resolve_trigger_key(trigger_object, trigger_id)`

- **Line:** 29
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `trigger_object` | Declared in this function; type not inferred. |
| 2 | `trigger_id` | Declared in this function; type not inferred. |

#### 2. `ezbottriggers.add_radius_trigger(area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id)`

- **Line:** 35
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `trigger_object` | Declared in this function; type not inferred. |
| 3 | `diameter_x` | Declared in this function; type not inferred. |
| 4 | `diameter_y` | Declared in this function; type not inferred. |
| 5 | `center_x` | Declared in this function; type not inferred. |
| 6 | `center_y` | Declared in this function; type not inferred. |
| 7 | `trigger_id` | Declared in this function; type not inferred. |

#### 3. `ezbottriggers.add_rectangle_trigger(area_id, trigger_object, width, height, trigger_id)`

- **Line:** 86
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `trigger_object` | Declared in this function; type not inferred. |
| 3 | `width` | Declared in this function; type not inferred. |
| 4 | `height` | Declared in this function; type not inferred. |
| 5 | `trigger_id` | Declared in this function; type not inferred. |

#### 4. `set_bot_overlap(trigger_info, bot_id, is_inside, reason, x, y, z)`

- **Line:** 135
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `trigger_info` | Declared in this function; type not inferred. |
| 2 | `bot_id` | Declared in this function; type not inferred. |
| 3 | `is_inside` | Declared in this function; type not inferred. |
| 4 | `reason` | Declared in this function; type not inferred. |
| 5 | `x` | Declared in this function; type not inferred. |
| 6 | `y` | Declared in this function; type not inferred. |
| 7 | `z` | Declared in this function; type not inferred. |

#### 5. `ezbottriggers.handle_bot_move(bot_id, x, y, z, area_id)`

- **Line:** 166
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |
| 5 | `area_id` | Declared in this function; type not inferred. |

#### 6. `ezbottriggers.clear_radius_overlaps_for_bot(bot_id, reason)`

- **Line:** 238
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 7. `ezbottriggers.clear_rectangle_overlaps_for_bot(bot_id, reason)`

- **Line:** 246
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 8. `ezbottriggers.handle_bot_created(bot_id, area_id, x, y, z)`

- **Line:** 254
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `x` | Declared in this function; type not inferred. |
| 4 | `y` | Declared in this function; type not inferred. |
| 5 | `z` | Declared in this function; type not inferred. |

#### 9. `ezbottriggers.handle_bot_removed(bot_id)`

- **Line:** 269
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 22 | `ezbottriggers` |
| 26 | `ezbottriggers.radius_triggers` |
| 27 | `ezbottriggers.rectangle_triggers` |
| 64 | `trigger_info` |
| 68 | `overlapping_bots` |
| 113 | `trigger_info` |
| 117 | `overlapping_bots` |

## Net API calls

No direct `Net.method(...)` call expression matched.
