# 📄 `sliced-sprite.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/sliced-sprite.lua`](../../../displayer/sliced-sprite.lua)  
> **Source lines:** 1306  
> **SHA-256 (UTF-8):** `23835c59a7f3f5…`  
> **Declared/assigned functions detected:** 43  
> **Anonymous closures detected:** 2  
> **Table initializers detected:** 68

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

Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering. Also provides a text panel that combines slices with automatic mixed text + sprite layout (vertical stacking or horizontal row). IMPORTANT: Net.player_draw_sprite has no source-rectangle / UV / crop fields here.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 16 | `scripts/boom/main` |
| 17 | `scripts/displayer/text-layout` |
| 24 | `scripts/displayer/font-system` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 742 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 19 | `normalize_text_scale` | `value, fallback` | local |
| 41 | `round` | `value` | local |
| 49 | `fail` | `message` | local |
| 53 | `player_state` | `player_id` | local |
| 65 | `load_animation` | `anim_path` | local |
| 85 | `animation_state_metrics` | `anim_path, anim_state` | local |
| 142 | `copy_part` | `raw` | local |
| 152 | `resolve_part` | `style, raw, label` | local |
| 193 | `ensure_asset` | `player_id, part` | local |
| 232 | `erase_object_ids` | `player_id, object_ids` | local |
| 242 | `sprite_native_dimensions` | `def` | local |
| 259 | `sprite_rendered_dimensions` | `def, sprite_scale` | local |
| 266 | `draw_sprite_instance` | `player_id, object_id, def, x, y, sprite_scale, options` | local |
| 328 | `begin_instance` | `player_id, logical_id, signature, suffixes` | local |
| 356 | `draw_piece` | `player_id, object_id, part, x, y, width, height, options` | local |
| 396 | `resolve_strip_parts` | `style, count, default_middle_stretch` | local |
| 424 | `strip_signature` | `kind, orientation, parts` | local |
| 438 | `draw_strip` | `player_id, logical_id, x, y, width, height, style, options, count, kind, default_middle_stretch` | local |
| 539 | `SlicedSprite.draw3` | `player_id, logical_id, x, y, width, height, style, options` | declared |
| 543 | `SlicedSprite.draw5` | `player_id, logical_id, x, y, width, height, style, options` | declared |
| 547 | `resolve_nine` | `style` | local |
| 563 | `nine_signature` | `parts` | local |
| 576 | `same_number` | `a, b` | local |
| 580 | `SlicedSprite.draw9` | `player_id, logical_id, x, y, width, height, style, options` | declared |
| 711 | `SlicedSprite.erase` | `player_id, logical_id` | declared |
| 724 | `SlicedSprite.cleanupPlayer` | `player_id` | declared |
| 755 | `normalize_edges` | `value, fallback` | local |
| 777 | `normalize_alignment` | `value, fallback` | local |
| 786 | `alignment_offset` | `alignment, available, used` | local |
| 797 | `main_axis_distribution` | `alignment, available, used, count, base_spacing` | local |
| 820 | `TextPanel:new` | `player_id, logical_id, x, y, text, style, options` | declared |
| 844 | `TextPanel:_measure_child` | `child, inner_max_width` | declared |
| 936 | `TextPanel:_draw_text_child` | `player_id, child, m, base_x, base_y, z, glyph_ids` | declared |
| 974 | `TextPanel:_draw_sprites_child` | `player_id, child, m, base_x, base_y, z, sprite_ids, child_idx` | declared |
| 1014 | `TextPanel:_redraw` | `(none)` | declared |
| 1160 | `draw_child` | `m, slot_x, slot_y, slot_w, slot_h` | local |
| 1233 | `TextPanel:getSize` | `(none)` | declared |
| 1237 | `TextPanel:setText` | `new_text` | declared |
| 1244 | `TextPanel:setChildren` | `children` | declared |
| 1250 | `TextPanel:setPosition` | `x, y` | declared |
| 1257 | `TextPanel:setOptions` | `new_options` | declared |
| 1273 | `TextPanel:destroy` | `(none)` | declared |
| 1294 | `SlicedSprite.drawTextPanel` | `player_id, logical_id, x, y, text, style, options` | declared |

### Function details

#### 1. `normalize_text_scale(value, fallback)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `fallback` | Not explicitly documented in adjacent source annotations. |

#### 2. `round(value)`

- **Location:** source line 41.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `fail(message)`

- **Location:** source line 49.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 4. `player_state(player_id)`

