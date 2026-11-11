# 📄 `scrolling-text-list.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/scrolling-text-list.lua`](../../../displayer/scrolling-text-list.lua)  
> **Source lines:** 569  
> **SHA-256 (UTF-8):** `e4794922eb601a…`  
> **Declared/assigned functions detected:** 36  
> **Anonymous closures detected:** 8  
> **Table initializers detected:** 18

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

Source-based reference for `scripts/displayer/scrolling-text-list.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 9 | `scripts/displayer/font-system` |
| 10 | `scripts/animation-engine/animation-engine` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 235 | `Net:on` | `player_join` |
| 239 | `Net:on` | `player_disconnect` |
| 245 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 14 | `normalize_scale` | `value, fallback` | local |
| 20 | `getFontHeight` | `font_name, scale` | local |
| 32 | `TextEntry:new` | `list_obj, player_id, list_id, index, text, config` | declared |
| 54 | `TextEntry:_createGlyphs` | `y_offset` | declared |
| 113 | `TextEntry:_updatePositions` | `y_offset` | declared |
| 121 | `TextEntry:setPosition` | `x, y` | declared |
| 129 | `TextEntry:setColor` | `r, g, b, a` | declared |
| 146 | `TextEntry:setScale` | `scale` | declared |
| 153 | `TextEntry:destroy` | `(none)` | declared |
| 171 | `TextEntry:startScroll` | `delay, distance, speed` | declared |
| 185 | `TextEntry:_beginScroll` | `distance, speed` | declared |
| 198 | `on_update` | `values` | assigned |
| 201 | `on_complete` | `(none)` | assigned |
| 217 | `ScrollingTextList:init` | `(none)` | declared |
| 252 | `ScrollingTextList:setupPlayer` | `player_id` | declared |
| 264 | `ScrollingTextList:cleanupPlayer` | `player_id` | declared |
| 279 | `ScrollingTextList:_drawBackdrop` | `player_id, list_id, config` | declared |
| 302 | `ScrollingTextList:_computeGridPositions` | `config` | declared |
| 316 | `ScrollingTextList:createScrollingList` | `player_id, list_id, x, y, width, height, config` | declared |
| 397 | `list_object:onEntryFinished` | `(none)` | declared |
| 409 | `list_object:getEntry` | `index` | declared |
| 413 | `list_object:addText` | `text` | declared |
| 419 | `list_object:setTexts` | `texts` | declared |
| 424 | `list_object:setScale` | `scale` | declared |
| 430 | `list_object:setSpeed` | `speed` | declared |
| 435 | `list_object:setPosition` | `x, y` | declared |
| 458 | `list_object:destroy` | `(none)` | declared |
| 478 | `list_object:_recreateEntries` | `(none)` | declared |
| 512 | `ScrollingTextList:updateAll` | `delta` | declared |
| 515 | `ScrollingTextList:getList` | `player_id, list_id` | declared |
| 520 | `ScrollingTextList:removeScrollingList` | `player_id, list_id` | declared |
| 525 | `ScrollingTextList:setListPosition` | `player_id, list_id, x, y` | declared |
| 531 | `ScrollingTextList:setListSpeed` | `player_id, list_id, speed` | declared |
| 537 | `ScrollingTextList:addTextToList` | `player_id, list_id, text` | declared |
| 543 | `ScrollingTextList:setListTexts` | `player_id, list_id, texts` | declared |
| 549 | `ScrollingTextList:getListState` | `player_id, list_id` | declared |

### Function details

#### 1. `normalize_scale(value, fallback)`

- **Location:** source line 14.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `fallback` | Not explicitly documented in adjacent source annotations. |

#### 2. `getFontHeight(font_name, scale)`

- **Location:** source line 20.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 3. `TextEntry:new(list_obj, player_id, list_id, index, text, config)`

- **Location:** source line 32.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `list_obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `index` | Not explicitly documented in adjacent source annotations. |
| 5 | `text` | Not explicitly documented in adjacent source annotations. |
| 6 | `config` | Not explicitly documented in adjacent source annotations. |

