# `net-games/npcs/prog_vert_prompt.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_vert_prompt.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_vert_prompt.lua Vertical prompt demo PROG (basic style, like prog_basic_nameplate) Adds: - Mugshot support in the vertical prompt UI - Mugshot support in the follow-up Dialogue (reuse_existing_box) =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt.lua`
- **Reference:** `script-reference/net-games/npcs/prog_vert_prompt.lua.md`
- **Source SHA-256 prefix:** `f0a9ff3ef21c`

## Source header notes

- prog_vert_prompt.lua
- Vertical prompt demo PROG (basic style, like prog_basic_nameplate)
- Adds:
- - Mugshot support in the vertical prompt UI
- - Mugshot support in the follow-up Dialogue (reuse_existing_box)

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/net-games/dialogue/startup` |
| `scripts/net-games/dialogue/dialogue` |
| `scripts/net-games/dialogue/prompt_vertical` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `build_options` | `` |
| `build_ui_config` | `box_id` |
| `build_layout_config` | `` |
| `on_select` | `choice, index` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_object_by_name`, `create_bot`, `get_bot_name`, `on`, `get_player_position`, `set_bot_direction`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `BOT_NAME` | `Net.get_bot_name(bot_id)` |

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
