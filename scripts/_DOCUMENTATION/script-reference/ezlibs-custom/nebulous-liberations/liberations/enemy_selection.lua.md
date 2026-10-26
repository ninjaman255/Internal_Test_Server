# `ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Enemy selection source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua.md`
- **Source SHA-256 prefix:** `d7d258ff5b3a`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/selection` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `EnemySelection:new` | `instance` |
| `filter` | `x, y, z` |
| `EnemySelection:set_shape` | `shape, shape_offset_x, shape_offset_y` |
| `EnemySelection:move` | `position, direction` |
| `EnemySelection:detect_player_sessions` | `` |
| `EnemySelection:indicate` | `` |
| `EnemySelection:remove_indicators` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_tileset`, `get_tile`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `INDICATOR_GID` | `Net.get_tileset(instance.area_id, "/server/assets/tiles/attack indicator.tsx").first_gid` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/tiles/attack indicator.tsx` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
