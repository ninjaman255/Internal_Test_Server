# 📄 `text-display.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/text-display.lua`](../../../displayer/text-display.lua)  
> **Source lines:** 757  
> **SHA-256 (UTF-8):** `e67040061cb037…`  
> **Declared/assigned functions detected:** 58  
> **Anonymous closures detected:** 7  
> **Table initializers detected:** 15

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

Unified text renderer for static text, marquee text, and BN-style typewriter boxes. Public coordinates are virtual 240x160 coordinates. Hardened with deterministic marquee IDs, pixel-snapped updates, real paging, explicit teardown, and a public layout/measurement API.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 9 | `scripts/displayer/font-system` |
| 10 | `scripts/animation-engine/animation-engine` |
| 11 | `scripts/displayer/text-layout` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 551 | `Net:on` | `tick` |
| 555 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 15 | `normalize_loops` | `value` | local |
| 23 | `normalize_scale` | `value, fallback` | local |
| 29 | `pixel_snap_virtual` | `value` | local |
| 34 | `copy_table` | `src` | local |
| 40 | `safe_call` | `fn, ...` | local |
| 46 | `deterministic_glyph_id` | `text_id, index` | local |
| 53 | `DisplayInstance:new` | `owner, player_id, text_id, text, x, y, options` | declared |
| 134 | `DisplayInstance:relayout` | `(none)` | declared |
| 149 | `DisplayInstance:_glyphOptions` | `glyph, extra` | declared |
| 175 | `DisplayInstance:_eraseGlyphId` | `id` | declared |
| 180 | `DisplayInstance:_eraseAllGlyphs` | `(none)` | declared |
| 196 | `DisplayInstance:_drawStatic` | `(none)` | declared |
| 214 | `DisplayInstance:_drawBackdrop` | `(none)` | declared |
| 253 | `DisplayInstance:_eraseBackdrop` | `force` | declared |
| 261 | `DisplayInstance:_marqueeGlyphs` | `(none)` | declared |
| 274 | `DisplayInstance:_drawMarqueeAt` | `offset, elapsed` | declared |
| 308 | `DisplayInstance:_cleanupMarquee` | `done` | declared |
| 314 | `pass` | `n` | local |
| 326 | `DisplayInstance:_startMarquee` | `(none)` | declared |
| 348 | `on_update` | `values` | assigned |
| 354 | `on_complete` | `_, interrupted` | assigned |
| 366 | `DisplayInstance:_pageMeta` | `page_index` | declared |
| 370 | `DisplayInstance:_currentGlyph` | `(none)` | declared |
| 378 | `DisplayInstance:_cancelPendingCharacter` | `(none)` | declared |
| 385 | `DisplayInstance:_scheduleNextChar` | `delay` | declared |
| 394 | `DisplayInstance:_startCurrentPage` | `(none)` | declared |
| 406 | `DisplayInstance:_pageFinished` | `(none)` | declared |
| 411 | `DisplayInstance:_drawTypewriterGlyph` | `glyph` | declared |
| 429 | `DisplayInstance:_printNextChar` | `(none)` | declared |
| 456 | `DisplayInstance:_finishCurrentPageImmediately` | `(none)` | declared |
| 473 | `DisplayInstance:_eraseCurrentPage` | `(none)` | declared |
| 488 | `DisplayInstance:advance` | `(none)` | declared |
| 503 | `DisplayInstance:reset` | `text, options` | declared |
| 534 | `DisplayInstance:close` | `(none)` | declared |
| 545 | `TextDisplay:init` | `(none)` | declared |
| 561 | `TextDisplay:layout` | `text, options` | declared |
| 565 | `TextDisplay:measure` | `text, options` | declared |
| 569 | `TextDisplay:cleanupPlayer` | `player_id` | declared |
| 576 | `TextDisplay:updateAll` | `_dt` | declared |
| 589 | `TextDisplay:draw` | `player_id, text_id, text, x, y, options` | declared |
| 599 | `TextDisplay:remove` | `player_id, text_id` | declared |
| 606 | `TextDisplay:get` | `player_id, text_id` | declared |
| 610 | `TextDisplay:getState` | `player_id, text_id` | declared |
| 615 | `TextDisplay:getData` | `player_id, text_id` | declared |
| 662 | `TextDisplay:setKeepAlive` | `player_id, text_id, value` | declared |
| 669 | `TextDisplay:advance` | `player_id, text_id` | declared |
| 676 | `TextDisplay:reset` | `player_id, text_id, text, options` | declared |
| 688 | `copy_options` | `options` | local |
| 694 | `TextDisplay:drawStatic` | `player_id, text_id, text, x, y, options` | declared |
| 701 | `TextDisplay:removeStatic` | `player_id, text_id` | declared |
| 705 | `TextDisplay:drawMarquee` | `player_id, marquee_id, text, y, options` | declared |
| 713 | `TextDisplay:removeMarquee` | `player_id, marquee_id` | declared |
| 717 | `TextDisplay:createTextBox` | `player_id, box_id, text, x, y, width, height, options` | declared |
| 726 | `TextDisplay:advanceTextBox` | `player_id, box_id` | declared |
| 730 | `TextDisplay:closeTextBox` | `player_id, box_id` | declared |
| 734 | `TextDisplay:getTextBoxState` | `player_id, box_id` | declared |
| 747 | `TextDisplay:getTextBoxData` | `player_id, box_id` | declared |
| 751 | `TextDisplay:resetTextBox` | `player_id, box_id, text, options` | declared |

