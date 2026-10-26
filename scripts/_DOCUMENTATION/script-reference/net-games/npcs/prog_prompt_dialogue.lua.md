# `net-games/npcs/prog_prompt_dialogue.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_prompt_dialogue.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_prompt_dialogue_shared_box.lua Tiled-spawned NPC that shows a YES/NO prompt, then follows up with Dialogue.start, reusing the same textbox UI (no close/recreate). =====================================================

## Module location

- **Source:** `net-games/npcs/prog_prompt_dialogue.lua`
- **Reference:** `script-reference/net-games/npcs/prog_prompt_dialogue.lua.md`
- **Source SHA-256 prefix:** `b8fab5efab4e`

## Source header notes

- prog_prompt_dialogue_shared_box.lua
- Tiled-spawned NPC that shows a YES/NO prompt,
- then follows up with Dialogue.start,
- reusing the same textbox UI (no close/recreate).

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
| `basic_prog_ui` | `box_id` |
| `prog_ui_prompt` | `` |
| `prog_ui_dialogue` | `` |
| `on_yes` | `` |
| `on_no` | `` |
| `on_cancel` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_object_by_name`, `create_bot`, `get_bot_name`, `on`, `get_player_position`, `set_bot_direction`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEBUG` | `false` |
| `BOT_NAME` | `Net.get_bot_name(bot_id)` |
| `SHARED_BOX_ID` | `"prog_prompt_shared_box"` |

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
