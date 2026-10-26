# `ezlibs-custom/nebulous-liberations/liberations/loot.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/loot.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Loot source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/loot.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/loot.lua.md`
- **Source SHA-256 prefix:** `b811f9ea4c4b`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `unlock_gates` | `` |
| `spawn_item_bot` | `bot_data, property_animation` |
| `cleanup` | `` |
| `Loot.spawn_item_bot` | `item, area_id, x, y, z` |
| `Loot.spawn_randomized_item_bot` | `loot_pool, item_index, area_id, x, y, z` |
| `Loot.loot_item_panel` | `instance, player_session, panel, destroy_items` |
| `Loot.loot_bonus_panel` | `instance, player_session, panel` |
| `activate` | `instance, player_session` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`slide_player_camera`, `move_player_camera`, `create_bot`, `animate_bot_properties`, `remove_bot`

## Engine `Async` calls

`create_promise`, `await`, `promisify`, `sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `HEART` | `{` |
| `CHIP` | `{` |
| `MONEY` | `{` |
| `BUGFRAG` | `{` |
| `ORDER_POINT` | `{` |
| `INVINCIBILITY` | `{` |
| `MAJOR_HIT` | `{` |
| `KEY` | `{` |
| `RISE_DURATION` | `.1` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/bots/item.png` |
| `/server/assets/NebuLibsAssets/bots/item.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
