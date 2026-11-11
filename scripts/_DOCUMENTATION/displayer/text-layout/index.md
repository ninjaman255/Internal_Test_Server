# 📄 `text-layout.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/text-layout.lua`](../../../displayer/text-layout.lua)  
> **Source lines:** 299  
> **SHA-256 (UTF-8):** `140b1851366056…`  
> **Declared/assigned functions detected:** 11  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 21

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

Public text measurement/layout helper for Displayer. All input and output coordinates are virtual 240x160 coordinates.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 4 | `scripts/displayer/font-system` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `normalize_scale` | `value, fallback` | local |
| 17 | `normalize_text` | `text` | local |
| 33 | `TextLayout.parseMarkup` | `text` | declared |
| 40 | `push_char` | `ch` | local |
| 78 | `glyph_advance` | `font, char, scale` | local |
| 82 | `TextLayout.measureLine` | `text, options` | declared |
| 94 | `split_long_word` | `word, max_width, options` | local |
| 111 | `wrap_paragraph` | `paragraph, max_width, options` | local |
| 149 | `split_preserve_empty` | `text, sep` | local |
| 163 | `TextLayout.layout` | `text, options` | declared |
| 288 | `TextLayout.measure` | `text, options` | declared |

### Function details

#### 1. `normalize_scale(value, fallback)`

- **Location:** source line 11.
- **Declaration style:** `local`.
- **Adjacent source comment:** Font scale controls glyph size; the virtual-to-rendered coordinate ratio is still fixed at 2 in FontSystem. Keep scale values numeric and positive so measurement and drawing cannot silently diverge for 0/negative/string scales.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `fallback` | Not explicitly documented in adjacent source annotations. |

#### 2. `normalize_text(text)`

- **Location:** source line 17.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |

#### 3. `TextLayout.parseMarkup(text)`

- **Location:** source line 33.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Turn the legacy dialogue markup into plain layout text while preserving pause positions. Supported tags: {p_0.25}, {end_line}, {end_page}. Unknown tags remain literal.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |

#### 4. `push_char(ch)`

- **Location:** source line 40.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ch` | Not explicitly documented in adjacent source annotations. |

#### 5. `glyph_advance(font, char, scale)`

- **Location:** source line 78.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font` | Not explicitly documented in adjacent source annotations. |
| 2 | `char` | Not explicitly documented in adjacent source annotations. |
| 3 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 6. `TextLayout.measureLine(text, options)`

- **Location:** source line 82.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 7. `split_long_word(word, max_width, options)`

- **Location:** source line 94.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `word` | Not explicitly documented in adjacent source annotations. |
| 2 | `max_width` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 8. `wrap_paragraph(paragraph, max_width, options)`

- **Location:** source line 111.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `paragraph` | Not explicitly documented in adjacent source annotations. |
| 2 | `max_width` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 9. `split_preserve_empty(text, sep)`

- **Location:** source line 149.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `sep` | Not explicitly documented in adjacent source annotations. |

#### 10. `TextLayout.layout(text, options)`

- **Location:** source line 163.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 11. `TextLayout.measure(text, options)`

- **Location:** source line 288.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **21** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `TextLayout` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `out` — line 35

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `pauses` — line 36

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `return` — line 95

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `word` |

### 5. `width` — line 96

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `return` — line 112

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `paragraph` |

### 7. `return` — line 113

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `""` |

### 8. `current` — line 115

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `pieces` — line 119

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `word` |

### 10. `start` — line 150

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `wrapped_lines` — line 184

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `forced_page_break_after` — line 185

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `current` — line 197

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `current` — line 202

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `page_layouts` — line 207

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 16. `flat_glyphs` — line 208

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 17. `lines_meta` — line 220

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 18. `glyphs` — line 232

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 19. `glyph` — line 236

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `char` | expression/reference | `ch` |
| `x` | expression/reference | `cx` |
| `y` | expression/reference | `line_y` |
| `page` | expression/reference | `page_index` |
| `line` | expression/reference | `line_index` |
| `col` | expression/reference | `col` |
| `visible_index` | expression/reference | `global_visible_index` |
| `pause_before` | expression/reference | `pauses[global_visible_index] or 0` |

### 20. `return` — line 268

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `text` | expression/reference | `plain` |
| `pages` | expression/reference | `pages` |
| `page_layouts` | expression/reference | `page_layouts` |
| `flat_glyphs` | expression/reference | `flat_glyphs` |
| `font` | expression/reference | `font` |
| `scale` | expression/reference | `scale` |
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `width` | expression/reference | `width` |
| `height` | expression/reference | `height` |
| `line_height` | expression/reference | `line_height` |
| `max_lines` | expression/reference | `max_lines == math.huge and nil or max_lines` |
| `total_width` | expression/reference | `max_page_width` |
| `total_height` | expression/reference | `(#pages[1] or 0) * line_height` |
| `page_count` | expression/reference | `#pages` |
| `pauses` | expression/reference | `pauses` |

### 21. `return` — line 290

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `width` | expression/reference | `layout.total_width` |
| `height` | expression/reference | `layout.total_height` |
| `page_count` | expression/reference | `layout.page_count` |
| `line_height` | expression/reference | `layout.line_height` |
| `pages` | expression/reference | `layout.pages` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