### Function details

#### 1. `normalize_loops(value)`

- **Location:** source line 15.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 2. `normalize_scale(value, fallback)`

- **Location:** source line 23.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `fallback` | Not explicitly documented in adjacent source annotations. |

#### 3. `pixel_snap_virtual(value)`

- **Location:** source line 29.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 4. `copy_table(src)`

- **Location:** source line 34.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `src` | Not explicitly documented in adjacent source annotations. |

#### 5. `safe_call(fn, ...)`

- **Location:** source line 40.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `fn` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 6. `deterministic_glyph_id(text_id, index)`

- **Location:** source line 46.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `index` | Not explicitly documented in adjacent source annotations. |

#### 7. `DisplayInstance:new(owner, player_id, text_id, text, x, y, options)`

- **Location:** source line 53.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `owner` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `text` | Not explicitly documented in adjacent source annotations. |
| 5 | `x` | Not explicitly documented in adjacent source annotations. |
| 6 | `y` | Not explicitly documented in adjacent source annotations. |
| 7 | `options` | Not explicitly documented in adjacent source annotations. |

#### 8. `DisplayInstance:relayout()`

- **Location:** source line 134.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 9. `DisplayInstance:_glyphOptions(glyph, extra)`

- **Location:** source line 149.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `glyph` | Not explicitly documented in adjacent source annotations. |
| 2 | `extra` | Not explicitly documented in adjacent source annotations. |

#### 10. `DisplayInstance:_eraseGlyphId(id)`

- **Location:** source line 175.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `id` | Not explicitly documented in adjacent source annotations. |

#### 11. `DisplayInstance:_eraseAllGlyphs()`

- **Location:** source line 180.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 12. `DisplayInstance:_drawStatic()`

- **Location:** source line 196.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 13. `DisplayInstance:_drawBackdrop()`

- **Location:** source line 214.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 14. `DisplayInstance:_eraseBackdrop(force)`

- **Location:** source line 253.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `force` | Not explicitly documented in adjacent source annotations. |

#### 15. `DisplayInstance:_marqueeGlyphs()`

- **Location:** source line 261.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 16. `DisplayInstance:_drawMarqueeAt(offset, elapsed)`

- **Location:** source line 274.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `offset` | Not explicitly documented in adjacent source annotations. |
| 2 | `elapsed` | Not explicitly documented in adjacent source annotations. |

#### 17. `DisplayInstance:_cleanupMarquee(done)`

- **Location:** source line 308.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `done` | Not explicitly documented in adjacent source annotations. |

#### 18. `pass(n)`

- **Location:** source line 314.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `n` | Not explicitly documented in adjacent source annotations. |

#### 19. `DisplayInstance:_startMarquee()`

- **Location:** source line 326.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 20. `on_update(values)`

- **Location:** source line 348.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 21. `on_complete(_, interrupted)`

- **Location:** source line 354.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `_` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 22. `DisplayInstance:_pageMeta(page_index)`

- **Location:** source line 366.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `page_index` | Not explicitly documented in adjacent source annotations. |

#### 23. `DisplayInstance:_currentGlyph()`

- **Location:** source line 370.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 24. `DisplayInstance:_cancelPendingCharacter()`

