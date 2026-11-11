# 📄 `enemy_templates.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua)  
> **Source lines:** 271  
> **SHA-256 (UTF-8):** `ae067b5a8437a3…`  
> **Declared/assigned functions detected:** 10  
> **Anonymous closures detected:** 5  
> **Table initializers detected:** 5

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

Enemy behaviour, health, and assets live here. Encounters do NOT live here: they are always resolved from the area's Liberation Encounters custom property via PanelEncounters.resolve_encounter(base_area_id), which routes through ezencounters. Do not add a per-template encounter path — it will be ignored by instance.lua.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 8 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| 9 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| 10 | `scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception` |
| 11 | `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| 12 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |
| 13 | `scripts/libs/direction` |
| 15 | `scripts/ezlibs-custom/nebulous-liberations/liberations/logger` |
| 258 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_bigbrute` |
| 259 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_blizzardman` |
| 260 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_shademan` |
| 269 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/mettaur` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 21 | `EnemyTemplates.has` | `name` | declared |
| 25 | `EnemyTemplates.register` | `name, template` | declared |
| 30 | `EnemyTemplates.create` | `instance, position, direction, template_name, spawn_options` | declared |
| 113 | `spawn` | `self, direction` | assigned |
| 137 | `get_death_message` | `self` | assigned |
| 140 | `take_turn` | `self` | assigned |
| 153 | `sign` | `a` | local |
| 163 | `EnemyTemplates.ai.simple_charge` | `self` | declared |
| 174 | `attempt_axis` | `xstep, ystep, diff` | local |
| 252 | `EnemyTemplates.ai.ranged` | `self` | declared |

### Function details

#### 1. `EnemyTemplates.has(name)`

- **Location:** source line 21.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a template

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |

#### 2. `EnemyTemplates.register(name, template)`

- **Location:** source line 25.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |
| 2 | `template` | Not explicitly documented in adjacent source annotations. |

#### 3. `EnemyTemplates.create(instance, position, direction, template_name, spawn_options)`

- **Location:** source line 30.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create an enemy instance from a template

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `position` | Not explicitly documented in adjacent source annotations. |
| 3 | `direction` | Not explicitly documented in adjacent source annotations. |
| 4 | `template_name` | Not explicitly documented in adjacent source annotations. |
| 5 | `spawn_options` | Not explicitly documented in adjacent source annotations. |

#### 4. `spawn(self, direction)`

- **Location:** source line 113.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 5. `get_death_message(self)`

- **Location:** source line 137.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 6. `take_turn(self)`

- **Location:** source line 140.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 7. `sign(a)`

- **Location:** source line 153.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |

#### 8. `EnemyTemplates.ai.simple_charge(self)`

- **Location:** source line 163.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 9. `attempt_axis(xstep, ystep, diff)`

- **Location:** source line 174.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `xstep` | Not explicitly documented in adjacent source annotations. |
| 2 | `ystep` | Not explicitly documented in adjacent source annotations. |
| 3 | `diff` | Not explicitly documented in adjacent source annotations. |

#### 10. `EnemyTemplates.ai.ranged(self)`

- **Location:** source line 252.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 149 | `resolve` | `rn EnemyTemplates.ai.shockwave_line(self) else return Async.create_promise(` |
| 164 | `(none)` | `plates.ai = {} function EnemyTemplates.ai.simple_charge(self) local co = coroutine.c…` |
| 175 | `resolve` | `local function attempt_axis(xstep, ystep, diff) return Async.create_promise(` |
| 193 | `(none)` | `EnemyHelpers.move(self.instance, self, targetx, targety, self.z, target_direction).a…` |
| 254 | `resolve` | `nd function EnemyTemplates.ai.ranged(self) -- placeholder return Async.create_promis…` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `EnemyTemplates` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `enemy` — line 40

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instance` | expression/reference | `instance` |
| `id` | nil | `nil` |
| `[3]` | expression/reference | `-- Preserve the ezencounters enemy_packages alias (the key used in -- data.enemies[index].name). Display names are not guaranteed to be -- identical to th…` |
| `battle_name` | expression/reference | `template.battle_name` |
| `default_ow_bot_encounter_name` | expression/reference | `template.default_ow_bot_encounter_name` |
| `health` | expression/reference | `template.health` |
| `max_health` | expression/reference | `template.max_health` |
| `[8]` | expression/reference | `-- Preserve the enemy's intended world scale across movement. A -- spawn-specific scale overrides the template scale; normal is 1.0. -- Resolve the OW sca…` |
| `battle_scale_explicit` | expression/reference | `tonumber(template.battle_scale) ~= nil` |
| `battle_scale_scope` | expression/reference | `template.battle_scale_scope or "Matching"` |
| `scale` | expression/reference | `tonumber(spawn_options and spawn_options.scale) or tonumber(template.scale) or 1.0` |
| `x` | expression/reference | `math.floor(position.x)` |
| `y` | expression/reference | `math.floor(position.y)` |
| `z` | expression/reference | `math.floor(position.z)` |
| `selection` | expression/reference | `EnemySelection:new(instance)` |
| `mug` | expression/reference | `template.mug` |
| `is_boss` | expression/reference | `(spawn_options and spawn_options.is_boss == true) or template.is_boss or false` |
| `is_special_encounter` | expression/reference | `template.is_special_encounter or false` |
| `ai_type` | expression/reference | `template.ai_type or "simple_charge"` |
| `ai_params` | expression/reference | `template.ai_params or {}` |
| `[21]` | expression/reference | `-- These fields are read from self at runtime (spawn, attack, -- death) and must be copied explicitly; the enemy instance table -- does not otherwise in…` |
| `animation_path` | expression/reference | `template.animation_path` |
| `attack_texture` | expression/reference | `template.attack_texture` |
| `attack_animation_path` | expression/reference | `template.attack_animation_path` |
| `attack_damage` | expression/reference | `template.attack_damage` |
| `death_message` | expression/reference | `template.death_message` |
| `preload_assets` | expression/reference | `template.preload_assets` |
| `auto_face_player` | expression/reference | `spawn_options == nil or spawn_options.auto_face_player ~= false` |

### 3. `EnemyTemplates.metatable` — line 112

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `spawn` | function | `function(self, direction) local closest_session = EnemyHelpers.find_closest_player_session(self.instance, self) if self.auto_face_player and closest_sessi…` |
| `get_death_message` | function | `function(self) return self.death_message or "Gyaaaaahh!!" end` |
| `take_turn` | function | `function(self) -- Use the AI type to determine behaviour if self.ai_type == "simple_charge" then return EnemyTemplates.ai.simple_charge(self) elseif self.…` |

### 4. `EnemyTemplates.ai` — line 161

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `spawned_bots` — line 218

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 8 |
| `Async.create_promise` | 3 |
| `Async.promisify` | 1 |
| `Async.sleep` | 4 |
| `Net.create_bot` | 2 |
| `Net.get_bot_direction` | 1 |
| `Net.remove_bot` | 1 |
| `Net.set_bot_minimap_color` | 1 |
| `Net.shake_player_camera` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
