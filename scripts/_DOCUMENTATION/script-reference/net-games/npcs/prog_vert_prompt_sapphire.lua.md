# `net-games/npcs/prog_vert_prompt_sapphire.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_vert_prompt_sapphire.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_vert_prompt_sapphire.lua Flow: Interact -> YES/NO prompt: "Do you wanna check out the vertical menu?" YES -> SAME textbox becomes: "Awesome. Let me know if there's anything that you like." Vertical menu opens while that line prints, and menu control unlocks after printing finishes. NO -> short line (same textbox) Assumes prompt_vertical.lua supports reuse_existing_box reset. =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_sapphire.lua`
- **Reference:** `script-reference/net-games/npcs/prog_vert_prompt_sapphire.lua.md`
- **Source SHA-256 prefix:** `7bec270976b8`

## Source header notes

- prog_vert_prompt_sapphire.lua
- Flow:
- Interact ->
- YES/NO prompt: "Do you wanna check out the vertical menu?"
- YES ->
- SAME textbox becomes:

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/net-games/dialogue/startup` |
| `scripts/net-games/dialogue/dialogue` |
| `scripts/net-games/dialogue/prompt` |
| `scripts/net-games/dialogue/prompt_vertical` |
| `scripts/net-games/npcs/talk_presets` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `copy_frame_preset` | `preset` |
| `build_options` | `` |
| `build_ui_config` | `box_id` |
| `build_layout_config` | `` |
| `open_vertical_menu` | `player_id, intro_text` |
| `on_select` | `choice, index` |
| `on_yes` | `` |
| `on_no` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_object_by_name`, `create_bot`, `get_bot_name`, `on`, `get_player_position`, `set_bot_direction`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `BOT_NAME` | `Net.get_bot_name(bot_id)` |
| `SAPPHIRE_FRAME` | `TalkPresets.frames.sapphire` |
| `SAPPHIRE_MUG` | `TalkPresets.mugs.prog_sapphire` |
| `FRAME` | `copy_frame_preset(SAPPHIRE_FRAME)` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ow/prog/prog_ow_sapphire.png` |
| `/server/assets/ow/prog/prog_ow.animation` |
| `/server/assets/net-games/sfx/text.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
