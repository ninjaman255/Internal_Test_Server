# 📄 `loot.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/loot.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/loot.lua)  
> **Source lines:** 363  
> **SHA-256 (UTF-8):** `817b445bf2a2440b52955dc943b6e9413798685d54dadb5a53b291195935d1ad`  
> **Named functions detected:** 16  
> **Table initializers detected:** 20

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
| 2 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy` |

## Event hooks

No static literal subscriptions detected.

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 7 | `show_reward_message` | `player, message, on_acknowledged` | local |
| 24 | `activate` | `instance, player_session` | assigned/declared |
| 33 | `activate` | `instance, player_session` | assigned/declared |
| 40 | `activate` | `instance, player_session` | assigned/declared |
| 49 | `activate` | `instance, player_session` | assigned/declared |
| 56 | `activate` | `instance, player_session` | assigned/declared |
| 68 | `activate` | `instance, player_session` | assigned/declared |
| 79 | `activate` | `instance, player_session` | assigned/declared |
| 95 | `activate` | `instance, player_session` | assigned/declared |
| 109 | `unlock_gates` | `(none)` | local |
| 186 | `spawn_item_bot` | `bot_data, property_animation` | local |
| 209 | `cleanup` | `(none)` | local |
| 217 | `Loot.spawn_item_bot` | `item, area_id, x, y, z` | assigned/declared |
| 246 | `Loot.spawn_randomized_item_bot` | `loot_pool, item_index, area_id, x, y, z` | assigned/declared |
| 296 | `Loot.loot_item_panel` | `instance, player_session, panel, destroy_items` | assigned/declared |
| 335 | `Loot.loot_bonus_panel` | `instance, player_session, panel` | assigned/declared |

### Parameter inventory

#### 1. `show_reward_message(player, message, on_acknowledged)`

- **Line:** 7
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player` | Declared directly in the current Lua. Type not inferred. |
| 2 | `message` | Declared directly in the current Lua. Type not inferred. |
| 3 | `on_acknowledged` | Declared directly in the current Lua. Type not inferred. |

#### 2. `activate(instance, player_session)`

- **Line:** 24
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 3. `activate(instance, player_session)`

- **Line:** 33
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 4. `activate(instance, player_session)`

- **Line:** 40
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 5. `activate(instance, player_session)`

- **Line:** 49
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 6. `activate(instance, player_session)`

- **Line:** 56
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 7. `activate(instance, player_session)`

- **Line:** 68
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 8. `activate(instance, player_session)`

- **Line:** 79
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 9. `activate(instance, player_session)`

- **Line:** 95
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 10. `unlock_gates()`

- **Line:** 109
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 11. `spawn_item_bot(bot_data, property_animation)`

- **Line:** 186
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_data` | Declared directly in the current Lua. Type not inferred. |
| 2 | `property_animation` | Declared directly in the current Lua. Type not inferred. |

#### 12. `cleanup()`

- **Line:** 209
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 13. `Loot.spawn_item_bot(item, area_id, x, y, z)`

- **Line:** 217
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `item` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 14. `Loot.spawn_randomized_item_bot(loot_pool, item_index, area_id, x, y, z)`

- **Line:** 246
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `loot_pool` | Declared directly in the current Lua. Type not inferred. |
| 2 | `item_index` | Declared directly in the current Lua. Type not inferred. |
| 3 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `x` | Declared directly in the current Lua. Type not inferred. |
| 5 | `y` | Declared directly in the current Lua. Type not inferred. |
| 6 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 15. `Loot.loot_item_panel(instance, player_session, panel, destroy_items)`

- **Line:** 296
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |
| 3 | `panel` | Declared directly in the current Lua. Type not inferred. |
| 4 | `destroy_items` | Declared directly in the current Lua. Type not inferred. |

#### 16. `Loot.loot_bonus_panel(instance, player_session, panel)`

- **Line:** 335
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |
| 3 | `panel` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 20 | `Loot` |
| 21 | `HEART` |
| 30 | `CHIP` |
| 37 | `MONEY` |
| 46 | `BUGFRAG` |
| 53 | `ORDER_POINT` |
| 65 | `INVINCIBILITY` |
| 76 | `MAJOR_HIT` |
| 92 | `KEY` |
| 151 | `Loot.DEFAULT_POOL` |
| 157 | `Loot.BONUS_POOL` |
| 165 | `Loot.TEST_POOL` |
| 173 | `Loot.FULL_POOL` |
| 218 | `bot_data` |
| 229 | `property_animation` |
| 231 | `properties` |
| 253 | `bot_data` |
| 264 | `property_animation` |
| 271 | `key_frame` |
| 272 | `properties` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.animate_bot_properties` | 1 | 207 |
| `Net.create_bot` | 2 | 187 |
| `Net.move_player_camera` | 2 | 130 |
| `Net.remove_bot` | 3 | 203 |
| `Net.slide_player_camera` | 3 | 129 |
