# 📄 `ezexplosions.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezexplosions.lua`](../../../ezlibs-scripts/ezexplosions.lua)  
> **Source lines:** 329  
> **SHA-256 (UTF-8):** `6cb7f15a7e3defda17693baa9dbbf829bfe49d3087c7d62073513e2f14d65495`  
> **Named/assigned functions detected:** 12  
> **Table initializers detected:** 6

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezexplosions.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/ezlibs-scripts/ezbus` |
| 2 | `scripts/logger/logger` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 320 | `ezbus` | `explode` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 21 | `async` | `fn` | local |
| 26 | `await` | `value` | local |
| 34 | `update_tracked_position` | `exploding_effect` | local |
| 73 | `finish_effect` | `self, reason` | local |
| 88 | `remove_explosion_bot` | `self, bot_id, reason` | local |
| 111 | `remove_all_active_bots` | `self, reason` | local |
| 121 | `explode` | `self, explosion_bot_id` | local |
| 193 | `spawn` | `self` | local |
| 242 | `ExplodingEffect:new` | `actor_id, opt_area_id, max_explosions, on_complete` | assigned/declared |
| 268 | `ExplodingEffect:remove` | `(none)` | assigned/declared |
| 286 | `ezexplosions.explode` | `actor_id, area_id, max_explosions, on_complete` | assigned/declared |
| 293 | `ezexplosions.explode_and_wait` | `actor_id, area_id, max_explosions, timeout_seconds` | assigned/declared |

### Detailed parameter inventory

#### 1. `async(fn)`

- **Line:** 21
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared in this function; type not inferred. |

#### 2. `await(value)`

- **Line:** 26
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 3. `update_tracked_position(exploding_effect)`

- **Line:** 34
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `exploding_effect` | Declared in this function; type not inferred. |

#### 4. `finish_effect(self, reason)`

- **Line:** 73
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 5. `remove_explosion_bot(self, bot_id, reason)`

- **Line:** 88
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |
| 2 | `bot_id` | Declared in this function; type not inferred. |
| 3 | `reason` | Declared in this function; type not inferred. |

#### 6. `remove_all_active_bots(self, reason)`

- **Line:** 111
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 7. `explode(self, explosion_bot_id)`

- **Line:** 121
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |
| 2 | `explosion_bot_id` | Declared in this function; type not inferred. |

#### 8. `spawn(self)`

- **Line:** 193
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |

#### 9. `ExplodingEffect:new(actor_id, opt_area_id, max_explosions, on_complete)`

- **Line:** 242
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actor_id` | Declared in this function; type not inferred. |
| 2 | `opt_area_id` | Declared in this function; type not inferred. |
| 3 | `max_explosions` | Declared in this function; type not inferred. |
| 4 | `on_complete` | Declared in this function; type not inferred. |

#### 10. `ExplodingEffect:remove()`

- **Line:** 268
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 11. `ezexplosions.explode(actor_id, area_id, max_explosions, on_complete)`

- **Line:** 286
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actor_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `max_explosions` | Declared in this function; type not inferred. |
| 4 | `on_complete` | Declared in this function; type not inferred. |

#### 12. `ezexplosions.explode_and_wait(actor_id, area_id, max_explosions, timeout_seconds)`

- **Line:** 293
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actor_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `max_explosions` | Declared in this function; type not inferred. |
| 4 | `timeout_seconds` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 59 | `position` |
| 112 | `to_remove` |
| 240 | `ExplodingEffect` |
| 243 | `exploding_effect` |
| 253 | `_active_bot_ids` |
| 284 | `ezexplosions` |

## Net API calls

No direct `Net.method(...)` call expression matched.
