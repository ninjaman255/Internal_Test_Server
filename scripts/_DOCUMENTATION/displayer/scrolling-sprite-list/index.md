# 📄 `scrolling-sprite-list.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/scrolling-sprite-list.lua`](../../../displayer/scrolling-sprite-list.lua)  
> **Source lines:** 645  
> **SHA-256 (UTF-8):** `64776120c6b9ef…`  
> **Declared/assigned functions detected:** 35  
> **Anonymous closures detected:** 8  
> **Table initializers detected:** 20

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

Source-based reference for `scripts/displayer/scrolling-sprite-list.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 9 | `scripts/animation-engine/animation-engine` |
| 13 | `scripts/boom/main` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 216 | `Net:on` | `player_join` |
| 220 | `Net:on` | `player_disconnect` |
| 224 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 22 | `SpriteEntry:new` | `list_obj, player_id, list_id, index, def` | declared |
| 53 | `SpriteEntry:setPosition` | `x, y` | declared |
| 59 | `SpriteEntry:setColor` | `r, g, b, a` | declared |
| 67 | `SpriteEntry:setScale` | `sx, sy` | declared |
| 73 | `SpriteEntry:setAnimationState` | `state` | declared |
| 78 | `SpriteEntry:redraw` | `(none)` | declared |
| 118 | `SpriteEntry:destroy` | `(none)` | declared |
| 132 | `SpriteEntry:startScroll` | `delay, distance, speed` | declared |
| 146 | `SpriteEntry:_beginScroll` | `distance, speed` | declared |
| 176 | `on_update` | `values` | assigned |
| 180 | `on_complete` | `(none)` | assigned |
| 198 | `ScrollingSpriteList:init` | `(none)` | declared |
| 231 | `ScrollingSpriteList:setupPlayer` | `player_id` | declared |
| 244 | `ScrollingSpriteList:cleanupPlayer` | `player_id` | declared |
| 264 | `getFirstState` | `anim_path` | local |
| 288 | `ScrollingSpriteList:ensureSpriteAsset` | `player_id, sprite_def` | declared |
| 327 | `ScrollingSpriteList:_computeGridPositions` | `config` | declared |
| 367 | `ScrollingSpriteList:_drawBackdrop` | `player_id, list_id, config` | declared |
| 394 | `ScrollingSpriteList:createScrollingList` | `player_id, list_id, x, y, width, height, config` | declared |
| 479 | `list_object:onEntryFinished` | `(none)` | declared |
| 491 | `list_object:getEntry` | `index` | declared |
| 495 | `list_object:addSprite` | `sprite_def` | declared |
| 502 | `list_object:setSprites` | `sprites` | declared |
| 507 | `list_object:setSpeed` | `speed` | declared |
| 511 | `list_object:setPosition` | `x, y` | declared |
| 542 | `list_object:destroy` | `(none)` | declared |
| 558 | `list_object:_recreateEntries` | `(none)` | declared |
| 588 | `ScrollingSpriteList:updateAll` | `delta` | declared |
| 591 | `ScrollingSpriteList:getList` | `player_id, list_id` | declared |
| 596 | `ScrollingSpriteList:removeScrollingList` | `player_id, list_id` | declared |
| 601 | `ScrollingSpriteList:setListPosition` | `player_id, list_id, x, y` | declared |
| 607 | `ScrollingSpriteList:setListSpeed` | `player_id, list_id, speed` | declared |
| 613 | `ScrollingSpriteList:addSpriteToList` | `player_id, list_id, sprite_def` | declared |
| 619 | `ScrollingSpriteList:setListSprites` | `player_id, list_id, sprites` | declared |
| 625 | `ScrollingSpriteList:getListState` | `player_id, list_id` | declared |

### Function details

#### 1. `SpriteEntry:new(list_obj, player_id, list_id, index, def)`

- **Location:** source line 22.
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
| 5 | `def` | Not explicitly documented in adjacent source annotations. |

#### 2. `SpriteEntry:setPosition(x, y)`

- **Location:** source line 53.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 3. `SpriteEntry:setColor(r, g, b, a)`

- **Location:** source line 59.
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

#### 4. `SpriteEntry:setScale(sx, sy)`

- **Location:** source line 67.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sx` | Not explicitly documented in adjacent source annotations. |
| 2 | `sy` | Not explicitly documented in adjacent source annotations. |

