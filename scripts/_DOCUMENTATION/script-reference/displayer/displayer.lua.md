# `displayer/displayer.lua`

> **Source reference**
>
> Refreshed from the current `displayer/displayer.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/displayer.lua`
- **Reference:** `script-reference/displayer/displayer.lua.md`
- **Source SHA-256 prefix:** `d16db7dbc470`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/font-system` |
| `scripts/displayer/text-display` |
| `scripts/displayer/timer-display` |
| `scripts/displayer/nameplate` |
| `scripts/displayer/scrolling-text-list` |
| `scripts/displayer/scrolling-sprite-list` |
| `scripts/displayer/timer-system` |
| `scripts/displayer/sliced-sprite` |
| `scripts/boom/main` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Displayer:init` | `` |
| `Displayer:_setupBuilderAPI` | `` |
| `api.glyph` | `overrides` |
| `api.staticText` | `overrides` |
| `api.marquee` | `overrides` |
| `api.textBox` | `overrides` |
| `api.timerDisplay` | `overrides` |
| `api.textList` | `overrides` |
| `api.spriteList` | `overrides` |
| `api.backdrop` | `x, y, width, height, padding_x, padding_y, r, g, b, opacity, a` |
| `api.spriteDef` | `texture_path, anim_path, anim_state, overrides` |
| `api.sliceStyle9` | `texture_path, anim_path, overrides` |
| `api.sliceStyle3` | `texture_path, anim_path, states, orientation` |
| `api.sliceStyle5` | `texture_path, anim_path, states, orientation` |
| `api.text` | `mode, overrides` |
| `api.textPanelStyle` | `kind, parts, orientation` |
| `panelPadding` | `value, vertical` |
| `api.panelPadding` | `value, vertical` |
| `api.panelChildPadding` | `value, vertical` |
| `api.textPanelOptions` | `overrides` |
| `api.rowPanelOptions` | `overrides` |
| `api.columnPanelOptions` | `overrides` |
| `api.gridPanelOptions` | `columns, overrides` |
| `api.textPanel` | `text, style, options` |
| `api.panelTextChild` | `text, overrides` |
| `api.panelSpritesChild` | `sprites, overrides` |
| `Displayer:_setupFontAPI` | `` |
| `Displayer:_setupTextAPI` | `` |
| `Displayer:_setupTimerDisplayAPI` | `` |
| `Displayer:_setupNameplateAPI` | `` |
| `Displayer:_setupScrollingTextAPI` | `` |
| `Displayer:_setupScrollingSpriteAPI` | `` |
| `Displayer:_setupTimerAPI` | `` |
| `Displayer:_setupTextPanelAPI` | `` |
| `Displayer:_setupSlicedSpriteAPI` | `` |
| `Displayer:formatTime` | `seconds, is_countdown` |
| `Displayer:getScreenDimensions` | `` |
| `api.drawGlyph` | `player_id, font_name, char, x, y, options` |
| `api.updateGlyph` | `player_id, instance_id, updates` |
| `api.eraseGlyph` | `player_id, instance_id` |
| `api.getGlyphDimensions` | `font_name, char` |
| `api.allocateAllFontsForPlayer` | `player_id` |
| `api.draw` | `pid, tid, text, x, y, o` |
| `api.drawStatic` | `pid, tid, text, x, y, o` |
| `api.removeStatic` | `pid, tid` |
| `api.drawMarquee` | `pid, mid, text, y, o` |
| `api.removeMarquee` | `pid, mid` |
| `api.createTextBox` | `pid, bid, text, x, y, w, h, o` |
| `api.advanceTextBox` | `pid, bid` |
| `api.closeTextBox` | `pid, bid` |
| `api.getTextBoxState` | `pid, bid` |
| `api.getTextBoxData` | `pid, bid` |
| `api.setKeepAlive` | `pid, bid, keep` |
| `api.createPlayerTimer` | `pid, did, x, y, o` |
| `api.createPlayerCountdown` | `pid, did, x, y, o` |
| `api.createGlobalTimer` | `did, x, y, o` |
| `api.createGlobalCountdown` | `did, x, y, o` |
| `api.remove` | `pid, did` |
| `api.setPosition` | `pid, did, x, y` |
| `api.attach` | `pid, pd, bid, bd, cfg` |
| `api.erase` | `pid, pd, bd` |
| `api.begin_close` | `pid, pd, bd, cfg` |
| `api.createList` | `pid, lid, x, y, w, h, cfg` |
| `api.addText` | `pid, lid, text` |
| `api.setTexts` | `pid, lid, texts` |
| `api.getState` | `pid, lid` |
| `api.setSpeed` | `pid, lid, s` |
| `api.removeList` | `pid, lid` |
| `api.addSprite` | `pid, lid, d` |
| `api.setSprites` | `pid, lid, s` |
| `api.pausePlayerTimer` | `p, t` |
| `api.resumePlayerTimer` | `p, t` |
| `api.pausePlayerCountdown` | `p, c` |
| `api.resumePlayerCountdown` | `p, c` |
| `api.removePlayerTimer` | `p, t` |
| `api.removePlayerCountdown` | `p, c` |
| `api.getPlayerTimer` | `p, t` |
| `api.getPlayerCountdown` | `p, c` |
| `api.pauseGlobalTimer` | `t` |
| `api.resumeGlobalTimer` | `t` |
| `api.pauseGlobalCountdown` | `c` |
| `api.resumeGlobalCountdown` | `c` |
| `api.removeGlobalTimer` | `t` |
| `api.removeGlobalCountdown` | `c` |
| `api.getGlobalTimer` | `t` |
| `api.getGlobalCountdown` | `c` |
| `api.getAllGlobalTimers` | `` |
| `api.getAllGlobalCountdowns` | `` |
| `api.clearAllGlobalTimers` | `` |
| `api.clearAllGlobalCountdowns` | `` |
| `api.create` | `player_id, panel_id, text, x, y, style, options` |
| `api.createWithChildren` | `player_id, panel_id, x, y, style, options` |
| `api.updateText` | `player_id, panel_id, newText` |
| `api.setChildren` | `player_id, panel_id, children` |
| `api.setOptions` | `player_id, panel_id, newOptions` |
| `api.getSize` | `player_id, panel_id` |
| `api.get` | `player_id, panel_id` |
| `api.draw3` | `pid, lid, x, y, w, h, style, o` |
| `api.draw5` | `pid, lid, x, y, w, h, style, o` |
| `api.draw9` | `pid, lid, x, y, w, h, style, o` |
| `api.drawTextPanel` | `pid, lid, x, y, text, style, options` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