- **Location:** source line 53.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `load_animation(anim_path)`

- **Location:** source line 65.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `anim_path` | Not explicitly documented in adjacent source annotations. |

#### 6. `animation_state_metrics(anim_path, anim_state)`

- **Location:** source line 85.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 2 | `anim_state` | Not explicitly documented in adjacent source annotations. |

#### 7. `copy_part(raw)`

- **Location:** source line 142.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `raw` | Not explicitly documented in adjacent source annotations. |

#### 8. `resolve_part(style, raw, label)`

- **Location:** source line 152.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `style` | Not explicitly documented in adjacent source annotations. |
| 2 | `raw` | Not explicitly documented in adjacent source annotations. |
| 3 | `label` | Not explicitly documented in adjacent source annotations. |

#### 9. `ensure_asset(player_id, part)`

- **Location:** source line 193.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `part` | Not explicitly documented in adjacent source annotations. |

#### 10. `erase_object_ids(player_id, object_ids)`

- **Location:** source line 232.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `object_ids` | Not explicitly documented in adjacent source annotations. |

#### 11. `sprite_native_dimensions(def)`

- **Location:** source line 242.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `def` | Not explicitly documented in adjacent source annotations. |

#### 12. `sprite_rendered_dimensions(def, sprite_scale)`

- **Location:** source line 259.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `def` | Not explicitly documented in adjacent source annotations. |
| 2 | `sprite_scale` | Not explicitly documented in adjacent source annotations. |

#### 13. `draw_sprite_instance(player_id, object_id, def, x, y, sprite_scale, options)`

- **Location:** source line 266.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `def` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `sprite_scale` | Not explicitly documented in adjacent source annotations. |
| 7 | `options` | Not explicitly documented in adjacent source annotations. |

#### 14. `begin_instance(player_id, logical_id, signature, suffixes)`

- **Location:** source line 328.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `signature` | Not explicitly documented in adjacent source annotations. |
| 4 | `suffixes` | Not explicitly documented in adjacent source annotations. |

#### 15. `draw_piece(player_id, object_id, part, x, y, width, height, options)`

- **Location:** source line 356.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `part` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `width` | Not explicitly documented in adjacent source annotations. |
| 7 | `height` | Not explicitly documented in adjacent source annotations. |
| 8 | `options` | Not explicitly documented in adjacent source annotations. |

#### 16. `resolve_strip_parts(style, count, default_middle_stretch)`

- **Location:** source line 396.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `style` | Not explicitly documented in adjacent source annotations. |
| 2 | `count` | Not explicitly documented in adjacent source annotations. |
| 3 | `default_middle_stretch` | Not explicitly documented in adjacent source annotations. |

#### 17. `strip_signature(kind, orientation, parts)`

- **Location:** source line 424.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `kind` | Not explicitly documented in adjacent source annotations. |
| 2 | `orientation` | Not explicitly documented in adjacent source annotations. |
| 3 | `parts` | Not explicitly documented in adjacent source annotations. |

#### 18. `draw_strip(player_id, logical_id, x, y, width, height, style, options, count, kind, default_middle_stretch)`

- **Location:** source line 438.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `width` | Not explicitly documented in adjacent source annotations. |
| 6 | `height` | Not explicitly documented in adjacent source annotations. |
| 7 | `style` | Not explicitly documented in adjacent source annotations. |
| 8 | `options` | Not explicitly documented in adjacent source annotations. |
| 9 | `count` | Not explicitly documented in adjacent source annotations. |
| 10 | `kind` | Not explicitly documented in adjacent source annotations. |
| 11 | `default_middle_stretch` | Not explicitly documented in adjacent source annotations. |

#### 19. `SlicedSprite.draw3(player_id, logical_id, x, y, width, height, style, options)`

- **Location:** source line 539.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `width` | Not explicitly documented in adjacent source annotations. |
| 6 | `height` | Not explicitly documented in adjacent source annotations. |
| 7 | `style` | Not explicitly documented in adjacent source annotations. |
| 8 | `options` | Not explicitly documented in adjacent source annotations. |

#### 20. `SlicedSprite.draw5(player_id, logical_id, x, y, width, height, style, options)`

- **Location:** source line 543.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `width` | Not explicitly documented in adjacent source annotations. |
| 6 | `height` | Not explicitly documented in adjacent source annotations. |
| 7 | `style` | Not explicitly documented in adjacent source annotations. |
| 8 | `options` | Not explicitly documented in adjacent source annotations. |

