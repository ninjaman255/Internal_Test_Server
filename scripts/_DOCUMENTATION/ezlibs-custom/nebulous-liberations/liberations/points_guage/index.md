# 📄 `points_guage.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/points_guage.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/points_guage.lua)  
> **Source lines:** 183  
> **SHA-256 (UTF-8):** `0cb0d05ebf569b…`  
> **Declared/assigned functions detected:** 10  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 6

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

Screen HUD for a liberation's order points. Composed of three 3-slice sprites drawn through Displayer.SlicedSprite: * base-guage-3slice -- the empty bar behind everything (widest) * points-3slice -- one pip per filled point, laid out left-to-right * point-total-3slice -- centered badge showing "value/max" as text

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 14 | `scripts/displayer/displayer` |
| 15 | `scripts/displayer/text-layout` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 46 | `get_styles` | `(none)` | local |
| 65 | `id_safe` | `value` | local |
| 69 | `PointsGauge:new` | `player_id, max_points` | declared |
| 91 | `PointsGauge:_draw_base` | `(none)` | declared |
| 102 | `PointsGauge:_draw_fill` | `(none)` | declared |
| 121 | `PointsGauge:_draw_badge` | `(none)` | declared |
| 150 | `PointsGauge:show` | `(none)` | declared |
| 158 | `PointsGauge:set_value` | `value` | declared |
| 167 | `PointsGauge:hide` | `(none)` | declared |
| 178 | `PointsGauge:destroy` | `(none)` | declared |

### Function details

#### 1. `get_styles()`

- **Location:** source line 46.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 2. `id_safe(value)`

- **Location:** source line 65.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `PointsGauge:new(player_id, max_points)`

- **Location:** source line 69.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `max_points` | Not explicitly documented in adjacent source annotations. |

#### 4. `PointsGauge:_draw_base()`

- **Location:** source line 91.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 5. `PointsGauge:_draw_fill()`

- **Location:** source line 102.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 6. `PointsGauge:_draw_badge()`

- **Location:** source line 121.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 7. `PointsGauge:show()`

- **Location:** source line 150.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 8. `PointsGauge:set_value(value)`

- **Location:** source line 158.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 9. `PointsGauge:hide()`

- **Location:** source line 167.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 10. `PointsGauge:destroy()`

- **Location:** source line 178.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **6** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `PointsGauge` — line 17

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `LAYOUT` — line 24

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `screen_w` | numeric literal | `480` |
| `screen_h` | numeric literal | `320` |
| `gauge_y` | numeric literal | `12` |
| `gauge_h` | numeric literal | `24` |
| `segment_w` | numeric literal | `20` |
| `[6]` | expression/reference | `-- width of one order-point pip badge_w = 48` |
| `badge_h` | numeric literal | `16` |
| `badge_y` | numeric literal | `0` |
| `[9]` | expression/reference | `-- overlaps the gauge top by (gauge_y - (badge_y + badge_h))? no: -- badge spans 0..16, gauge spans 12..36 → 4px overlap. z_base = 200` |
| `z_fill` | numeric literal | `201` |
| `z_badge` | numeric literal | `202` |
| `z_text` | numeric literal | `203` |
| `text_font` | string literal | `"THICK"` |
| `text_scale` | numeric literal | `1.0` |
| `text_color` | nested table | `{ r = 255, g = 255, b = 255, a = 255 }` |

### 3. `text_color` — line 40

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `a` | numeric literal | `255` |

### 4. `styles` — line 48

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `base` | expression/reference | `Displayer.Builder.sliceStyle3( ASSET_ROOT .. "/base-guage-3slice.png", ASSET_ROOT .. "/base-guage-3slice.animation" )` |
| `points` | expression/reference | `Displayer.Builder.sliceStyle3( ASSET_ROOT .. "/points-3slice.png", ASSET_ROOT .. "/points-3slice.animation" )` |
| `badge` | expression/reference | `Displayer.Builder.sliceStyle3( ASSET_ROOT .. "/point-total-3slice.png", ASSET_ROOT .. "/point-total-3slice.animation" )` |

### 5. `gauge.fill_lids` — line 84

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `opts` — line 132

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | expression/reference | `LAYOUT.text_font` |
| `scale` | expression/reference | `LAYOUT.text_scale` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
