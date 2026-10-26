# `displayer/scrolling-sprite-list.lua`

> **Source reference**
>
> Refreshed from the current `displayer/scrolling-sprite-list.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/scrolling-sprite-list.lua`
- **Reference:** `script-reference/displayer/scrolling-sprite-list.lua.md`
- **Source SHA-256 prefix:** `64776120c6b9`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/animation-engine/animation-engine` |
| `scripts/boom/main` |

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
| `SpriteEntry:new` | `list_obj, player_id, list_id, index, def` |
| `SpriteEntry:setPosition` | `x, y` |
| `SpriteEntry:setColor` | `r, g, b, a` |
| `SpriteEntry:setScale` | `sx, sy` |
| `SpriteEntry:setAnimationState` | `state` |
| `SpriteEntry:redraw` | `` |
| `SpriteEntry:destroy` | `` |
| `SpriteEntry:startScroll` | `delay, distance, speed` |
| `SpriteEntry:_beginScroll` | `distance, speed` |
| `ScrollingSpriteList:init` | `` |
| `ScrollingSpriteList:setupPlayer` | `player_id` |
| `ScrollingSpriteList:cleanupPlayer` | `player_id` |
| `getFirstState` | `anim_path` |
| `ScrollingSpriteList:ensureSpriteAsset` | `player_id, sprite_def` |
| `ScrollingSpriteList:_computeGridPositions` | `config` |
| `ScrollingSpriteList:_drawBackdrop` | `player_id, list_id, config` |
| `ScrollingSpriteList:createScrollingList` | `player_id, list_id, x, y, width, height, config` |
| `list_object:onEntryFinished` | `` |
| `list_object:getEntry` | `index` |
| `list_object:addSprite` | `sprite_def` |
| `list_object:setSprites` | `sprites` |
| `list_object:setSpeed` | `speed` |
| `list_object:setPosition` | `x, y` |
| `list_object:destroy` | `` |
| `list_object:_recreateEntries` | `` |
| `ScrollingSpriteList:updateAll` | `delta` |
| `ScrollingSpriteList:getList` | `player_id, list_id` |
| `ScrollingSpriteList:removeScrollingList` | `player_id, list_id` |
| `ScrollingSpriteList:setListPosition` | `player_id, list_id, x, y` |
| `ScrollingSpriteList:setListSpeed` | `player_id, list_id, speed` |
| `ScrollingSpriteList:addSpriteToList` | `player_id, list_id, sprite_def` |
| `ScrollingSpriteList:setListSprites` | `player_id, list_id, sprites` |
| `ScrollingSpriteList:getListState` | `player_id, list_id` |
| `on_update` | `values` |
| `on_complete` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`player_draw_sprite`, `player_erase_sprite`, `on`, `provide_asset_for_player`, `player_alloc_sprite`, `player_dealloc_sprite`

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