#### 4. `TextEntry:_createGlyphs(y_offset)`

- **Location:** source line 54.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create glyphs at current position (grid_x, grid_y + y_offset)
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `y_offset` | Not explicitly documented in adjacent source annotations. |

#### 5. `TextEntry:_updatePositions(y_offset)`

- **Location:** source line 113.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Update glyph positions (used during scrolling)
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `y_offset` | Not explicitly documented in adjacent source annotations. |

#### 6. `TextEntry:setPosition(x, y)`

- **Location:** source line 121.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 7. `TextEntry:setColor(r, g, b, a)`

- **Location:** source line 129.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `r` | Not explicitly documented in adjacent source annotations. |
| 2 | `g` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `a` | Not explicitly documented in adjacent source annotations. |

#### 8. `TextEntry:setScale(scale)`

- **Location:** source line 146.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 9. `TextEntry:destroy()`

- **Location:** source line 153.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 10. `TextEntry:startScroll(delay, distance, speed)`

- **Location:** source line 171.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Start scrolling: after delay, animate y_offset from 0 to -distance
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delay` | Not explicitly documented in adjacent source annotations. |
| 2 | `distance` | Not explicitly documented in adjacent source annotations. |
| 3 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 11. `TextEntry:_beginScroll(distance, speed)`

- **Location:** source line 185.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `distance` | Not explicitly documented in adjacent source annotations. |
| 2 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 12. `on_update(values)`

- **Location:** source line 198.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 13. `on_complete()`

- **Location:** source line 201.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 14. `ScrollingTextList:init()`

- **Location:** source line 217.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  ScrollingTextList main class 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 15. `ScrollingTextList:setupPlayer(player_id)`

- **Location:** source line 252.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 16. `ScrollingTextList:cleanupPlayer(player_id)`

- **Location:** source line 264.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 17. `ScrollingTextList:_drawBackdrop(player_id, list_id, config)`

- **Location:** source line 279.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `config` | Not explicitly documented in adjacent source annotations. |

#### 18. `ScrollingTextList:_computeGridPositions(config)`

- **Location:** source line 302.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `config` | Not explicitly documented in adjacent source annotations. |

#### 19. `ScrollingTextList:createScrollingList(player_id, list_id, x, y, width, height, config)`

- **Location:** source line 316.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `width` | Not explicitly documented in adjacent source annotations. |
| 6 | `height` | Not explicitly documented in adjacent source annotations. |
| 7 | `config` | Not explicitly documented in adjacent source annotations. |

#### 20. `list_object:onEntryFinished()`

- **Location:** source line 397.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Method to handle entry finished
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 21. `list_object:getEntry(index)`

- **Location:** source line 409.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `index` | Not explicitly documented in adjacent source annotations. |

#### 22. `list_object:addText(text)`

- **Location:** source line 413.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |

#### 23. `list_object:setTexts(texts)`

- **Location:** source line 419.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `texts` | Not explicitly documented in adjacent source annotations. |

#### 24. `list_object:setScale(scale)`

- **Location:** source line 424.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 25. `list_object:setSpeed(speed)`

- **Location:** source line 430.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 26. `list_object:setPosition(x, y)`

- **Location:** source line 435.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 27. `list_object:destroy()`

- **Location:** source line 458.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 28. `list_object:_recreateEntries()`

- **Location:** source line 478.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 29. `ScrollingTextList:updateAll(delta)`

- **Location:** source line 512.
- **Declaration style:** `declared`.
- **Adjacent source comment:** updateAll is now a no‑op (kept for compatibility)
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delta` | Not explicitly documented in adjacent source annotations. |

#### 30. `ScrollingTextList:getList(player_id, list_id)`

- **Location:** source line 515.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Legacy API wrappers (unchanged, but now use list_object methods)
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |

#### 31. `ScrollingTextList:removeScrollingList(player_id, list_id)`

- **Location:** source line 520.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |

