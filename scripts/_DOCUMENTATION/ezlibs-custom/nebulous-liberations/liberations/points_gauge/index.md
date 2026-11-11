# 📄 `points_gauge.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/points_gauge.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/points_gauge.lua)  
> **Source lines:** 495  
> **SHA-256 (UTF-8):** `0a528532750271ce802a13badcbe8133f9e0966e9c54c21f27be714b21d1b048`  
> **Named/assigned functions detected:** 16  
> **Table initializers detected:** 15

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/liberations/points_gauge.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 36 | `scripts/logger/logger` |
| 39 | `scripts/displayer/displayer` |
| 40 | `scripts/displayer/text-layout` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 83 | `get_animation_insights` | `(none)` | local |
| 130 | `get_styles` | `(none)` | local |
| 154 | `run_startup_diagnostic` | `(none)` | local |
| 226 | `round_pixel` | `value` | local |
| 230 | `id_safe` | `value` | local |
| 234 | `measure_text_240` | `text, opts` | local |
| 252 | `PointsGauge:new` | `player_id, max_points` | assigned/declared |
| 290 | `PointsGauge:_warn_once` | `tag, message, extra` | assigned/declared |
| 298 | `safe_draw3` | `player_id, lid, x, y, w, h, style, opts, tag, gauge` | local |
| 321 | `PointsGauge:_draw_base` | `(none)` | assigned/declared |
| 340 | `PointsGauge:_draw_fill` | `(none)` | assigned/declared |
| 387 | `PointsGauge:_draw_badge` | `(none)` | assigned/declared |
| 454 | `PointsGauge:show` | `(none)` | assigned/declared |
| 470 | `PointsGauge:set_value` | `value` | assigned/declared |
| 479 | `PointsGauge:hide` | `(none)` | assigned/declared |
| 490 | `PointsGauge:destroy` | `(none)` | assigned/declared |

### Detailed parameter inventory

#### 1. `get_animation_insights()`

- **Line:** 83
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 2. `get_styles()`

- **Line:** 130
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 3. `run_startup_diagnostic()`

- **Line:** 154
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 4. `round_pixel(value)`

- **Line:** 226
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 5. `id_safe(value)`

- **Line:** 230
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 6. `measure_text_240(text, opts)`

- **Line:** 234
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text` | Declared in this function; type not inferred. |
| 2 | `opts` | Declared in this function; type not inferred. |

#### 7. `PointsGauge:new(player_id, max_points)`

- **Line:** 252
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `max_points` | Declared in this function; type not inferred. |

#### 8. `PointsGauge:_warn_once(tag, message, extra)`

- **Line:** 290
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tag` | Declared in this function; type not inferred. |
| 2 | `message` | Declared in this function; type not inferred. |
| 3 | `extra` | Declared in this function; type not inferred. |

#### 9. `safe_draw3(player_id, lid, x, y, w, h, style, opts, tag, gauge)`

- **Line:** 298
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `lid` | Declared in this function; type not inferred. |
| 3 | `x` | Declared in this function; type not inferred. |
| 4 | `y` | Declared in this function; type not inferred. |
| 5 | `w` | Declared in this function; type not inferred. |
| 6 | `h` | Declared in this function; type not inferred. |
| 7 | `style` | Declared in this function; type not inferred. |
| 8 | `opts` | Declared in this function; type not inferred. |
| 9 | `tag` | Declared in this function; type not inferred. |
| 10 | `gauge` | Declared in this function; type not inferred. |

#### 10. `PointsGauge:_draw_base()`

- **Line:** 321
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 11. `PointsGauge:_draw_fill()`

- **Line:** 340
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 12. `PointsGauge:_draw_badge()`

- **Line:** 387
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 13. `PointsGauge:show()`

- **Line:** 454
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 14. `PointsGauge:set_value(value)`

- **Line:** 470
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 15. `PointsGauge:hide()`

- **Line:** 479
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 16. `PointsGauge:destroy()`

- **Line:** 490
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 42 | `PointsGauge` |
| 53 | `LAYOUT` |
| 77 | `text_color` |
| 85 | `animation_insights` |
| 90 | `specs` |
| 99 | `insight` |
| 132 | `styles` |
| 158 | `required` |
| 159 | `specs` |
| 173 | `missing` |
| 174 | `available` |
| 268 | `gauge._warned` |
| 281 | `gauge.fill_lids` |
| 293 | `payload` |
| 390 | `text_opts` |

## Net API calls

No direct `Net.method(...)` call expression matched.
