# 📄 `font-system.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/font-system.lua`](../../../displayer/font-system.lua)  
> **Source lines:** 678  
> **SHA-256 (UTF-8):** `5bce5bcdca6a95…`  
> **Declared/assigned functions detected:** 18  
> **Anonymous closures detected:** 5  
> **Table initializers detected:** 38

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

Source-based reference for `scripts/displayer/font-system.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 14 | `scripts/boom/main` |
| 15 | `scripts/utils/async` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 650 | `Net:on` | `player_request` |
| 663 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 154 | `load_animation_metrics` | `anim_path` | local |
| 190 | `FontSystem:loadAllFonts` | `(none)` | declared |
| 207 | `FontSystem:getGlyphState` | `font_name, char` | declared |
| 283 | `FontSystem:getGlyphDimensions` | `font_name, char` | declared |
| 298 | `FontSystem:isBattleFont` | `font_name` | declared |
| 310 | `FontSystem:getVirtualAdvance` | `font_name, char, scale` | declared |
| 323 | `FontSystem:getScreenAdvance` | `font_name, char, scale` | declared |
| 335 | `FontSystem:setupPlayer` | `player_id` | declared |
| 350 | `FontSystem:provideAllFontAssets` | `player_id` | declared |
| 358 | `FontSystem:cleanupPlayer` | `player_id` | declared |
| 382 | `FontSystem:ensureAssetAllocated` | `player_id, font_name` | declared |
| 416 | `FontSystem:nextInstanceId` | `player_id, prefix` | declared |
| 449 | `FontSystem:drawGlyph` | `player_id, font_name, char, x, y, options` | declared |
| 524 | `FontSystem:updateGlyph` | `player_id, instance_id, updates` | declared |
| 594 | `FontSystem:eraseGlyph` | `player_id, instance_id` | declared |
| 604 | `FontSystem:eraseGlyphsByPrefix` | `player_id, prefix` | declared |
| 616 | `FontSystem:allocateAllFontsForPlayer` | `player_id` | declared |
| 647 | `FontSystem:init` | `(none)` | declared |

### Function details

#### 1. `load_animation_metrics(anim_path)`

- **Location:** source line 154.
- **Declaration style:** `local`.
- **Adjacent source comment:**  Helper: load animation data using boom (strip "/server/" prefix) 
- **Lua documentation annotations:** `@param anim_path string   # full path with "/server/"`, `@return table<string, {w:number, h:number, ox:number, oy:number}> metrics`, `@return table<string, boolean> states`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `anim_path` | `@param anim_path string   # full path with "/server/"` |

#### 2. `FontSystem:loadAllFonts()`

- **Location:** source line 190.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Initialize global font data (call once on server start) 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 3. `FontSystem:getGlyphState(font_name, char)`

- **Location:** source line 207.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Determine the correct animation state for a given font and character 
- **Lua documentation annotations:** `@param font_name string`, `@param char string`, `@return string|nil   -- animation state name, or nil if no glyph`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | `@param font_name string` |
| 2 | `char` | `@param char string` |

#### 4. `FontSystem:getGlyphDimensions(font_name, char)`

- **Location:** source line 283.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Get glyph dimensions (after scale) for spacing calculations 
- **Lua documentation annotations:** `@param font_name string`, `@param char string`, `@return number width, number height`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | `@param font_name string` |
| 2 | `char` | `@param char string` |

#### 5. `FontSystem:isBattleFont(font_name)`

- **Location:** source line 298.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if a font name is a battle variant (no extra spacing).
- **Lua documentation annotations:** `@param font_name string`, `@return boolean`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | `@param font_name string` |

#### 6. `FontSystem:getVirtualAdvance(font_name, char, scale)`

- **Location:** source line 310.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Glyph advance helpers (single source of truth for text layout)  Get glyph advance in virtual 240x160 units (matches TextLayout).
- **Lua documentation annotations:** `@param font_name string`, `@param char string`, `@param scale number`, `@return number`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | `@param font_name string` |
| 2 | `char` | `@param char string` |
| 3 | `scale` | `@param scale number` |