#### 5. `SpriteEntry:setAnimationState(state)`

- **Location:** source line 73.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | Not explicitly documented in adjacent source annotations. |

#### 6. `SpriteEntry:redraw()`

- **Location:** source line 78.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 7. `SpriteEntry:destroy()`

- **Location:** source line 118.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 8. `SpriteEntry:startScroll(delay, distance, speed)`

- **Location:** source line 132.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delay` | Not explicitly documented in adjacent source annotations. |
| 2 | `distance` | Not explicitly documented in adjacent source annotations. |
| 3 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 9. `SpriteEntry:_beginScroll(distance, speed)`

- **Location:** source line 146.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `distance` | Not explicitly documented in adjacent source annotations. |
| 2 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 10. `on_update(values)`

- **Location:** source line 176.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 11. `on_complete()`

- **Location:** source line 180.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 12. `ScrollingSpriteList:init()`

- **Location:** source line 198.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  ScrollingSpriteList main class (unchanged except where noted) 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 13. `ScrollingSpriteList:setupPlayer(player_id)`

- **Location:** source line 231.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 14. `ScrollingSpriteList:cleanupPlayer(player_id)`

- **Location:** source line 244.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 15. `getFirstState(anim_path)`

- **Location:** source line 264.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper: get first available animation state from an animation file

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `anim_path` | Not explicitly documented in adjacent source annotations. |

#### 16. `ScrollingSpriteList:ensureSpriteAsset(player_id, sprite_def)`

- **Location:** source line 288.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `sprite_def` | Not explicitly documented in adjacent source annotations. |

#### 17. `ScrollingSpriteList:_computeGridPositions(config)`

- **Location:** source line 327.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `config` | Not explicitly documented in adjacent source annotations. |

#### 18. `ScrollingSpriteList:_drawBackdrop(player_id, list_id, config)`

- **Location:** source line 367.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `config` | Not explicitly documented in adjacent source annotations. |

#### 19. `ScrollingSpriteList:createScrollingList(player_id, list_id, x, y, width, height, config)`

- **Location:** source line 394.
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

- **Location:** source line 479.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 21. `list_object:getEntry(index)`

- **Location:** source line 491.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `index` | Not explicitly documented in adjacent source annotations. |

#### 22. `list_object:addSprite(sprite_def)`

- **Location:** source line 495.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_def` | Not explicitly documented in adjacent source annotations. |

#### 23. `list_object:setSprites(sprites)`

- **Location:** source line 502.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprites` | Not explicitly documented in adjacent source annotations. |

#### 24. `list_object:setSpeed(speed)`

- **Location:** source line 507.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 25. `list_object:setPosition(x, y)`

- **Location:** source line 511.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 26. `list_object:destroy()`

- **Location:** source line 542.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 27. `list_object:_recreateEntries()`

- **Location:** source line 558.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 28. `ScrollingSpriteList:updateAll(delta)`

- **Location:** source line 588.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delta` | Not explicitly documented in adjacent source annotations. |

#### 29. `ScrollingSpriteList:getList(player_id, list_id)`

- **Location:** source line 591.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Legacy API wrappers
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |

#### 30. `ScrollingSpriteList:removeScrollingList(player_id, list_id)`

- **Location:** source line 596.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |

#### 31. `ScrollingSpriteList:setListPosition(player_id, list_id, x, y)`

- **Location:** source line 601.
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

#### 32. `ScrollingSpriteList:setListSpeed(player_id, list_id, speed)`

- **Location:** source line 607.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 33. `ScrollingSpriteList:addSpriteToList(player_id, list_id, sprite_def)`

- **Location:** source line 613.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `sprite_def` | Not explicitly documented in adjacent source annotations. |

#### 34. `ScrollingSpriteList:setListSprites(player_id, list_id, sprites)`

