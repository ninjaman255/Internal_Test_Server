# `displayer/scrolling-text-list.lua`

> **Source reference**
>
> Refreshed from the current `displayer/scrolling-text-list.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/scrolling-text-list.lua`
- **Reference:** `script-reference/displayer/scrolling-text-list.lua.md`
- **Source SHA-256 prefix:** `e4794922eb60`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/font-system` |
| `scripts/animation-engine/animation-engine` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `player_disconnect` |
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `normalize_scale` | `value, fallback` |
| `getFontHeight` | `font_name, scale` |
| `TextEntry:new` | `list_obj, player_id, list_id, index, text, config` |
| `TextEntry:_createGlyphs` | `y_offset` |
| `TextEntry:_updatePositions` | `y_offset` |
| `TextEntry:setPosition` | `x, y` |
| `TextEntry:setColor` | `r, g, b, a` |
| `TextEntry:setScale` | `scale` |
| `TextEntry:destroy` | `` |
| `TextEntry:startScroll` | `delay, distance, speed` |
| `TextEntry:_beginScroll` | `distance, speed` |
| `ScrollingTextList:init` | `` |
| `ScrollingTextList:setupPlayer` | `player_id` |
| `ScrollingTextList:cleanupPlayer` | `player_id` |
| `ScrollingTextList:_drawBackdrop` | `player_id, list_id, config` |
| `ScrollingTextList:_computeGridPositions` | `config` |
| `ScrollingTextList:createScrollingList` | `player_id, list_id, x, y, width, height, config` |
| `list_object:onEntryFinished` | `` |
| `list_object:getEntry` | `index` |
| `list_object:addText` | `text` |
| `list_object:setTexts` | `texts` |
| `list_object:setScale` | `scale` |
| `list_object:setSpeed` | `speed` |
| `list_object:setPosition` | `x, y` |
| `list_object:destroy` | `` |
| `list_object:_recreateEntries` | `` |
| `ScrollingTextList:updateAll` | `delta` |
| `ScrollingTextList:getList` | `player_id, list_id` |
| `ScrollingTextList:removeScrollingList` | `player_id, list_id` |
| `ScrollingTextList:setListPosition` | `player_id, list_id, x, y` |
| `ScrollingTextList:setListSpeed` | `player_id, list_id, speed` |
| `ScrollingTextList:addTextToList` | `player_id, list_id, text` |
| `ScrollingTextList:setListTexts` | `player_id, list_id, texts` |
| `ScrollingTextList:getListState` | `player_id, list_id` |
| `on_update` | `values` |
| `on_complete` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `provide_asset_for_player`, `player_alloc_sprite`, `player_dealloc_sprite`, `player_draw_sprite`, `player_erase_sprite`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `BACKDROP_TEXTURE` | `"/server/assets/net-games/displayer/empty_white.png"` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/displayer/empty_white.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
