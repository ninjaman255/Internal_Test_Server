# `net-games/npcs/prog_banner_dialogue.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_banner_dialogue.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_banner_dialogue.lua Tiled-spawned NPC that triggers net-games Marquee =====================================================

## Module location

- **Source:** `net-games/npcs/prog_banner_dialogue.lua`
- **Reference:** `script-reference/net-games/npcs/prog_banner_dialogue.lua.md`
- **Source SHA-256 prefix:** `130ce6dcb12c`

## Source header notes

- prog_banner_dialogue.lua
- Tiled-spawned NPC that triggers net-games Marquee

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/displayer/displayer` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `actor_interaction` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dbg` | `msg` |
| `ensure_backdrop_sprite` | `player_id` |
| `draw_backdrop` | `player_id, backdrop, z` |
| `erase_backdrop` | `player_id` |
| `ensure_tick` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `player_alloc_sprite`, `player_draw_sprite`, `player_erase_sprite`, `get_object_by_name`, `create_bot`, `on`, `get_player_position`, `set_bot_direction`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEBUG` | `true` |
| `BACKDROP_TEXTURE` | `"/server/assets/net-games/displayer/empty_white.png"` |
| `TICK_ATTACHED` | `false` |
| `TICK_ATTACHED` | `true` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/displayer/empty_white.png` |
| `/server/assets/ow/prog/prog_ow.png` |
| `/server/assets/ow/prog/prog_ow.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
