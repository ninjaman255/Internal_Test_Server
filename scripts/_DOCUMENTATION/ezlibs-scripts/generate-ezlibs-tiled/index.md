# 📄 `generate-ezlibs-tiled.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/generate-ezlibs-tiled.lua`](../../../ezlibs-scripts/generate-ezlibs-tiled.lua)  
> **Source lines:** 2309  
> **SHA-256 (UTF-8):** `a692702508591f…`  
> **Declared/assigned functions detected:** 24  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 255

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

Generates three artifacts from a single source of truth: ezlibs-tiled-types.json — Tiled project types (unchanged shape; metadata fields are stripped so Tiled doesn't see anything it might reject). ezlibs-tiled-schema.lua — Runtime schema including category/required/

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 16 | `scripts/ezlibs-scripts/json` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 146 | `prop` | `name, typ, default, enumName` | local |
| 157 | `dark_hole_members` | `(none)` | local |
| 1871 | `validate_schema` | `(none)` | local |
| 1873 | `err` | `fmt, ...` | local |
| 1940 | `strip_member` | `p` | local |
| 1948 | `strip_class_members` | `members` | local |
| 1956 | `build_tiled_types` | `(none)` | local |
| 1994 | `lua_quote` | `s` | local |
| 1998 | `serialize_value` | `v, indent` | local |
| 2038 | `merge_member_meta` | `ot, p` | local |
| 2048 | `build_schema_lua` | `(none)` | local |
| 2050 | `w` | `s` | local |
| 2091 | `md_escape` | `s` | local |
| 2097 | `fmt_default` | `v` | local |
| 2109 | `fmt_type` | `p` | local |
| 2117 | `category_of` | `ot_name, p` | local |
| 2124 | `required_of` | `ot_name, p` | local |
| 2129 | `description_of` | `ot_name, p` | local |
| 2134 | `conditional_of` | `ot_name, p` | local |
| 2156 | `build_reference_md` | `(none)` | local |
| 2158 | `w` | `s` | local |
| 2241 | `dirname` | `p` | local |
| 2245 | `script_dirname` | `(none)` | local |
| 2257 | `main` | `output_path, pretty` | local |

### Function details

#### 1. `prop(name, typ, default, enumName)`

- **Location:** source line 146.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |
| 2 | `typ` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |
| 4 | `enumName` | Not explicitly documented in adjacent source annotations. |

#### 2. `dark_hole_members()`

- **Location:** source line 157.
- **Declaration style:** `local`.
- **Adjacent source comment:**  Common field definition: Dark Hole and Buffed Virus use exactly the same property schema. Override values of 0 mean "inherit".

#### 3. `validate_schema()`

- **Location:** source line 1871.
- **Declaration style:** `local`.
- **Adjacent source comment:**  Schema validation 

#### 4. `err(fmt, ...)`

- **Location:** source line 1873.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `fmt` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 5. `strip_member(p)`

- **Location:** source line 1940.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |

#### 6. `strip_class_members(members)`

- **Location:** source line 1948.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `members` | Not explicitly documented in adjacent source annotations. |

#### 7. `build_tiled_types()`

- **Location:** source line 1956.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 8. `lua_quote(s)`

- **Location:** source line 1994.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s` | Not explicitly documented in adjacent source annotations. |

#### 9. `serialize_value(v, indent)`

- **Location:** source line 1998.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |
| 2 | `indent` | Not explicitly documented in adjacent source annotations. |

#### 10. `merge_member_meta(ot, p)`

- **Location:** source line 2038.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ot` | Not explicitly documented in adjacent source annotations. |
| 2 | `p` | Not explicitly documented in adjacent source annotations. |

#### 11. `build_schema_lua()`

- **Location:** source line 2048.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 12. `w(s)`

- **Location:** source line 2050.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s` | Not explicitly documented in adjacent source annotations. |

#### 13. `md_escape(s)`

- **Location:** source line 2091.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s` | Not explicitly documented in adjacent source annotations. |

#### 14. `fmt_default(v)`

- **Location:** source line 2097.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |

#### 15. `fmt_type(p)`

- **Location:** source line 2109.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |

#### 16. `category_of(ot_name, p)`

- **Location:** source line 2117.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ot_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `p` | Not explicitly documented in adjacent source annotations. |

#### 17. `required_of(ot_name, p)`

- **Location:** source line 2124.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ot_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `p` | Not explicitly documented in adjacent source annotations. |

#### 18. `description_of(ot_name, p)`

- **Location:** source line 2129.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ot_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `p` | Not explicitly documented in adjacent source annotations. |

#### 19. `conditional_of(ot_name, p)`

- **Location:** source line 2134.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ot_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `p` | Not explicitly documented in adjacent source annotations. |

#### 20. `build_reference_md()`

- **Location:** source line 2156.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 21. `w(s)`

- **Location:** source line 2158.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s` | Not explicitly documented in adjacent source annotations. |

#### 22. `dirname(p)`

- **Location:** source line 2241.
- **Declaration style:** `local`.
- **Adjacent source comment:**  Directory helpers 

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |

#### 23. `script_dirname()`

- **Location:** source line 2245.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 24. `main(output_path, pretty)`

- **Location:** source line 2257.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `output_path` | Not explicitly documented in adjacent source annotations. |
| 2 | `pretty` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 853 | `(none)` | `e Encounter List", color = "#9955aa", useAs = { "object" }, members = (` |
| 2021 | `a, b` | `keys = {} for k in pairs(v) do keys[#keys+1] = k end table.sort(keys,` |
| 2190 | `a, b` | `ed = {} for i, p in ipairs(ot.members) do sorted[i] = p end table.sort(sorted,` |

## 📦 Tables and data

The following **255** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Enums` — line 20

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `Direction` | nested table | `{ type = "string", values = {"Up", "Down", "Left", "Right", "Up Left", "Up Right", "Down Left", "Down Right"} }` |
| `MysteryType` | nested table | `{ type = "string", values = {"keyitem", "item", "money", "random", "quiz", "fragments", "tokens", "encounter"} }` |
| `WaypointType` | nested table | `{ type = "string", values = {"first", "random", "before", "after"} }` |
| `DialogueType` | nested table | `{ type = "string", values = {"first", "question", "quiz", "random", "itemcheck", "before", "after", "shop", "password", "quest_switch", "quest_event", "it…` |
| `ItemType` | nested table | `{ type = "string", values = {"item", "keyitem", "money", "fragments", "tokens"} }` |
| `CurrencyType` | nested table | `{ type = "string", values = {"money", "fragments", "tokens"} }` |
| `QuizFailAction` | nested table | `{ type = "string", values = {"retry", "hide_once", "hide_temp", "explode"} }` |
| `TriggerShape` | nested table | `{ type = "string", values = {"rect", "ellipse"} }` |
| `ButtonBehavior` | nested table | `{ type = "string", values = {"Pressure Plate", "One-Time", "Toggle", "Custom", "Timed"} }` |
| `KeyType` | nested table | `{ type = "string", values = {"money", "fragments", "tokens", "item", "bossgate", "navi_name", "navi_element", "navi_list"} }` |
| `ButtonChainType` | nested table | `{ type = "string", values = {"Any", "Exclusive"} }` |
| `ButtonGroupMode` | nested table | `{ type = "string", values = {"all_active", "any_active", "combination"} }` |
| `ButtonComboMode` | nested table | `{ type = "string", values = {"Inclusive", "Exclusive"} }` |
| `ButtonEffectEvent` | nested table | `{ type = "string", values = {"activated", "deactivated"} }` |
| `ButtonGroupEvent` | nested table | `{ type = "string", values = {"completed", "incomplete"} }` |
| `ButtonEffectAction` | nested table | `{ type = "string", values = {"activate", "deactivate", "toggle", "reset"} }` |
| `CompressionMode` | nested table | `{ type = "string", values = {"Compress", "Normalize", "Enlarge"} }` |
| `SizeModeScope` | nested table | `{ type = "string", values = {"Player", "Area Wide"} }` |
| `NaviElement` | nested table | `{ type = "string", values = {"None", "Fire", "Aqua", "Elec", "Wood", "Sword", "Break", "Cursor", "Wind", "Summon", "Plus"} }` |
| `CutsceneStepType` | nested table | `{ type = "string", values = {"Wait", "Move Actor", "Set Pose", "Show Message", "Ask Quiz", "Prompt Player", "Play Sound", "Fade Camera", "Move Camera", "E…` |
| `NPCSpawnMode` | nested table | `{ type = "string", values = {"Once", "Interval"} }` |
| `BossSpawnMode` | nested table | `{ type = "string", values = {"Immediate", "On Dark Hole Cleared", "Manual", "After Boss Defeated"} }` |
| `BossRequirementType` | nested table | `{ type = "string", values = {"All", "Any"} }` |
| `[24]` | expression/reference | `-- Liberation configuration selectors. These are authored here so future -- schema regeneration retains the selectable options. LiberationEncounterMode = …` |
| `LiberationEncounterCategory` | nested table | `{ type = "string", values = {"Auto", "encounters", "special_encounters", "bosses"} }` |
| `LiberationEnemyCategory` | nested table | `{ type = "string", values = {"All", "Dark Hole", "Buffed Virus", "Boss"} }` |
| `LiberationAIType` | nested table | `{ type = "string", values = {"Auto", "simple_charge", "ranged", "shockwave_line"} }` |
| `[28]` | expression/reference | `-- Matching is safe for composite encounters; All is an explicit opt-in. LiberationBattleScaleScope = { type = "string", values = {"Auto", "Matching", "Al…` |

### 2. `Direction` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Up", "Down", "Left", "Right", "Up Left", "Up Right", "Down Left", "Down Right"}` |

### 3. `values` — line 23

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Up"` |
| `[2]` | string literal | `"Down"` |
| `[3]` | string literal | `"Left"` |
| `[4]` | string literal | `"Right"` |
| `[5]` | string literal | `"Up Left"` |
| `[6]` | string literal | `"Up Right"` |
| `[7]` | string literal | `"Down Left"` |
| `[8]` | string literal | `"Down Right"` |

### 4. `MysteryType` — line 25

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"keyitem", "item", "money", "random", "quiz", "fragments", "tokens", "encounter"}` |

### 5. `values` — line 27

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"keyitem"` |
| `[2]` | string literal | `"item"` |
| `[3]` | string literal | `"money"` |
| `[4]` | string literal | `"random"` |
| `[5]` | string literal | `"quiz"` |
| `[6]` | string literal | `"fragments"` |
| `[7]` | string literal | `"tokens"` |
| `[8]` | string literal | `"encounter"` |

### 6. `WaypointType` — line 29

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"first", "random", "before", "after"}` |

### 7. `values` — line 31

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"first"` |
| `[2]` | string literal | `"random"` |
| `[3]` | string literal | `"before"` |
| `[4]` | string literal | `"after"` |

### 8. `DialogueType` — line 33

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"first", "question", "quiz", "random", "itemcheck", "before", "after", "shop", "password", "quest_switch", "quest_event", "item", "email", "questcheck", …` |

### 9. `values` — line 35

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"first"` |
| `[2]` | string literal | `"question"` |
| `[3]` | string literal | `"quiz"` |
| `[4]` | string literal | `"random"` |
| `[5]` | string literal | `"itemcheck"` |
| `[6]` | string literal | `"before"` |
| `[7]` | string literal | `"after"` |
| `[8]` | string literal | `"shop"` |
| `[9]` | string literal | `"password"` |
| `[10]` | string literal | `"quest_switch"` |
| `[11]` | string literal | `"quest_event"` |
| `[12]` | string literal | `"item"` |
| `[13]` | string literal | `"email"` |
| `[14]` | string literal | `"questcheck"` |
| `[15]` | string literal | `"battle_npc"` |

### 10. `ItemType` — line 39

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"item", "keyitem", "money", "fragments", "tokens"}` |

### 11. `values` — line 41

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"item"` |
| `[2]` | string literal | `"keyitem"` |
| `[3]` | string literal | `"money"` |
| `[4]` | string literal | `"fragments"` |
| `[5]` | string literal | `"tokens"` |