#### 21. `resolve_nine(style)`

- **Location:** source line 547.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `style` | Not explicitly documented in adjacent source annotations. |

#### 22. `nine_signature(parts)`

- **Location:** source line 563.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `parts` | Not explicitly documented in adjacent source annotations. |

#### 23. `same_number(a, b)`

- **Location:** source line 576.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 24. `SlicedSprite.draw9(player_id, logical_id, x, y, width, height, style, options)`

- **Location:** source line 580.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `width` | Not explicitly documented in adjacent source annotations. |
| 6 | `height` | Not explicitly documented in adjacent source annotations. |
| 7 | `style` | Not explicitly documented in adjacent source annotations. |
| 8 | `options` | Not explicitly documented in adjacent source annotations. |

#### 25. `SlicedSprite.erase(player_id, logical_id)`

- **Location:** source line 711.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |

#### 26. `SlicedSprite.cleanupPlayer(player_id)`

- **Location:** source line 724.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 27. `normalize_edges(value, fallback)`

- **Location:** source line 755.
- **Declaration style:** `local`.
- **Adjacent source comment:** Normalize Flutter-style EdgeInsets-like padding. Values are in physical screen pixels, matching the sliced-sprite and sprite-child coordinate space.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `fallback` | Not explicitly documented in adjacent source annotations. |

#### 28. `normalize_alignment(value, fallback)`

- **Location:** source line 777.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `fallback` | Not explicitly documented in adjacent source annotations. |

#### 29. `alignment_offset(alignment, available, used)`

- **Location:** source line 786.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `alignment` | Not explicitly documented in adjacent source annotations. |
| 2 | `available` | Not explicitly documented in adjacent source annotations. |
| 3 | `used` | Not explicitly documented in adjacent source annotations. |

#### 30. `main_axis_distribution(alignment, available, used, count, base_spacing)`

- **Location:** source line 797.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `alignment` | Not explicitly documented in adjacent source annotations. |
| 2 | `available` | Not explicitly documented in adjacent source annotations. |
| 3 | `used` | Not explicitly documented in adjacent source annotations. |
| 4 | `count` | Not explicitly documented in adjacent source annotations. |
| 5 | `base_spacing` | Not explicitly documented in adjacent source annotations. |

#### 31. `TextPanel:new(player_id, logical_id, x, y, text, style, options)`

- **Location:** source line 820.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `text` | Not explicitly documented in adjacent source annotations. |
| 6 | `style` | Not explicitly documented in adjacent source annotations. |
| 7 | `options` | Not explicitly documented in adjacent source annotations. |

#### 32. `TextPanel:_measure_child(child, inner_max_width)`

- **Location:** source line 844.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `child` | Not explicitly documented in adjacent source annotations. |
| 2 | `inner_max_width` | Not explicitly documented in adjacent source annotations. |

#### 33. `TextPanel:_draw_text_child(player_id, child, m, base_x, base_y, z, glyph_ids)`

- **Location:** source line 936.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `child` | Not explicitly documented in adjacent source annotations. |
| 3 | `m` | Not explicitly documented in adjacent source annotations. |
| 4 | `base_x` | Not explicitly documented in adjacent source annotations. |
| 5 | `base_y` | Not explicitly documented in adjacent source annotations. |
| 6 | `z` | Not explicitly documented in adjacent source annotations. |
| 7 | `glyph_ids` | Not explicitly documented in adjacent source annotations. |

#### 34. `TextPanel:_draw_sprites_child(player_id, child, m, base_x, base_y, z, sprite_ids, child_idx)`

- **Location:** source line 974.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `child` | Not explicitly documented in adjacent source annotations. |
| 3 | `m` | Not explicitly documented in adjacent source annotations. |
| 4 | `base_x` | Not explicitly documented in adjacent source annotations. |
| 5 | `base_y` | Not explicitly documented in adjacent source annotations. |
| 6 | `z` | Not explicitly documented in adjacent source annotations. |
| 7 | `sprite_ids` | Not explicitly documented in adjacent source annotations. |
| 8 | `child_idx` | Not explicitly documented in adjacent source annotations. |

#### 35. `TextPanel:_redraw()`

- **Location:** source line 1014.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 36. `draw_child(m, slot_x, slot_y, slot_w, slot_h)`

