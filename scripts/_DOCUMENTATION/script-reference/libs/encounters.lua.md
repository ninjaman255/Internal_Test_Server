# `libs/encounters.lua`

> **Source reference**
>
> Refreshed from the current `libs/encounters.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Encounters source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `libs/encounters.lua`
- **Reference:** `script-reference/libs/encounters.lua.md`
- **Source SHA-256 prefix:** `a6ce960265fb`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `lib.track_player` | `player_id` |
| `lib.drop_player` | `player_id` |
| `lib.setup` | `encounter_table` |
| `lib.setup_area` | `area_id, area_table` |
| `lib.handle_player_move` | `player_id, x, y, z` |
| `lib.initiate_direct_encounter` | `player_id, asset_path` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_position`, `get_player_area`, `provide_asset`, `is_player_busy`, `initiate_encounter`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `BIG_TILE_MOVEMENT` | `1, -- users can't walk/run this far without help from the server` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/basic_mob1.zip` |
| `/server/assets/basic_mob2.zip` |
| `/server/assets/basic_mob3.zip` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