### 12. `CurrencyType` — line 43

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"money", "fragments", "tokens"}` |

### 13. `values` — line 45

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"money"` |
| `[2]` | string literal | `"fragments"` |
| `[3]` | string literal | `"tokens"` |

### 14. `QuizFailAction` — line 47

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"retry", "hide_once", "hide_temp", "explode"}` |

### 15. `values` — line 49

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"retry"` |
| `[2]` | string literal | `"hide_once"` |
| `[3]` | string literal | `"hide_temp"` |
| `[4]` | string literal | `"explode"` |

### 16. `TriggerShape` — line 51

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"rect", "ellipse"}` |

### 17. `values` — line 53

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"rect"` |
| `[2]` | string literal | `"ellipse"` |

### 18. `ButtonBehavior` — line 55

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Pressure Plate", "One-Time", "Toggle", "Custom", "Timed"}` |

### 19. `values` — line 57

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Pressure Plate"` |
| `[2]` | string literal | `"One-Time"` |
| `[3]` | string literal | `"Toggle"` |
| `[4]` | string literal | `"Custom"` |
| `[5]` | string literal | `"Timed"` |

### 20. `KeyType` — line 59

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"money", "fragments", "tokens", "item", "bossgate", "navi_name", "navi_element", "navi_list"}` |

### 21. `values` — line 61

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"money"` |
| `[2]` | string literal | `"fragments"` |
| `[3]` | string literal | `"tokens"` |
| `[4]` | string literal | `"item"` |
| `[5]` | string literal | `"bossgate"` |
| `[6]` | string literal | `"navi_name"` |
| `[7]` | string literal | `"navi_element"` |
| `[8]` | string literal | `"navi_list"` |

### 22. `ButtonChainType` — line 64

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Any", "Exclusive"}` |

### 23. `values` — line 66

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Any"` |
| `[2]` | string literal | `"Exclusive"` |

### 24. `ButtonGroupMode` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"all_active", "any_active", "combination"}` |

### 25. `values` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"all_active"` |
| `[2]` | string literal | `"any_active"` |
| `[3]` | string literal | `"combination"` |

### 26. `ButtonComboMode` — line 72

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Inclusive", "Exclusive"}` |

### 27. `values` — line 74

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Inclusive"` |
| `[2]` | string literal | `"Exclusive"` |

### 28. `ButtonEffectEvent` — line 76

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"activated", "deactivated"}` |

### 29. `values` — line 78

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"activated"` |
| `[2]` | string literal | `"deactivated"` |

### 30. `ButtonGroupEvent` — line 80

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"completed", "incomplete"}` |

### 31. `values` — line 82

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"completed"` |
| `[2]` | string literal | `"incomplete"` |

### 32. `ButtonEffectAction` — line 84

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"activate", "deactivate", "toggle", "reset"}` |

### 33. `values` — line 86

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"activate"` |
| `[2]` | string literal | `"deactivate"` |
| `[3]` | string literal | `"toggle"` |
| `[4]` | string literal | `"reset"` |

### 34. `CompressionMode` — line 88

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Compress", "Normalize", "Enlarge"}` |

### 35. `values` — line 90

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Compress"` |
| `[2]` | string literal | `"Normalize"` |
| `[3]` | string literal | `"Enlarge"` |

### 36. `SizeModeScope` — line 92

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Player", "Area Wide"}` |

### 37. `values` — line 94

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Player"` |
| `[2]` | string literal | `"Area Wide"` |

### 38. `NaviElement` — line 96

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"None", "Fire", "Aqua", "Elec", "Wood", "Sword", "Break", "Cursor", "Wind", "Summon", "Plus"}` |

### 39. `values` — line 98

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"None"` |
| `[2]` | string literal | `"Fire"` |
| `[3]` | string literal | `"Aqua"` |
| `[4]` | string literal | `"Elec"` |
| `[5]` | string literal | `"Wood"` |
| `[6]` | string literal | `"Sword"` |
| `[7]` | string literal | `"Break"` |
| `[8]` | string literal | `"Cursor"` |
| `[9]` | string literal | `"Wind"` |
| `[10]` | string literal | `"Summon"` |
| `[11]` | string literal | `"Plus"` |

### 40. `CutsceneStepType` — line 101

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Wait", "Move Actor", "Set Pose", "Show Message", "Ask Quiz", "Prompt Player", "Play Sound", "Fade Camera", "Move Camera", "Emit Event"}` |

### 41. `values` — line 103

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Wait"` |
| `[2]` | string literal | `"Move Actor"` |
| `[3]` | string literal | `"Set Pose"` |
| `[4]` | string literal | `"Show Message"` |
| `[5]` | string literal | `"Ask Quiz"` |
| `[6]` | string literal | `"Prompt Player"` |
| `[7]` | string literal | `"Play Sound"` |
| `[8]` | string literal | `"Fade Camera"` |
| `[9]` | string literal | `"Move Camera"` |
| `[10]` | string literal | `"Emit Event"` |

### 42. `NPCSpawnMode` — line 107

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Once", "Interval"}` |

### 43. `values` — line 109

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Once"` |
| `[2]` | string literal | `"Interval"` |

### 44. `BossSpawnMode` — line 111

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Immediate", "On Dark Hole Cleared", "Manual", "After Boss Defeated"}` |

### 45. `values` — line 113

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Immediate"` |
| `[2]` | string literal | `"On Dark Hole Cleared"` |
| `[3]` | string literal | `"Manual"` |
| `[4]` | string literal | `"After Boss Defeated"` |

### 46. `BossRequirementType` — line 115

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"All", "Any"}` |

### 47. `values` — line 117

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"All"` |
| `[2]` | string literal | `"Any"` |

### 48. `LiberationEncounterMode` — line 122

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Auto", "Fixed", "Pool", "Category"}` |

### 49. `values` — line 124

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Auto"` |
| `[2]` | string literal | `"Fixed"` |
| `[3]` | string literal | `"Pool"` |
| `[4]` | string literal | `"Category"` |

### 50. `LiberationEncounterCategory` — line 126

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Auto", "encounters", "special_encounters", "bosses"}` |

### 51. `values` — line 128

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Auto"` |
| `[2]` | string literal | `"encounters"` |
| `[3]` | string literal | `"special_encounters"` |
| `[4]` | string literal | `"bosses"` |

### 52. `LiberationEnemyCategory` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"All", "Dark Hole", "Buffed Virus", "Boss"}` |

### 53. `values` — line 132

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"All"` |
| `[2]` | string literal | `"Dark Hole"` |
| `[3]` | string literal | `"Buffed Virus"` |
| `[4]` | string literal | `"Boss"` |

### 54. `LiberationAIType` — line 134

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Auto", "simple_charge", "ranged", "shockwave_line"}` |

### 55. `values` — line 136

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Auto"` |
| `[2]` | string literal | `"simple_charge"` |
| `[3]` | string literal | `"ranged"` |
| `[4]` | string literal | `"shockwave_line"` |

### 56. `LiberationBattleScaleScope` — line 139

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"string"` |
| `values` | nested table | `{"Auto", "Matching", "All"}` |

### 57. `values` — line 141

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Auto"` |
| `[2]` | string literal | `"Matching"` |
| `[3]` | string literal | `"All"` |

### 58. `p` — line 147

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | expression/reference | `name` |
| `type` | expression/reference | `typ` |
| `value` | expression/reference | `default` |

### 59. `return` — line 158

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Spawns", "string", "")` |
| `[2]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[3]` | expression/reference | `prop("Boss ID 1", "string", "")` |
| `[4]` | expression/reference | `prop("Boss ID 2", "string", "")` |
| `[5]` | expression/reference | `prop("OW Bot Encounter", "string", "")` |
| `[6]` | expression/reference | `prop("Liberation Encounters", "object", 0)` |
| `[7]` | expression/reference | `prop("Enemy Config", "object", 0)` |
| `[8]` | expression/reference | `prop("Encounter Mode", "string", "Auto", "LiberationEncounterMode")` |
| `[9]` | expression/reference | `prop("Encounter Category", "string", "Auto", "LiberationEncounterCategory")` |
| `[10]` | expression/reference | `prop("OW Encounter Pool", "object", 0)` |
| `[11]` | expression/reference | `prop("Max HP", "int", 0)` |
| `[12]` | expression/reference | `prop("Starting HP", "int", 0)` |
| `[13]` | expression/reference | `prop("OW Scale", "float", 0)` |
| `[14]` | expression/reference | `prop("Battle Scale", "float", 0)` |
| `[15]` | expression/reference | `prop("Battle Scale Scope", "string", "Auto", "LiberationBattleScaleScope")` |
| `[16]` | expression/reference | `prop("OW Attack Damage", "int", 0)` |
| `[17]` | expression/reference | `prop("OW Damage Multiplier", "float", 0)` |
| `[18]` | expression/reference | `prop("Battle Attack Multiplier", "float", 0)` |
| `[19]` | expression/reference | `prop("Battle Defense Multiplier", "float", 0)` |
| `[20]` | expression/reference | `prop("AI Type", "string", "Auto", "LiberationAIType")` |

