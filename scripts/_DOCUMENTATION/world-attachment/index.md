# 📄 `world-attachment.lua`

[🏠 Documentation home](../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/world-attachment.lua`](../../world-attachment.lua)  
> **Source lines:** 428  
> **SHA-256 (UTF-8):** `9afdb7cf1d25a6…`  
> **Declared/assigned functions detected:** 9  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 13

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

Shared world-attachment coordinate helpers for NetGames and FootBomb. This module intentionally contains only coordinate math. It does not create bots, move actors, subscribe to events, or animate properties. Projection modes: "isometric" - invert the standard screen/map projection used by FootBomb.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 34 | `number_or_nil` | `value` | local |
| 39 | `is_flipped` | `value` | local |
| 43 | `round_fraction` | `value, denominator` | local |
| 69 | `WorldAttachment.quantize_map_offset` | `offset, options` | declared |
| 120 | `WorldAttachment.point_to_pixel_offset` | `frame, point` | declared |
| 204 | `WorldAttachment.pixel_offset_to_map` | `screen_offset, options` | declared |
| 308 | `WorldAttachment.point_to_map_offset` | `frame, point, options` | declared |
| 369 | `WorldAttachment.target_position` | `parent_position, map_offset, options` | declared |
| 399 | `WorldAttachment.follow_position` | `parent_position, screen_offset, options` | declared |

### Function details

#### 1. `number_or_nil(value)`

- **Location:** source line 34.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 2. `is_flipped(value)`

- **Location:** source line 39.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `round_fraction(value, denominator)`

- **Location:** source line 43.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `denominator` | Not explicitly documented in adjacent source annotations. |

#### 4. `WorldAttachment.quantize_map_offset(offset, options)`

- **Location:** source line 69.
- **Declaration style:** `declared`.
- **Adjacent source comment:** slow-moving attachments do not shimmer on the isometric grid. Math: * Split x and y into integer + fractional parts. * Round each fraction to the nearest 1/denominator (default 32). * Compute \|x_frac - y_frac\|; snap that separation to the nearest 1/difference_steps (default 16) to keep the parallel-edges offset stable across quantized frames. Operates on: map delta {x, y} (typically the output of pixel_offset_to_map before it is applied to a parent position). When to use: slow or static attachments (resting items, poses). Do NOT use for fast t…

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `offset` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 5. `WorldAttachment.point_to_pixel_offset(frame, point)`

- **Location:** source line 120.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  point_to_pixel_offset(frame, point)  Convert a labeled point inside an animation frame into a pixel offset from the frame's pivot, with flips handled correctly.  Math: * Mirror point and pivot around the frame center for flipx/flipy so their relative distance is preserved. * Return point - pivot.  Operates on: frame rect from a parsed Boom animation + a labeled point.  Output: pixel offset (relative to the sprite's anchor). NOT absolute screen coordinates — the sprite's own screen position supplies the origin.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | Not explicitly documented in adjacent source annotations. |
| 2 | `point` | Not explicitly documented in adjacent source annotations. |

#### 6. `WorldAttachment.pixel_offset_to_map(screen_offset, options)`

- **Location:** source line 204.
- **Declaration style:** `declared`.
- **Adjacent source comment:** i.e., a pure vertical screen displacement of (child_z * scale * tile_h) pixels downward, with zero horizontal shift. `child_z` is the DELTA above the parent, not the parent's absolute Z. The engine already renders the parent at its own Z; we only add the delta needed to lift the child above the parent. Operates on: pixel offset {x, y} + options. Output: map delta {x, y}. NOT an absolute position — add it to the parent via target_position to get the child's final position. Returns (map_delta, error, meta) where meta exposes `tile_width`, `tile_…

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `screen_offset` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 7. `WorldAttachment.point_to_map_offset(frame, point, options)`

- **Location:** source line 308.
- **Declaration style:** `declared`.
- **Adjacent source comment:**  point_to_map_offset(frame, point, options)  Convenience: point_to_pixel_offset → pixel_offset_to_map.  Sprite support: If `options.z_correction.actor_kind == "sprite"`, this function computes `scale_multiplier = frame.originy / frame.h` and passes it through, so a bottom-anchored sprite (originy ≈ h) gets full correction and a top-anchored sprite (originy ≈ 0) gets none. Bots use "bot" (default) which relies on the map-derived scale directly.  Operates on: frame + point + options. Output: map delta {x, y} (and merged metadata).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | Not explicitly documented in adjacent source annotations. |
| 2 | `point` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 8. `WorldAttachment.target_position(parent_position, map_offset, options)`

- **Location:** source line 369.
- **Declaration style:** `declared`.
- **Adjacent source comment:** map delta.  Math: target.x = parent.x + offset.x target.y = parent.y + offset.y target.z = parent.z + (options.z_offset or 0)  Operates on: parent map pos + map delta + z_offset. Output: child map pos {x, y, z}.  IMPORTANT: `options.z_offset` here is the child's ACTUAL z separation above the parent. It is NOT the z_correction.z_offset used inside pixel_offset_to_map (that one only controls x/y compensation). Passing the same lift to both keeps the ball visually attached to the ball point while rendered `lift` units higher than the defender.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `parent_position` | Not explicitly documented in adjacent source annotations. |
| 2 | `map_offset` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 9. `WorldAttachment.follow_position(parent_position, screen_offset, options)`

- **Location:** source line 399.
- **Declaration style:** `declared`.
- **Adjacent source comment:** follow_position(parent_position, screen_offset, options) Recompute the attachment position as the parent moves, so the z correction tracks the parent's elevation changes rather than freezing at creation. The caller supplies `screen_offset` directly (rather than frame + point) because continuous attachment usually samples the animation at multiple elapsed times in a loop. Bot-friendly: the map-derived scale is used automatically. For sprite actors use point_to_map_offset (which can compute the frame-based scale_multiplier); follow_position does…

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `parent_position` | Not explicitly documented in adjacent source annotations. |
| 2 | `screen_offset` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **13** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `WorldAttachment` — line 29

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `return` — line 102

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `x_int + x_dec` |
| `y` | expression/reference | `y_int + y_dec` |

### 3. `return` — line 154

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `point_x - origin_x` |
| `y` | expression/reference | `point_y - origin_y` |

### 4. `map_offset` — line 227

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `sx / tile_width + sy / tile_height` |
| `y` | expression/reference | `-sx / tile_width + sy / tile_height` |

### 5. `map_offset` — line 232

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `(2 * sy - sx) / 64` |
| `y` | expression/reference | `(2 * sy + sx) / 64` |

### 6. `meta` — line 240

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `tile_width` | expression/reference | `tile_width` |
| `tile_height` | expression/reference | `tile_height` |

### 7. `z_options` — line 246

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |

### 8. `local_options` — line 329

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `local_z` — line 331

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `return` — line 383

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `px + ox` |
| `y` | expression/reference | `py + oy` |
| `z` | expression/reference | `pz + z_offset` |

### 11. `local_options` — line 405

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `z_options` — line 408

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |

### 13. `local_z` — line 410

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
