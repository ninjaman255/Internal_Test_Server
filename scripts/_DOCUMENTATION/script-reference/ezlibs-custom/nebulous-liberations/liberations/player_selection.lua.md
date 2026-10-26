# `ezlibs-custom/nebulous-liberations/liberations/player_selection.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/player_selection.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Player selection source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/player_selection.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/player_selection.lua.md`
- **Source SHA-256 prefix:** `156abe126743`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/selection` |
| `scripts/libs/direction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `includes` | `table, value` |
| `resolve_selection_direction` | `player_pos, panel_object` |
| `PlayerSelection:new` | `instance, player_id` |
| `filter` | `x, y, z` |
| `PlayerSelection:select_panel` | `panel_object` |
| `PlayerSelection:set_shape` | `shape, shape_offset_x, shape_offset_y` |
| `PlayerSelection:get_panels` | `` |
| `PlayerSelection:clear` | `` |
| `PlayerSelection:count_panels` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_tileset`, `get_player_position`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `LIBERATING_PANEL_GID` | `Net.get_tileset(instance.area_id, "/server/assets/tiles/selected tile.tsx").first_gid` |
| `LIBERATING_PANEL_GID` | `LIBERATING_PANEL_GID,` |
| `SELECTED_PANEL_GID` | `LIBERATING_PANEL_GID + 1` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/tiles/selected tile.tsx` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