### 60. `object_types` — line 183

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ name = "Checkpoint", color = "#ffaa00", members = { prop("Password", "string", ""), prop("Key Type", "string", "money", "KeyType"), prop("Key Item Name"…` |
| `[2]` | nested table | `{ name = "Mystery Data", color = "#00aaff", members = { prop("Locked", "bool", false), prop("Password Locked", "string", ""), prop("Once", "bool", false),…` |
| `[3]` | nested table | `{ name = "Quiz List", color = "#aa66cc", members = { prop("Next 1", "object", ""), prop("Next 2", "object", ""), prop("Next 3", "object", ""), prop("Next …` |
| `[4]` | nested table | `{ name = "Quiz Question", color = "#88aa44", members = { prop("Question", "string", ""), prop("Option 1", "string", ""), prop("Option 2", "string", ""), p…` |
| `[5]` | nested table | `{ name = "Location Trigger", color = "#88ff88", members = { prop("Event Name", "string", ""), prop("Name", "string", ""), } }` |
| `[6]` | nested table | `{ name = "Server Warp", color = "#ff8888", members = { prop("Incoming Data", "string", ""), prop("Direction", "string", "Down", "Direction"), prop("Warp I…` |
| `[7]` | nested table | `{ name = "Custom Warp", color = "#ff8888", members = { prop("Incoming Data", "string", ""), prop("Direction", "string", "Down", "Direction"), prop("Warp I…` |
| `[8]` | nested table | `{ name = "Interact Warp", color = "#ff8888", members = { prop("Incoming Data", "string", ""), prop("Direction", "string", "Down", "Direction"), prop("Warp…` |
| `[9]` | nested table | `{ name = "Radius Warp", color = "#ff8888", members = { prop("Incoming Data", "string", ""), prop("Direction", "string", "Down", "Direction"), prop("Warp I…` |
| `[10]` | nested table | `{ name = "NPC", color = "#aaaaaa", members = { prop("Direction", "string", "Down", "Direction"), prop("Asset Name", "string", ""), prop("Animation Name", …` |
| `[11]` | nested table | `{ name = "Pushback NPC", color = "#ff6666", members = { prop("Direction", "string", "Down", "Direction"), prop("Asset Name", "string", "male-navi-exe6_tea…` |
| `[12]` | nested table | `{ name = "NPC Behavior", color = "#88bbdd", members = { prop("Attached NPC", "object", ""), prop("Behavior", "string", "Pushback"), prop("Enabled", "bool"…` |
| `[13]` | nested table | `{ name = "NPC Spawner", color = "#ffcc88", members = { prop("NPC Template", "object", ""), prop("Trigger Radius", "number", 0), prop("Spawn Mode", "string…` |
| `[14]` | nested table | `{ name = "FootBomb Controller", color = "#ffcc66", members = { prop("Direction", "string", "Down", "Direction"), prop("Asset Name", "string", "male-navi-e…` |
| `[15]` | nested table | `{ name = "Waypoint", color = "#55ff55", members = { prop("Wait Time", "number", 0), prop("Direction", "string", "", "Direction"), prop("Waypoint Type", "s…` |
| `[16]` | nested table | `{ name = "Radius Encounter", color = "#ff5555", members = { prop("Radius", "number", 1), prop("Name", "string", ""), prop("Path", "file", ""), prop("Once"…` |
| `[17]` | nested table | `{ name = "Water Refill", color = "#4444ff", members = {} }` |
| `[18]` | nested table | `{ name = "Item", color = "#ffdd44", members = { prop("Name", "string", ""), prop("Type", "string", "item", "ItemType"), prop("Description", "string", ""),…` |
| `[19]` | nested table | `{ name = "Dialogue", color = "#cc66cc", members = { prop("Dialogue Type", "string", "first", "DialogueType"), prop("Event Name", "string", ""), prop("Mugs…` |
| `[20]` | nested table | `{ name = "Explosion Trigger", color = "#ff6600", members = { prop("Target", "string", ""), prop("Follow", "bool", false), prop("Once", "bool", false), } }` |
| `[21]` | nested table | `{ name = "Rush Road", color = "#ffaa00", members = { prop("Rush Object", "object", ""), prop("Direction", "string", "Down Left", "Direction"), } }` |
| `[22]` | nested table | `{ name = "Compression Tile", color = "#88aaff", members = { prop("Mode", "string", "Compress", "CompressionMode"), } }` |
| `[23]` | nested table | `{ name = "Admin Console", color = "#ffaa00", members = {} }` |
| `[24]` | nested table | `{ name = "Button Bot Details", color = "#99ddff", members = { prop("Asset Name", "string", ""), prop("Direction", "string", "Down", "Direction"), prop("An…` |
| `[25]` | nested table | `{ name = "OW Button", color = "#66ccff", members = { prop("Bot Details", "object", ""), prop("Next 1", "object", ""), prop("Button Behavior", "string", "O…` |
| `[26]` | nested table | `{ name = "OW Button Group Member", color = "#66ddbb", members = { prop("Bot Details", "object", ""), prop("Button Behavior", "string", "One-Time", "Button…` |
| `[27]` | nested table | `{ name = "Unlock Behavior", color = "#ffcc00", members = { prop("Unlock This", "object", ""), prop("Unlock Permanently", "bool", false), prop("Area Wide",…` |
| `[28]` | nested table | `{ name = "Relock Behavior", color = "#ff8888", members = { prop("Relock This", "object", ""), prop("Area Wide", "bool", false), } }` |
| `[29]` | nested table | `{ name = "Button Trigger", color = "#aaddff", members = { prop("Trigger Type", "string", "rect", "TriggerShape"), } }` |
| `[30]` | nested table | `{ name = "Button Group", color = "#66dd99", members = { prop("Group ID", "string", ""), prop("Group Mode", "string", "all_active", "ButtonGroupMode"), pro…` |
| `[31]` | nested table | `{ name = "Button Combo", color = "#66bbdd", members = { prop("Button 1", "object", ""), prop("Forbidden Button 1", "object", ""), prop("Unlock Checkpoint …` |
| `[32]` | nested table | `{ name = "Combo Button Group", color = "#44bb88", members = { prop("Group ID", "string", ""), prop("Combo Mode", "string", "Inclusive", "ButtonComboMode")…` |
| `[33]` | nested table | `{ name = "Button Effect", color = "#ffbb66", members = { prop("Source Button", "object", ""), prop("Event", "string", "activated", "ButtonEffectEvent"), p…` |
| `[34]` | nested table | `{ name = "Button Group Effect", color = "#ff9966", members = { prop("Button Group", "object", ""), prop("Event", "string", "completed", "ButtonGroupEvent"…` |
| `[35]` | nested table | `{ name = "Cutscene", color = "#c678dd", members = { prop("Name", "string", ""), prop("Start Step", "object", ""), prop("Trigger Radius", "number", 0), pro…` |
| `[36]` | nested table | `{ name = "Cutscene Step", color = "#e5c07b", members = { prop("Type", "string", "Wait", "CutsceneStepType"), prop("Next Step", "object", ""), prop("Next 1…` |
| `[37]` | nested table | `{ name = "Music Definition", color = "#66aacc", useAs = { "object" }, members = { prop("Path", "string", ""), prop("Loop Start", "number", 0), prop("Loop …` |
| `[38]` | nested table | `{ name = "Liberation Config", color = "#cc66ff", members = { -- Liberation-specific settings. Encounter Music references a -- reusable Music Definition ob…` |
| `[39]` | nested table | `{ name = "Liberation Gate", color = "#cc66ff", members = { prop("Liberation Map File Name", "string", ""), } }` |
| `[40]` | nested table | `{ name = "Spawn Point", color = "#66ccff", useAs = { "object" }, members = { prop("Next Spawn", "object", ""), prop("Facing Direction", "string", "Down", …` |
| `[41]` | expression/reference | `-- Boss Dark Panel is a placed tile object. The boss settings live here, -- rather than being repeated across map-specific scripts. { name = "Boss Dark Pa…` |
| `[42]` | expression/reference | `-- Reusable, object-referenced list of named special encounters for a -- Dark Hole liberation battle. Empty Name fields are ignored. { name = "Dark Hole E…` |
| `[43]` | expression/reference | `-- These classes are applied to placed tile objects on the map's object -- layer. Boss ID 1/2 associate the object with one or two boss groups. -- The two…` |
| `[44]` | nested table | `{ name = "Dark Hole Buffed Virus", color = "#8844aa", useAs = { "object" }, members = dark_hole_members(), }` |
| `[45]` | nested table | `{ name = "Indestructible Panel", color = "#9966cc", useAs = { "object" }, members = { prop("Boss ID 1", "string", ""), prop("Boss ID 2", "string", ""), pr…` |
| `[46]` | expression/reference | `-- Reusable Liberation configuration and weighted encounter pool objects. { name = "Liberation Enemy Config", color = "#37a7b5", useAs = { "object" }, mem…` |
| `[47]` | nested table | `{ name = "Liberation Enemy Defaults", color = "#4c9e72", useAs = { "object" }, members = { prop("Category", "string", "All", "LiberationEnemyCategory"), p…` |
| `[48]` | nested table | `{ name = "Liberation Encounter Pool", color = "#bd8844", useAs = { "object" }, members = { prop("Encounter Category", "string", "Auto", "LiberationEncount…` |

### 61. `members` — line 187

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Password", "string", "")` |
| `[2]` | expression/reference | `prop("Key Type", "string", "money", "KeyType")` |
| `[3]` | expression/reference | `prop("Key Item Name", "string", "")` |
| `[4]` | expression/reference | `prop("Required Keys", "number", 1)` |
| `[5]` | expression/reference | `prop("Consume", "bool", false)` |
| `[6]` | expression/reference | `prop("Once", "bool", false)` |
| `[7]` | expression/reference | `prop("Unlocking Asset Name", "string", "bn5cubegreen")` |
| `[8]` | expression/reference | `prop("Unlocking Animation Time", "number", 0)` |
| `[9]` | expression/reference | `prop("Unlocking Sound Path", "string", "/server/assets/ezlibs-assets/sfx/panel_change.ogg")` |
| `[10]` | expression/reference | `prop("Skip Prompt", "bool", false)` |
| `[11]` | expression/reference | `prop("Description", "string", "It's a Security Cube")` |
| `[12]` | expression/reference | `prop("Unlocked Message", "string", "The Security Cube was unlocked!")` |
| `[13]` | expression/reference | `prop("Unlock Failed Message", "string", "You were unable to unlock the Security Cube")` |
| `[14]` | expression/reference | `prop("Navi Name", "string", "")` |
| `[15]` | expression/reference | `prop("Navi Element", "string", "", "NaviElement")` |
| `[16]` | expression/reference | `prop("Navi 1", "string", "")` |
| `[17]` | expression/reference | `prop("Navi 2", "string", "")` |
| `[18]` | expression/reference | `prop("Navi 3", "string", "")` |
| `[19]` | expression/reference | `prop("Navi 4", "string", "")` |
| `[20]` | expression/reference | `prop("Navi 5", "string", "")` |
| `[21]` | expression/reference | `prop("Navi 6", "string", "")` |
| `[22]` | expression/reference | `prop("Navi 7", "string", "")` |
| `[23]` | expression/reference | `prop("Navi 8", "string", "")` |
| `[24]` | expression/reference | `prop("Navi 9", "string", "")` |
| `[25]` | expression/reference | `prop("Navi 10", "string", "")` |

### 62. `members` — line 218

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Locked", "bool", false)` |
| `[2]` | expression/reference | `prop("Password Locked", "string", "")` |
| `[3]` | expression/reference | `prop("Once", "bool", false)` |
| `[4]` | expression/reference | `prop("Type", "string", "item", "MysteryType")` |
| `[5]` | expression/reference | `prop("Name", "string", "")` |
| `[6]` | expression/reference | `prop("Description", "string", "")` |
| `[7]` | expression/reference | `prop("Amount", "number", 1)` |
| `[8]` | expression/reference | `prop("Quiz List", "object", "")` |
| `[9]` | expression/reference | `prop("Failure Message", "string", "")` |
| `[10]` | expression/reference | `prop("On Fail", "string", "retry", "QuizFailAction")` |
| `[11]` | expression/reference | `prop("Explosion Count", "number", 3)` |
| `[12]` | expression/reference | `prop("Reward Type", "string", "item", "ItemType")` |
| `[13]` | expression/reference | `prop("Reward Name", "string", "")` |
| `[14]` | expression/reference | `prop("Reward Amount", "number", 1)` |
| `[15]` | expression/reference | `prop("Reward Description", "string", "")` |
| `[16]` | expression/reference | `prop("Cost Type", "string", "", "CurrencyType")` |
| `[17]` | expression/reference | `prop("Cost Amount", "number", 1)` |
| `[18]` | expression/reference | `prop("Cost Failure Message", "string", "")` |
| `[19]` | expression/reference | `prop("Next 1", "object", "")` |
| `[20]` | expression/reference | `prop("Next 2", "object", "")` |
| `[21]` | expression/reference | `prop("Next 3", "object", "")` |
| `[22]` | expression/reference | `prop("Next 4", "object", "")` |
| `[23]` | expression/reference | `prop("Next 5", "object", "")` |
| `[24]` | expression/reference | `prop("Next 6", "object", "")` |
| `[25]` | expression/reference | `prop("Next 7", "object", "")` |
| `[26]` | expression/reference | `prop("Next 8", "object", "")` |
| `[27]` | expression/reference | `prop("Next 9", "object", "")` |
| `[28]` | expression/reference | `prop("Next 10", "object", "")` |

### 63. `members` — line 252

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Next 1", "object", "")` |
| `[2]` | expression/reference | `prop("Next 2", "object", "")` |
| `[3]` | expression/reference | `prop("Next 3", "object", "")` |
| `[4]` | expression/reference | `prop("Next 4", "object", "")` |
| `[5]` | expression/reference | `prop("Next 5", "object", "")` |
| `[6]` | expression/reference | `prop("Next 6", "object", "")` |
| `[7]` | expression/reference | `prop("Next 7", "object", "")` |
| `[8]` | expression/reference | `prop("Next 8", "object", "")` |
| `[9]` | expression/reference | `prop("Next 9", "object", "")` |
| `[10]` | expression/reference | `prop("Next 10", "object", "")` |

### 64. `members` — line 268

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Question", "string", "")` |
| `[2]` | expression/reference | `prop("Option 1", "string", "")` |
| `[3]` | expression/reference | `prop("Option 2", "string", "")` |
| `[4]` | expression/reference | `prop("Option 3", "string", "")` |
| `[5]` | expression/reference | `prop("Correct Answer", "number", 1)` |

### 65. `members` — line 279

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Event Name", "string", "")` |
| `[2]` | expression/reference | `prop("Name", "string", "")` |

### 66. `members` — line 287

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Incoming Data", "string", "")` |
| `[2]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[3]` | expression/reference | `prop("Warp In", "bool", false)` |
| `[4]` | expression/reference | `prop("Arrival Animation", "string", "")` |
| `[5]` | expression/reference | `prop("Dont Teleport", "bool", false)` |
| `[6]` | expression/reference | `prop("Address", "string", "")` |
| `[7]` | expression/reference | `prop("Port", "number", 0)` |
| `[8]` | expression/reference | `prop("Data", "string", "")` |
| `[9]` | expression/reference | `prop("Warp Out", "bool", false)` |

### 67. `members` — line 302

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Incoming Data", "string", "")` |
| `[2]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[3]` | expression/reference | `prop("Warp In", "bool", false)` |
| `[4]` | expression/reference | `prop("Arrival Animation", "string", "")` |
| `[5]` | expression/reference | `prop("Dont Teleport", "bool", false)` |
| `[6]` | expression/reference | `prop("Target Area", "string", "")` |
| `[7]` | expression/reference | `prop("Target Object", "string", "")` |
| `[8]` | expression/reference | `prop("Leave Animation", "string", "")` |

### 68. `members` — line 316

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Incoming Data", "string", "")` |
| `[2]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[3]` | expression/reference | `prop("Warp In", "bool", false)` |
| `[4]` | expression/reference | `prop("Arrival Animation", "string", "")` |
| `[5]` | expression/reference | `prop("Dont Teleport", "bool", false)` |
| `[6]` | expression/reference | `prop("Target Area", "string", "")` |
| `[7]` | expression/reference | `prop("Target Object", "string", "")` |
| `[8]` | expression/reference | `prop("Leave Animation", "string", "")` |

### 69. `members` — line 330

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Incoming Data", "string", "")` |
| `[2]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[3]` | expression/reference | `prop("Warp In", "bool", false)` |
| `[4]` | expression/reference | `prop("Arrival Animation", "string", "")` |
| `[5]` | expression/reference | `prop("Dont Teleport", "bool", false)` |
| `[6]` | expression/reference | `prop("Activation Radius", "number", 1)` |
| `[7]` | expression/reference | `prop("Target Area", "string", "")` |
| `[8]` | expression/reference | `prop("Target Object", "string", "")` |
| `[9]` | expression/reference | `prop("Leave Animation", "string", "")` |

### 70. `members` — line 345

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[2]` | expression/reference | `prop("Asset Name", "string", "")` |
| `[3]` | expression/reference | `prop("Animation Name", "string", "")` |
| `[4]` | expression/reference | `prop("Mug Animation Name", "string", "")` |
| `[5]` | expression/reference | `prop("Dont Face Player", "bool", false)` |
| `[6]` | expression/reference | `prop("First Dialogue", "object", "")` |
| `[7]` | expression/reference | `prop("Cutscene", "string", "")` |
| `[8]` | expression/reference | `prop("Next Waypoint 1", "object", "")` |
| `[9]` | expression/reference | `prop("Player Exclusive", "bool", false)` |
| `[10]` | expression/reference | `prop("Quest NPC", "bool", false)` |
| `[11]` | expression/reference | `prop("Quest Exclusive", "string", "")` |
| `[12]` | expression/reference | `prop("Quest State", "string", "active")` |
| `[13]` | expression/reference | `prop("Template Only", "bool", false)` |

### 71. `members` — line 364

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[2]` | expression/reference | `prop("Asset Name", "string", "male-navi-exe6_teal")` |
| `[3]` | expression/reference | `prop("Animation Name", "string", "")` |
| `[4]` | expression/reference | `prop("Mug Animation Name", "string", "")` |
| `[5]` | expression/reference | `prop("Dont Face Player", "bool", false)` |
| `[6]` | expression/reference | `prop("First Dialogue", "object", "")` |
| `[7]` | expression/reference | `prop("Next Waypoint 1", "object", "")` |
| `[8]` | expression/reference | `prop("Player Exclusive", "bool", false)` |
| `[9]` | expression/reference | `prop("Quest NPC", "bool", false)` |
| `[10]` | expression/reference | `prop("Quest Exclusive", "string", "")` |
| `[11]` | expression/reference | `prop("Quest State", "string", "active")` |
| `[12]` | expression/reference | `prop("Collision Enabled", "bool", true)` |
| `[13]` | expression/reference | `prop("Collision Width", "number", 1.5)` |
| `[14]` | expression/reference | `prop("Collision Height", "number", 1.5)` |
| `[15]` | expression/reference | `prop("Push Distance", "number", 1.0)` |
| `[16]` | expression/reference | `prop("Push Duration", "number", 0.28)` |
| `[17]` | expression/reference | `prop("Push Cooldown", "number", 0.75)` |
| `[18]` | expression/reference | `prop("Move Animation State", "string", "MOVE")` |
| `[19]` | expression/reference | `prop("Template Only", "bool", false)` |

### 72. `members` — line 389

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Attached NPC", "object", "")` |
| `[2]` | expression/reference | `prop("Behavior", "string", "Pushback")` |
| `[3]` | expression/reference | `prop("Enabled", "bool", true)` |
| `[4]` | expression/reference | `prop("Collision Width", "number", 1.5)` |
| `[5]` | expression/reference | `prop("Collision Height", "number", 1.5)` |
| `[6]` | expression/reference | `prop("Push Distance", "number", 1.0)` |
| `[7]` | expression/reference | `prop("Push Duration", "number", 0.28)` |
| `[8]` | expression/reference | `prop("Push Cooldown", "number", 0.75)` |
| `[9]` | expression/reference | `prop("Move Animation State", "string", "MOVE")` |

### 73. `members` — line 404

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("NPC Template", "object", "")` |
| `[2]` | expression/reference | `prop("Trigger Radius", "number", 0)` |
| `[3]` | expression/reference | `prop("Spawn Mode", "string", "Once", "NPCSpawnMode")` |
| `[4]` | expression/reference | `prop("Spawn Interval", "number", 3)` |
| `[5]` | expression/reference | `prop("Max Alive", "number", 0)` |
| `[6]` | expression/reference | `prop("Once", "bool", false)` |
| `[7]` | expression/reference | `prop("Warp Out At End", "bool", false)` |
| `[8]` | expression/reference | `prop("Warp Out Delay", "number", 0)` |
| `[9]` | expression/reference | `prop("Warp Out Animation", "string", "")` |
| `[10]` | expression/reference | `prop("Warp Out Animation Duration", "number", 0.5)` |

### 74. `members` — line 420

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[2]` | expression/reference | `prop("Asset Name", "string", "male-navi-exe6_teal")` |
| `[3]` | expression/reference | `prop("Animation Name", "string", "")` |
| `[4]` | expression/reference | `prop("Mugshot", "string", "")` |
| `[5]` | expression/reference | `prop("Mug Animation Name", "string", "")` |
| `[6]` | expression/reference | `prop("Dont Face Player", "bool", false)` |
| `[7]` | expression/reference | `prop("Instance Map", "string", "footbomb")` |
| `[8]` | expression/reference | `prop("Points to Win", "number", 10)` |

### 75. `members` — line 434

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Wait Time", "number", 0)` |
| `[2]` | expression/reference | `prop("Direction", "string", "", "Direction")` |
| `[3]` | expression/reference | `prop("Waypoint Type", "string", "first", "WaypointType")` |
| `[4]` | expression/reference | `prop("Date", "string", "")` |
| `[5]` | expression/reference | `prop("Move Animation", "string", "")` |
| `[6]` | expression/reference | `prop("Move Loop", "bool", true)` |
| `[7]` | expression/reference | `prop("Move Duration", "number", 0)` |
| `[8]` | expression/reference | `prop("Move Direction", "string", "", "Direction")` |
| `[9]` | expression/reference | `prop("Wait Animation", "string", "")` |
| `[10]` | expression/reference | `prop("Wait Loop", "bool", true)` |
| `[11]` | expression/reference | `prop("Next Waypoint 1", "object", "")` |
| `[12]` | expression/reference | `prop("Next Waypoint 2", "object", "")` |
| `[13]` | expression/reference | `prop("Next Waypoint 3", "object", "")` |
| `[14]` | expression/reference | `prop("Next Waypoint 4", "object", "")` |
| `[15]` | expression/reference | `prop("Next Waypoint 5", "object", "")` |

### 76. `members` — line 455

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Radius", "number", 1)` |
| `[2]` | expression/reference | `prop("Name", "string", "")` |
| `[3]` | expression/reference | `prop("Path", "file", "")` |
| `[4]` | expression/reference | `prop("Once", "bool", false)` |

### 77. `members` — line 465

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 78. `members` — line 470

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Name", "string", "")` |
| `[2]` | expression/reference | `prop("Type", "string", "item", "ItemType")` |
| `[3]` | expression/reference | `prop("Description", "string", "")` |
| `[4]` | expression/reference | `prop("Amount", "number", 1)` |
| `[5]` | expression/reference | `prop("Price", "number", 999999)` |

### 79. `members` — line 481

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Dialogue Type", "string", "first", "DialogueType")` |
| `[2]` | expression/reference | `prop("Event Name", "string", "")` |
| `[3]` | expression/reference | `prop("Mugshot", "string", "")` |
| `[4]` | expression/reference | `prop("Text 1", "string", "")` |
| `[5]` | expression/reference | `prop("Text 2", "string", "")` |
| `[6]` | expression/reference | `prop("Text 3", "string", "")` |
| `[7]` | expression/reference | `prop("Next 1", "object", "")` |
| `[8]` | expression/reference | `prop("Next 2", "object", "")` |
| `[9]` | expression/reference | `prop("Next 3", "object", "")` |
| `[10]` | expression/reference | `prop("Next 4", "object", "")` |
| `[11]` | expression/reference | `prop("Next 5", "object", "")` |
| `[12]` | expression/reference | `prop("Item 1", "object", "")` |
| `[13]` | expression/reference | `prop("Item 2", "object", "")` |
| `[14]` | expression/reference | `prop("Take Item", "bool", false)` |
| `[15]` | expression/reference | `prop("Date", "string", "")` |
| `[16]` | expression/reference | `prop("Quest Name", "string", "")` |
| `[17]` | expression/reference | `prop("Event Value", "string", "")` |
| `[18]` | expression/reference | `prop("Dont Notify", "bool", false)` |
| `[19]` | expression/reference | `prop("Email Id", "string", "")` |
| `[20]` | expression/reference | `prop("Email Icon", "number", 1)` |
| `[21]` | expression/reference | `prop("Email Title", "string", "Mail")` |
| `[22]` | expression/reference | `prop("Email From", "string", "???")` |
| `[23]` | expression/reference | `prop("Body 1", "string", "")` |
| `[24]` | expression/reference | `prop("Body 2", "string", "")` |
| `[25]` | expression/reference | `prop("Body 3", "string", "")` |
| `[26]` | expression/reference | `prop("Body 4", "string", "")` |
| `[27]` | expression/reference | `prop("Body 5", "string", "")` |
| `[28]` | expression/reference | `prop("Body 6", "string", "")` |
| `[29]` | expression/reference | `prop("Body 7", "string", "")` |
| `[30]` | expression/reference | `prop("Body 8", "string", "")` |
| `[31]` | expression/reference | `prop("Body 9", "string", "")` |
| `[32]` | expression/reference | `prop("Body 10", "string", "")` |
| `[33]` | expression/reference | `prop("Notify Delay", "number", 1.5)` |
| `[34]` | expression/reference | `prop("Notify Message", "string", "Looks like you got an e-mail.")` |
| `[35]` | expression/reference | `prop("Mug Texture Path", "string", "")` |
| `[36]` | expression/reference | `prop("Mug Animation Path", "string", "")` |
| `[37]` | expression/reference | `prop("Persist", "bool", true)` |
| `[38]` | expression/reference | `prop("Encounter Name", "string", "")` |
| `[39]` | expression/reference | `prop("Failure Message", "string", "")` |
| `[40]` | expression/reference | `prop("Kick On Loss", "bool", true)` |

### 80. `members` — line 527

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Target", "string", "")` |
| `[2]` | expression/reference | `prop("Follow", "bool", false)` |
| `[3]` | expression/reference | `prop("Once", "bool", false)` |

### 81. `members` — line 536

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Rush Object", "object", "")` |
| `[2]` | expression/reference | `prop("Direction", "string", "Down Left", "Direction")` |

### 82. `members` — line 544

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Mode", "string", "Compress", "CompressionMode")` |

### 83. `members` — line 551

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 84. `members` — line 556

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Asset Name", "string", "")` |
| `[2]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[3]` | expression/reference | `prop("Animation Name", "string", "")` |
| `[4]` | expression/reference | `prop("Mug Animation Name", "string", "")` |
| `[5]` | expression/reference | `prop("Active Animation", "string", "ACTIVE")` |
| `[6]` | expression/reference | `prop("Inactive Animation", "string", "INACTIVE")` |
| `[7]` | expression/reference | `prop("Activated Animation", "string", "")` |
| `[8]` | expression/reference | `prop("Deactivated Animation", "string", "")` |
| `[9]` | expression/reference | `prop("Activation Animation Duration", "number", 0.5)` |
| `[10]` | expression/reference | `prop("Deactivation Animation Duration", "number", 0.5)` |

### 85. `members` — line 572

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Bot Details", "object", "")` |
| `[2]` | expression/reference | `prop("Next 1", "object", "")` |
| `[3]` | expression/reference | `prop("Button Behavior", "string", "One-Time", "ButtonBehavior")` |
| `[4]` | expression/reference | `prop("Script Path", "file", "")` |
| `[5]` | expression/reference | `prop("Trigger Object", "object", "")` |
| `[6]` | expression/reference | `prop("Button Activated Behavior", "object", "")` |
| `[7]` | expression/reference | `prop("Button Deactivated Behavior", "object", "")` |
| `[8]` | expression/reference | `prop("Button Chain Type", "string", "Any", "ButtonChainType")` |
| `[9]` | expression/reference | `prop("Trigger Type", "string", "rect", "TriggerShape")` |
| `[10]` | expression/reference | `prop("Trigger Width", "number", 4)` |
| `[11]` | expression/reference | `prop("Trigger Height", "number", 4)` |
| `[12]` | expression/reference | `prop("Activated Time", "number", 1)` |
| `[13]` | expression/reference | `prop("Bots Can Trigger", "bool", false)` |
| `[14]` | expression/reference | `prop("Cinematic Unlock", "bool", false)` |
| `[15]` | expression/reference | `prop("Cinematic Duration", "number", 1.0)` |
| `[16]` | expression/reference | `prop("Cinematic on Bot Trigger", "bool", false)` |

### 86. `members` — line 594

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Bot Details", "object", "")` |
| `[2]` | expression/reference | `prop("Button Behavior", "string", "One-Time", "ButtonBehavior")` |
| `[3]` | expression/reference | `prop("Script Path", "file", "")` |
| `[4]` | expression/reference | `prop("Trigger Object", "object", "")` |
| `[5]` | expression/reference | `prop("Trigger Type", "string", "rect", "TriggerShape")` |
| `[6]` | expression/reference | `prop("Trigger Width", "number", 4)` |
| `[7]` | expression/reference | `prop("Trigger Height", "number", 4)` |
| `[8]` | expression/reference | `prop("Activated Time", "number", 1)` |
| `[9]` | expression/reference | `prop("Bots Can Trigger", "bool", false)` |

### 87. `members` — line 609

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Unlock This", "object", "")` |
| `[2]` | expression/reference | `prop("Unlock Permanently", "bool", false)` |
| `[3]` | expression/reference | `prop("Area Wide", "bool", false)` |

### 88. `members` — line 618

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Relock This", "object", "")` |
| `[2]` | expression/reference | `prop("Area Wide", "bool", false)` |

### 89. `members` — line 626

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Trigger Type", "string", "rect", "TriggerShape")` |

### 90. `members` — line 633

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Group ID", "string", "")` |
| `[2]` | expression/reference | `prop("Group Mode", "string", "all_active", "ButtonGroupMode")` |
| `[3]` | expression/reference | `prop("Button 1", "object", "")` |
| `[4]` | expression/reference | `prop("Forbidden Button 1", "object", "")` |
| `[5]` | expression/reference | `prop("Unlock Checkpoint 1", "object", "")` |
| `[6]` | expression/reference | `prop("Unlock Permanently", "bool", true)` |
| `[7]` | expression/reference | `prop("Unlock Area Wide", "bool", false)` |
| `[8]` | expression/reference | `prop("Relock Checkpoint 1", "object", "")` |
| `[9]` | expression/reference | `prop("Relock Area Wide", "bool", false)` |
| `[10]` | expression/reference | `prop("Cinematic Unlock", "bool", false)` |
| `[11]` | expression/reference | `prop("Cinematic Duration", "number", 1.0)` |
| `[12]` | expression/reference | `prop("Cinematic on Bot Trigger", "bool", false)` |

### 91. `members` — line 651

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Button 1", "object", "")` |
| `[2]` | expression/reference | `prop("Forbidden Button 1", "object", "")` |
| `[3]` | expression/reference | `prop("Unlock Checkpoint 1", "object", "")` |
| `[4]` | expression/reference | `prop("Unlock Permanently", "bool", true)` |
| `[5]` | expression/reference | `prop("Unlock Area Wide", "bool", false)` |
| `[6]` | expression/reference | `prop("Relock Checkpoint 1", "object", "")` |
| `[7]` | expression/reference | `prop("Relock Area Wide", "bool", false)` |

### 92. `members` — line 664

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Group ID", "string", "")` |
| `[2]` | expression/reference | `prop("Combo Mode", "string", "Inclusive", "ButtonComboMode")` |
| `[3]` | expression/reference | `prop("Button Combo 1", "object", "")` |
| `[4]` | expression/reference | `prop("Cinematic Unlock", "bool", false)` |
| `[5]` | expression/reference | `prop("Cinematic Duration", "number", 1.0)` |
| `[6]` | expression/reference | `prop("Cinematic on Bot Trigger", "bool", false)` |

### 93. `members` — line 676

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Source Button", "object", "")` |
| `[2]` | expression/reference | `prop("Event", "string", "activated", "ButtonEffectEvent")` |
| `[3]` | expression/reference | `prop("Target Button", "object", "")` |
| `[4]` | expression/reference | `prop("Action", "string", "activate", "ButtonEffectAction")` |

### 94. `members` — line 686

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Button Group", "object", "")` |
| `[2]` | expression/reference | `prop("Event", "string", "completed", "ButtonGroupEvent")` |
| `[3]` | expression/reference | `prop("Target Button", "object", "")` |
| `[4]` | expression/reference | `prop("Action", "string", "activate", "ButtonEffectAction")` |

### 95. `members` — line 696

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Name", "string", "")` |
| `[2]` | expression/reference | `prop("Start Step", "object", "")` |
| `[3]` | expression/reference | `prop("Trigger Radius", "number", 0)` |
| `[4]` | expression/reference | `prop("Once", "bool", false)` |

### 96. `members` — line 706

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Type", "string", "Wait", "CutsceneStepType")` |
| `[2]` | expression/reference | `prop("Next Step", "object", "")` |
| `[3]` | expression/reference | `prop("Next 1", "object", "")` |
| `[4]` | expression/reference | `prop("Next 2", "object", "")` |
| `[5]` | expression/reference | `prop("Next 3", "object", "")` |
| `[6]` | expression/reference | `prop("Fail Next", "object", "")` |
| `[7]` | expression/reference | `-- Wait prop("Wait Seconds", "number", 1)` |
| `[8]` | expression/reference | `-- Move Actor / Set Pose / Move Camera prop("Actor", "object", "")` |
| `[9]` | expression/reference | `prop("Target", "object", "")` |
| `[10]` | expression/reference | `prop("Target X", "number", 0)` |
| `[11]` | expression/reference | `prop("Target Y", "number", 0)` |
| `[12]` | expression/reference | `prop("Target Z", "number", 0)` |
| `[13]` | expression/reference | `-- Move Actor prop("Move Animation", "string", "")` |
| `[14]` | expression/reference | `prop("Move Direction", "string", "", "Direction")` |
| `[15]` | expression/reference | `prop("Move Speed", "number", 3)` |
| `[16]` | expression/reference | `prop("End Animation", "string", "")` |
| `[17]` | expression/reference | `prop("End Direction", "string", "", "Direction")` |
| `[18]` | expression/reference | `prop("End Hold Seconds", "number", 0)` |
| `[19]` | expression/reference | `prop("End Loop", "bool", true)` |
| `[20]` | expression/reference | `-- Set Pose prop("Animation", "string", "")` |
| `[21]` | expression/reference | `prop("Direction", "string", "", "Direction")` |
| `[22]` | expression/reference | `prop("Loop", "bool", true)` |
| `[23]` | expression/reference | `prop("Hold Seconds", "number", 0)` |
| `[24]` | expression/reference | `-- Show Message / Ask Quiz / Prompt Player prop("Speaker", "object", "")` |
| `[25]` | expression/reference | `prop("Mugshot Override", "string", "")` |
| `[26]` | expression/reference | `prop("Text", "string", "")` |
| `[27]` | expression/reference | `prop("Question", "string", "")` |
| `[28]` | expression/reference | `prop("Option 1", "string", "")` |
| `[29]` | expression/reference | `prop("Option 2", "string", "")` |
| `[30]` | expression/reference | `prop("Option 3", "string", "")` |
| `[31]` | expression/reference | `prop("Message", "string", "")` |
| `[32]` | expression/reference | `prop("Expected", "string", "")` |
| `[33]` | expression/reference | `-- Play Sound prop("Sound Path", "string", "")` |
| `[34]` | expression/reference | `-- Fade Camera / Move Camera prop("Color R", "number", 0)` |
| `[35]` | expression/reference | `prop("Color G", "number", 0)` |
| `[36]` | expression/reference | `prop("Color B", "number", 0)` |
| `[37]` | expression/reference | `prop("Color A", "number", 255)` |
| `[38]` | expression/reference | `prop("Duration", "number", 0.8)` |
| `[39]` | expression/reference | `-- Emit Event prop("Event Name", "string", "")` |

### 97. `useAs` — line 767

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 98. `members` — line 768

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Path", "string", "")` |
| `[2]` | expression/reference | `prop("Loop Start", "number", 0)` |
| `[3]` | expression/reference | `prop("Loop End", "number", 0)` |

### 99. `members` — line 777

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Liberation-specific settings. Encounter Music references a -- reusable Music Definition object placed in the base area. -- Background texture, animatio…` |
| `[2]` | expression/reference | `prop("Waiting Area", "string", "")` |
| `[3]` | expression/reference | `prop("Liberation Tileset", "string", "")` |
| `[4]` | expression/reference | `prop("Max Order Points", "number", 9)` |
| `[5]` | expression/reference | `prop("Target Phase Count", "number", 13)` |
| `[6]` | expression/reference | `prop("Target Player Count", "number", 3)` |
| `[7]` | expression/reference | `prop("Minimum Target Phase Count", "number", 1)` |
| `[8]` | expression/reference | `prop("Victory Lap Song", "string", "")` |
| `[9]` | expression/reference | `prop("Encounter Music", "object", "")` |
| `[10]` | expression/reference | `prop("Honor HPMem", "bool", false)` |

### 100. `members` — line 797

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Liberation Map File Name", "string", "")` |

### 101. `useAs` — line 804

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 102. `members` — line 805

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Next Spawn", "object", "")` |
| `[2]` | expression/reference | `prop("Facing Direction", "string", "Down", "Direction")` |

### 103. `useAs` — line 815

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 104. `members` — line 816

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Boss", "string", "")` |
| `[2]` | expression/reference | `prop("Boss ID", "string", "")` |
| `[3]` | expression/reference | `prop("Direction", "string", "Down", "Direction")` |
| `[4]` | expression/reference | `prop("Spawn Mode", "string", "Immediate", "BossSpawnMode")` |
| `[5]` | expression/reference | `prop("Trigger Boss", "object", "")` |
| `[6]` | expression/reference | `prop("Spawn Offset X", "number", 0)` |
| `[7]` | expression/reference | `prop("Spawn Offset Y", "number", 0)` |
| `[8]` | expression/reference | `prop("Spawn Offset Z", "number", 0)` |
| `[9]` | expression/reference | `prop("Auto Face Player", "bool", false)` |
| `[10]` | expression/reference | `prop("Boss Health Override", "number", 0)` |
| `[11]` | expression/reference | `prop("scale", "number", 1)` |
| `[12]` | expression/reference | `prop("Spawn Enabled", "bool", true)` |
| `[13]` | expression/reference | `prop("Boss Display Name", "string", "")` |
| `[14]` | expression/reference | `prop("Enemy Config", "object", 0)` |
| `[15]` | expression/reference | `prop("Encounter Mode", "string", "Auto", "LiberationEncounterMode")` |
| `[16]` | expression/reference | `prop("Encounter Category", "string", "Auto", "LiberationEncounterCategory")` |
| `[17]` | expression/reference | `prop("OW Encounter Pool", "object", 0)` |
| `[18]` | expression/reference | `prop("Max HP", "int", 0)` |
| `[19]` | expression/reference | `prop("Starting HP", "int", 0)` |
| `[20]` | expression/reference | `prop("OW Scale", "float", 0)` |
| `[21]` | expression/reference | `prop("Battle Scale", "float", 0)` |
| `[22]` | expression/reference | `prop("Battle Scale Scope", "string", "Auto", "LiberationBattleScaleScope")` |
| `[23]` | expression/reference | `prop("OW Attack Damage", "int", 0)` |
| `[24]` | expression/reference | `prop("OW Damage Multiplier", "float", 0)` |
| `[25]` | expression/reference | `prop("Battle Attack Multiplier", "float", 0)` |
| `[26]` | expression/reference | `prop("Battle Defense Multiplier", "float", 0)` |
| `[27]` | expression/reference | `prop("AI Type", "string", "Auto", "LiberationAIType")` |
| `[28]` | expression/reference | `prop("OW Bot Encounter", "string", "")` |

### 105. `useAs` — line 852

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 106. `fields` — line 854

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 107. `useAs` — line 869

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 108. `useAs` — line 875

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 109. `useAs` — line 881

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 110. `members` — line 882

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Boss ID 1", "string", "")` |
| `[2]` | expression/reference | `prop("Boss ID 2", "string", "")` |
| `[3]` | expression/reference | `prop("Type", "string", "All", "BossRequirementType")` |
| `[4]` | expression/reference | `prop("Shared", "bool", false)` |

### 111. `useAs` — line 894

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 112. `members` — line 895

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Spawns", "string", "")` |
| `[2]` | expression/reference | `prop("Max HP", "int", 0)` |
| `[3]` | expression/reference | `prop("Starting HP", "int", 0)` |
| `[4]` | expression/reference | `prop("OW Scale", "float", 0)` |
| `[5]` | expression/reference | `prop("Battle Scale", "float", 0)` |
| `[6]` | expression/reference | `prop("Battle Scale Scope", "string", "Auto", "LiberationBattleScaleScope")` |
| `[7]` | expression/reference | `prop("OW Attack Damage", "int", 0)` |
| `[8]` | expression/reference | `prop("OW Damage Multiplier", "float", 0)` |
| `[9]` | expression/reference | `prop("Battle Attack Multiplier", "float", 0)` |
| `[10]` | expression/reference | `prop("Battle Defense Multiplier", "float", 0)` |
| `[11]` | expression/reference | `prop("AI Type", "string", "Auto", "LiberationAIType")` |
| `[12]` | expression/reference | `prop("Encounter Mode", "string", "Auto", "LiberationEncounterMode")` |
| `[13]` | expression/reference | `prop("Encounter Category", "string", "Auto", "LiberationEncounterCategory")` |
| `[14]` | expression/reference | `prop("OW Bot Encounter", "string", "")` |
| `[15]` | expression/reference | `prop("OW Encounter Pool", "object", 0)` |

### 113. `useAs` — line 916

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 114. `members` — line 917

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Category", "string", "All", "LiberationEnemyCategory")` |
| `[2]` | expression/reference | `prop("Max HP", "int", 0)` |
| `[3]` | expression/reference | `prop("Starting HP", "int", 0)` |
| `[4]` | expression/reference | `prop("OW Scale", "float", 0)` |
| `[5]` | expression/reference | `prop("Battle Scale", "float", 0)` |
| `[6]` | expression/reference | `prop("Battle Scale Scope", "string", "Auto", "LiberationBattleScaleScope")` |
| `[7]` | expression/reference | `prop("OW Attack Damage", "int", 0)` |
| `[8]` | expression/reference | `prop("OW Damage Multiplier", "float", 0)` |
| `[9]` | expression/reference | `prop("Battle Attack Multiplier", "float", 0)` |
| `[10]` | expression/reference | `prop("Battle Defense Multiplier", "float", 0)` |
| `[11]` | expression/reference | `prop("AI Type", "string", "Auto", "LiberationAIType")` |
| `[12]` | expression/reference | `prop("Encounter Mode", "string", "Auto", "LiberationEncounterMode")` |
| `[13]` | expression/reference | `prop("Encounter Category", "string", "Auto", "LiberationEncounterCategory")` |
| `[14]` | expression/reference | `prop("OW Bot Encounter", "string", "")` |
| `[15]` | expression/reference | `prop("OW Encounter Pool", "object", 0)` |

### 115. `useAs` — line 938

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"object"` |

### 116. `members` — line 939

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `prop("Encounter Category", "string", "Auto", "LiberationEncounterCategory")` |
| `[2]` | expression/reference | `prop("Name 1", "string", "")` |
| `[3]` | expression/reference | `prop("Weight 1", "float", 1)` |
| `[4]` | expression/reference | `prop("Name 2", "string", "")` |
| `[5]` | expression/reference | `prop("Weight 2", "float", 1)` |
| `[6]` | expression/reference | `prop("Name 3", "string", "")` |
| `[7]` | expression/reference | `prop("Weight 3", "float", 1)` |
| `[8]` | expression/reference | `prop("Name 4", "string", "")` |
| `[9]` | expression/reference | `prop("Weight 4", "float", 1)` |
| `[10]` | expression/reference | `prop("Name 5", "string", "")` |
| `[11]` | expression/reference | `prop("Weight 5", "float", 1)` |
| `[12]` | expression/reference | `prop("Name 6", "string", "")` |
| `[13]` | expression/reference | `prop("Weight 6", "float", 1)` |
| `[14]` | expression/reference | `prop("Name 7", "string", "")` |
| `[15]` | expression/reference | `prop("Weight 7", "float", 1)` |
| `[16]` | expression/reference | `prop("Name 8", "string", "")` |
| `[17]` | expression/reference | `prop("Weight 8", "float", 1)` |
| `[18]` | expression/reference | `prop("Name 9", "string", "")` |
| `[19]` | expression/reference | `prop("Weight 9", "float", 1)` |
| `[20]` | expression/reference | `prop("Name 10", "string", "")` |
| `[21]` | expression/reference | `prop("Weight 10", "float", 1)` |
| `[22]` | expression/reference | `prop("Name 11", "string", "")` |
| `[23]` | expression/reference | `prop("Weight 11", "float", 1)` |
| `[24]` | expression/reference | `prop("Name 12", "string", "")` |
| `[25]` | expression/reference | `prop("Weight 12", "float", 1)` |
| `[26]` | expression/reference | `prop("Name 13", "string", "")` |
| `[27]` | expression/reference | `prop("Weight 13", "float", 1)` |
| `[28]` | expression/reference | `prop("Name 14", "string", "")` |
| `[29]` | expression/reference | `prop("Weight 14", "float", 1)` |
| `[30]` | expression/reference | `prop("Name 15", "string", "")` |
| `[31]` | expression/reference | `prop("Weight 15", "float", 1)` |
| `[32]` | expression/reference | `prop("Name 16", "string", "")` |
| `[33]` | expression/reference | `prop("Weight 16", "float", 1)` |
| `[34]` | expression/reference | `prop("Name 17", "string", "")` |
| `[35]` | expression/reference | `prop("Weight 17", "float", 1)` |
| `[36]` | expression/reference | `prop("Name 18", "string", "")` |
| `[37]` | expression/reference | `prop("Weight 18", "float", 1)` |
| `[38]` | expression/reference | `prop("Name 19", "string", "")` |
| `[39]` | expression/reference | `prop("Weight 19", "float", 1)` |
| `[40]` | expression/reference | `prop("Name 20", "string", "")` |
| `[41]` | expression/reference | `prop("Weight 20", "float", 1)` |

### 117. `META` — line 988

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `classes` | nested table | `{ ["Checkpoint"] = { category = "gameplay", description = "Lockable Security Cube that gates progression.", numberedTemplates = { "Navi " } }, ["Mystery D…` |
| `properties` | nested table | `{ ["Music Definition"] = { ["Path"] = { category = "appearance", description = "Song filename without extension, resolved under the encounter package's mu…` |

### 118. `classes` — line 989

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `["Checkpoint"]` | nested table | `{ category = "gameplay", description = "Lockable Security Cube that gates progression.", numberedTemplates = { "Navi " } }` |
| `[2]` | expression/reference | `["Mystery Data"] = { category = "gameplay", description = "Pickup or event; behaviour branches on Type." }` |
| `[3]` | expression/reference | `["Quiz List"] = { category = "dialogue", description = "Ordered chain of Quiz Question objects.", numberedTemplates = { "Next " } }` |
| `[4]` | expression/reference | `["Quiz Question"] = { category = "dialogue", description = "Single quiz entry." }` |
| `["Dialogue"]` | nested table | `{ category = "dialogue", description = "Dialogue node. Many properties are type-specific; see the Conditional section.", numberedTemplates = { "Text ", "N…` |
| `["NPC"]` | nested table | `{ category = "gameplay", description = "Placed non-player character. Set Template Only to use an NPC purely as a reference target for NPC Spawners witho…` |
| `[7]` | expression/reference | `["Pushback NPC"] = { category = "gameplay", description = "NPC with a moving collision zone that pushes the player." }` |
| `[8]` | expression/reference | `["NPC Spawner"] = { category = "gameplay", description = "Spawns NPCs from a template object, lets them follow a waypoint path, and optionally warps them …` |
| `[9]` | expression/reference | `["FootBomb Controller"] = { category = "gameplay", description = "Interaction actor for the FootBomb minigame." }` |
| `[10]` | expression/reference | `["Music Definition"] = { category = "gameplay", description = "Reusable encounter music settings. Path is a song name relative to the encounter package's …` |
| `[11]` | expression/reference | `["Liberation Config"] = { category = "gameplay", description = "Configuration object for a liberation mission. Liberation Tileset, Max Order Points, and E…` |
| `[12]` | expression/reference | `["Liberation Gate"] = { category = "gameplay", description = "Interactive gate that starts the liberation mission named by Liberation Map File Name." }` |
| `[13]` | expression/reference | `["Spawn Point"] = { category = "gameplay", description = "Player arrival point for Liberation missions. The assigned player faces this direction after tra…` |
| `[14]` | expression/reference | `["Boss Dark Panel"] = { category = "gameplay", description = "A Liberation boss spawn point. Select an enemy template, spawn mode, optional boss dependenc…` |
| `[15]` | expression/reference | `["Dark Hole Encounter List"] = { category = "gameplay", description = "Reusable list of named encounters from this area's special_encounters section, used…` |
| `[16]` | expression/reference | `["Dark Hole"] = { category = "gameplay", description = "Placed Liberation panel. Spawns/Direction define its overworld bot. OW Bot Encounter or OW Encount…` |
| `[17]` | expression/reference | `["Dark Hole Buffed Virus"] = { category = "gameplay", description = "Dark Hole variant sharing the same OW template, encounter selection, HP and scaling f…` |
| `[18]` | expression/reference | `["Indestructible Panel"] = { category = "gameplay", description = "Placed Liberation panel object. Boss ID 1/2 define boss-group unlock requirements; Type…` |
| `["Waypoint"]` | nested table | `{ category = "gameplay", description = "Navigation node for NPCs. Move Animation handles travel; Wait Animation handles the arrival hold. Set Move Duratio…` |
| `[20]` | expression/reference | `-- Button system ------------------------------------------------- ["Button Bot Details"] = { category = "appearance", description = "Visual and animation…` |
| `[21]` | expression/reference | `["OW Button"] = { category = "gameplay", description = "A pressable button. Unlocks checkpoints through a referenced Unlock Behavior. Optionally plays a c…` |
| `[22]` | expression/reference | `["OW Button Group Member"] = { category = "gameplay", description = "Button that participates in a Button Group or Button Combo but never unlocks checkpoi…` |
| `[23]` | expression/reference | `["Unlock Behavior"] = { category = "gameplay", description = "Defines which checkpoint a button unlocks when it becomes active." }` |
| `[24]` | expression/reference | `["Relock Behavior"] = { category = "gameplay", description = "Defines which checkpoint a button re-locks when it becomes inactive." }` |
| `[25]` | expression/reference | `["Button Trigger"] = { category = "gameplay", description = "Optional standalone trigger rectangle referenced by an OW Button." }` |
| `[26]` | expression/reference | `["Button Group"] = { category = "gameplay", description = "Group of OW Button Group Members that share a satisfaction rule; owns its own checkpoint unlock…` |
| `[27]` | expression/reference | `["Button Combo"] = { category = "gameplay", description = "One specific button pattern; owns its own checkpoint unlocks.", numberedTemplates = { "Button "…` |
| `[28]` | expression/reference | `["Combo Button Group"] = { category = "gameplay", description = "A set of Button Combos; satisfying any one fires that combo's actions. Optionally plays a…` |
| `[29]` | expression/reference | `["Button Effect"] = { category = "gameplay", description = "One button's state transition drives another button's action." }` |
| `[30]` | expression/reference | `["Button Group Effect"] = { category = "gameplay", description = "A group's completion transition drives another button's action." }` |
| `[31]` | expression/reference | `-- Cutscene system ----------------------------------------------- ["Cutscene"] = { category = "gameplay", description = "Named cutscene definition. Trigg…` |
| `[32]` | expression/reference | `["Cutscene Step"] = { category = "gameplay", description = "One action in a cutscene chain. Chain via Next Step; branch via Next N / Fail Next." }` |
| `[33]` | expression/reference | `["Compression Tile"] = { category = "advanced", description = "Changes player or area scale while standing inside." }` |
| `["Item"]` | nested table | `{ category = "gameplay", description = "Inventory or shop item reference." }` |
| `[35]` | expression/reference | `["Rush Road"] = { category = "advanced", description = "ezrushroads interaction object." }` |

### 119. `numberedTemplates` — line 992

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Navi "` |

### 120. `numberedTemplates` — line 997

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Next "` |

### 121. `numberedTemplates` — line 1002

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Text "` |
| `[2]` | string literal | `"Next "` |
| `[3]` | string literal | `"Item "` |
| `[4]` | string literal | `"Body "` |

### 122. `numberedTemplates` — line 1023

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Name "` |

### 123. `numberedTemplates` — line 1032

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Next Waypoint "` |

### 124. `numberedTemplates` — line 1039

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Next "` |

### 125. `numberedTemplates` — line 1050

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Button "` |
| `[2]` | string literal | `"Forbidden Button "` |
| `[3]` | string literal | `"Unlock Checkpoint "` |
| `[4]` | string literal | `"Relock Checkpoint "` |

### 126. `numberedTemplates` — line 1054

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Button "` |
| `[2]` | string literal | `"Forbidden Button "` |
| `[3]` | string literal | `"Unlock Checkpoint "` |
| `[4]` | string literal | `"Relock Checkpoint "` |

### 127. `numberedTemplates` — line 1058

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Button Combo "` |

### 128. `properties` — line 1078

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `["Music Definition"] = { ["Path"] = { category = "appearance", description = "Song filename without extension, resolved under the encounter package's musi…` |
| `[2]` | expression/reference | `["Liberation Config"] = { ["Encounter Music"] = { category = "appearance", description = "Tiled Object reference to a Music Definition used for every enco…` |
| `[3]` | expression/reference | `["Liberation Gate"] = { ["Liberation Map File Name"] = { category = "gameplay", description = "Area ID of the liberation mission this gate starts. Must ma…` |
| `[4]` | expression/reference | `["Spawn Point"] = { ["Next Spawn"] = { category = "gameplay", description = "Optional Tiled Object reference to the next Spawn Point in the player assignm…` |
| `[5]` | expression/reference | `["Boss Dark Panel"] = { ["Boss"] = { category = "gameplay", description = "Required enemy template key registered in Liberation enemy_templates.lua." }, […` |
| `[6]` | expression/reference | `["Dark Hole Encounter List"] = { -- All numbered Name fields refer to special_encounters by name. }` |
| `[7]` | expression/reference | `["Dark Hole"] = { ["Spawns"] = { category = "gameplay", description = "Registered overworld enemy template key (e.g. Mettaur). Required unless provided by…` |
| `[8]` | expression/reference | `["Dark Hole Buffed Virus"] = { ["Spawns"] = { category = "gameplay", description = "Registered overworld enemy template key. Required unless the reference…` |
| `[9]` | expression/reference | `["Indestructible Panel"] = { ["Boss ID 1"] = { category = "gameplay", description = "First boss-group identifier required to unlock this panel." }, ["Boss…` |
| `[10]` | expression/reference | `-- Checkpoint ---------------------------------------------------- ["Checkpoint"] = { ["Password"] = { category = "gameplay", description = "If set, requi…` |
| `[11]` | expression/reference | `-- NPC / Pushback / FootBomb / Spawner --------------------------- ["NPC"] = { ["Direction"] = { category = "appearance", description = "Initial facing (T…` |
| `[12]` | expression/reference | `["Pushback NPC"] = { ["Collision Enabled"] = { category = "gameplay", description = "Enables the push collision zone." }, ["Collision Width"] = { category…` |
| `[13]` | expression/reference | `["NPC Behavior"] = { ["Attached NPC"] = { category = "gameplay", description = "Object reference to an NPC or NPC template that receives this behavior.", …` |
| `[14]` | expression/reference | `["NPC Spawner"] = { ["NPC Template"] = { category = "gameplay", description = "Reference to an NPC object to spawn. The referenced NPC should have Templa…` |
| `[15]` | expression/reference | `["FootBomb Controller"] = { ["Instance Map"] = { category = "gameplay", description = "Map loaded for a match." }, ["Points to Win"] = { category = "gamep…` |
| `[16]` | expression/reference | `-- Mystery / Dialogue / Waypoint -------------------------------- ["Mystery Data"] = { ["Type"] = { category = "gameplay", description = "Selects the even…` |
| `["Dialogue"]` | nested table | `{ ["Text 1"] = { category = "dialogue", description = "Primary text; meaning varies by Dialogue Type." }, ["Text 2"] = { category = "dialogue" }, ["Text 3…` |
| `["Waypoint"]` | nested table | `{ ["Waypoint Type"] = { category = "gameplay", description = "How the next waypoint is selected." }, ["Date"] = { category = "gameplay", conditional = "On…` |
| `[19]` | expression/reference | `-- Button system ------------------------------------------------- ["Button Bot Details"] = { ["Asset Name"] = { category = "appearance", description = "S…` |
| `[20]` | expression/reference | `["OW Button"] = { ["Bot Details"] = { category = "appearance", description = "Reference to the Button Bot Details object that configures this button's app…` |
| `[21]` | expression/reference | `["OW Button Group Member"] = { ["Bot Details"] = { category = "appearance", description = "Reference to the Button Bot Details object that configures this…` |
| `[22]` | expression/reference | `["Unlock Behavior"] = { ["Unlock This"] = { category = "gameplay", description = "Checkpoint reference this behavior unlocks.", required = true }, ["Unloc…` |
| `[23]` | expression/reference | `["Relock Behavior"] = { ["Relock This"] = { category = "gameplay", description = "Checkpoint reference this behavior re-locks.", required = true }, ["Area…` |
| `[24]` | expression/reference | `["Button Trigger"] = { ["Trigger Type"] = { category = "gameplay", description = "Rectangle vs ellipse detection shape for the referenced trigger object."…` |
| `[25]` | expression/reference | `["Button Group"] = { ["Group ID"] = { category = "gameplay", description = "Optional stable identifier. Falls back to the object's Tiled ID." }, ["Group M…` |
| `[26]` | expression/reference | `["Button Combo"] = { ["Button 1"] = { category = "gameplay", description = "Reference to a required OW Button Group Member. Add Button 2..N as needed.", r…` |
| `[27]` | expression/reference | `["Combo Button Group"] = { ["Group ID"] = { category = "gameplay", description = "Optional stable identifier. Falls back to the object's Tiled ID." }, ["C…` |
| `[28]` | expression/reference | `["Button Effect"] = { ["Source Button"] = { category = "gameplay", description = "Button whose state transition triggers this effect.", required = true },…` |
| `[29]` | expression/reference | `["Button Group Effect"] = { ["Button Group"] = { category = "gameplay", description = "Button Group (or Combo Button Group) whose completion transition tr…` |
| `[30]` | expression/reference | `-- Cutscene system ----------------------------------------------- ["Cutscene"] = { ["Name"] = { category = "gameplay", description = "Unique cutscene ide…` |
| `[31]` | expression/reference | `["Cutscene Step"] = { ["Type"] = { category = "gameplay", description = "Which action this step performs.", required = true }, ["Next Step"] = { category …` |

### 129. `dependsOn` — line 1182

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Key Type"` |
| `equals` | string literal | `"item"` |

### 130. `dependsOn` — line 1206

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Key Type"` |
| `equals` | string literal | `"navi_name"` |

### 131. `dependsOn` — line 1210

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Key Type"` |
| `equals` | string literal | `"navi_element"` |

### 132. `dependsOn` — line 1214

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Key Type"` |
| `equals` | string literal | `"navi_list"` |

### 133. `dependsOn` — line 1247

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Quest Exclusive"` |

### 134. `dependsOn` — line 1303

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Spawn Mode"` |
| `equals` | string literal | `"Interval"` |

### 135. `dependsOn` — line 1307

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Spawn Mode"` |
| `equals` | string literal | `"Interval"` |

### 136. `dependsOn` — line 1311

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Spawn Mode"` |
| `equals` | string literal | `"Once"` |

### 137. `dependsOn` — line 1317

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Warp Out At End"` |

### 138. `dependsOn` — line 1321

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Warp Out At End"` |

### 139. `dependsOn` — line 1325

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Warp Out At End"` |

### 140. `dependsOn` — line 1342

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"quiz"` |

### 141. `dependsOn` — line 1345

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"quiz"` |

### 142. `dependsOn` — line 1348

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"quiz"` |

### 143. `dependsOn` — line 1351

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"quiz"` |

### 144. `dependsOn` — line 1354

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"quiz"` |

### 145. `dependsOn` — line 1359

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cost Type"` |

### 146. `dependsOn` — line 1362

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cost Type"` |

### 147. `dependsOn` — line 1374

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `oneOf` | nested table | `{ "item", "itemcheck", "shop" }` |

### 148. `oneOf` — line 1375

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"item"` |
| `[2]` | string literal | `"itemcheck"` |
| `[3]` | string literal | `"shop"` |

### 149. `dependsOn` — line 1378

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"itemcheck"` |

### 150. `dependsOn` — line 1381

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `oneOf` | nested table | `{ "before", "after" }` |

### 151. `oneOf` — line 1382

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"before"` |
| `[2]` | string literal | `"after"` |

### 152. `dependsOn` — line 1385

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `oneOf` | nested table | `{ "quest_switch", "quest_event", "questcheck" }` |

### 153. `oneOf` — line 1386

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"quest_switch"` |
| `[2]` | string literal | `"quest_event"` |
| `[3]` | string literal | `"questcheck"` |

### 154. `dependsOn` — line 1389

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"quest_event"` |

### 155. `dependsOn` — line 1392

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"email"` |

### 156. `dependsOn` — line 1395

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"email"` |

### 157. `dependsOn` — line 1398

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"email"` |

### 158. `dependsOn` — line 1401

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"email"` |

### 159. `dependsOn` — line 1404

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"email"` |

### 160. `dependsOn` — line 1407

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"email"` |

### 161. `dependsOn` — line 1410

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"email"` |

### 162. `dependsOn` — line 1413

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `oneOf` | nested table | `{ "item", "email" }` |

### 163. `oneOf` — line 1414

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"item"` |
| `[2]` | string literal | `"email"` |

### 164. `dependsOn` — line 1417

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"battle_npc"` |

### 165. `dependsOn` — line 1420

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"battle_npc"` |

### 166. `dependsOn` — line 1426

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Dialogue Type"` |
| `equals` | string literal | `"battle_npc"` |

### 167. `dependsOn` — line 1433

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Waypoint Type"` |
| `oneOf` | nested table | `{ "before", "after" }` |

### 168. `oneOf` — line 1434

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"before"` |
| `[2]` | string literal | `"after"` |

### 169. `dependsOn` — line 1443

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Move Animation"` |

### 170. `dependsOn` — line 1447

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Move Animation"` |

### 171. `dependsOn` — line 1457

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Wait Animation"` |

### 172. `dependsOn` — line 1501

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Behavior"` |
| `equals` | string literal | `"Custom"` |

### 173. `dependsOn` — line 1522

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Behavior"` |
| `equals` | string literal | `"Timed"` |

### 174. `dependsOn` — line 1526

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Behavior"` |
| `oneOf` | nested table | `{ "Pressure Plate", "One-Time", "Toggle", "Timed" }` |

### 175. `oneOf` — line 1527

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Pressure Plate"` |
| `[2]` | string literal | `"One-Time"` |
| `[3]` | string literal | `"Toggle"` |
| `[4]` | string literal | `"Timed"` |

### 176. `dependsOn` — line 1531

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Activated Behavior"` |

### 177. `dependsOn` — line 1535

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cinematic Unlock"` |

### 178. `dependsOn` — line 1539

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cinematic Unlock"` |

### 179. `dependsOn` — line 1549

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Behavior"` |
| `equals` | string literal | `"Custom"` |

### 180. `dependsOn` — line 1564

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Behavior"` |
| `equals` | string literal | `"Timed"` |

### 181. `dependsOn` — line 1568

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Behavior"` |
| `oneOf` | nested table | `{ "Pressure Plate", "One-Time", "Toggle", "Timed" }` |

### 182. `oneOf` — line 1569

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Pressure Plate"` |
| `[2]` | string literal | `"One-Time"` |
| `[3]` | string literal | `"Toggle"` |
| `[4]` | string literal | `"Timed"` |

### 183. `dependsOn` — line 1605

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Group Mode"` |
| `equals` | string literal | `"combination"` |

### 184. `dependsOn` — line 1620

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Unlock Checkpoint 1"` |

### 185. `dependsOn` — line 1624

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cinematic Unlock"` |

### 186. `dependsOn` — line 1628

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cinematic Unlock"` |

### 187. `dependsOn` — line 1661

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Button Combo 1"` |

### 188. `dependsOn` — line 1665

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cinematic Unlock"` |

### 189. `dependsOn` — line 1669

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Cinematic Unlock"` |

### 190. `dependsOn` — line 1719

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Ask Quiz"` |

### 191. `dependsOn` — line 1722

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Ask Quiz"` |

### 192. `dependsOn` — line 1725

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Ask Quiz"` |

### 193. `dependsOn` — line 1729

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Prompt Player"` |

### 194. `dependsOn` — line 1733

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Wait"` |

### 195. `dependsOn` — line 1738

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Move Actor", "Set Pose" }` |

### 196. `oneOf` — line 1739

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Actor"` |
| `[2]` | string literal | `"Set Pose"` |

### 197. `dependsOn` — line 1746

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Move Actor", "Move Camera" }` |

### 198. `oneOf` — line 1747

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Actor"` |
| `[2]` | string literal | `"Move Camera"` |

### 199. `dependsOn` — line 1750

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Move Actor", "Move Camera" }` |

### 200. `oneOf` — line 1751

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Actor"` |
| `[2]` | string literal | `"Move Camera"` |

### 201. `dependsOn` — line 1754

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Move Actor", "Move Camera" }` |

### 202. `oneOf` — line 1755

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Actor"` |
| `[2]` | string literal | `"Move Camera"` |

### 203. `dependsOn` — line 1758

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Move Actor", "Move Camera" }` |

### 204. `oneOf` — line 1759

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Actor"` |
| `[2]` | string literal | `"Move Camera"` |

### 205. `dependsOn` — line 1764

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Move Actor"` |

### 206. `dependsOn` — line 1768

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Move Actor"` |

### 207. `dependsOn` — line 1772

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Move Actor"` |

### 208. `dependsOn` — line 1776

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Move Actor"` |

### 209. `dependsOn` — line 1779

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Move Actor"` |

### 210. `dependsOn` — line 1783

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Move Actor"` |

### 211. `dependsOn` — line 1786

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Move Actor"` |

### 212. `dependsOn` — line 1791

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Set Pose"` |

### 213. `dependsOn` — line 1794

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Set Pose"` |

### 214. `dependsOn` — line 1797

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Set Pose"` |

### 215. `dependsOn` — line 1801

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Set Pose"` |

### 216. `dependsOn` — line 1806

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Show Message", "Ask Quiz", "Prompt Player" }` |

### 217. `oneOf` — line 1807

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Show Message"` |
| `[2]` | string literal | `"Ask Quiz"` |
| `[3]` | string literal | `"Prompt Player"` |

### 218. `dependsOn` — line 1811

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Show Message", "Ask Quiz", "Prompt Player" }` |

### 219. `oneOf` — line 1812

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Show Message"` |
| `[2]` | string literal | `"Ask Quiz"` |
| `[3]` | string literal | `"Prompt Player"` |

### 220. `dependsOn` — line 1815

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Show Message"` |

### 221. `dependsOn` — line 1818

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Ask Quiz"` |

### 222. `dependsOn` — line 1821

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Ask Quiz"` |

### 223. `dependsOn` — line 1824

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Ask Quiz"` |

### 224. `dependsOn` — line 1828

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Ask Quiz"` |

### 225. `dependsOn` — line 1832

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Prompt Player"` |

### 226. `dependsOn` — line 1836

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Prompt Player"` |

### 227. `dependsOn` — line 1840

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Play Sound"` |

### 228. `dependsOn` — line 1844

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Fade Camera"` |

### 229. `dependsOn` — line 1847

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Fade Camera"` |

### 230. `dependsOn` — line 1850

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Fade Camera"` |

### 231. `dependsOn` — line 1853

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Fade Camera"` |

### 232. `dependsOn` — line 1857

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `oneOf` | nested table | `{ "Fade Camera", "Move Camera" }` |

### 233. `oneOf` — line 1858

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Fade Camera"` |
| `[2]` | string literal | `"Move Camera"` |

### 234. `dependsOn` — line 1863

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `property` | string literal | `"Type"` |
| `equals` | string literal | `"Emit Event"` |

### 235. `errors` — line 1872

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 236. `seen_classes` — line 1877

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 237. `seen` — line 1886

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 238. `METADATA_FIELDS` — line 1935

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `category` | boolean literal | `true` |
| `required` | boolean literal | `true` |
| `description` | boolean literal | `true` |
| `conditional` | boolean literal | `true` |
| `dependsOn` | boolean literal | `true` |

### 239. `out` — line 1941

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 240. `out` — line 1949

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 241. `output` — line 1957

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 242. `enum_names` — line 1960

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 243. `parts` — line 2013

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 244. `keys` — line 2019

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 245. `parts` — line 2022

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 246. `out` — line 2039

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 247. `lines` — line 2049

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 248. `enum_names` — line 2055

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 249. `CATEGORY_ORDER` — line 2087

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `appearance` | numeric literal | `1` |
| `dialogue` | numeric literal | `2` |
| `gameplay` | numeric literal | `3` |
| `advanced` | numeric literal | `4` |

### 250. `parts` — line 2143

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 251. `lines` — line 2157

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 252. `enum_names` — line 2167

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 253. `sorted` — line 2188

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 254. `parts` — line 2211

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 255. `return` — line 2308

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `generate` | expression/reference | `main` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
