# `displayer/scrolling-text-list.lua`

> **Source reference**
>
> Generated from `displayer/scrolling-text-list.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/scrolling-text-list.lua`
- **Relative reference:** `script-reference/displayer/scrolling-text-list.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-engine` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/font-system` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `ScrollingTextList:_computeGridPositions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:_drawBackdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:addTextToList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:cleanupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:createScrollingList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:getList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:getListState` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:removeScrollingList` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:setListPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:setListSpeed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:setListTexts` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:setupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ScrollingTextList:updateAll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:_beginScroll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:_createGlyphs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:_updatePositions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:setColor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:setScale` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextEntry:startScroll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `getFontHeight` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:_recreateEntries` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:addText` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:getEntry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:onEntryFinished` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:setSpeed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `list_object:setTexts` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 557 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