- **Location:** source line 1160.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `m` | Not explicitly documented in adjacent source annotations. |
| 2 | `slot_x` | Not explicitly documented in adjacent source annotations. |
| 3 | `slot_y` | Not explicitly documented in adjacent source annotations. |
| 4 | `slot_w` | Not explicitly documented in adjacent source annotations. |
| 5 | `slot_h` | Not explicitly documented in adjacent source annotations. |

#### 37. `TextPanel:getSize()`

- **Location:** source line 1233.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 38. `TextPanel:setText(new_text)`

- **Location:** source line 1237.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `new_text` | Not explicitly documented in adjacent source annotations. |

#### 39. `TextPanel:setChildren(children)`

- **Location:** source line 1244.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `children` | Not explicitly documented in adjacent source annotations. |

#### 40. `TextPanel:setPosition(x, y)`

- **Location:** source line 1250.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 41. `TextPanel:setOptions(new_options)`

- **Location:** source line 1257.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `new_options` | Not explicitly documented in adjacent source annotations. |

#### 42. `TextPanel:destroy()`

- **Location:** source line 1273.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 43. `SlicedSprite.drawTextPanel(player_id, logical_id, x, y, text, style, options)`

- **Location:** source line 1294.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `text` | Not explicitly documented in adjacent source annotations. |
| 6 | `style` | Not explicitly documented in adjacent source annotations. |
| 7 | `options` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 730 | `(none)` | `s[player_id] then for panel_id, panel in pairs(panels[player_id]) do pcall(` |
| 742 | `event` | `, player_id, sprite_id) end players[player_id] = nil end Net:on("player_disconnect",` |

## 📦 Tables and data

The following **68** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `SlicedSprite` — line 26

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `animation_cache` — line 28

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `players` — line 29

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `panels` — line 33

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `NINE_ORDER` — line 35

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"top_left"` |
| `[2]` | string literal | `"top"` |
| `[3]` | string literal | `"top_right"` |
| `[4]` | string literal | `"left"` |
| `[5]` | string literal | `"center"` |
| `[6]` | string literal | `"right"` |
| `[7]` | string literal | `"bottom_left"` |
| `[8]` | string literal | `"bottom"` |
| `[9]` | string literal | `"bottom_right"` |

### 6. `state` — line 56

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `assets` | nested table | `{}` |
| `instances` | nested table | `{}` |

### 7. `assets` — line 57

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `instances` — line 58

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `return` — line 136

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `width` | expression/reference | `width` |
| `height` | expression/reference | `height` |

### 10. `out` — line 143

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `raw` — line 154

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `anim_state` | expression/reference | `raw` |

### 12. `alloc` — line 215

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | expression/reference | `part.texture_path` |

### 13. `part` — line 277

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | expression/reference | `def.texture_path` |
| `anim_path` | expression/reference | `anim_path` |
| `anim_state` | expression/reference | `def.anim_state` |
| `width` | expression/reference | `native_w` |
| `height` | expression/reference | `native_h` |
| `asset_key` | expression/reference | `def.texture_path .. "\|" .. anim_path` |

### 14. `draw` — line 294

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `object_id` |
| `x` | expression/reference | `round(x)` |
| `y` | expression/reference | `round(y)` |
| `z` | expression/reference | `tonumber(options and options.z) or 100` |
| `sx` | expression/reference | `final_sx` |
| `sy` | expression/reference | `final_sy` |
| `r` | expression/reference | `tonumber(def.r) or 255` |
| `g` | expression/reference | `tonumber(def.g) or 255` |
| `b` | expression/reference | `tonumber(def.b) or 255` |
| `opacity` | expression/reference | `tonumber(def.opacity) or 255` |
| `a` | expression/reference | `tonumber(def.a) or 255` |
| `ro` | expression/reference | `tonumber(def.ro) or 0` |
| `color_mode` | expression/reference | `tonumber(def.color_mode) or 0` |

### 15. `object_ids` — line 343

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 16. `instance` — line 348

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `signature` | expression/reference | `signature` |
| `object_ids` | expression/reference | `object_ids` |

### 17. `draw` — line 366

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `object_id` |
| `x` | expression/reference | `round(x)` |
| `y` | expression/reference | `round(y)` |
| `z` | expression/reference | `tonumber(options.z) or 100` |
| `sx` | expression/reference | `width / part.width` |
| `sy` | expression/reference | `height / part.height` |
| `r` | expression/reference | `tonumber(part.r or options.r) or 255` |
| `g` | expression/reference | `tonumber(part.g or options.g) or 255` |
| `b` | expression/reference | `tonumber(part.b or options.b) or 255` |
| `opacity` | expression/reference | `tonumber(part.opacity or options.opacity) or 255` |
| `a` | expression/reference | `tonumber(part.a or options.a) or 255` |
| `color_mode` | expression/reference | `tonumber(part.color_mode or options.color_mode) or 0` |

### 18. `parts` — line 401

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 19. `fields` — line 425

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `kind` |
| `[2]` | expression/reference | `orientation` |

### 20. `suffixes` — line 499

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 21. `parts` — line 552

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 22. `fields` — line 564

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"9-slice"` |

