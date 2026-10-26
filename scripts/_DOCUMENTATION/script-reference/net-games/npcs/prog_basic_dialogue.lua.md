# `net-games/npcs/prog_basic_dialogue.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_basic_dialogue.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_basic_dialogue.lua Tiled-spawned NPC that triggers net-games Dialogue (BLACK BOX style + normal THICK font) =====================================================

## Module location

- **Source:** `net-games/npcs/prog_basic_dialogue.lua`
- **Reference:** `script-reference/net-games/npcs/prog_basic_dialogue.lua.md`
- **Source SHA-256 prefix:** `4210ad86b934`

## Source header notes

- prog_basic_dialogue.lua
- Tiled-spawned NPC that triggers net-games Dialogue
- (BLACK BOX style + normal THICK font)

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/net-games/dialogue/dialogue` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dbg` | `msg` |
| `on_finish` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_object_by_name`, `create_bot`, `on`, `get_player_position`, `set_bot_direction`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEBUG` | `false` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ow/prog/prog_ow.png` |
| `/server/assets/ow/prog/prog_ow.animation` |
| `/server/assets/net-games/sfx/text.ogg` |
| `/server/assets/ow/prog/prog_mug.png` |
| `/server/assets/ow/prog/prog_mug.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
