# 📄 `eznpcs_events.lua`

> ⚠️ **Archive-only reference:** The source file `scripts/events/eznpcs_events.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `scripts/events/eznpcs_events.lua` (not present in the current server ZIP).  
> **Source lines:** 347  
> **SHA-256 (UTF-8):** `46878fb948c482…`  
> **Declared/assigned functions detected:** 9  
> **Anonymous closures detected:** 8  
> **Table initializers detected:** 19

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

Source-based reference for `scripts/events/eznpcs_events.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 2 | `scripts/ezlibs-scripts/ezmemory` |
| 3 | `scripts/ezlibs-scripts/ezmystery` |
| 4 | `scripts/ezlibs-scripts/ezweather` |
| 5 | `scripts/ezlibs-scripts/ezwarps/main` |
| 6 | `scripts/ezlibs-scripts/ezencounters/main` |
| 7 | `scripts/ezlibs-scripts/helpers` |
| 8 | `scripts/ezlibs-custom/nebulous-liberations/main` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 20 | `_encounter_result_flags` | `stats` | local |
| 92 | `action` | `npc,player_id,dialogue,relay_object` | assigned |
| 122 | `action` | `npc,player_id,dialogue,relay_object` | assigned |
| 148 | `action` | `npc, player_id, dialogue, relay_object` | assigned |
| 157 | `action` | `npc, player_id, dialogue, relay_object` | assigned |
| 272 | `action` | `npc, player_id, dialogue` | assigned |
| 288 | `action` | `npc, player_id, dialogue` | assigned |
| 301 | `action` | `npc, player_id, dialogue, relay_object` | assigned |
| 313 | `action` | `npc, player_id, dialogue, relay_object` | assigned |

### Function details

#### 1. `_encounter_result_flags(stats)`

- **Location:** source line 20.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `stats` | Not explicitly documented in adjacent source annotations. |

#### 2. `action(npc,player_id,dialogue,relay_object)`

- **Location:** source line 92.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |
| 4 | `relay_object` | Not explicitly documented in adjacent source annotations. |

#### 3. `action(npc,player_id,dialogue,relay_object)`

- **Location:** source line 122.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |
| 4 | `relay_object` | Not explicitly documented in adjacent source annotations. |

#### 4. `action(npc, player_id, dialogue, relay_object)`

- **Location:** source line 148.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |
| 4 | `relay_object` | Not explicitly documented in adjacent source annotations. |

#### 5. `action(npc, player_id, dialogue, relay_object)`

- **Location:** source line 157.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |
| 4 | `relay_object` | Not explicitly documented in adjacent source annotations. |

#### 6. `action(npc, player_id, dialogue)`

- **Location:** source line 272.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |

#### 7. `action(npc, player_id, dialogue)`

- **Location:** source line 288.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |

#### 8. `action(npc, player_id, dialogue, relay_object)`

- **Location:** source line 301.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |
| 4 | `relay_object` | Not explicitly documented in adjacent source annotations. |

#### 9. `action(npc, player_id, dialogue, relay_object)`

- **Location:** source line 313.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `npc` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `dialogue` | Not explicitly documented in adjacent source annotations. |
| 4 | `relay_object` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 93 | `(none)` | `name="Heel1", action=function (npc,player_id,dialogue,relay_object) return async(` |
| 123 | `(none)` | `ame="Clown1", action=function (npc,player_id,dialogue,relay_object) return async(` |
| 149 | `(none)` | `fight Liberation", action = function(npc, player_id, dialogue, relay_object) return …` |
| 158 | `(none)` | `Mission Ability", action = function(npc, player_id, dialogue, relay_object) return a…` |
| 273 | `(none)` | `name = "Steal Money", action = function(npc, player_id, dialogue) return async(` |
| 289 | `(none)` | `name = "Gift Monies", action = function(npc, player_id, dialogue) return async(` |
| 302 | `(none)` | `= "Snow", action = function(npc, player_id, dialogue, relay_object) return async(` |
| 314 | `(none)` | `"Punch", action = function(npc, player_id, dialogue, relay_object) return async(` |

## 📦 Tables and data

The following **19** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `sfx` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `hurt` | string literal | `'/server/assets/ezlibs-assets/sfx/hurt.ogg'` |
| `item_get` | string literal | `'/server/assets/ezlibs-assets/sfx/item_get.ogg'` |
| `recover` | string literal | `'/server/assets/ezlibs-assets/sfx/recover.ogg'` |
| `card_error` | string literal | `'/server/assets/ezlibs-assets/ezfarms/card_error.ogg'` |

