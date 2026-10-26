# `net-games/npcs/prog_basic_freedraw.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_basic_freedraw.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_basic_freedraw.lua Tiled-spawned NPC that draws ALL available fonts on screen WITHOUT using Dialogue / textbox pipeline. =====================================================

## Module location

- **Source:** `net-games/npcs/prog_basic_freedraw.lua`
- **Reference:** `script-reference/net-games/npcs/prog_basic_freedraw.lua.md`
- **Source SHA-256 prefix:** `c454f5e77d7c`

## Source header notes

- prog_basic_freedraw.lua
- Tiled-spawned NPC that draws ALL available fonts on screen
- WITHOUT using Dialogue / textbox pipeline.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/displayer/displayer` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dbg` | `msg` |
| `display_id_for` | `font_name` |
| `show` | `player_id` |
| `hide` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_object_by_name`, `create_bot`, `provide_asset_for_player`, `on`, `get_player_position`, `set_bot_direction`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEBUG` | `true` |
| `FONT_TESTS` | `{` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ow/prog/prog_ow.png` |
| `/server/assets/ow/prog/prog_ow.animation` |
| `/server/assets/net-games/fonts/fonts_dark_compressed.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
