# 📄 `displayer.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/displayer.lua`](../../../displayer/displayer.lua)  
> **Source lines:** 613  
> **SHA-256 (UTF-8):** `d16db7dbc47011…`  
> **Declared/assigned functions detected:** 114  
> **Anonymous closures detected:** 2  
> **Table initializers detected:** 48

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

Source-based reference for `scripts/displayer/displayer.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 34 | `scripts/displayer/font-system` |
| 35 | `scripts/displayer/text-display` |
| 36 | `scripts/displayer/timer-display` |
| 37 | `scripts/displayer/nameplate` |
| 39 | `scripts/displayer/scrolling-text-list` |
| 40 | `scripts/displayer/scrolling-sprite-list` |
| 41 | `scripts/displayer/timer-system` |
| 42 | `scripts/displayer/sliced-sprite` |
| 70 | `scripts/boom/main` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 59 | `Net:on` | `player_join` |
| 571 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 21 | `Displayer:init` | `(none)` | declared |
| 68 | `Displayer:_setupBuilderAPI` | `(none)` | declared |
| 73 | `api.glyph` | `overrides` | declared |
| 80 | `api.staticText` | `overrides` | declared |
| 87 | `api.marquee` | `overrides` | declared |
| 95 | `api.textBox` | `overrides` | declared |
| 104 | `api.timerDisplay` | `overrides` | declared |
| 118 | `api.textList` | `overrides` | declared |
| 127 | `api.spriteList` | `overrides` | declared |
| 136 | `api.backdrop` | `x, y, width, height, padding_x, padding_y, r, g, b, opacity, a` | declared |
| 143 | `api.spriteDef` | `texture_path, anim_path, anim_state, overrides` | declared |
| 187 | `api.sliceStyle9` | `texture_path, anim_path, overrides` | declared |
| 202 | `api.sliceStyle3` | `texture_path, anim_path, states, orientation` | declared |
| 219 | `api.sliceStyle5` | `texture_path, anim_path, states, orientation` | declared |
| 238 | `api.text` | `mode, overrides` | declared |
| 254 | `api.textPanelStyle` | `kind, parts, orientation` | declared |
| 261 | `panelPadding` | `value, vertical` | local |
| 283 | `api.panelPadding` | `value, vertical` | declared |
| 287 | `api.panelChildPadding` | `value, vertical` | declared |
| 294 | `api.textPanelOptions` | `overrides` | declared |
| 328 | `api.rowPanelOptions` | `overrides` | declared |
| 336 | `api.columnPanelOptions` | `overrides` | declared |
| 344 | `api.gridPanelOptions` | `columns, overrides` | declared |
| 353 | `api.textPanel` | `text, style, options` | declared |
| 357 | `api.panelTextChild` | `text, overrides` | declared |
| 364 | `api.panelSpritesChild` | `sprites, overrides` | declared |
| 379 | `Displayer:_setupFontAPI` | `(none)` | declared |
| 381 | `api.drawGlyph` | `player_id, font_name, char, x, y, options` | assigned |
| 384 | `api.updateGlyph` | `player_id, instance_id, updates` | assigned |
| 387 | `api.eraseGlyph` | `player_id, instance_id` | assigned |
| 390 | `api.getGlyphDimensions` | `font_name, char` | assigned |
| 393 | `api.allocateAllFontsForPlayer` | `player_id` | assigned |
| 401 | `Displayer:_setupTextAPI` | `(none)` | declared |
| 403 | `api.draw` | `pid, tid, text, x, y, o` | assigned |
| 404 | `api.drawStatic` | `pid, tid, text, x, y, o` | assigned |
| 405 | `api.removeStatic` | `pid, tid` | assigned |
| 406 | `api.drawMarquee` | `pid, mid, text, y, o` | assigned |
| 407 | `api.removeMarquee` | `pid, mid` | assigned |
| 408 | `api.createTextBox` | `pid, bid, text, x, y, w, h, o` | assigned |
| 409 | `api.advanceTextBox` | `pid, bid` | assigned |
| 410 | `api.closeTextBox` | `pid, bid` | assigned |
| 411 | `api.getTextBoxState` | `pid, bid` | assigned |
| 412 | `api.getTextBoxData` | `pid, bid` | assigned |
| 413 | `api.setKeepAlive` | `pid, bid, keep` | assigned |
| 419 | `Displayer:_setupTimerDisplayAPI` | `(none)` | declared |
| 421 | `api.createPlayerTimer` | `pid, did, x, y, o` | assigned |
| 422 | `api.createPlayerCountdown` | `pid, did, x, y, o` | assigned |
| 423 | `api.createGlobalTimer` | `did, x, y, o` | assigned |
| 424 | `api.createGlobalCountdown` | `did, x, y, o` | assigned |
| 425 | `api.remove` | `pid, did` | assigned |
| 426 | `api.setPosition` | `pid, did, x, y` | assigned |
| 432 | `Displayer:_setupNameplateAPI` | `(none)` | declared |
| 434 | `api.attach` | `pid, pd, bid, bd, cfg` | assigned |
| 435 | `api.erase` | `pid, pd, bd` | assigned |
| 436 | `api.begin_close` | `pid, pd, bd, cfg` | assigned |
| 442 | `Displayer:_setupScrollingTextAPI` | `(none)` | declared |
| 444 | `api.createList` | `pid, lid, x, y, w, h, cfg` | assigned |
| 445 | `api.addText` | `pid, lid, text` | assigned |
| 446 | `api.setTexts` | `pid, lid, texts` | assigned |
| 447 | `api.getState` | `pid, lid` | assigned |
| 448 | `api.setSpeed` | `pid, lid, s` | assigned |
| 449 | `api.removeList` | `pid, lid` | assigned |
| 450 | `api.setPosition` | `pid, lid, x, y` | assigned |
| 456 | `Displayer:_setupScrollingSpriteAPI` | `(none)` | declared |
| 458 | `api.createList` | `pid, lid, x, y, w, h, cfg` | assigned |
| 459 | `api.addSprite` | `pid, lid, d` | assigned |
| 460 | `api.setSprites` | `pid, lid, s` | assigned |
| 461 | `api.getState` | `pid, lid` | assigned |
| 462 | `api.setSpeed` | `pid, lid, s` | assigned |
| 463 | `api.removeList` | `pid, lid` | assigned |
| 464 | `api.setPosition` | `pid, lid, x, y` | assigned |
| 470 | `Displayer:_setupTimerAPI` | `(none)` | declared |
| 472 | `api.createPlayerTimer` | `p, t, d, cb, l` | assigned |
| 473 | `api.createPlayerCountdown` | `p, c, d, cb, l` | assigned |
| 474 | `api.pausePlayerTimer` | `p, t` | assigned |
| 475 | `api.resumePlayerTimer` | `p, t` | assigned |
| 476 | `api.pausePlayerCountdown` | `p, c` | assigned |
| 477 | `api.resumePlayerCountdown` | `p, c` | assigned |
| 478 | `api.removePlayerTimer` | `p, t` | assigned |
| 479 | `api.removePlayerCountdown` | `p, c` | assigned |
| 480 | `api.getPlayerTimer` | `p, t` | assigned |
| 481 | `api.getPlayerCountdown` | `p, c` | assigned |
| 482 | `api.createGlobalTimer` | `t, d, cb, l` | assigned |
| 483 | `api.createGlobalCountdown` | `c, d, cb, l` | assigned |
| 484 | `api.pauseGlobalTimer` | `t` | assigned |
| 485 | `api.resumeGlobalTimer` | `t` | assigned |
| 486 | `api.pauseGlobalCountdown` | `c` | assigned |
| 487 | `api.resumeGlobalCountdown` | `c` | assigned |
| 488 | `api.removeGlobalTimer` | `t` | assigned |
| 489 | `api.removeGlobalCountdown` | `c` | assigned |
| 490 | `api.getGlobalTimer` | `t` | assigned |
| 491 | `api.getGlobalCountdown` | `c` | assigned |
| 492 | `api.getAllGlobalTimers` | `(none)` | assigned |
| 493 | `api.getAllGlobalCountdowns` | `(none)` | assigned |
| 494 | `api.clearAllGlobalTimers` | `(none)` | assigned |
| 495 | `api.clearAllGlobalCountdowns` | `(none)` | assigned |
| 501 | `Displayer:_setupTextPanelAPI` | `(none)` | declared |
| 505 | `api.create` | `player_id, panel_id, text, x, y, style, options` | assigned |
| 515 | `api.createWithChildren` | `player_id, panel_id, x, y, style, options` | assigned |
| 525 | `api.updateText` | `player_id, panel_id, newText` | assigned |
| 532 | `api.setChildren` | `player_id, panel_id, children` | assigned |
| 539 | `api.setPosition` | `player_id, panel_id, x, y` | assigned |
| 546 | `api.setOptions` | `player_id, panel_id, newOptions` | assigned |
| 553 | `api.getSize` | `player_id, panel_id` | assigned |
| 559 | `api.remove` | `player_id, panel_id` | assigned |
| 567 | `api.get` | `player_id, panel_id` | assigned |
| 585 | `Displayer:_setupSlicedSpriteAPI` | `(none)` | declared |
| 587 | `api.draw3` | `pid, lid, x, y, w, h, style, o` | assigned |
| 588 | `api.draw5` | `pid, lid, x, y, w, h, style, o` | assigned |
| 589 | `api.draw9` | `pid, lid, x, y, w, h, style, o` | assigned |
| 590 | `api.erase` | `pid, lid` | assigned |
| 591 | `api.drawTextPanel` | `pid, lid, x, y, text, style, options` | assigned |
| 597 | `Displayer:formatTime` | `seconds, is_countdown` | declared |
| 607 | `Displayer:getScreenDimensions` | `(none)` | declared |

### Function details

#### 1. `Displayer:init()`

- **Location:** source line 21.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 2. `Displayer:_setupBuilderAPI()`

- **Location:** source line 68.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Builder API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 3. `api.glyph(overrides)`

- **Location:** source line 73.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 4. `api.staticText(overrides)`

- **Location:** source line 80.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 5. `api.marquee(overrides)`

- **Location:** source line 87.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 6. `api.textBox(overrides)`

- **Location:** source line 95.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 7. `api.timerDisplay(overrides)`

- **Location:** source line 104.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 8. `api.textList(overrides)`

- **Location:** source line 118.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 9. `api.spriteList(overrides)`

- **Location:** source line 127.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 10. `api.backdrop(x, y, width, height, padding_x, padding_y, r, g, b, opacity, a)`

- **Location:** source line 136.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |
| 3 | `width` | Not explicitly documented in adjacent source annotations. |
| 4 | `height` | Not explicitly documented in adjacent source annotations. |
| 5 | `padding_x` | Not explicitly documented in adjacent source annotations. |
| 6 | `padding_y` | Not explicitly documented in adjacent source annotations. |
| 7 | `r` | Not explicitly documented in adjacent source annotations. |
| 8 | `g` | Not explicitly documented in adjacent source annotations. |
| 9 | `b` | Not explicitly documented in adjacent source annotations. |
| 10 | `opacity` | Not explicitly documented in adjacent source annotations. |
| 11 | `a` | Not explicitly documented in adjacent source annotations. |

#### 11. `api.spriteDef(texture_path, anim_path, anim_state, overrides)`

- **Location:** source line 143.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 2 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 3 | `anim_state` | Not explicitly documented in adjacent source annotations. |
| 4 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 12. `api.sliceStyle9(texture_path, anim_path, overrides)`

- **Location:** source line 187.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 2 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 3 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 13. `api.sliceStyle3(texture_path, anim_path, states, orientation)`

- **Location:** source line 202.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 2 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 3 | `states` | Not explicitly documented in adjacent source annotations. |
| 4 | `orientation` | Not explicitly documented in adjacent source annotations. |

#### 14. `api.sliceStyle5(texture_path, anim_path, states, orientation)`

- **Location:** source line 219.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 2 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 3 | `states` | Not explicitly documented in adjacent source annotations. |
| 4 | `orientation` | Not explicitly documented in adjacent source annotations. |

#### 15. `api.text(mode, overrides)`

- **Location:** source line 238.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `mode` | Not explicitly documented in adjacent source annotations. |
| 2 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 16. `api.textPanelStyle(kind, parts, orientation)`

- **Location:** source line 254.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `kind` | Not explicitly documented in adjacent source annotations. |
| 2 | `parts` | Not explicitly documented in adjacent source annotations. |
| 3 | `orientation` | Not explicitly documented in adjacent source annotations. |

#### 17. `panelPadding(value, vertical)`

- **Location:** source line 261.
- **Declaration style:** `local`.
- **Adjacent source comment:** Normalize panel/child padding into the edge shape consumed by sliced-sprite.lua. Accepts a uniform number or an edge table such as { horizontal = 6, vertical = 8 } / { left=6, right=6, top=8, bottom=8 }.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `vertical` | Not explicitly documented in adjacent source annotations. |

#### 18. `api.panelPadding(value, vertical)`

- **Location:** source line 283.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `vertical` | Not explicitly documented in adjacent source annotations. |

#### 19. `api.panelChildPadding(value, vertical)`

- **Location:** source line 287.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `vertical` | Not explicitly documented in adjacent source annotations. |

#### 20. `api.textPanelOptions(overrides)`

- **Location:** source line 294.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Build options for text/sliced panels. `layout` accepts vertical/column, horizontal/row, or grid. Spacing and padding are included in auto-size. `children` is an array of descriptors from panelTextChild/panelSpritesChild.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 21. `api.rowPanelOptions(overrides)`

- **Location:** source line 328.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 22. `api.columnPanelOptions(overrides)`

- **Location:** source line 336.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 23. `api.gridPanelOptions(columns, overrides)`

- **Location:** source line 344.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `columns` | Not explicitly documented in adjacent source annotations. |
| 2 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 24. `api.textPanel(text, style, options)`

- **Location:** source line 353.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `style` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 25. `api.panelTextChild(text, overrides)`

- **Location:** source line 357.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 26. `api.panelSpritesChild(sprites, overrides)`

- **Location:** source line 364.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprites` | Not explicitly documented in adjacent source annotations. |
| 2 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 27. `Displayer:_setupFontAPI()`