### 2. `return` — line 46

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `reason` | expression/reference | `reason` |
| `hp` | expression/reference | `hp` |
| `ran` | expression/reference | `ran` |
| `won` | expression/reference | `won` |
| `lost` | expression/reference | `lost` |

### 3. `boss2` — line 54

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"boss2"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `pet_exp` | numeric literal | `0` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 4. `enemies` — line 58

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 5. `obstacles` — line 61

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `positions` — line 63

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 7. `obstacle_positions` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 8. `player_positions` — line 73

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 9. `tiles` — line 78

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 10. `teams` — line 83

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 11. `event1` — line 90

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Heel1"` |
| `action` | function | `function (npc,player_id,dialogue,relay_object) return async(function() local stats = await(ezencounters.begin_encounter(player_id, boss2)) local flags = _…` |

### 12. `event2` — line 120

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Clown1"` |
| `action` | function | `function (npc,player_id,dialogue,relay_object) return async(function() Net.initiate_encounter(player_id, "/server/assets/bosses/com_louise_CircusMan.zip")…` |

### 13. `liberation_item_list` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{n="HeroSwrd",d="A Hero Sword Chip. Use it in Liberations!"}` |
| `[2]` | nested table | `{n="WideSwrd",d="A Wide Sword Chip. Use it in Liberations!"}` |
| `[3]` | nested table | `{n="OldSaber",d="A Saber projection hilt, scarred with age. Use it in Liberations!"}` |
| `[4]` | nested table | `{n="Guard",d="A Guards you and your teammates!"}` |
| `[5]` | expression/reference | `--{n="HevyShld",d="A heavy shield, great for defense. Use it in Liberations!"}, {n="HexSickle",d="A wicked scythe which cleaves most anything. Use it in L…` |
| `[6]` | nested table | `{n="NumGadgt",d="A gadget that's constantly calculating outcomes. Use it in Liberations!"}` |
| `[7]` | nested table | `{n="GutsHamr",d="A hammer that takes guts to wield. Use it in Liberations!"}` |
| `[8]` | nested table | `{n="ShdwShoe",d="Delicate shoes that let you walk on air. Wear them in Liberations!"}` |
| `[9]` | nested table | `{n="CrosBmb",d="A hefty bomb to blow up panels in a plus shape. use it in Liberations!"}` |
| `[10]` | nested table | `{n="Burner",d="A powerful fire blast to burn up what stands in your way. use it in Liberations!"}` |
| `[11]` | nested table | `{n="Blaster",d="A well rounded buster that fires in a T shape. use it in Liberations!"}` |
| `[12]` | nested table | `{n="Bazooka",d="A destructive and powerful weapon. use it in Liberations!"}` |

### 14. `RematchProgEvent` — line 146

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Refight Liberation"` |
| `action` | function | `function(npc, player_id, dialogue, relay_object) return async(function() return LibPlugin.start_game_for_player(player_id, dialogue.custom_properties["Lib…` |

### 15. `GrantLiberationAbility` — line 155

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Grant Liberation Mission Ability"` |
| `action` | function | `function(npc, player_id, dialogue, relay_object) return async(function() for i = 1, #liberation_item_list, 1 do ezmemory.create_or_update_item(liberation_…` |

### 16. `Steal_Money` — line 270

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Steal Money"` |
| `action` | function | `function(npc, player_id, dialogue) return async(function() if ezmemory.spend_player_money(player_id, 999) then await(Async.message_player(player_id, "Your…` |

### 17. `gift_zenny` — line 286

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Gift Monies"` |
| `action` | function | `function(npc, player_id, dialogue) return async(function() local zenny_amount = tonumber(dialogue.custom_properties["Amount"]) ezmemory.spend_player_money…` |

### 18. `event_snow` — line 299

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Snow"` |
| `action` | function | `function(npc, player_id, dialogue, relay_object) return async(function() local area_id = Net.get_player_area(player_id) ezweather.start_snow_in_area(area_…` |

### 19. `event1` — line 311

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Punch"` |
| `action` | function | `function(npc, player_id, dialogue, relay_object) return async(function() local player_mugshot = Net.get_player_mugshot(player_id) local next_dialogues = h…` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.message_player` | 3 |
| `Net.get_player_area` | 1 |
| `Net.get_player_mugshot` | 1 |
| `Net.initiate_encounter` | 1 |
| `Net.play_sound_for_player` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
