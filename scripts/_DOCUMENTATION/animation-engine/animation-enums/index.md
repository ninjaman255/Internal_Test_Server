# 📄 `animation-enums.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/animation-engine/animation-enums.lua`](../../../animation-engine/animation-enums.lua)  
> **Source lines:** 80  
> **SHA-256 (UTF-8):** `c44fc79c89f290…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 7

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

animation-enums.lua (enhanced)

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `AnimationEnums` — line 2

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `AnimationEnums.easing_function_names` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instant` | string literal | `"instant"` |
| `linear` | string literal | `"linear"` |
| `ease_in` | string literal | `"ease_in"` |
| `ease_out` | string literal | `"ease_out"` |
| `ease_in_out` | string literal | `"ease_in_out"` |
| `smoothstep` | string literal | `"smoothstep"` |
| `smootherstep` | string literal | `"smootherstep"` |
| `elastic_in` | string literal | `"elastic_in"` |
| `elastic_out` | string literal | `"elastic_out"` |
| `bounce_out` | string literal | `"bounce_out"` |
| `bounce_in` | string literal | `"bounce_in"` |
| `elastic_in_out` | string literal | `"elastic_in_out"` |
| `square` | string literal | `"square"` |
| `cubic` | string literal | `"cubic"` |

### 3. `AnimationEnums.animation_types` — line 24

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `SUMMON` | string literal | `"summon"` |
| `SET` | string literal | `"set"` |
| `POSITION_CHANGE` | string literal | `"position_change"` |
| `ATTACK` | string literal | `"attack"` |
| `SLIDE` | string literal | `"slide"` |
| `BOB` | string literal | `"bob"` |
| `PULSE` | string literal | `"pulse"` |
| `SHAKE` | string literal | `"shake"` |
| `FADE` | string literal | `"fade"` |
| `TINT` | string literal | `"tint"` |
| `COLOR_PULSE` | string literal | `"color_pulse"` |
| `SERIES` | string literal | `"series"` |

### 4. `AnimationEnums.animation_properties` — line 40

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `POSITION_X` | string literal | `"x"` |
| `POSITION_Y` | string literal | `"y"` |
| `SCALE` | string literal | `"scale"` |
| `SCALE_X` | string literal | `"scaleX"` |
| `SCALE_Y` | string literal | `"scaleY"` |
| `ROTATION` | string literal | `"rotation"` |
| `ALPHA` | string literal | `"alpha"` |
| `COLOR_R` | string literal | `"r"` |
| `COLOR_G` | string literal | `"g"` |
| `COLOR_B` | string literal | `"b"` |
| `COLOR_A` | string literal | `"a"` |

### 5. `AnimationEnums.directions` — line 55

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `UP` | string literal | `"up"` |
| `DOWN` | string literal | `"down"` |
| `LEFT` | string literal | `"left"` |
| `RIGHT` | string literal | `"right"` |
| `IN` | string literal | `"in"` |
| `OUT` | string literal | `"out"` |

### 6. `AnimationEnums.triggers` — line 65

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `ON_CLICK` | string literal | `"on_click"` |
| `ON_HOVER` | string literal | `"on_hover"` |
| `ON_SHOW` | string literal | `"on_show"` |
| `ON_HIDE` | string literal | `"on_hide"` |
| `ON_COMPLETE` | string literal | `"on_complete"` |
| `ON_START` | string literal | `"on_start"` |

### 7. `return` — line 74

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `EasingFns` | expression/reference | `AnimationEnums.easing_function_names` |
| `AnimationTypes` | expression/reference | `AnimationEnums.animation_types` |
| `Properties` | expression/reference | `AnimationEnums.animation_properties` |
| `Directions` | expression/reference | `AnimationEnums.directions` |
| `Triggers` | expression/reference | `AnimationEnums.triggers` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
