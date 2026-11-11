# 📁 displayer

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `displayer.lua` | 1 | 114 | 48 | 613 | [Open script reference](displayer/index.md) |
| 📄 Script | `font-system.lua` | 1 | 18 | 38 | 678 | [Open script reference](font-system/index.md) |
| 📄 Script | `nameplate.lua` | 1 | 14 | 9 | 628 | [Open script reference](nameplate/index.md) |
| 📄 Script | `scrolling-sprite-list.lua` | 1 | 35 | 20 | 645 | [Open script reference](scrolling-sprite-list/index.md) |
| 📄 Script | `scrolling-text-list.lua` | 1 | 36 | 18 | 569 | [Open script reference](scrolling-text-list/index.md) |
| 📄 Script | `sliced-sprite.lua` | 1 | 43 | 68 | 1306 | [Open script reference](sliced-sprite/index.md) |
| 📄 Script | `text-display.lua` | 1 | 58 | 15 | 757 | [Open script reference](text-display/index.md) |
| 📄 Script | `text-layout.lua` | 1 | 11 | 21 | 299 | [Open script reference](text-layout/index.md) |
| 📄 Script | `timer-display.lua` | 1 | 12 | 6 | 527 | [Open script reference](timer-display/index.md) |
| 📄 Script | `timer-system.lua` | 1 | 30 | 7 | 486 | [Open script reference](timer-system/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `displayer.lua` | `Displayer:init()` | 21 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupBuilderAPI()` | 68 | [Details](displayer/index.md) |
| `displayer.lua` | `api.glyph(overrides)` | 73 | [Details](displayer/index.md) |
| `displayer.lua` | `api.staticText(overrides)` | 80 | [Details](displayer/index.md) |
| `displayer.lua` | `api.marquee(overrides)` | 87 | [Details](displayer/index.md) |
| `displayer.lua` | `api.textBox(overrides)` | 95 | [Details](displayer/index.md) |
| `displayer.lua` | `api.timerDisplay(overrides)` | 104 | [Details](displayer/index.md) |
| `displayer.lua` | `api.textList(overrides)` | 118 | [Details](displayer/index.md) |
| `displayer.lua` | `api.spriteList(overrides)` | 127 | [Details](displayer/index.md) |
| `displayer.lua` | `api.backdrop(x, y, width, height, padding_x, padding_y, r, g, b, opacity, a)` | 136 | [Details](displayer/index.md) |
| `displayer.lua` | `api.spriteDef(texture_path, anim_path, anim_state, overrides)` | 143 | [Details](displayer/index.md) |
| `displayer.lua` | `api.sliceStyle9(texture_path, anim_path, overrides)` | 187 | [Details](displayer/index.md) |
| `displayer.lua` | `api.sliceStyle3(texture_path, anim_path, states, orientation)` | 202 | [Details](displayer/index.md) |
| `displayer.lua` | `api.sliceStyle5(texture_path, anim_path, states, orientation)` | 219 | [Details](displayer/index.md) |
| `displayer.lua` | `api.text(mode, overrides)` | 238 | [Details](displayer/index.md) |
| `displayer.lua` | `api.textPanelStyle(kind, parts, orientation)` | 254 | [Details](displayer/index.md) |
| `displayer.lua` | `api.panelPadding(value, vertical)` | 283 | [Details](displayer/index.md) |
| `displayer.lua` | `api.panelChildPadding(value, vertical)` | 287 | [Details](displayer/index.md) |
| `displayer.lua` | `api.textPanelOptions(overrides)` | 294 | [Details](displayer/index.md) |
| `displayer.lua` | `api.rowPanelOptions(overrides)` | 328 | [Details](displayer/index.md) |
| `displayer.lua` | `api.columnPanelOptions(overrides)` | 336 | [Details](displayer/index.md) |
| `displayer.lua` | `api.gridPanelOptions(columns, overrides)` | 344 | [Details](displayer/index.md) |
| `displayer.lua` | `api.textPanel(text, style, options)` | 353 | [Details](displayer/index.md) |
| `displayer.lua` | `api.panelTextChild(text, overrides)` | 357 | [Details](displayer/index.md) |
| `displayer.lua` | `api.panelSpritesChild(sprites, overrides)` | 364 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupFontAPI()` | 379 | [Details](displayer/index.md) |
| `displayer.lua` | `api.drawGlyph(player_id, font_name, char, x, y, options)` | 381 | [Details](displayer/index.md) |
| `displayer.lua` | `api.updateGlyph(player_id, instance_id, updates)` | 384 | [Details](displayer/index.md) |
| `displayer.lua` | `api.eraseGlyph(player_id, instance_id)` | 387 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getGlyphDimensions(font_name, char)` | 390 | [Details](displayer/index.md) |
| `displayer.lua` | `api.allocateAllFontsForPlayer(player_id)` | 393 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupTextAPI()` | 401 | [Details](displayer/index.md) |
| `displayer.lua` | `api.draw(pid, tid, text, x, y, o)` | 403 | [Details](displayer/index.md) |
| `displayer.lua` | `api.drawStatic(pid, tid, text, x, y, o)` | 404 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removeStatic(pid, tid)` | 405 | [Details](displayer/index.md) |
| `displayer.lua` | `api.drawMarquee(pid, mid, text, y, o)` | 406 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removeMarquee(pid, mid)` | 407 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createTextBox(pid, bid, text, x, y, w, h, o)` | 408 | [Details](displayer/index.md) |
| `displayer.lua` | `api.advanceTextBox(pid, bid)` | 409 | [Details](displayer/index.md) |
| `displayer.lua` | `api.closeTextBox(pid, bid)` | 410 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getTextBoxState(pid, bid)` | 411 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getTextBoxData(pid, bid)` | 412 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setKeepAlive(pid, bid, keep)` | 413 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupTimerDisplayAPI()` | 419 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createPlayerTimer(pid, did, x, y, o)` | 421 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createPlayerCountdown(pid, did, x, y, o)` | 422 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createGlobalTimer(did, x, y, o)` | 423 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createGlobalCountdown(did, x, y, o)` | 424 | [Details](displayer/index.md) |
| `displayer.lua` | `api.remove(pid, did)` | 425 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setPosition(pid, did, x, y)` | 426 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupNameplateAPI()` | 432 | [Details](displayer/index.md) |
| `displayer.lua` | `api.attach(pid, pd, bid, bd, cfg)` | 434 | [Details](displayer/index.md) |
| `displayer.lua` | `api.erase(pid, pd, bd)` | 435 | [Details](displayer/index.md) |
| `displayer.lua` | `api.begin_close(pid, pd, bd, cfg)` | 436 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupScrollingTextAPI()` | 442 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createList(pid, lid, x, y, w, h, cfg)` | 444 | [Details](displayer/index.md) |
| `displayer.lua` | `api.addText(pid, lid, text)` | 445 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setTexts(pid, lid, texts)` | 446 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getState(pid, lid)` | 447 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setSpeed(pid, lid, s)` | 448 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removeList(pid, lid)` | 449 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setPosition(pid, lid, x, y)` | 450 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupScrollingSpriteAPI()` | 456 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createList(pid, lid, x, y, w, h, cfg)` | 458 | [Details](displayer/index.md) |
| `displayer.lua` | `api.addSprite(pid, lid, d)` | 459 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setSprites(pid, lid, s)` | 460 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getState(pid, lid)` | 461 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setSpeed(pid, lid, s)` | 462 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removeList(pid, lid)` | 463 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setPosition(pid, lid, x, y)` | 464 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupTimerAPI()` | 470 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createPlayerTimer(p, t, d, cb, l)` | 472 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createPlayerCountdown(p, c, d, cb, l)` | 473 | [Details](displayer/index.md) |
| `displayer.lua` | `api.pausePlayerTimer(p, t)` | 474 | [Details](displayer/index.md) |
| `displayer.lua` | `api.resumePlayerTimer(p, t)` | 475 | [Details](displayer/index.md) |
| `displayer.lua` | `api.pausePlayerCountdown(p, c)` | 476 | [Details](displayer/index.md) |
| `displayer.lua` | `api.resumePlayerCountdown(p, c)` | 477 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removePlayerTimer(p, t)` | 478 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removePlayerCountdown(p, c)` | 479 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getPlayerTimer(p, t)` | 480 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getPlayerCountdown(p, c)` | 481 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createGlobalTimer(t, d, cb, l)` | 482 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createGlobalCountdown(c, d, cb, l)` | 483 | [Details](displayer/index.md) |
| `displayer.lua` | `api.pauseGlobalTimer(t)` | 484 | [Details](displayer/index.md) |
| `displayer.lua` | `api.resumeGlobalTimer(t)` | 485 | [Details](displayer/index.md) |
| `displayer.lua` | `api.pauseGlobalCountdown(c)` | 486 | [Details](displayer/index.md) |
| `displayer.lua` | `api.resumeGlobalCountdown(c)` | 487 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removeGlobalTimer(t)` | 488 | [Details](displayer/index.md) |
| `displayer.lua` | `api.removeGlobalCountdown(c)` | 489 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getGlobalTimer(t)` | 490 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getGlobalCountdown(c)` | 491 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getAllGlobalTimers()` | 492 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getAllGlobalCountdowns()` | 493 | [Details](displayer/index.md) |
| `displayer.lua` | `api.clearAllGlobalTimers()` | 494 | [Details](displayer/index.md) |
| `displayer.lua` | `api.clearAllGlobalCountdowns()` | 495 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupTextPanelAPI()` | 501 | [Details](displayer/index.md) |
| `displayer.lua` | `api.create(player_id, panel_id, text, x, y, style, options)` | 505 | [Details](displayer/index.md) |
| `displayer.lua` | `api.createWithChildren(player_id, panel_id, x, y, style, options)` | 515 | [Details](displayer/index.md) |
| `displayer.lua` | `api.updateText(player_id, panel_id, newText)` | 525 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setChildren(player_id, panel_id, children)` | 532 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setPosition(player_id, panel_id, x, y)` | 539 | [Details](displayer/index.md) |
| `displayer.lua` | `api.setOptions(player_id, panel_id, newOptions)` | 546 | [Details](displayer/index.md) |
| `displayer.lua` | `api.getSize(player_id, panel_id)` | 553 | [Details](displayer/index.md) |
| `displayer.lua` | `api.remove(player_id, panel_id)` | 559 | [Details](displayer/index.md) |
| `displayer.lua` | `api.get(player_id, panel_id)` | 567 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:_setupSlicedSpriteAPI()` | 585 | [Details](displayer/index.md) |
| `displayer.lua` | `api.draw3(pid, lid, x, y, w, h, style, o)` | 587 | [Details](displayer/index.md) |
| `displayer.lua` | `api.draw5(pid, lid, x, y, w, h, style, o)` | 588 | [Details](displayer/index.md) |
| `displayer.lua` | `api.draw9(pid, lid, x, y, w, h, style, o)` | 589 | [Details](displayer/index.md) |
| `displayer.lua` | `api.erase(pid, lid)` | 590 | [Details](displayer/index.md) |
| `displayer.lua` | `api.drawTextPanel(pid, lid, x, y, text, style, options)` | 591 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:formatTime(seconds, is_countdown)` | 597 | [Details](displayer/index.md) |
| `displayer.lua` | `Displayer:getScreenDimensions()` | 607 | [Details](displayer/index.md) |
| `font-system.lua` | `FontSystem:loadAllFonts()` | 190 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:getGlyphState(font_name, char)` | 207 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:getGlyphDimensions(font_name, char)` | 283 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:isBattleFont(font_name)` | 298 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:getVirtualAdvance(font_name, char, scale)` | 310 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:getScreenAdvance(font_name, char, scale)` | 323 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:setupPlayer(player_id)` | 335 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:provideAllFontAssets(player_id)` | 350 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:cleanupPlayer(player_id)` | 358 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:ensureAssetAllocated(player_id, font_name)` | 382 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:nextInstanceId(player_id, prefix)` | 416 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:drawGlyph(player_id, font_name, char, x, y, options)` | 449 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:updateGlyph(player_id, instance_id, updates)` | 524 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:eraseGlyph(player_id, instance_id)` | 594 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:eraseGlyphsByPrefix(player_id, prefix)` | 604 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:allocateAllFontsForPlayer(player_id)` | 616 | [Details](font-system/index.md) |
| `font-system.lua` | `FontSystem:init()` | 647 | [Details](font-system/index.md) |
| `nameplate.lua` | `Nameplate:new(font_system)` | 13 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:setTextAPI(api)` | 52 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:ensureAssets(player_id)` | 57 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:cleanupPlayer(player_id)` | 97 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:_redraw(player_id, np, assets)` | 117 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:attach(player_id, player_data, box_id, box_data, cfg)` | 260 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:erase(player_id, player_data, box_data)` | 448 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:begin_close(player_id, player_data, box_data, cfg)` | 547 | [Details](nameplate/index.md) |
| `nameplate.lua` | `Nameplate:update(player_id, player_data, box_data, dt)` | 624 | [Details](nameplate/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:new(list_obj, player_id, list_id, index, def)` | 22 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:setPosition(x, y)` | 53 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:setColor(r, g, b, a)` | 59 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:setScale(sx, sy)` | 67 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:setAnimationState(state)` | 73 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:redraw()` | 78 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:destroy()` | 118 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:startScroll(delay, distance, speed)` | 132 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `SpriteEntry:_beginScroll(distance, speed)` | 146 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:init()` | 198 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:setupPlayer(player_id)` | 231 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:cleanupPlayer(player_id)` | 244 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:ensureSpriteAsset(player_id, sprite_def)` | 288 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:_computeGridPositions(config)` | 327 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:_drawBackdrop(player_id, list_id, config)` | 367 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:createScrollingList(player_id, list_id, x, y, width, height, config)` | 394 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:onEntryFinished()` | 479 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:getEntry(index)` | 491 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:addSprite(sprite_def)` | 495 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:setSprites(sprites)` | 502 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:setSpeed(speed)` | 507 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:setPosition(x, y)` | 511 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:destroy()` | 542 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `list_object:_recreateEntries()` | 558 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:updateAll(delta)` | 588 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:getList(player_id, list_id)` | 591 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:removeScrollingList(player_id, list_id)` | 596 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:setListPosition(player_id, list_id, x, y)` | 601 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:setListSpeed(player_id, list_id, speed)` | 607 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:addSpriteToList(player_id, list_id, sprite_def)` | 613 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:setListSprites(player_id, list_id, sprites)` | 619 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-sprite-list.lua` | `ScrollingSpriteList:getListState(player_id, list_id)` | 625 | [Details](scrolling-sprite-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:new(list_obj, player_id, list_id, index, text, config)` | 32 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:_createGlyphs(y_offset)` | 54 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:_updatePositions(y_offset)` | 113 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:setPosition(x, y)` | 121 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:setColor(r, g, b, a)` | 129 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:setScale(scale)` | 146 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:destroy()` | 153 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:startScroll(delay, distance, speed)` | 171 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `TextEntry:_beginScroll(distance, speed)` | 185 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:init()` | 217 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:setupPlayer(player_id)` | 252 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:cleanupPlayer(player_id)` | 264 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:_drawBackdrop(player_id, list_id, config)` | 279 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:_computeGridPositions(config)` | 302 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:createScrollingList(player_id, list_id, x, y, width, height, config)` | 316 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:onEntryFinished()` | 397 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:getEntry(index)` | 409 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:addText(text)` | 413 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:setTexts(texts)` | 419 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:setScale(scale)` | 424 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:setSpeed(speed)` | 430 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:setPosition(x, y)` | 435 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:destroy()` | 458 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `list_object:_recreateEntries()` | 478 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:updateAll(delta)` | 512 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:getList(player_id, list_id)` | 515 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:removeScrollingList(player_id, list_id)` | 520 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:setListPosition(player_id, list_id, x, y)` | 525 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:setListSpeed(player_id, list_id, speed)` | 531 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:addTextToList(player_id, list_id, text)` | 537 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:setListTexts(player_id, list_id, texts)` | 543 | [Details](scrolling-text-list/index.md) |
| `scrolling-text-list.lua` | `ScrollingTextList:getListState(player_id, list_id)` | 549 | [Details](scrolling-text-list/index.md) |
| `sliced-sprite.lua` | `SlicedSprite.draw3(player_id, logical_id, x, y, width, height, style, options)` | 539 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `SlicedSprite.draw5(player_id, logical_id, x, y, width, height, style, options)` | 543 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `SlicedSprite.draw9(player_id, logical_id, x, y, width, height, style, options)` | 580 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `SlicedSprite.erase(player_id, logical_id)` | 711 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `SlicedSprite.cleanupPlayer(player_id)` | 724 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:new(player_id, logical_id, x, y, text, style, options)` | 820 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:_measure_child(child, inner_max_width)` | 844 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:_draw_text_child(player_id, child, m, base_x, base_y, z, glyph_ids)` | 936 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:_draw_sprites_child(player_id, child, m, base_x, base_y, z, sprite_ids, child_idx)` | 974 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:_redraw()` | 1014 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:getSize()` | 1233 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:setText(new_text)` | 1237 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:setChildren(children)` | 1244 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:setPosition(x, y)` | 1250 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:setOptions(new_options)` | 1257 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `TextPanel:destroy()` | 1273 | [Details](sliced-sprite/index.md) |
| `sliced-sprite.lua` | `SlicedSprite.drawTextPanel(player_id, logical_id, x, y, text, style, options)` | 1294 | [Details](sliced-sprite/index.md) |
| `text-display.lua` | `DisplayInstance:new(owner, player_id, text_id, text, x, y, options)` | 53 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:relayout()` | 134 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_glyphOptions(glyph, extra)` | 149 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_eraseGlyphId(id)` | 175 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_eraseAllGlyphs()` | 180 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_drawStatic()` | 196 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_drawBackdrop()` | 214 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_eraseBackdrop(force)` | 253 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_marqueeGlyphs()` | 261 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_drawMarqueeAt(offset, elapsed)` | 274 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_cleanupMarquee(done)` | 308 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_startMarquee()` | 326 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_pageMeta(page_index)` | 366 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_currentGlyph()` | 370 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_cancelPendingCharacter()` | 378 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_scheduleNextChar(delay)` | 385 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_startCurrentPage()` | 394 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_pageFinished()` | 406 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_drawTypewriterGlyph(glyph)` | 411 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_printNextChar()` | 429 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_finishCurrentPageImmediately()` | 456 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:_eraseCurrentPage()` | 473 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:advance()` | 488 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:reset(text, options)` | 503 | [Details](text-display/index.md) |
| `text-display.lua` | `DisplayInstance:close()` | 534 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:init()` | 545 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:layout(text, options)` | 561 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:measure(text, options)` | 565 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:cleanupPlayer(player_id)` | 569 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:updateAll(_dt)` | 576 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:draw(player_id, text_id, text, x, y, options)` | 589 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:remove(player_id, text_id)` | 599 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:get(player_id, text_id)` | 606 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:getState(player_id, text_id)` | 610 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:getData(player_id, text_id)` | 615 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:setKeepAlive(player_id, text_id, value)` | 662 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:advance(player_id, text_id)` | 669 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:reset(player_id, text_id, text, options)` | 676 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:drawStatic(player_id, text_id, text, x, y, options)` | 694 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:removeStatic(player_id, text_id)` | 701 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:drawMarquee(player_id, marquee_id, text, y, options)` | 705 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:removeMarquee(player_id, marquee_id)` | 713 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:createTextBox(player_id, box_id, text, x, y, width, height, options)` | 717 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:advanceTextBox(player_id, box_id)` | 726 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:closeTextBox(player_id, box_id)` | 730 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:getTextBoxState(player_id, box_id)` | 734 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:getTextBoxData(player_id, box_id)` | 747 | [Details](text-display/index.md) |
| `text-display.lua` | `TextDisplay:resetTextBox(player_id, box_id, text, options)` | 751 | [Details](text-display/index.md) |
| `text-layout.lua` | `TextLayout.parseMarkup(text)` | 33 | [Details](text-layout/index.md) |
| `text-layout.lua` | `TextLayout.measureLine(text, options)` | 82 | [Details](text-layout/index.md) |
| `text-layout.lua` | `TextLayout.layout(text, options)` | 163 | [Details](text-layout/index.md) |
| `text-layout.lua` | `TextLayout.measure(text, options)` | 288 | [Details](text-layout/index.md) |
| `timer-display.lua` | `TimerDisplay:init()` | 32 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:createPlayerTimerDisplay(player_id, display_id, x, y, options)` | 249 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:createPlayerCountdownDisplay(player_id, display_id, x, y, options)` | 259 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:createGlobalTimerDisplay(display_id, x, y, options)` | 268 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:createGlobalCountdownDisplay(display_id, x, y, options)` | 290 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:_createDisplay(player_id, display_id, x, y, type, options)` | 312 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:updateTimerDisplay(player_id, display_id, seconds)` | 343 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:updateCountdownDisplay(player_id, display_id, seconds)` | 350 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:_updateDisplay(player_id, display_id, seconds, is_countdown)` | 358 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:removeDisplay(player_id, display_id)` | 481 | [Details](timer-display/index.md) |
| `timer-display.lua` | `TimerDisplay:setDisplayPosition(player_id, display_id, x, y)` | 500 | [Details](timer-display/index.md) |
| `timer-system.lua` | `Timer:init()` | 6 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:handlePlayerJoin(player_id)` | 47 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:handlePlayerLeave(player_id)` | 62 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:updateTimers(delta)` | 69 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:emitToAllPlayers(event_name, data)` | 209 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:pausePlayerTimer(player_id, timer_id)` | 223 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:resumePlayerTimer(player_id, timer_id)` | 229 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:pausePlayerCountdown(player_id, countdown_id)` | 235 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:resumePlayerCountdown(player_id, countdown_id)` | 241 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:removePlayerTimer(player_id, timer_id)` | 247 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:removePlayerCountdown(player_id, countdown_id)` | 252 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:createGlobalTimer(timer_id, duration, callback, loop)` | 258 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:createGlobalCountdown(countdown_id, duration, callback, loop)` | 281 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:pauseGlobalTimer(timer_id)` | 304 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:resumeGlobalTimer(timer_id)` | 311 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:pauseGlobalCountdown(countdown_id)` | 318 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:resumeGlobalCountdown(countdown_id)` | 325 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:removeGlobalTimer(timer_id)` | 332 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:removeGlobalCountdown(countdown_id)` | 341 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:getGlobalTimer(timer_id)` | 350 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:getGlobalCountdown(countdown_id)` | 354 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:syncGlobalTimers(player_id)` | 359 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:createPlayerTimer(player_id, timer_id, duration, callback, loop)` | 389 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:createPlayerCountdown(player_id, countdown_id, duration, callback, loop)` | 418 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:getAllGlobalTimers()` | 448 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:getAllGlobalCountdowns()` | 452 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:clearAllGlobalTimers()` | 456 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:clearAllGlobalCountdowns()` | 462 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:getPlayerTimer(player_id, timer_id)` | 468 | [Details](timer-system/index.md) |
| `timer-system.lua` | `Timer:getPlayerCountdown(player_id, countdown_id)` | 475 | [Details](timer-system/index.md) |

## 📊 Collection summary

This folder subtree contains **10 Lua source files**, **371 named/assigned function detections**, and **250 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `readme.md`](readme.md) | 🎮 Displayer Library — Complete Documentation |