- **Location:** source line 619.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `list_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `sprites` | Not explicitly documented in adjacent source annotations. |

#### 35. `ScrollingSpriteList:getListState(player_id, list_id)`

- **Location:** source line 625.
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
| 135 | `(none)` | `f.state = "waiting" if delay > 0 then self.delay_id = AnimationEngine.delay(delay,` |
| 216 | `event` | `_spacing = 5, row_spacing = 5, align = "left" } Net:on("player_join",` |
| 217 | `(none)` | `ing = 5, align = "left" } Net:on("player_join", function(event) pcall(` |
| 220 | `event` | `ll(function() self:setupPlayer(event.player_id) end) end) Net:on("player_disconnect",` |
| 221 | `(none)` | `(event.player_id) end) end) Net:on("player_disconnect", function(event) pcall(` |
| 224 | `event` | `pcall(function() self:cleanupPlayer(event.player_id) end) end) Net:on("tick",` |
| 225 | `(none)` | `cleanupPlayer(event.player_id) end) end) Net:on("tick", function(event) pcall(` |
| 484 | `(none)` | `d then self.remove_delay_id = AnimationEngine.delay(self.config.destroy_delay,` |

## 📦 Tables and data

The following **20** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ScrollingSpriteList` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `anim_cache` — line 14

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `SpriteEntry` — line 19

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `o.props` — line 29

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `0` |
| `y` | numeric literal | `0` |
| `r` | expression/reference | `def.r or 255` |
| `g` | expression/reference | `def.g or 255` |
| `b` | expression/reference | `def.b or 255` |
| `a` | expression/reference | `def.a or 255` |
| `opacity` | expression/reference | `def.opacity or 255` |
| `sx` | expression/reference | `def.sx or 1` |
| `sy` | expression/reference | `def.sy or 1` |
| `ro` | expression/reference | `def.ro or 0` |
| `color_mode` | expression/reference | `def.color_mode or 0` |
| `anim_state` | expression/reference | `def.anim_state` |

### 5. `draw` — line 85

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `self.instance_id or (self.list_id .. "_entry_" .. self.index)` |
| `x` | expression/reference | `self.props.x` |
| `y` | expression/reference | `self.props.y` |
| `z` | expression/reference | `self.list.config.z_order` |
| `sx` | expression/reference | `self.props.sx` |
| `sy` | expression/reference | `self.props.sy` |
| `r` | expression/reference | `self.props.r` |
| `g` | expression/reference | `self.props.g` |
| `b` | expression/reference | `self.props.b` |
| `opacity` | expression/reference | `self.props.opacity` |
| `a` | expression/reference | `self.props.a` |
| `ro` | expression/reference | `self.props.ro` |
| `color_mode` | expression/reference | `self.props.color_mode` |
| `ox` | numeric literal | `0` |
| `oy` | numeric literal | `0` |

### 6. `self.player_lists` — line 199

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `self.player_assets` — line 200

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `self.player_backdrop_sprite` — line 201

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `self.default_config` — line 203

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `z_order` | numeric literal | `100` |
| `scroll_speed` | numeric literal | `30` |
| `entry_delay` | numeric literal | `1.0` |
| `loop` | boolean literal | `false` |
| `destroy_when_finished` | boolean literal | `true` |
| `destroy_delay` | numeric literal | `1.0` |
| `max_columns` | numeric literal | `1` |
| `column_spacing` | numeric literal | `5` |
| `row_spacing` | numeric literal | `5` |
| `align` | string literal | `"left"` |

### 10. `self.player_lists` — line 232

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `active_lists` — line 233

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `self.player_assets` — line 289

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `alloc_params` — line 306

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | expression/reference | `sprite_def.texture_path` |
| `anim_path` | expression/reference | `anim_path or ""` |

### 14. `positions` — line 355

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `self.player_lists` — line 396

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 16. `list_config` — line 399

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 17. `list_object` — line 450

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `parent` | expression/reference | `self` |
| `player_id` | expression/reference | `player_id` |
| `list_id` | expression/reference | `list_id` |
| `config` | expression/reference | `list_config` |
| `backdrop_id` | expression/reference | `backdrop_id` |
| `entries` | nested table | `{}` |
| `active_count` | numeric literal | `0` |
| `finished` | boolean literal | `false` |
| `remove_delay_id` | nil | `nil` |

### 18. `entries` — line 456

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 19. `self.entries` — line 565

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 20. `return` — line 634

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
| `Net.player_alloc_sprite` | 2 |
| `Net.player_dealloc_sprite` | 2 |
| `Net.player_draw_sprite` | 2 |
| `Net.player_erase_sprite` | 3 |
| `Net.provide_asset_for_player` | 3 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
