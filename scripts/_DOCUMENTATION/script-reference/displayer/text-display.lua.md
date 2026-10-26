# `displayer/text-display.lua`

> **Source reference**
>
> Refreshed from the current `displayer/text-display.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Unified text renderer for static text, marquee text, and BN-style typewriter boxes. Public coordinates are virtual 240x160 coordinates. Hardened with deterministic marquee IDs, pixel-snapped updates, real paging, explicit teardown, and a public layout/measurement API.

## Module location

- **Source:** `displayer/text-display.lua`
- **Reference:** `script-reference/displayer/text-display.lua.md`
- **Source SHA-256 prefix:** `e67040061cb0`

## Source header notes

- Unified text renderer for static text, marquee text, and BN-style typewriter boxes.
- Public coordinates are virtual 240x160 coordinates.
- Hardened with deterministic marquee IDs, pixel-snapped updates, real paging,
- explicit teardown, and a public layout/measurement API.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/font-system` |
| `scripts/animation-engine/animation-engine` |
| `scripts/displayer/text-layout` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `normalize_loops` | `value` |
| `normalize_scale` | `value, fallback` |
| `pixel_snap_virtual` | `value` |
| `copy_table` | `src` |
| `safe_call` | `fn, ...` |
| `deterministic_glyph_id` | `text_id, index` |
| `DisplayInstance:new` | `owner, player_id, text_id, text, x, y, options` |
| `DisplayInstance:relayout` | `` |
| `DisplayInstance:_glyphOptions` | `glyph, extra` |
| `DisplayInstance:_eraseGlyphId` | `id` |
| `DisplayInstance:_eraseAllGlyphs` | `` |
| `DisplayInstance:_drawStatic` | `` |
| `DisplayInstance:_drawBackdrop` | `` |
| `DisplayInstance:_eraseBackdrop` | `force` |
| `DisplayInstance:_marqueeGlyphs` | `` |
| `DisplayInstance:_drawMarqueeAt` | `offset, elapsed` |
| `DisplayInstance:_cleanupMarquee` | `done` |
| `pass` | `n` |
| `DisplayInstance:_startMarquee` | `` |
| `DisplayInstance:_pageMeta` | `page_index` |
| `DisplayInstance:_currentGlyph` | `` |
| `DisplayInstance:_cancelPendingCharacter` | `` |
| `DisplayInstance:_scheduleNextChar` | `delay` |
| `DisplayInstance:_startCurrentPage` | `` |
| `DisplayInstance:_pageFinished` | `` |
| `DisplayInstance:_drawTypewriterGlyph` | `glyph` |
| `DisplayInstance:_printNextChar` | `` |
| `DisplayInstance:_finishCurrentPageImmediately` | `` |
| `DisplayInstance:_eraseCurrentPage` | `` |
| `DisplayInstance:advance` | `` |
| `DisplayInstance:reset` | `text, options` |
| `DisplayInstance:close` | `` |
| `TextDisplay:init` | `` |
| `TextDisplay:layout` | `text, options` |
| `TextDisplay:measure` | `text, options` |
| `TextDisplay:cleanupPlayer` | `player_id` |
| `TextDisplay:updateAll` | `_dt` |
| `TextDisplay:draw` | `player_id, text_id, text, x, y, options` |
| `TextDisplay:remove` | `player_id, text_id` |
| `TextDisplay:get` | `player_id, text_id` |
| `TextDisplay:getState` | `player_id, text_id` |
| `TextDisplay:getData` | `player_id, text_id` |
| `TextDisplay:setKeepAlive` | `player_id, text_id, value` |
| `TextDisplay:advance` | `player_id, text_id` |
| `TextDisplay:reset` | `player_id, text_id, text, options` |
| `copy_options` | `options` |
| `TextDisplay:drawStatic` | `player_id, text_id, text, x, y, options` |
| `TextDisplay:removeStatic` | `player_id, text_id` |
| `TextDisplay:drawMarquee` | `player_id, marquee_id, text, y, options` |
| `TextDisplay:removeMarquee` | `player_id, marquee_id` |
| `TextDisplay:createTextBox` | `player_id, box_id, text, x, y, width, height, options` |
| `TextDisplay:advanceTextBox` | `player_id, box_id` |
| `TextDisplay:closeTextBox` | `player_id, box_id` |
| `TextDisplay:getTextBoxState` | `player_id, box_id` |
| `TextDisplay:getTextBoxData` | `player_id, box_id` |
| `TextDisplay:resetTextBox` | `player_id, box_id, text, options` |
| `on_update` | `values` |
| `on_complete` | `_, interrupted` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`has_asset`, `provide_asset_for_player`, `player_alloc_sprite`, `player_draw_sprite`, `player_erase_sprite`, `player_dealloc_sprite`, `play_sound_for_player`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEFAULT_BACKDROP_TEXTURE` | `"/server/assets/net-games/displayer/empty_white.png"` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/displayer/empty_white.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
