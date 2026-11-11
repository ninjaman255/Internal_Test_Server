# 📄 `sfx_driver.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/sfx_driver.lua`](../../../../ezlibs-custom/footbomb/sfx_driver.lua)  
> **Source lines:** 71  
> **SHA-256 (UTF-8):** `b7bceb9fa39747…`  
> **Declared/assigned functions detected:** 2  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 2

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

Sound driver for FootBomb round events. Reacts to semantic round events by playing sounds. All timing lives in the round's event emitters; this module only decides WHAT to play, not WHEN. Adding a new sound effect is a one-line addition here — no changes needed to `resolve_round_winner` or any animation code.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 34 | `SfxDriver.attach` | `round_events, event_names, play_sound_for_inst, instance_id, file_exists` | declared |
| 40 | `safe_play` | `path, reason` | local |

### Function details

#### 1. `SfxDriver.attach(round_events, event_names, play_sound_for_inst, instance_id, file_exists)`

- **Location:** source line 34.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Attach listeners to a round event bus. Parameters: round_events : EzBus instance for this round event_names : ROUND_EVENT table from main.lua play_sound_for_inst : function(instance_id, path, reason) instance_id : the current round's instance id file_exists : optional function(path) -> boolean; when supplied, used to skip obvious missing-file plays at the event level instead of logging a failure inside play_sound_for_inst. Optional so callers that don't need it can omit the 5th argument. All listeners are safe to call multiple times per round;…

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `round_events` | Not explicitly documented in adjacent source annotations. |
| 2 | `event_names` | Not explicitly documented in adjacent source annotations. |
| 3 | `play_sound_for_inst` | Not explicitly documented in adjacent source annotations. |
| 4 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 5 | `file_exists` | Not explicitly documented in adjacent source annotations. |

#### 2. `safe_play(path, reason)`

- **Location:** source line 40.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |
| 2 | `reason` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 51 | `(none)` | `e visual launch rather than the kicker arrival. round_events:on(event_names.BOMB_LAU…` |
| 56 | `payload` | `the defender's Ball point during a catch. round_events:on(event_names.BOMB_CATCH_CON…` |
| 66 | `(none)` | `only. -- Kicker wins: the bomb detonates. round_events:on(event_names.BOMB_EXPLODING,` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `SfxDriver` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `SFX` — line 14

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `THUD` | string literal | `"/server/assets/net-game-footbomb/sfx/item-thud.ogg"` |
| `EXPLOSION` | string literal | `"/server/assets/net-game-footbomb/sfx/explosion.ogg"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