- **Location:** source line 379.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Font API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 28. `api.drawGlyph(player_id, font_name, char, x, y, options)`

- **Location:** source line 381.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `font_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `char` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `options` | Not explicitly documented in adjacent source annotations. |

#### 29. `api.updateGlyph(player_id, instance_id, updates)`

- **Location:** source line 384.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `updates` | Not explicitly documented in adjacent source annotations. |

#### 30. `api.eraseGlyph(player_id, instance_id)`

- **Location:** source line 387.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `instance_id` | Not explicitly documented in adjacent source annotations. |

#### 31. `api.getGlyphDimensions(font_name, char)`

- **Location:** source line 390.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `char` | Not explicitly documented in adjacent source annotations. |

#### 32. `api.allocateAllFontsForPlayer(player_id)`

- **Location:** source line 393.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 33. `Displayer:_setupTextAPI()`

- **Location:** source line 401.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Text API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 34. `api.draw(pid, tid, text, x, y, o)`

- **Location:** source line 403.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `tid` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `o` | Not explicitly documented in adjacent source annotations. |

#### 35. `api.drawStatic(pid, tid, text, x, y, o)`

- **Location:** source line 404.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `tid` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `o` | Not explicitly documented in adjacent source annotations. |

#### 36. `api.removeStatic(pid, tid)`

- **Location:** source line 405.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `tid` | Not explicitly documented in adjacent source annotations. |

#### 37. `api.drawMarquee(pid, mid, text, y, o)`

- **Location:** source line 406.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `mid` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `o` | Not explicitly documented in adjacent source annotations. |

#### 38. `api.removeMarquee(pid, mid)`

- **Location:** source line 407.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `mid` | Not explicitly documented in adjacent source annotations. |

#### 39. `api.createTextBox(pid, bid, text, x, y, w, h, o)`

- **Location:** source line 408.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `bid` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `w` | Not explicitly documented in adjacent source annotations. |
| 7 | `h` | Not explicitly documented in adjacent source annotations. |
| 8 | `o` | Not explicitly documented in adjacent source annotations. |

#### 40. `api.advanceTextBox(pid, bid)`

- **Location:** source line 409.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `bid` | Not explicitly documented in adjacent source annotations. |

#### 41. `api.closeTextBox(pid, bid)`

- **Location:** source line 410.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `bid` | Not explicitly documented in adjacent source annotations. |

#### 42. `api.getTextBoxState(pid, bid)`

- **Location:** source line 411.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `bid` | Not explicitly documented in adjacent source annotations. |

#### 43. `api.getTextBoxData(pid, bid)`

- **Location:** source line 412.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `bid` | Not explicitly documented in adjacent source annotations. |

#### 44. `api.setKeepAlive(pid, bid, keep)`

- **Location:** source line 413.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `bid` | Not explicitly documented in adjacent source annotations. |
| 3 | `keep` | Not explicitly documented in adjacent source annotations. |

#### 45. `Displayer:_setupTimerDisplayAPI()`

- **Location:** source line 419.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Timer Display API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 46. `api.createPlayerTimer(pid, did, x, y, o)`

- **Location:** source line 421.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `did` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `o` | Not explicitly documented in adjacent source annotations. |

#### 47. `api.createPlayerCountdown(pid, did, x, y, o)`

- **Location:** source line 422.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `did` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `o` | Not explicitly documented in adjacent source annotations. |

#### 48. `api.createGlobalTimer(did, x, y, o)`

- **Location:** source line 423.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `did` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `o` | Not explicitly documented in adjacent source annotations. |

#### 49. `api.createGlobalCountdown(did, x, y, o)`

- **Location:** source line 424.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `did` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `o` | Not explicitly documented in adjacent source annotations. |

#### 50. `api.remove(pid, did)`

- **Location:** source line 425.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `did` | Not explicitly documented in adjacent source annotations. |

#### 51. `api.setPosition(pid, did, x, y)`

- **Location:** source line 426.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `did` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |

#### 52. `Displayer:_setupNameplateAPI()`

- **Location:** source line 432.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Nameplate API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 53. `api.attach(pid, pd, bid, bd, cfg)`

- **Location:** source line 434.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `pd` | Not explicitly documented in adjacent source annotations. |
| 3 | `bid` | Not explicitly documented in adjacent source annotations. |
| 4 | `bd` | Not explicitly documented in adjacent source annotations. |
| 5 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 54. `api.erase(pid, pd, bd)`

- **Location:** source line 435.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `pd` | Not explicitly documented in adjacent source annotations. |
| 3 | `bd` | Not explicitly documented in adjacent source annotations. |

#### 55. `api.begin_close(pid, pd, bd, cfg)`

- **Location:** source line 436.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `pd` | Not explicitly documented in adjacent source annotations. |
| 3 | `bd` | Not explicitly documented in adjacent source annotations. |
| 4 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 56. `Displayer:_setupScrollingTextAPI()`

- **Location:** source line 442.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Scrolling Text List API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 57. `api.createList(pid, lid, x, y, w, h, cfg)`

- **Location:** source line 444.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `w` | Not explicitly documented in adjacent source annotations. |
| 6 | `h` | Not explicitly documented in adjacent source annotations. |
| 7 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 58. `api.addText(pid, lid, text)`

- **Location:** source line 445.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |

#### 59. `api.setTexts(pid, lid, texts)`

- **Location:** source line 446.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `texts` | Not explicitly documented in adjacent source annotations. |

#### 60. `api.getState(pid, lid)`

- **Location:** source line 447.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |

#### 61. `api.setSpeed(pid, lid, s)`

- **Location:** source line 448.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `s` | Not explicitly documented in adjacent source annotations. |

#### 62. `api.removeList(pid, lid)`

- **Location:** source line 449.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |

#### 63. `api.setPosition(pid, lid, x, y)`

- **Location:** source line 450.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |

#### 64. `Displayer:_setupScrollingSpriteAPI()`

- **Location:** source line 456.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Scrolling Sprite List API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 65. `api.createList(pid, lid, x, y, w, h, cfg)`

- **Location:** source line 458.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `w` | Not explicitly documented in adjacent source annotations. |
| 6 | `h` | Not explicitly documented in adjacent source annotations. |
| 7 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 66. `api.addSprite(pid, lid, d)`

- **Location:** source line 459.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `d` | Not explicitly documented in adjacent source annotations. |

#### 67. `api.setSprites(pid, lid, s)`

- **Location:** source line 460.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `s` | Not explicitly documented in adjacent source annotations. |

#### 68. `api.getState(pid, lid)`

- **Location:** source line 461.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |

#### 69. `api.setSpeed(pid, lid, s)`

- **Location:** source line 462.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `s` | Not explicitly documented in adjacent source annotations. |

#### 70. `api.removeList(pid, lid)`

- **Location:** source line 463.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |

#### 71. `api.setPosition(pid, lid, x, y)`

- **Location:** source line 464.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |

#### 72. `Displayer:_setupTimerAPI()`

- **Location:** source line 470.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Timer System API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 73. `api.createPlayerTimer(p, t, d, cb, l)`

- **Location:** source line 472.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |
| 3 | `d` | Not explicitly documented in adjacent source annotations. |
| 4 | `cb` | Not explicitly documented in adjacent source annotations. |
| 5 | `l` | Not explicitly documented in adjacent source annotations. |

#### 74. `api.createPlayerCountdown(p, c, d, cb, l)`

- **Location:** source line 473.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `c` | Not explicitly documented in adjacent source annotations. |
| 3 | `d` | Not explicitly documented in adjacent source annotations. |
| 4 | `cb` | Not explicitly documented in adjacent source annotations. |
| 5 | `l` | Not explicitly documented in adjacent source annotations. |

#### 75. `api.pausePlayerTimer(p, t)`

- **Location:** source line 474.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |

#### 76. `api.resumePlayerTimer(p, t)`

- **Location:** source line 475.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |

#### 77. `api.pausePlayerCountdown(p, c)`

- **Location:** source line 476.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `c` | Not explicitly documented in adjacent source annotations. |

#### 78. `api.resumePlayerCountdown(p, c)`

- **Location:** source line 477.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `c` | Not explicitly documented in adjacent source annotations. |

#### 79. `api.removePlayerTimer(p, t)`

- **Location:** source line 478.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |

#### 80. `api.removePlayerCountdown(p, c)`

- **Location:** source line 479.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `c` | Not explicitly documented in adjacent source annotations. |

#### 81. `api.getPlayerTimer(p, t)`

- **Location:** source line 480.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |

#### 82. `api.getPlayerCountdown(p, c)`

- **Location:** source line 481.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |
| 2 | `c` | Not explicitly documented in adjacent source annotations. |

#### 83. `api.createGlobalTimer(t, d, cb, l)`

- **Location:** source line 482.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |
| 2 | `d` | Not explicitly documented in adjacent source annotations. |
| 3 | `cb` | Not explicitly documented in adjacent source annotations. |
| 4 | `l` | Not explicitly documented in adjacent source annotations. |

#### 84. `api.createGlobalCountdown(c, d, cb, l)`

- **Location:** source line 483.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |
| 2 | `d` | Not explicitly documented in adjacent source annotations. |
| 3 | `cb` | Not explicitly documented in adjacent source annotations. |
| 4 | `l` | Not explicitly documented in adjacent source annotations. |

#### 85. `api.pauseGlobalTimer(t)`

- **Location:** source line 484.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 86. `api.resumeGlobalTimer(t)`

- **Location:** source line 485.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 87. `api.pauseGlobalCountdown(c)`

- **Location:** source line 486.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |

#### 88. `api.resumeGlobalCountdown(c)`

- **Location:** source line 487.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |

#### 89. `api.removeGlobalTimer(t)`

- **Location:** source line 488.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 90. `api.removeGlobalCountdown(c)`

- **Location:** source line 489.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |

#### 91. `api.getGlobalTimer(t)`

- **Location:** source line 490.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 92. `api.getGlobalCountdown(c)`

- **Location:** source line 491.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |

#### 93. `api.getAllGlobalTimers()`

- **Location:** source line 492.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 94. `api.getAllGlobalCountdowns()`

- **Location:** source line 493.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 95. `api.clearAllGlobalTimers()`

- **Location:** source line 494.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 96. `api.clearAllGlobalCountdowns()`

- **Location:** source line 495.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 97. `Displayer:_setupTextPanelAPI()`

- **Location:** source line 501.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Text Panel API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 98. `api.create(player_id, panel_id, text, x, y, style, options)`

- **Location:** source line 505.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `style` | Not explicitly documented in adjacent source annotations. |
| 7 | `options` | Not explicitly documented in adjacent source annotations. |

#### 99. `api.createWithChildren(player_id, panel_id, x, y, style, options)`

- **Location:** source line 515.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `style` | Not explicitly documented in adjacent source annotations. |
| 6 | `options` | Not explicitly documented in adjacent source annotations. |

#### 100. `api.updateText(player_id, panel_id, newText)`

- **Location:** source line 525.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `newText` | Not explicitly documented in adjacent source annotations. |

#### 101. `api.setChildren(player_id, panel_id, children)`

- **Location:** source line 532.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `children` | Not explicitly documented in adjacent source annotations. |

#### 102. `api.setPosition(player_id, panel_id, x, y)`

- **Location:** source line 539.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |

#### 103. `api.setOptions(player_id, panel_id, newOptions)`

- **Location:** source line 546.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `newOptions` | Not explicitly documented in adjacent source annotations. |

#### 104. `api.getSize(player_id, panel_id)`

- **Location:** source line 553.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |

#### 105. `api.remove(player_id, panel_id)`

- **Location:** source line 559.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |

#### 106. `api.get(player_id, panel_id)`

- **Location:** source line 567.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |

#### 107. `Displayer:_setupSlicedSpriteAPI()`

- **Location:** source line 585.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Sliced Sprite API 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 108. `api.draw3(pid, lid, x, y, w, h, style, o)`

- **Location:** source line 587.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `w` | Not explicitly documented in adjacent source annotations. |
| 6 | `h` | Not explicitly documented in adjacent source annotations. |
| 7 | `style` | Not explicitly documented in adjacent source annotations. |
| 8 | `o` | Not explicitly documented in adjacent source annotations. |

#### 109. `api.draw5(pid, lid, x, y, w, h, style, o)`

- **Location:** source line 588.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `w` | Not explicitly documented in adjacent source annotations. |
| 6 | `h` | Not explicitly documented in adjacent source annotations. |
| 7 | `style` | Not explicitly documented in adjacent source annotations. |
| 8 | `o` | Not explicitly documented in adjacent source annotations. |

#### 110. `api.draw9(pid, lid, x, y, w, h, style, o)`

- **Location:** source line 589.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `w` | Not explicitly documented in adjacent source annotations. |
| 6 | `h` | Not explicitly documented in adjacent source annotations. |
| 7 | `style` | Not explicitly documented in adjacent source annotations. |
| 8 | `o` | Not explicitly documented in adjacent source annotations. |

#### 111. `api.erase(pid, lid)`

- **Location:** source line 590.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |

#### 112. `api.drawTextPanel(pid, lid, x, y, text, style, options)`

- **Location:** source line 591.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `lid` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `text` | Not explicitly documented in adjacent source annotations. |
| 6 | `style` | Not explicitly documented in adjacent source annotations. |
| 7 | `options` | Not explicitly documented in adjacent source annotations. |

#### 113. `Displayer:formatTime(seconds, is_countdown)`

- **Location:** source line 597.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Utility 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `seconds` | Not explicitly documented in adjacent source annotations. |
| 2 | `is_countdown` | Not explicitly documented in adjacent source annotations. |

#### 114. `Displayer:getScreenDimensions()`

- **Location:** source line 607.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 59 | `event` | `) self:_setupBuilderAPI() self.SlicedPanel = self.TextPanel Net:on("player_join",` |
| 571 | `event` | `player_id] and self._text_panels[player_id][panel_id] end Net:on("player_disconnect",` |

## 📦 Tables and data

The following **48** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Displayer` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `self.Font` — line 22

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `self.Text` — line 23

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `self.TimerDisplay` — line 24

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `self.Nameplate` — line 25

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `self.ScrollingText` — line 26

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `self.ScrollingSprite` — line 27

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `self.Timer` — line 28

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `self.TextPanel` — line 29

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `self.SlicedPanel` — line 30

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `self.SlicedSprite` — line 31

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `self.Builder` — line 32

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `anim_cache` — line 71

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `opts` — line 74

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `opacity` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |

### 15. `opts` — line 81

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `opacity` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |

### 16. `opts` — line 88

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `speed` | numeric literal | `60` |
| `loops` | nil | `nil` |
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `opacity` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |
| `updateChar` | nil | `nil` |

### 17. `opts` — line 96

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `speed` | numeric literal | `30` |
| `type_sound` | nil | `nil` |
| `type_sound_min_dt` | numeric literal | `0.1` |
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `opacity` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |

### 18. `opts` — line 105

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `color` | nested table | `{ r = 255, g = 255, b = 255 }` |
| `opacity` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |

### 19. `color` — line 106

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |

### 20. `opts.color` — line 111

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `v.r or 255` |
| `g` | expression/reference | `v.g or 255` |
| `b` | expression/reference | `v.b or 255` |

### 21. `opts` — line 119

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `1.0` |
| `z_order` | numeric literal | `100` |
| `scroll_speed` | numeric literal | `30` |
| `line_spacing` | numeric literal | `15` |
| `entry_delay` | numeric literal | `1.0` |
| `loop` | boolean literal | `false` |
| `destroy_when_finished` | boolean literal | `true` |
| `destroy_delay` | numeric literal | `1.0` |
| `backdrop` | nil | `nil` |
| `texts` | nested table | `{}` |

### 22. `texts` — line 122

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 23. `opts` — line 128

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `0` |
| `y` | numeric literal | `0` |
| `width` | numeric literal | `200` |
| `height` | numeric literal | `100` |
| `z_order` | numeric literal | `100` |
| `scroll_speed` | numeric literal | `30` |
| `entry_delay` | numeric literal | `1.0` |
| `max_columns` | numeric literal | `1` |
| `column_spacing` | numeric literal | `5` |
| `row_spacing` | numeric literal | `5` |
| `align` | string literal | `"left"` |
| `backdrop` | nil | `nil` |
| `sprites` | nested table | `{}` |

### 24. `sprites` — line 131

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 25. `return` — line 137

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `width` | expression/reference | `width` |
| `height` | expression/reference | `height` |
| `padding_x` | expression/reference | `padding_x or 8` |
| `padding_y` | expression/reference | `padding_y or 6` |
| `r` | expression/reference | `r or 0` |
| `g` | expression/reference | `g or 0` |
| `b` | expression/reference | `b or 0` |
| `opacity` | expression/reference | `opacity or 200` |
| `a` | expression/reference | `a or 255` |

### 26. `def` — line 150

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | expression/reference | `texture_path` |
| `anim_path` | expression/reference | `anim_path or ""` |
| `anim_state` | expression/reference | `anim_state or ""` |
| `ox` | numeric literal | `0` |
| `oy` | numeric literal | `0` |
| `sx` | numeric literal | `2` |
| `sy` | numeric literal | `2` |
| `width` | numeric literal | `16` |
| `height` | numeric literal | `16` |
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `opacity` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |

### 27. `default_states` — line 189

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `top_left` | string literal | `"CORNER_UL"` |
| `top` | string literal | `"EDGE_UC"` |
| `top_right` | string literal | `"CORNER_UR"` |
| `left` | string literal | `"EDGE_CL"` |
| `center` | string literal | `"CENTER"` |
| `right` | string literal | `"EDGE_RC"` |
| `bottom_left` | string literal | `"CORNER_LL"` |
| `bottom` | string literal | `"EDGE_LC"` |
| `bottom_right` | string literal | `"CORNER_LR"` |

### 28. `parts` — line 194

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 29. `return` — line 198

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"9"` |
| `orientation` | string literal | `"horizontal"` |
| `texture_path` | expression/reference | `texture_path` |
| `anim_path` | expression/reference | `anim_path` |
| `parts` | expression/reference | `parts` |

### 30. `return` — line 208

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"3"` |
| `orientation` | expression/reference | `orientation` |
| `texture_path` | expression/reference | `texture_path` |
| `anim_path` | expression/reference | `anim_path` |
| `parts` | nested table | `{ { anim_state = states[1] or defaults[1] }, { anim_state = states[2] or defaults[2] }, { anim_state = states[3] or defaults[3] }, }` |

### 31. `parts` — line 211

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ anim_state = states[1] or defaults[1] }` |
| `[2]` | nested table | `{ anim_state = states[2] or defaults[2] }` |
| `[3]` | nested table | `{ anim_state = states[3] or defaults[3] }` |

### 32. `return` — line 225

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"5"` |
| `orientation` | expression/reference | `orientation` |
| `texture_path` | expression/reference | `texture_path` |
| `anim_path` | expression/reference | `anim_path` |
| `parts` | nested table | `{ { anim_state = states[1] or defaults[1] }, { anim_state = states[2] or defaults[2], stretch = true }, { anim_state = states[3] or defaults[3] }, { anim_…` |

