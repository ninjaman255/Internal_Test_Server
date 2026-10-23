# `displayer/scrolling-sprite-list.lua`

> **Source reference**
>
> Generated from `displayer/scrolling-sprite-list.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/scrolling-sprite-list.lua`
- **Relative reference:** `script-reference/displayer/scrolling-sprite-list.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-engine` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/boom/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `ScrollingSpriteList:_computeGridPositions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:_drawBackdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:addSpriteToList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:cleanupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:createScrollingList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:ensureSpriteAsset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:getList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:getListState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:removeScrollingList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:setListPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:setListSpeed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:setListSprites` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:setupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingSpriteList:updateAll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:_beginScroll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:redraw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:setAnimationState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:setColor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:setScale` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `SpriteEntry:startScroll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `getFirstState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:_recreateEntries` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:addSprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:getEntry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:onEntryFinished` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:setSpeed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:setSprites` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 645 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
