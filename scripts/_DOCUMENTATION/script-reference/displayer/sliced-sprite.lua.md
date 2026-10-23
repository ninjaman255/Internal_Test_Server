# `displayer/sliced-sprite.lua`

> **Source reference**
>
> Generated from `displayer/sliced-sprite.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/displayer/sliced-sprite.lua Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering. Also provides a text panel that combines slices with automatic text layout. This module only relies on sprite fields already used/documented in this server source and on scripts/boom/main for reading .animation files. IMPORTANT: Net.player_draw_sprite has no source-rectangle / UV / crop fields here. A slice therefore has to be either: 1) its own texture, with explicit width/height metadata, or 2) an animation state whose frame selects the rectangle from an atlas. Coordinates and target sizes in this module are raw Net screen pixels (the same coordinate space passed directly to Net.player

## Module location

- **Source:** `displayer/sliced-sprite.lua`
- **Relative reference:** `script-reference/displayer/sliced-sprite.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/boom/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/font-system` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-layout` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `SlicedSprite.cleanupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SlicedSprite.draw3` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SlicedSprite.draw5` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SlicedSprite.draw9` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SlicedSprite.drawTextPanel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SlicedSprite.erase` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextPanel:_redraw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextPanel:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextPanel:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextPanel:setOptions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextPanel:setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextPanel:setText` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `animation_state_metrics` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `begin_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_part` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_piece` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_strip` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_asset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_object_ids` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fail` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `nine_signature` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `player_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_nine` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_part` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_strip_parts` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `same_number` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `strip_signature` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 890 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