#### 7. `FontSystem:getScreenAdvance(font_name, char, scale)`

- **Location:** source line 323.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Get glyph advance in screen (480x320) units.
- **Lua documentation annotations:** `@param font_name string`, `@param char string`, `@param scale number`, `@return number`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | `@param font_name string` |
| 2 | `char` | `@param char string` |
| 3 | `scale` | `@param scale number` |

#### 8. `FontSystem:setupPlayer(player_id)`

- **Location:** source line 335.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Per‑player asset management 
- **Lua documentation annotations:** `@param player_id string`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |

#### 9. `FontSystem:provideAllFontAssets(player_id)`

- **Location:** source line 350.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Provide all font textures and animation files for a player.
- **Lua documentation annotations:** `@param player_id string`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |

#### 10. `FontSystem:cleanupPlayer(player_id)`

- **Location:** source line 358.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |

#### 11. `FontSystem:ensureAssetAllocated(player_id, font_name)`

- **Location:** source line 382.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Ensure the sprite asset for a given font is allocated for the player
- **Lua documentation annotations:** `@param player_id string`, `@param font_name string`, `@return string? sprite_id`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `font_name` | `@param font_name string` |

#### 12. `FontSystem:nextInstanceId(player_id, prefix)`

- **Location:** source line 416.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Generate a unique instance ID for a player
- **Lua documentation annotations:** `@param player_id string`, `@param prefix string`, `@return string`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `prefix` | `@param prefix string` |

#### 13. `FontSystem:drawGlyph(player_id, font_name, char, x, y, options)`

- **Location:** source line 449.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Draw a single glyph.
- **Lua documentation annotations:** `@param player_id string`, `@param font_name string`, `@param char string`, `@param x number       # virtual 240×160 coordinate`, `@param y number       # virtual 240×160 coordinate`, `@param options? GlyphOptions`, `@return string|nil instance_id`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `font_name` | `@param font_name string` |
| 3 | `char` | `@param char string` |
| 4 | `x` | `@param x number       # virtual 240×160 coordinate` |
| 5 | `y` | `@param y number       # virtual 240×160 coordinate` |
| 6 | `options` | `@param options? GlyphOptions` |

#### 14. `FontSystem:updateGlyph(player_id, instance_id, updates)`

- **Location:** source line 524.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Update an existing glyph.
- **Lua documentation annotations:** `@param player_id string`, `@param instance_id string`, `@param updates GlyphOptions   -- can include 'char', 'x', 'y' in virtual space`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `instance_id` | `@param instance_id string` |
| 3 | `updates` | `@param updates GlyphOptions   -- can include 'char', 'x', 'y' in virtual space` |

#### 15. `FontSystem:eraseGlyph(player_id, instance_id)`

- **Location:** source line 594.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Erase a glyph instance.
- **Lua documentation annotations:** `@param player_id string`, `@param instance_id string`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `instance_id` | `@param instance_id string` |

#### 16. `FontSystem:eraseGlyphsByPrefix(player_id, prefix)`

- **Location:** source line 604.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Erase all glyphs with a given prefix.
- **Lua documentation annotations:** `@param player_id string`, `@param prefix string`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `prefix` | `@param prefix string` |

#### 17. `FontSystem:allocateAllFontsForPlayer(player_id)`

- **Location:** source line 616.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Asynchronous font allocation (one font every 0.5 seconds) 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 18. `FontSystem:init()`

- **Location:** source line 647.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  Initialization and event hooks 
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 618 | `(none)` | `yer(player_id) -- Run in a coroutine so we can sleep without blocking return async.r…` |
| 650 | `event` | `------------- function FontSystem:init() self:loadAllFonts() Net:on("player_request",` |
| 651 | `(none)` | `elf:loadAllFonts() Net:on("player_request", function(event) local ok, err = pcall(` |
| 663 | `event` | `"Error in player_request handler:", err) end end) Net:on("player_disconnect",` |
| 664 | `(none)` | `end end) Net:on("player_disconnect", function(event) local ok, err = pcall(` |