#### 32. `ScrollingTextList:setListPosition(player_id, list_id, x, y)`

- **Location:** source line 525.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |

#### 33. `ScrollingTextList:setListSpeed(player_id, list_id, speed)`

- **Location:** source line 531.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 34. `ScrollingTextList:addTextToList(player_id, list_id, text)`

- **Location:** source line 537.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |

#### 35. `ScrollingTextList:setListTexts(player_id, list_id, texts)`

- **Location:** source line 543.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `texts` | Not explicitly documented in adjacent source annotations. |

#### 36. `ScrollingTextList:getListState(player_id, list_id)`

- **Location:** source line 549.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 174 | `(none)` | `f.state = "waiting" if delay > 0 then self.delay_id = AnimationEngine.delay(delay,` |
| 235 | `event` | `iting = "waiting", scrolling = "scrolling", finished = "finished" } Net:on("player_j…` |
| 236 | `(none)` | `"scrolling", finished = "finished" } Net:on("player_join", function(event) pcall(` |
| 239 | `event` | `ll(function() self:setupPlayer(event.player_id) end) end) Net:on("player_disconnect",` |
| 240 | `(none)` | `(event.player_id) end) end) Net:on("player_disconnect", function(event) pcall(` |
| 245 | `event` | `s drive everything. -- But we keep updateAll for compatibility (empty). Net:on("tick…` |
| 246 | `(none)` | `we keep updateAll for compatibility (empty). Net:on("tick", function(event) pcall(` |
| 402 | `(none)` | `d then self.remove_delay_id = AnimationEngine.delay(self.config.destroy_delay,` |

## 📦 Tables and data

The following **18** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ScrollingTextList` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `TextEntry` — line 29

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `o.props` — line 42

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `255` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `255` |
| `a` | numeric literal | `255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |

### 4. `glyph_data` — line 85

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `opts` — line 92

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `scale` | expression/reference | `self.scale` |
| `z` | expression/reference | `self.z` |
| `r` | expression/reference | `self.props.r` |
| `g` | expression/reference | `self.props.g` |
| `b` | expression/reference | `self.props.b` |
| `a` | expression/reference | `self.props.a` |
| `ro` | expression/reference | `self.props.ro` |
| `color_mode` | expression/reference | `self.props.color_mode` |

### 6. `self.player_lists` — line 218

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `self.player_backdrop_sprite` — line 219

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `self.default_config` — line 221

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

### 9. `self.states` — line 233

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `waiting` | string literal | `"waiting"` |
| `scrolling` | string literal | `"scrolling"` |
| `finished` | string literal | `"finished"` |

### 10. `self.player_lists` — line 253

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `active_lists` — line 254

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `positions` — line 303

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `self.player_lists` — line 318

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `list_config` — line 321

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `list_object` — line 369

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `parent` | expression/reference | `self` |
| `player_id` | expression/reference | `player_id` |
| `list_id` | expression/reference | `list_id` |
| `config` | expression/reference | `list_config` |
| `backdrop_id` | expression/reference | `backdrop_id` |
| `entries` | nested table | `{}` |
| `active_count` | numeric literal | `0` |
| `[8]` | expression/reference | `-- number of entries not finished finished = false` |
| `remove_delay_id` | nil | `nil` |

### 16. `entries` — line 375

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 17. `self.entries` — line 490

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 18. `return` — line 558

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `state` | expression/reference | `list_object.finished and "finished" or "active"` |
| `all_finished` | expression/reference | `list_object.finished` |
| `total_entries` | expression/reference | `list_object.entries and #list_object.entries or 0` |
| `active_entries` | expression/reference | `active` |
| `marked_for_removal` | expression/reference | `list_object.finished and list_object.config.destroy_when_finished` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 3 |
| `Net.player_alloc_sprite` | 1 |
| `Net.player_dealloc_sprite` | 1 |
| `Net.player_draw_sprite` | 1 |
| `Net.player_erase_sprite` | 2 |
| `Net.provide_asset_for_player` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