### 33. `parts` — line 228

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ anim_state = states[1] or defaults[1] }` |
| `[2]` | nested table | `{ anim_state = states[2] or defaults[2], stretch = true }` |
| `[3]` | nested table | `{ anim_state = states[3] or defaults[3] }` |
| `[4]` | nested table | `{ anim_state = states[4] or defaults[4], stretch = true }` |
| `[5]` | nested table | `{ anim_state = states[5] or defaults[5] }` |

### 34. `base` — line 239

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `mode` | expression/reference | `mode` |
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `opacity` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |
| `halign` | string literal | `"left"` |
| `valign` | string literal | `"top"` |
| `width` | nil | `nil` |
| `height` | nil | `nil` |
| `perChar` | nil | `nil` |

### 35. `return` — line 255

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | expression/reference | `kind or "9"` |
| `orientation` | expression/reference | `orientation or "horizontal"` |
| `parts` | expression/reference | `parts` |

### 36. `return` — line 265

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `left` | expression/reference | `h` |
| `right` | expression/reference | `h` |
| `top` | expression/reference | `v` |
| `bottom` | expression/reference | `v` |

### 37. `return` — line 271

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `left` | expression/reference | `tonumber(value.left) or horizontal` |
| `right` | expression/reference | `tonumber(value.right) or horizontal` |
| `top` | expression/reference | `tonumber(value.top) or vertical_value` |
| `bottom` | expression/reference | `tonumber(value.bottom) or vertical_value` |

### 38. `return` — line 280

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `left` | expression/reference | `h` |
| `right` | expression/reference | `h` |
| `top` | expression/reference | `v` |
| `bottom` | expression/reference | `v` |

### 39. `opts` — line 295

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `color` | nested table | `{ r = 255, g = 255, b = 255, a = 255 }` |
| `halign` | string literal | `"left"` |
| `valign` | string literal | `"top"` |
| `line_spacing` | numeric literal | `0` |
| `padding` | numeric literal | `8` |
| `child_padding` | numeric literal | `0` |
| `auto_size` | boolean literal | `true` |
| `width` | nil | `nil` |
| `height` | nil | `nil` |
| `max_width` | nil | `nil` |
| `max_height` | nil | `nil` |
| `z` | numeric literal | `100` |
| `slice_scale` | numeric literal | `1.0` |
| `slice_options` | nested table | `{}` |
| `overflow` | string literal | `"wrap"` |
| `layout` | string literal | `"vertical"` |
| `spacing` | numeric literal | `0` |
| `main_axis_spacing` | nil | `nil` |
| `cross_axis_spacing` | numeric literal | `0` |
| `main_axis_alignment` | string literal | `"start"` |
| `cross_axis_alignment` | string literal | `"center"` |
| `columns` | numeric literal | `2` |
| `column_spacing` | nil | `nil` |
| `row_spacing` | nil | `nil` |
| `horizontal_alignment` | string literal | `"start"` |
| `vertical_alignment` | string literal | `"start"` |
| `children` | nil | `nil` |

### 40. `color` — line 297

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `a` | numeric literal | `255` |

### 41. `slice_options` — line 301

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 42. `opts.color` — line 313

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `v.r or 255` |
| `g` | expression/reference | `v.g or 255` |
| `b` | expression/reference | `v.b or 255` |
| `a` | expression/reference | `v.a or 255` |

### 43. `opts` — line 330

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 44. `opts` — line 338

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 45. `opts` — line 346

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 46. `return` — line 354

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `text` | expression/reference | `text` |
| `style` | expression/reference | `style` |
| `options` | expression/reference | `options or {}` |

### 47. `child` — line 358

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"text"` |
| `text` | expression/reference | `text` |

### 48. `child` — line 365

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"sprites"` |
| `sprites` | expression/reference | `sprites or {}` |
| `sprite_scale` | numeric literal | `1.0` |
| `columns` | numeric literal | `1` |
| `column_spacing` | numeric literal | `5` |
| `row_spacing` | numeric literal | `5` |
| `sprite_align` | string literal | `"center"` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