## 📦 Tables and data

The following **38** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `FontSystem` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `FONTS` — line 23

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Light variants (compressed sheet) THICK = { texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games…` |
| `THIN` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_thin.animation", prefix = "THIN"…` |
| `WIDE` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_wide.animation", prefix = "WIDE"…` |
| `TINY` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_tiny.animation", prefix = "TINY"…` |
| `BATTLE` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_battle.animation", prefix = "BAT…` |
| `GRADIENT` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix = "G…` |
| `GRADIENT_GOLD` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix = "G…` |
| `GRADIENT_ORANGE` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix = "G…` |
| `GRADIENT_GREEN` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix = "G…` |
| `GRADIENT_TALL` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix = "G…` |
| `[11]` | expression/reference | `-- Shimmer font (light) SHIMMER = { texture_path = "/server/assets/net-games/fonts/fonts_shimmer.png", anim_path = "/server/assets/net-games/fonts/fonts_s…` |
| `[12]` | expression/reference | `-- Dark variants (dark sheet) THICK_BLACK = { texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-g…` |
| `THIN_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_thin.animation", prefix = "…` |
| `WIDE_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_wide.animation", prefix = "…` |
| `TINY_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_tiny.animation", prefix = "…` |
| `BATTLE_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_battle.animation", prefix =…` |
| `GRADIENT_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix…` |
| `GRADIENT_GOLD_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix…` |
| `GRADIENT_ORANGE_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix…` |
| `GRADIENT_GREEN_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix…` |
| `GRADIENT_TALL_BLACK` | nested table | `{ texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png", anim_path = "/server/assets/net-games/fonts/fonts_gradient.animation", prefix…` |
| `[22]` | expression/reference | `-- Shimmer font (dark) SHIMMER_BLACK = { texture_path = "/server/assets/net-games/fonts/fonts_black_shimmer.png", anim_path = "/server/assets/net-games/fo…` |

### 3. `THICK` — line 25

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_thick.animation"` |
| `prefix` | string literal | `"THICK"` |

### 4. `THIN` — line 30

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_thin.animation"` |
| `prefix` | string literal | `"THIN"` |

### 5. `WIDE` — line 35

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_wide.animation"` |
| `prefix` | string literal | `"WIDE"` |

### 6. `TINY` — line 40

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_tiny.animation"` |
| `prefix` | string literal | `"TINY"` |

### 7. `BATTLE` — line 45

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_battle.animation"` |
| `prefix` | string literal | `"BATTLE"` |

### 8. `GRADIENT` — line 50

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT"` |

### 9. `GRADIENT_GOLD` — line 55

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_GOLD"` |

### 10. `GRADIENT_ORANGE` — line 60

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_ORANGE"` |

### 11. `GRADIENT_GREEN` — line 65

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_GREEN"` |

### 12. `GRADIENT_TALL` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_TALL"` |

### 13. `SHIMMER` — line 76

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_shimmer.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_shimmer.animation"` |
| `prefix` | string literal | `"SHIMMER"` |

### 14. `THICK_BLACK` — line 83

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_thick.animation"` |
| `prefix` | string literal | `"THICK"` |

### 15. `THIN_BLACK` — line 88

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_thin.animation"` |
| `prefix` | string literal | `"THIN"` |

### 16. `WIDE_BLACK` — line 93

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_wide.animation"` |
| `prefix` | string literal | `"WIDE"` |

### 17. `TINY_BLACK` — line 98

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_tiny.animation"` |
| `prefix` | string literal | `"TINY"` |

### 18. `BATTLE_BLACK` — line 103

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_battle.animation"` |
| `prefix` | string literal | `"BATTLE"` |

### 19. `GRADIENT_BLACK` — line 108

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT"` |

### 20. `GRADIENT_GOLD_BLACK` — line 113

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_GOLD"` |

### 21. `GRADIENT_ORANGE_BLACK` — line 118

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_ORANGE"` |

### 22. `GRADIENT_GREEN_BLACK` — line 123

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_GREEN"` |

### 23. `GRADIENT_TALL_BLACK` — line 128

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `prefix` | string literal | `"GRADIENT_TALL"` |

### 24. `SHIMMER_BLACK` — line 134

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/net-games/fonts/fonts_black_shimmer.png"` |
| `anim_path` | string literal | `"/server/assets/net-games/fonts/fonts_shimmer.animation"` |
| `prefix` | string literal | `"SHIMMER"` |

### 25. `GLYPH_METRICS` — line 143

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 26. `AVAILABLE_STATES` — line 146

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 27. `return` — line 159

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 28. `return` — line 164

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 29. `metrics` — line 167

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 30. `states` — line 168

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 31. `self.font_char_map` — line 198

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 32. `self.player_assets` — line 383

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 33. `self.next_instance_id` — line 417

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 34. `draw` — line 472

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `instance_id` |
| `x` | expression/reference | `screen_x` |
| `y` | expression/reference | `screen_y` |
| `z` | expression/reference | `z` |
| `sx` | expression/reference | `scale` |
| `sy` | expression/reference | `scale` |
| `anim_state` | expression/reference | `state` |
| `r` | expression/reference | `options.r or 255` |
| `g` | expression/reference | `options.g or 255` |
| `b` | expression/reference | `options.b or 255` |
| `opacity` | expression/reference | `options.opacity or 255` |
| `a` | expression/reference | `options.a or 255` |
| `ro` | expression/reference | `options.ro or 0` |
| `color_mode` | expression/reference | `options.color_mode or 0` |

### 35. `self.player_instances` — line 494

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 36. `props` — line 501

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `screen_x` |
| `y` | expression/reference | `screen_y` |
| `z` | expression/reference | `z` |
| `scale` | expression/reference | `scale` |
| `state` | expression/reference | `state` |
| `r` | expression/reference | `draw.r` |
| `g` | expression/reference | `draw.g` |
| `b` | expression/reference | `draw.b` |
| `opacity` | expression/reference | `draw.opacity` |
| `a` | expression/reference | `draw.a` |
| `ro` | expression/reference | `draw.ro` |
| `color_mode` | expression/reference | `draw.color_mode` |
| `ox` | expression/reference | `draw.ox` |
| `oy` | expression/reference | `draw.oy` |

### 37. `draw` — line 569

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `instance_id` |
| `x` | expression/reference | `inst.props.x` |
| `y` | expression/reference | `inst.props.y` |
| `z` | expression/reference | `inst.props.z` |
| `sx` | expression/reference | `inst.props.scale` |
| `sy` | expression/reference | `inst.props.scale` |
| `anim_state` | expression/reference | `inst.props.state` |
| `r` | expression/reference | `inst.props.r or 255` |
| `g` | expression/reference | `inst.props.g or 255` |
| `b` | expression/reference | `inst.props.b or 255` |
| `opacity` | expression/reference | `inst.props.opacity or 255` |
| `a` | expression/reference | `inst.props.a or 255` |
| `ro` | expression/reference | `inst.props.ro or 0` |
| `color_mode` | expression/reference | `inst.props.color_mode or 0` |

### 38. `font_names` — line 620

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.sleep` | 1 |
| `Net.on` | 2 |
| `Net.player_alloc_sprite` | 1 |
| `Net.player_dealloc_sprite` | 1 |
| `Net.player_draw_sprite` | 2 |
| `Net.player_erase_sprite` | 2 |
| `Net.provide_asset_for_player` | 4 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
