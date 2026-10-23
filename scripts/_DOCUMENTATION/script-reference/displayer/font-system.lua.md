# `displayer/font-system.lua`

> **Source reference**
>
> Generated from `displayer/font-system.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/font-system.lua`
- **Relative reference:** `script-reference/displayer/font-system.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/boom/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/utils/async` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_request` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `FontSystem:allocateAllFontsForPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:cleanupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:drawGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:ensureAssetAllocated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:eraseGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:eraseGlyphsByPrefix` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:getGlyphDimensions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:getGlyphState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:isBattleFont` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:loadAllFonts` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:nextInstanceId` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:provideAllFontAssets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:setupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FontSystem:updateGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_animation_metrics` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`BATTLE`, `BATTLE_BLACK`, `GRADIENT`, `GRADIENT_BLACK`, `GRADIENT_GOLD`, `GRADIENT_GOLD_BLACK`, `GRADIENT_GREEN`, `GRADIENT_GREEN_BLACK`, `GRADIENT_ORANGE`, `GRADIENT_ORANGE_BLACK`, `GRADIENT_TALL`, `GRADIENT_TALL_BLACK`, `SHIMMER`, `SHIMMER_BLACK`, `THICK`, `THICK_BLACK`, `THIN`, `THIN_BLACK`, `TINY`, `TINY_BLACK`, `WIDE`, `WIDE_BLACK`

## Source notes

- Approximate source size: 648 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
