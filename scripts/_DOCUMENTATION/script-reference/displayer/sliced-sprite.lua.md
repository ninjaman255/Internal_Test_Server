# `displayer/sliced-sprite.lua`

> **Source reference**
>
> Refreshed from the current `displayer/sliced-sprite.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/displayer/sliced-sprite.lua Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering. Also provides a text panel that combines slices with automatic text layout. This module only relies on sprite fields already used/documented in this server source and on scripts/boom/main for reading .animation files. IMPORTANT: Net.player_draw_sprite has no source-rectangle / UV / crop fields here. A slice therefore has to be either: 1) its own texture, with explicit width/height metadata, or 2) an animation state whose frame selects the rectangle from an atlas. Coordinates and target sizes in this module are raw Net screen pixels (the same coordinate space passed directly to Net.player

## Module location

- **Source:** `displayer/sliced-sprite.lua`
- **Reference:** `script-reference/displayer/sliced-sprite.lua.md`
- **Source SHA-256 prefix:** `44a3239241f0`

## Source header notes

- scripts/displayer/sliced-sprite.lua
- Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering.
- Also provides a text panel that combines slices with automatic mixed
- text + sprite layout (vertical stacking or horizontal row).
- IMPORTANT:
- Net.player_draw_sprite has no source-rectangle / UV / crop fields here.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/boom/main` |
| `scripts/displayer/text-layout` |
| `scripts/displayer/font-system` |

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `normalize_text_scale` | `value, fallback` |
| `round` | `value` |
| `fail` | `message` |
| `player_state` | `player_id` |
| `load_animation` | `anim_path` |
| `animation_state_metrics` | `anim_path, anim_state` |
| `copy_part` | `raw` |
| `resolve_part` | `style, raw, label` |
| `ensure_asset` | `player_id, part` |
| `erase_object_ids` | `player_id, object_ids` |
| `sprite_native_dimensions` | `def` |
| `sprite_rendered_dimensions` | `def, sprite_scale` |
| `draw_sprite_instance` | `player_id, object_id, def, x, y, sprite_scale, options` |
| `begin_instance` | `player_id, logical_id, signature, suffixes` |
| `draw_piece` | `player_id, object_id, part, x, y, width, height, options` |
| `resolve_strip_parts` | `style, count, default_middle_stretch` |
| `strip_signature` | `kind, orientation, parts` |
| `draw_strip` | `player_id, logical_id, x, y, width, height, style, options, count, kind, default_middle_stretch` |
| `SlicedSprite.draw3` | `player_id, logical_id, x, y, width, height, style, options` |
| `SlicedSprite.draw5` | `player_id, logical_id, x, y, width, height, style, options` |
| `resolve_nine` | `style` |
| `nine_signature` | `parts` |
| `same_number` | `a, b` |
| `SlicedSprite.draw9` | `player_id, logical_id, x, y, width, height, style, options` |
| `SlicedSprite.erase` | `player_id, logical_id` |
| `SlicedSprite.cleanupPlayer` | `player_id` |
| `normalize_edges` | `value, fallback` |
| `normalize_alignment` | `value, fallback` |
| `alignment_offset` | `alignment, available, used` |
| `main_axis_distribution` | `alignment, available, used, count, base_spacing` |
| `TextPanel:new` | `player_id, logical_id, x, y, text, style, options` |
| `TextPanel:_measure_child` | `child, inner_max_width` |
| `TextPanel:_draw_text_child` | `player_id, child, m, base_x, base_y, z, glyph_ids` |
| `TextPanel:_draw_sprites_child` | `player_id, child, m, base_x, base_y, z, sprite_ids, child_idx` |
| `TextPanel:_redraw` | `` |
| `draw_child` | `m, slot_x, slot_y, slot_w, slot_h` |
| `TextPanel:getSize` | `` |
| `TextPanel:setText` | `new_text` |
| `TextPanel:setChildren` | `children` |
| `TextPanel:setPosition` | `x, y` |
| `TextPanel:setOptions` | `new_options` |
| `TextPanel:destroy` | `` |
| `SlicedSprite.drawTextPanel` | `player_id, logical_id, x, y, text, style, options` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`player_draw_sprite`, `provide_asset_for_player`, `player_alloc_sprite`, `player_erase_sprite`, `player_dealloc_sprite`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `NINE_ORDER` | `{` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
