# `displayer/displayer.lua`

> **Source reference**
>
> Generated from `displayer/displayer.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/displayer.lua`
- **Relative reference:** `script-reference/displayer/displayer.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/boom/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/font-system` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/nameplate` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/scrolling-sprite-list` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/scrolling-text-list` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/sliced-sprite` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-display` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/timer-display` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/timer-system` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Displayer:_setupBuilderAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupFontAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupNameplateAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupScrollingSpriteAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupScrollingTextAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupTextAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupTextPanelAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupTimerAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:_setupTimerDisplayAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:formatTime` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:getScreenDimensions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Displayer:init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.addSprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.addText` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.advanceTextBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.allocateAllFontsForPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.attach` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.backdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.begin_close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.clearAllGlobalCountdowns` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.clearAllGlobalTimers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.closeTextBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.create` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.createGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.createGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.createList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.createPlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.createPlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.createTextBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.draw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.drawGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.drawMarquee` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.drawStatic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.erase` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.eraseGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.get` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getAllGlobalCountdowns` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getAllGlobalTimers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getGlyphDimensions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getPlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getPlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getTextBoxData` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.getTextBoxState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.glyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.marquee` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.pauseGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.pauseGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.pausePlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.pausePlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.remove` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.removeGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.removeGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.removeList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.removeMarquee` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.removePlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.removePlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.removeStatic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.resumeGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.resumeGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.resumePlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.resumePlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.setKeepAlive` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.setOptions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.setSpeed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.setSprites` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.setTexts` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.spriteDef` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.spriteList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.staticText` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.textBox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.textList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.textPanel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.textPanelOptions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.textPanelStyle` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.timerDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.updateGlyph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `api.updateText` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 1148 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
