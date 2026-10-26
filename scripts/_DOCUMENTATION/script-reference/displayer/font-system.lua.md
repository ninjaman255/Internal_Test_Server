# `displayer/font-system.lua`

> **Source reference**
>
> Refreshed from the current `displayer/font-system.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/font-system.lua`
- **Reference:** `script-reference/displayer/font-system.lua.md`
- **Source SHA-256 prefix:** `5bce5bcdca6a`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/boom/main` |
| `scripts/utils/async` |

## `Net:on` subscriptions

| Event |
|---|
| `player_request` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `load_animation_metrics` | `anim_path` |
| `FontSystem:loadAllFonts` | `` |
| `FontSystem:getGlyphState` | `font_name, char` |
| `FontSystem:getGlyphDimensions` | `font_name, char` |
| `FontSystem:isBattleFont` | `font_name` |
| `FontSystem:getVirtualAdvance` | `font_name, char, scale` |
| `FontSystem:getScreenAdvance` | `font_name, char, scale` |
| `FontSystem:setupPlayer` | `player_id` |
| `FontSystem:provideAllFontAssets` | `player_id` |
| `FontSystem:cleanupPlayer` | `player_id` |
| `FontSystem:ensureAssetAllocated` | `player_id, font_name` |
| `FontSystem:nextInstanceId` | `player_id, prefix` |
| `FontSystem:drawGlyph` | `player_id, font_name, char, x, y, options` |
| `FontSystem:updateGlyph` | `player_id, instance_id, updates` |
| `FontSystem:eraseGlyph` | `player_id, instance_id` |
| `FontSystem:eraseGlyphsByPrefix` | `player_id, prefix` |
| `FontSystem:allocateAllFontsForPlayer` | `player_id` |
| `FontSystem:init` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `player_erase_sprite`, `player_dealloc_sprite`, `player_alloc_sprite`, `player_draw_sprite`, `on`

## Engine `Async` calls

`sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `FONTS` | `{` |
| `THICK` | `{` |
| `THIN` | `{` |
| `WIDE` | `{` |
| `TINY` | `{` |
| `BATTLE` | `{` |
| `GRADIENT` | `{` |
| `GRADIENT_GOLD` | `{` |
| `GRADIENT_ORANGE` | `{` |
| `GRADIENT_GREEN` | `{` |
| `GRADIENT_TALL` | `{` |
| `SHIMMER` | `{` |
| `THICK_BLACK` | `{` |
| `THIN_BLACK` | `{` |
| `WIDE_BLACK` | `{` |
| `TINY_BLACK` | `{` |
| `BATTLE_BLACK` | `{` |
| `GRADIENT_BLACK` | `{` |
| `GRADIENT_GOLD_BLACK` | `{` |
| `GRADIENT_ORANGE_BLACK` | `{` |
| `GRADIENT_GREEN_BLACK` | `{` |
| `GRADIENT_TALL_BLACK` | `{` |
| `SHIMMER_BLACK` | `{` |
| `GLYPH_METRICS` | `{}          -- font_name -> state -> { w, h, ox, oy }` |
| `AVAILABLE_STATES` | `{}       -- font_name -> set of state names` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/fonts/fonts_compressed.png` |
| `/server/assets/net-games/fonts/fonts_thick.animation` |
| `/server/assets/net-games/fonts/fonts_thin.animation` |
| `/server/assets/net-games/fonts/fonts_wide.animation` |
| `/server/assets/net-games/fonts/fonts_tiny.animation` |
| `/server/assets/net-games/fonts/fonts_battle.animation` |
| `/server/assets/net-games/fonts/fonts_gradient.animation` |
| `/server/assets/net-games/fonts/fonts_shimmer.png` |
| `/server/assets/net-games/fonts/fonts_shimmer.animation` |
| `/server/assets/net-games/fonts/fonts_dark_compressed.png` |
| `/server/assets/net-games/fonts/fonts_black_shimmer.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
