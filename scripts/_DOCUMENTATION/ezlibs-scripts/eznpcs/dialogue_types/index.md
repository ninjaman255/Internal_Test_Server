# 📄 `dialogue_types.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/eznpcs/dialogue_types.lua`](../../../../ezlibs-scripts/eznpcs/dialogue_types.lua)  
> **Source lines:** 652  
> **SHA-256 (UTF-8):** `103fa1deba1d48a5fa4c4c7c79c487de01cdc5fb5a1bc5c0282d659ae3bf83b2`  
> **Named/assigned functions detected:** 22  
> **Table initializers detected:** 21

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/eznpcs/dialogue_types.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 2 | `scripts/logger/logger` |
| 3 | `scripts/ezlibs-scripts/helpers` |
| 4 | `scripts/ezlibs-scripts/ezmemory` |
| 5 | `scripts/ezlibs-scripts/ezquests` |
| 6 | `scripts/ezlibs-scripts/ezemail` |
| 7 | `scripts/ezlibs-scripts/condition` |
| 8 | `scripts/ezlibs-scripts/ezbus` |
| 9 | `scripts/ezlibs-scripts/ezencounters/main` |
| 10 | `scripts/ezlibs-scripts/ezexplosions` |
| 11 | `scripts/ezlibs-scripts/utils/eztiledutils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 33 | `Net` | `tick` |
| 639 | `Net` | `battle_results` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 40 | `now` | `(none)` | local |
| 71 | `player_won_from_stats` | `stats` | local |
| 104 | `merge_result_fields` | `stats, exit_results` | local |
| 117 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 130 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 143 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 156 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 170 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 201 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 220 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 238 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 256 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 285 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 299 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 313 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 330 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 344 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 351 | `has_asset` | `path` | local |
| 360 | `ensure_ext` | `p, ext` | local |
| 366 | `resolve_texture` | `raw` | local |
| 376 | `resolve_anim` | `raw` | local |
| 460 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |

### Detailed parameter inventory

#### 1. `now()`

- **Line:** 40
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 2. `player_won_from_stats(stats)`

- **Line:** 71
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `stats` | Declared in this function; type not inferred. |

#### 3. `merge_result_fields(stats, exit_results)`

- **Line:** 104
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `stats` | Declared in this function; type not inferred. |
| 2 | `exit_results` | Declared in this function; type not inferred. |

#### 4. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 117
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 5. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 130
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 6. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 143
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 7. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 156
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 8. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 170
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 9. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 201
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 10. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 220
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 11. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 238
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 12. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 256
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 13. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 285
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 14. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 299
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 15. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 313
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 16. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 330
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 17. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 344
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |

#### 18. `has_asset(path)`

- **Line:** 351
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 19. `ensure_ext(p, ext)`

- **Line:** 360
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared in this function; type not inferred. |
| 2 | `ext` | Declared in this function; type not inferred. |

#### 20. `resolve_texture(raw)`

- **Line:** 366
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw` | Declared in this function; type not inferred. |

#### 21. `resolve_anim(raw)`

- **Line:** 376
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw` | Declared in this function; type not inferred. |

#### 22. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 460
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |
| 4 | `relay_object` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 99 | `RESULT_FIELDS` |
| 114 | `dialogue_types` |
| 115 | `first` |
| 128 | `question` |
| 141 | `quiz` |
| 154 | `random` |
| 168 | `itemcheck` |
| 199 | `questcheck` |
| 204 | `cond` |
| 218 | `before` |
| 236 | `after` |
| 254 | `shop` |
| 262 | `shop_items` |
| 267 | `shop_item` |
| 283 | `password` |
| 297 | `quest_switch` |
| 311 | `quest_event` |
| 328 | `item` |
| 342 | `email` |
| 427 | `mail` |
| 458 | `battle_npc` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_area` | 4 | 172 |
| `Net.is_player` | 4 | 562 |
| `Net.is_player_battling` | 2 | 640 |
| `Net.on` | 2 | 33 |
