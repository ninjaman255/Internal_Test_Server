# 📄 `dialogue_types.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/eznpcs/dialogue_types.lua`](../../../../ezlibs-scripts/eznpcs/dialogue_types.lua)  
> **Source lines:** 652  
> **SHA-256 (UTF-8):** `4e7833f214ee44caf1fa655f3362b4fa2ab2d3d8c081ef4d504e94625a4810f5`  
> **Named functions detected:** 22  
> **Table initializers detected:** 21

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

## Functions and parameters

| Line | Function | Arguments | Declaration |
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

### Parameter inventory

#### 1. `now()`

- **Line:** 40
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 2. `player_won_from_stats(stats)`

- **Line:** 71
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `stats` | Declared directly in the current Lua. Type not inferred. |

#### 3. `merge_result_fields(stats, exit_results)`

- **Line:** 104
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `stats` | Declared directly in the current Lua. Type not inferred. |
| 2 | `exit_results` | Declared directly in the current Lua. Type not inferred. |

#### 4. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 117
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 5. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 130
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 6. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 143
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 7. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 156
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 8. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 170
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 9. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 201
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 10. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 220
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 11. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 238
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 12. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 256
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 13. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 285
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 14. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 299
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 15. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 313
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 16. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 330
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 17. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 344
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 18. `has_asset(path)`

- **Line:** 351
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared directly in the current Lua. Type not inferred. |

#### 19. `ensure_ext(p, ext)`

- **Line:** 360
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared directly in the current Lua. Type not inferred. |
| 2 | `ext` | Declared directly in the current Lua. Type not inferred. |

#### 20. `resolve_texture(raw)`

- **Line:** 366
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw` | Declared directly in the current Lua. Type not inferred. |

#### 21. `resolve_anim(raw)`

- **Line:** 376
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw` | Declared directly in the current Lua. Type not inferred. |

#### 22. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 460
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
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

| API | Count | First line |
|---|---:|---:|
| `Net.get_player_area` | 4 | 172 |
| `Net.is_player` | 4 | 562 |
| `Net.is_player_battling` | 2 | 640 |
| `Net.on` | 2 | 33 |