### 23. `rectangles` — line 645

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `top_left` | nested table | `{ x0, y0, x1 - x0, y1 - y0 }` |
| `top` | nested table | `{ x1, y0, x2 - x1, y1 - y0 }` |
| `top_right` | nested table | `{ x2, y0, x3 - x2, y1 - y0 }` |
| `left` | nested table | `{ x0, y1, x1 - x0, y2 - y1 }` |
| `center` | nested table | `{ x1, y1, x2 - x1, y2 - y1 }` |
| `right` | nested table | `{ x2, y1, x3 - x2, y2 - y1 }` |
| `bottom_left` | nested table | `{ x0, y2, x1 - x0, y3 - y2 }` |
| `bottom` | nested table | `{ x1, y2, x2 - x1, y3 - y2 }` |
| `bottom_right` | nested table | `{ x2, y2, x3 - x2, y3 - y2 }` |

### 24. `top_left` — line 646

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x0` |
| `[2]` | expression/reference | `y0` |
| `[3]` | expression/reference | `x1 - x0` |
| `[4]` | expression/reference | `y1 - y0` |

### 25. `top` — line 647

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x1` |
| `[2]` | expression/reference | `y0` |
| `[3]` | expression/reference | `x2 - x1` |
| `[4]` | expression/reference | `y1 - y0` |

### 26. `top_right` — line 648

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x2` |
| `[2]` | expression/reference | `y0` |
| `[3]` | expression/reference | `x3 - x2` |
| `[4]` | expression/reference | `y1 - y0` |

### 27. `left` — line 649

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x0` |
| `[2]` | expression/reference | `y1` |
| `[3]` | expression/reference | `x1 - x0` |
| `[4]` | expression/reference | `y2 - y1` |

### 28. `center` — line 650

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x1` |
| `[2]` | expression/reference | `y1` |
| `[3]` | expression/reference | `x2 - x1` |
| `[4]` | expression/reference | `y2 - y1` |

### 29. `right` — line 651

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x2` |
| `[2]` | expression/reference | `y1` |
| `[3]` | expression/reference | `x3 - x2` |
| `[4]` | expression/reference | `y2 - y1` |

### 30. `bottom_left` — line 652

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x0` |
| `[2]` | expression/reference | `y2` |
| `[3]` | expression/reference | `x1 - x0` |
| `[4]` | expression/reference | `y3 - y2` |

### 31. `bottom` — line 653

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x1` |
| `[2]` | expression/reference | `y2` |
| `[3]` | expression/reference | `x2 - x1` |
| `[4]` | expression/reference | `y3 - y2` |

### 32. `bottom_right` — line 654

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `x2` |
| `[2]` | expression/reference | `y2` |
| `[3]` | expression/reference | `x3 - x2` |
| `[4]` | expression/reference | `y3 - y2` |

### 33. `grid_positions` — line 662

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `top_left` | nested table | `{ 1, 1 }` |
| `top` | nested table | `{ 2, 1 }` |
| `top_right` | nested table | `{ 3, 1 }` |
| `left` | nested table | `{ 1, 2 }` |
| `center` | nested table | `{ 2, 2 }` |
| `right` | nested table | `{ 3, 2 }` |
| `bottom_left` | nested table | `{ 1, 3 }` |
| `bottom` | nested table | `{ 2, 3 }` |
| `bottom_right` | nested table | `{ 3, 3 }` |

### 34. `top_left` — line 663

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `1` |
| `[2]` | numeric literal | `1` |

### 35. `top` — line 664

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `2` |
| `[2]` | numeric literal | `1` |

### 36. `top_right` — line 665

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `3` |
| `[2]` | numeric literal | `1` |

### 37. `left` — line 666

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `1` |
| `[2]` | numeric literal | `2` |

### 38. `center` — line 667

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `2` |
| `[2]` | numeric literal | `2` |

### 39. `right` — line 668

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `3` |
| `[2]` | numeric literal | `2` |

