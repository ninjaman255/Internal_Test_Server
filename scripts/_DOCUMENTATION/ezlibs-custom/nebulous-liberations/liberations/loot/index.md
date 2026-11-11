# 📄 `loot.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/loot.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/loot.lua)  
> **Source lines:** 363  
> **SHA-256 (UTF-8):** `7f0326d230d0f1…`  
> **Declared/assigned functions detected:** 16  
> **Anonymous closures detected:** 14  
> **Table initializers detected:** 20

## 🗂️ Contents

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/loot.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `show_reward_message` | `player, message, on_acknowledged` | local |
| 23 | `activate` | `instance, player_session` | assigned |
| 32 | `activate` | `instance, player_session` | assigned |
| 39 | `activate` | `instance, player_session` | assigned |
| 48 | `activate` | `instance, player_session` | assigned |
| 55 | `activate` | `instance, player_session` | assigned |
| 67 | `activate` | `instance, player_session` | assigned |
| 78 | `activate` | `instance, player_session` | assigned |
| 94 | `activate` | `instance, player_session` | assigned |
| 108 | `unlock_gates` | `(none)` | local |
| 188 | `spawn_item_bot` | `bot_data, property_animation` | local |
| 211 | `cleanup` | `(none)` | local |
| 219 | `Loot.spawn_item_bot` | `item, area_id, x, y, z` | declared |
| 248 | `Loot.spawn_randomized_item_bot` | `loot_pool, item_index, area_id, x, y, z` | declared |
| 298 | `Loot.loot_item_panel` | `instance, player_session, panel, destroy_items` | declared |
| 340 | `Loot.loot_bonus_panel` | `instance, player_session, panel` | declared |

### Function details

#### 1. `show_reward_message(player, message, on_acknowledged)`

- **Location:** source line 6.
- **Declaration style:** `local`.
- **Adjacent source comment:** Loot reward messages are part of the reward sequence. Awaiting the message promise keeps the revealed item visible until the player dismisses its textbox before the loot sequence continues.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |
| 3 | `on_acknowledged` | Not explicitly documented in adjacent source annotations. |

#### 2. `activate(instance, player_session)`

- **Location:** source line 23.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 3. `activate(instance, player_session)`

- **Location:** source line 32.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 4. `activate(instance, player_session)`

- **Location:** source line 39.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 5. `activate(instance, player_session)`

- **Location:** source line 48.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 6. `activate(instance, player_session)`

- **Location:** source line 55.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 7. `activate(instance, player_session)`

- **Location:** source line 67.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 8. `activate(instance, player_session)`

- **Location:** source line 78.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 9. `activate(instance, player_session)`

- **Location:** source line 94.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |

#### 10. `unlock_gates()`

- **Location:** source line 108.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 11. `spawn_item_bot(bot_data, property_animation)`

- **Location:** source line 188.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `bot_data` | Not explicitly documented in adjacent source annotations. |
| 2 | `property_animation` | Not explicitly documented in adjacent source annotations. |

#### 12. `cleanup()`

- **Location:** source line 211.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 13. `Loot.spawn_item_bot(item, area_id, x, y, z)`

- **Location:** source line 219.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `item` | Not explicitly documented in adjacent source annotations. |
| 2 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `z` | Not explicitly documented in adjacent source annotations. |

#### 14. `Loot.spawn_randomized_item_bot(loot_pool, item_index, area_id, x, y, z)`

- **Location:** source line 248.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `loot_pool` | Not explicitly documented in adjacent source annotations. |
| 2 | `item_index` | Not explicitly documented in adjacent source annotations. |
| 3 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `z` | Not explicitly documented in adjacent source annotations. |

#### 15. `Loot.loot_item_panel(instance, player_session, panel, destroy_items)`

- **Location:** source line 298.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |
| 3 | `panel` | Not explicitly documented in adjacent source annotations. |
| 4 | `destroy_items` | Not explicitly documented in adjacent source annotations. |

#### 16. `Loot.loot_bonus_panel(instance, player_session, panel)`