- **Location:** source line 378.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 25. `DisplayInstance:_scheduleNextChar(delay)`

- **Location:** source line 385.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delay` | Not explicitly documented in adjacent source annotations. |

#### 26. `DisplayInstance:_startCurrentPage()`

- **Location:** source line 394.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 27. `DisplayInstance:_pageFinished()`

- **Location:** source line 406.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 28. `DisplayInstance:_drawTypewriterGlyph(glyph)`

- **Location:** source line 411.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `glyph` | Not explicitly documented in adjacent source annotations. |

#### 29. `DisplayInstance:_printNextChar()`

- **Location:** source line 429.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 30. `DisplayInstance:_finishCurrentPageImmediately()`

- **Location:** source line 456.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 31. `DisplayInstance:_eraseCurrentPage()`

- **Location:** source line 473.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 32. `DisplayInstance:advance()`

- **Location:** source line 488.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 33. `DisplayInstance:reset(text, options)`

- **Location:** source line 503.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 34. `DisplayInstance:close()`

- **Location:** source line 534.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 35. `TextDisplay:init()`

- **Location:** source line 545.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 36. `TextDisplay:layout(text, options)`

- **Location:** source line 561.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 37. `TextDisplay:measure(text, options)`

- **Location:** source line 565.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 38. `TextDisplay:cleanupPlayer(player_id)`

- **Location:** source line 569.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 39. `TextDisplay:updateAll(_dt)`

- **Location:** source line 576.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `_dt` | Not explicitly documented in adjacent source annotations. |

#### 40. `TextDisplay:draw(player_id, text_id, text, x, y, options)`

- **Location:** source line 589.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `options` | Not explicitly documented in adjacent source annotations. |

#### 41. `TextDisplay:remove(player_id, text_id)`

- **Location:** source line 599.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |

#### 42. `TextDisplay:get(player_id, text_id)`

- **Location:** source line 606.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |

#### 43. `TextDisplay:getState(player_id, text_id)`

- **Location:** source line 610.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |

#### 44. `TextDisplay:getData(player_id, text_id)`

- **Location:** source line 615.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |

#### 45. `TextDisplay:setKeepAlive(player_id, text_id, value)`

- **Location:** source line 662.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

#### 46. `TextDisplay:advance(player_id, text_id)`

- **Location:** source line 669.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |

#### 47. `TextDisplay:reset(player_id, text_id, text, options)`

- **Location:** source line 676.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `options` | Not explicitly documented in adjacent source annotations. |

#### 48. `copy_options(options)`

- **Location:** source line 688.
- **Declaration style:** `local`.
- **Adjacent source comment:**  Compatibility/public convenience wrappers used by the current Displayer facade. 

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `options` | Not explicitly documented in adjacent source annotations. |

#### 49. `TextDisplay:drawStatic(player_id, text_id, text, x, y, options)`

- **Location:** source line 694.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `options` | Not explicitly documented in adjacent source annotations. |

#### 50. `TextDisplay:removeStatic(player_id, text_id)`

- **Location:** source line 701.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text_id` | Not explicitly documented in adjacent source annotations. |

#### 51. `TextDisplay:drawMarquee(player_id, marquee_id, text, y, options)`

