# `displayer/text-display.lua`

> **Source reference**
>
> Generated from `displayer/text-display.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Unified text renderer for static text, marquee text, and BN-style typewriter boxes. Public coordinates are virtual 240x160 coordinates. Hardened with deterministic marquee IDs, pixel-snapped updates, real paging, explicit teardown, and a public layout/measurement API.

## Module location

- **Source:** `displayer/text-display.lua`
- **Relative reference:** `script-reference/displayer/text-display.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-engine` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/font-system` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-layout` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `DisplayInstance:_cancelPendingCharacter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_cleanupMarquee` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_currentGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_drawBackdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_drawMarqueeAt` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_drawStatic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_drawTypewriterGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_eraseAllGlyphs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_eraseBackdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_eraseCurrentPage` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_eraseGlyphId` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_finishCurrentPageImmediately` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_glyphOptions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_marqueeGlyphs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_pageFinished` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_pageMeta` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_printNextChar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_scheduleNextChar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_startCurrentPage` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:_startMarquee` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:advance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:relayout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `DisplayInstance:reset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:advance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:advanceTextBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:cleanupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:closeTextBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:createTextBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:draw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:drawMarquee` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:drawStatic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:get` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:getData` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:getState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:getTextBoxData` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:getTextBoxState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:measure` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:remove` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:removeMarquee` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:removeStatic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:reset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:resetTextBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:setKeepAlive` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextDisplay:updateAll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_options` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `deterministic_glyph_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_loops` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `pass` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `pixel_snap_virtual` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_call` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 751 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