- **Location:** source line 340.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_session` | Not explicitly documented in adjacent source annotations. |
| 3 | `panel` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 7 | `(none)` | `l function show_reward_message(player, message, on_acknowledged) local co = coroutin…` |
| 24 | `(none)` | `, player_session) return show_reward_message(player_session.player, "I found\na hear…` |
| 40 | `(none)` | `ayer_session) return show_reward_message(player_session.player, "I found some\nMonie…` |
| 56 | `(none)` | `yer_session) return show_reward_message(player_session.player, "I found\nOrder Point…` |
| 68 | `(none)` | `return show_reward_message(player_session.player, "Team becomes invincible for\n 1 p…` |
| 79 | `(none)` | `e = false, activate = function(instance, player_session) local co = coroutine.create(` |
| 95 | `(none)` | `e = false, activate = function(instance, player_session) local co = coroutine.create(` |
| 206 | `(none)` | `ta) if id == nil then if shadow_id ~= nil then Net.remove_bot(shadow_id) end return` |
| 240 | `resolve` | `ue = z + 1 } }, duration = RISE_DURATION }, } return Async.create_promise(` |
| 242 | `(none)` | `cleanup = spawn_item_bot(bot_data, property_animation) Async.sleep(RISE_DURATION).an…` |
| 290 | `resolve` | `property_animation[#property_animation+1] = key_frame end return Async.create_promis…` |
| 292 | `(none)` | `leanup = spawn_item_bot(bot_data, property_animation) Async.sleep(total_duration).an…` |
| 321 | `(none)` | `oot local breakable = panel.loot.breakable panel.loot = nil local co = coroutine.cre…` |
| 347 | `(none)` | `al spawn_y = math.floor(panel.y) + .5 local spawn_z = panel.z local co = coroutine.c…` |

## 📦 Tables and data

The following **20** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Loot` — line 19

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `HEART` | nested table | `{ animation = "HEART", breakable = true, activate = function(instance, player_session) return show_reward_message(player_session.player, "I found\na heart…` |
| `CHIP` | nested table | `{ animation = "CHIP", breakable = true, activate = function(instance, player_session) return show_reward_message(player_session.player, "I found a\nBattle…` |
| `MONEY` | nested table | `{ animation = "MONEY", breakable = true, activate = function(instance, player_session) return show_reward_message(player_session.player, "I found some\nMo…` |
| `BUGFRAG` | nested table | `{ animation = "BUGFRAG", breakable = true, activate = function(instance, player_session) return show_reward_message(player_session.player, "I found a\nBug…` |
| `ORDER_POINT` | nested table | `{ animation = "ORDER_POINT", breakable = false, activate = function(instance, player_session) return show_reward_message(player_session.player, "I found\n…` |
| `INVINCIBILITY` | nested table | `{ animation = "INVINCIBILITY", breakable = false, activate = function(instance, player_session) return show_reward_message(player_session.player, "Team be…` |
| `MAJOR_HIT` | nested table | `{ animation = "MAJOR_HIT", breakable = false, activate = function(instance, player_session) local co = coroutine.create(function() Async.await(player_sess…` |
| `KEY` | nested table | `{ animation = "KEY", breakable = false, activate = function(instance, player_session) local co = coroutine.create(function() Async.await(player_session.pl…` |

### 2. `HEART` — line 20

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"HEART"` |
| `breakable` | boolean literal | `true` |
| `activate` | function | `function(instance, player_session) return show_reward_message(player_session.player, "I found\na heart!", function() return player_session:heal(player_ses…` |

### 3. `CHIP` — line 29

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"CHIP"` |
| `breakable` | boolean literal | `true` |
| `activate` | function | `function(instance, player_session) return show_reward_message(player_session.player, "I found a\nBattleChip!") end` |

### 4. `MONEY` — line 36

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"MONEY"` |
| `breakable` | boolean literal | `true` |
| `activate` | function | `function(instance, player_session) return show_reward_message(player_session.player, "I found some\nMonies!", function() player_session.get_monies = true …` |

### 5. `BUGFRAG` — line 45

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"BUGFRAG"` |
| `breakable` | boolean literal | `true` |
| `activate` | function | `function(instance, player_session) return show_reward_message(player_session.player, "I found a\nBugFrag!") end` |

### 6. `ORDER_POINT` — line 52

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"ORDER_POINT"` |
| `breakable` | boolean literal | `false` |
| `activate` | function | `function(instance, player_session) return show_reward_message(player_session.player, "I found\nOrder Points!", function() local previous_points = instance…` |

### 7. `INVINCIBILITY` — line 64

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"INVINCIBILITY"` |
| `breakable` | boolean literal | `false` |
| `activate` | function | `function(instance, player_session) return show_reward_message(player_session.player, "Team becomes invincible for\n 1 phase!!", function() for _, other_se…` |

### 8. `MAJOR_HIT` — line 75

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"MAJOR_HIT"` |
| `breakable` | boolean literal | `false` |
| `activate` | function | `function(instance, player_session) local co = coroutine.create(function() Async.await(player_session.player:message_with_mug("Damages the closest Guardian…` |

### 9. `KEY` — line 91

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `animation` | string literal | `"KEY"` |
| `breakable` | boolean literal | `false` |
| `activate` | function | `function(instance, player_session) local co = coroutine.create(function() Async.await(player_session.player:message_with_mug("I found a Key!")) local gate…` |

### 10. `Loot.DEFAULT_POOL` — line 153

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Loot.HEART` |
| `[2]` | expression/reference | `Loot.MONEY` |
| `[3]` | expression/reference | `Loot.ORDER_POINT` |

### 11. `Loot.BONUS_POOL` — line 159

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Loot.HEART` |
| `[2]` | expression/reference | `Loot.ORDER_POINT` |
| `[3]` | expression/reference | `Loot.INVINCIBILITY` |
| `[4]` | expression/reference | `Loot.MAJOR_HIT` |
| `[5]` | expression/reference | `Loot.MONEY` |

### 12. `Loot.TEST_POOL` — line 167

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Loot.HEART` |
| `[2]` | expression/reference | `Loot.CHIP` |
| `[3]` | expression/reference | `Loot.MONEY` |
| `[4]` | expression/reference | `Loot.BUGFRAG` |
| `[5]` | expression/reference | `Loot.ORDER_POINT` |

### 13. `Loot.FULL_POOL` — line 175

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Loot.HEART` |
| `[2]` | expression/reference | `Loot.CHIP` |
| `[3]` | expression/reference | `Loot.MONEY` |
| `[4]` | expression/reference | `Loot.BUGFRAG` |
| `[5]` | expression/reference | `Loot.ORDER_POINT` |
| `[6]` | expression/reference | `Loot.INVINCIBILITY` |
| `[7]` | expression/reference | `Loot.KEY` |
| `[8]` | expression/reference | `Loot.MAJOR_HIT` |

### 14. `bot_data` — line 220

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `area_id` | expression/reference | `area_id` |
| `texture_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/item.png"` |
| `animation_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/item.animation"` |
| `animation` | expression/reference | `item.animation` |
| `warp_in` | boolean literal | `false` |
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `z` | expression/reference | `z` |

### 15. `property_animation` — line 231

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ properties = { { property = "Z", ease = "Linear", value = z + 1 } }, duration = RISE_DURATION }` |

### 16. `properties` — line 233

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "Z", ease = "Linear", value = z + 1 }` |

### 17. `bot_data` — line 255

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `area_id` | expression/reference | `area_id` |
| `texture_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/item.png"` |
| `animation_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/item.animation"` |
| `animation` | expression/reference | `loot_pool[start_index].animation` |
| `warp_in` | boolean literal | `false` |
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `z` | expression/reference | `z` |

### 18. `property_animation` — line 266

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 19. `key_frame` — line 273

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `properties` | nested table | `{ { property = "Animation", value = loot_pool[current_item_index].animation } }` |
| `duration` | expression/reference | `frame_duration` |

### 20. `properties` — line 274

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "Animation", value = loot_pool[current_item_index].animation }` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 15 |
| `Async.create_promise` | 2 |
| `Async.promisify` | 5 |
| `Async.sleep` | 4 |
| `Net.animate_bot_properties` | 1 |
| `Net.create_bot` | 2 |
| `Net.is_player_input_locked` | 2 |
| `Net.lock_player_input` | 2 |
| `Net.move_player_camera` | 2 |
| `Net.remove_bot` | 3 |
| `Net.slide_player_camera` | 3 |
| `Net.unlock_player_input` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