### 40. `bottom_left` — line 669

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `1` |
| `[2]` | numeric literal | `3` |

### 41. `bottom` — line 670

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `2` |
| `[2]` | numeric literal | `3` |

### 42. `bottom_right` — line 671

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `3` |
| `[2]` | numeric literal | `3` |

### 43. `return` — line 757

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `left` | expression/reference | `value` |
| `right` | expression/reference | `value` |
| `top` | expression/reference | `value` |
| `bottom` | expression/reference | `value` |

### 44. `return` — line 763

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `left` | expression/reference | `value` |
| `right` | expression/reference | `value` |
| `top` | expression/reference | `value` |
| `bottom` | expression/reference | `value` |

### 45. `return` — line 769

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `left` | expression/reference | `tonumber(value.left) or horizontal or all or 0` |
| `right` | expression/reference | `tonumber(value.right) or horizontal or all or 0` |
| `top` | expression/reference | `tonumber(value.top) or vertical or all or 0` |
| `bottom` | expression/reference | `tonumber(value.bottom) or vertical or all or 0` |

### 46. `TextPanel` — line 817

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 47. `o._glyph_ids` — line 829

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 48. `o._sprite_ids` — line 830

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 49. `layout_opts` — line 872

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | expression/reference | `font` |
| `scale` | expression/reference | `scale` |
| `halign` | expression/reference | `halign` |
| `valign` | expression/reference | `valign` |
| `line_spacing` | expression/reference | `line_spacing` |
| `width` | expression/reference | `layout_width` |
| `[7]` | expression/reference | `-- Leave height unconstrained. TextLayout uses a finite height to -- calculate middle/bottom vertical alignment; math.huge here -- makes page_y (and there…` |

### 50. `return` — line 886

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"text"` |
| `width` | expression/reference | `layout.total_width * 2` |
| `height` | expression/reference | `layout.total_height * 2` |
| `layout` | expression/reference | `layout` |
| `layout_opts` | expression/reference | `layout_opts` |

### 51. `return` — line 896

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"sprites"` |
| `width` | numeric literal | `0` |
| `height` | numeric literal | `0` |
| `sprites` | nested table | `{}` |
| `sizes` | nested table | `{}` |
| `columns` | numeric literal | `1` |
| `rows` | numeric literal | `0` |
| `cell_w` | numeric literal | `0` |
| `cell_h` | numeric literal | `0` |
| `col_spacing` | numeric literal | `0` |
| `row_spacing` | numeric literal | `0` |
| `sprite_scale` | numeric literal | `1.0` |

### 52. `sprites` — line 898

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 53. `sizes` — line 898

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 54. `sizes` — line 910

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 55. `return` — line 922

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"sprites"` |
| `width` | expression/reference | `total_w` |
| `height` | expression/reference | `total_h` |
| `sprites` | expression/reference | `sprites` |
| `sizes` | expression/reference | `sizes` |
| `columns` | expression/reference | `columns` |
| `rows` | expression/reference | `rows` |
| `cell_w` | expression/reference | `max_cell_w` |
| `cell_h` | expression/reference | `max_cell_h` |
| `col_spacing` | expression/reference | `col_spacing` |
| `row_spacing` | expression/reference | `row_spacing` |
| `sprite_scale` | expression/reference | `sprite_scale` |

### 56. `return` — line 932

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `kind` | string literal | `"unknown"` |
| `width` | numeric literal | `0` |
| `height` | numeric literal | `0` |

### 57. `self._glyph_ids` — line 1023

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 58. `self._sprite_ids` — line 1025

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 59. `children` — line 1029

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ kind = "text", text = self._text or "", font = options.font, scale = options.scale, color = options.color, halign = options.halign, valign = options.val…` |

### 60. `measured` — line 1050

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 61. `grid_row_heights` — line 1053

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 62. `slice_options` — line 1141

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 63. `self._sprite_ids` — line 1148

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 64. `sprite_ids` — line 1155

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 65. `self._options.padding` — line 1261

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `left` | expression/reference | `v` |
| `right` | expression/reference | `v` |
| `top` | expression/reference | `v` |
| `bottom` | expression/reference | `v` |

### 66. `self._options.color` — line 1263

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `v.r or 255` |
| `g` | expression/reference | `v.g or 255` |
| `b` | expression/reference | `v.b or 255` |
| `a` | expression/reference | `v.a or 255` |

### 67. `self._glyph_ids` — line 1283

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 68. `self._sprite_ids` — line 1287

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