- **Location:** source line 705.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `marquee_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `options` | Not explicitly documented in adjacent source annotations. |

#### 52. `TextDisplay:removeMarquee(player_id, marquee_id)`

- **Location:** source line 713.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `marquee_id` | Not explicitly documented in adjacent source annotations. |

#### 53. `TextDisplay:createTextBox(player_id, box_id, text, x, y, width, height, options)`

- **Location:** source line 717.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `width` | Not explicitly documented in adjacent source annotations. |
| 7 | `height` | Not explicitly documented in adjacent source annotations. |
| 8 | `options` | Not explicitly documented in adjacent source annotations. |

#### 54. `TextDisplay:advanceTextBox(player_id, box_id)`

- **Location:** source line 726.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 55. `TextDisplay:closeTextBox(player_id, box_id)`

- **Location:** source line 730.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 56. `TextDisplay:getTextBoxState(player_id, box_id)`

- **Location:** source line 734.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 57. `TextDisplay:getTextBoxData(player_id, box_id)`

- **Location:** source line 747.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 58. `TextDisplay:resetTextBox(player_id, box_id, text, options)`

- **Location:** source line 751.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `options` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 270 | `a, b` | `if glyph.char ~= " " then out[#out + 1] = glyph end end end table.sort(out,` |
| 318 | `(none)` | `self:_eraseAllGlyphs() if n < passes then AnimationEngine.delay(0,` |
| 357 | `(none)` | `if interrupted or self.marked_for_removal then return end self:_cleanupMarquee(` |
| 388 | `(none)` | `return end self.next_char_delay = AnimationEngine.delay(math.max(0, tonumber(delay) …` |
| 551 | `event` | `f.font_system = fontSystem self.player_texts = self.player_texts or {} Net:on("tick",` |
| 552 | `(none)` | `ts = self.player_texts or {} Net:on("tick", function(event) local ok, err = pcall(` |
| 555 | `event` | `t("[TextDisplay] tick failed: " .. tostring(err)) end end) Net:on("player_disconnect…` |

## 📦 Tables and data

The following **15** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `TextDisplay` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `out` — line 35

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `DisplayInstance` — line 50

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `o.global` — line 71

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `tonumber(options.r) or 255` |
| `g` | expression/reference | `tonumber(options.g) or 255` |
| `b` | expression/reference | `tonumber(options.b) or 255` |
| `opacity` | expression/reference | `tonumber(options.opacity) or 255` |
| `a` | expression/reference | `tonumber(options.a) or 255` |
| `ro` | expression/reference | `tonumber(options.ro) or 0` |
| `color_mode` | expression/reference | `tonumber(options.color_mode) or 0` |

### 5. `o.glyph_ids` — line 84

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `o.drawn` — line 85

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `opts` — line 150

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `scale` | expression/reference | `self.scale` |
| `z` | expression/reference | `self.z` |
| `r` | expression/reference | `self.global.r` |
| `g` | expression/reference | `self.global.g` |
| `b` | expression/reference | `self.global.b` |
| `opacity` | expression/reference | `self.global.opacity` |
| `a` | expression/reference | `self.global.a` |
| `ro` | expression/reference | `self.global.ro` |
| `color_mode` | expression/reference | `self.global.color_mode` |

### 8. `self.glyph_ids` — line 192

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `self.drawn` — line 193

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `self.backdrop` — line 250

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `asset_id` | expression/reference | `asset_id` |
| `draw_id` | expression/reference | `draw_id` |
| `keep` | expression/reference | `cfg.keep_backdrop == true` |

### 11. `out` — line 262

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `remove` — line 578

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `line_x_offsets` — line 619

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `return` — line 627

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Legacy screen-pixel fields retained for current Nameplate/Prompt callers. x = d.x * 2` |
| `y` | expression/reference | `d.y * 2` |
| `width` | expression/reference | `d.width and d.width * 2 or nil` |
| `height` | expression/reference | `d.height and d.height * 2 or nil` |
| `inner_x` | expression/reference | `d.x * 2` |
| `inner_y` | expression/reference | `d.y * 2` |
| `_line_height_px` | expression/reference | `d.layout.line_height * 2` |
| `line_x_offsets` | expression/reference | `line_x_offsets` |
| `[9]` | expression/reference | `-- Canonical public virtual-coordinate fields. virtual_x = d.x` |
| `virtual_y` | expression/reference | `d.y` |
| `virtual_width` | expression/reference | `d.width` |
| `virtual_height` | expression/reference | `d.height` |
| `line_height` | expression/reference | `d.layout.line_height` |
| `scale` | expression/reference | `d.scale` |
| `z_order` | expression/reference | `d.z` |
| `font` | expression/reference | `d.font` |
| `mode` | expression/reference | `d.mode` |
| `state` | expression/reference | `d.state` |
| `pages` | expression/reference | `d.layout.pages` |
| `page_layouts` | expression/reference | `d.layout.page_layouts` |
| `page_count` | expression/reference | `#d.layout.pages` |
| `current_page` | expression/reference | `d.current_page or 1` |
| `current_line` | expression/reference | `d.current_line or 1` |
| `current_char` | expression/reference | `d.current_char or 0` |
| `marked_for_removal` | expression/reference | `d.marked_for_removal` |
| `backdrop` | expression/reference | `d.backdrop_config` |
| `_box_id` | expression/reference | `d.text_id` |

### 15. `out` — line 689

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 2 |
| `Net.player_draw_sprite` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
