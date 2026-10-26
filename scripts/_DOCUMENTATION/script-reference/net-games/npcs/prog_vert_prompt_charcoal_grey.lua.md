# `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_vert_prompt_charcoal_grey.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_vert_prompt_charcoal_grey.lua New NPC that mirrors Lime/Pink vertical menu flow, but uses the new helpers: - npc_api.lua (bind interaction + guards + face + sfx) - menu_options.lua (count/list -> options table) =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`
- **Reference:** `script-reference/net-games/npcs/prog_vert_prompt_charcoal_grey.lua.md`
- **Source SHA-256 prefix:** `fed28bbc131f`

## Source header notes

- prog_vert_prompt_charcoal_grey.lua
- New NPC that mirrors Lime/Pink vertical menu flow,
- but uses the new helpers:
- - npc_api.lua (bind interaction + guards + face + sfx)
- - menu_options.lua (count/list -> options table)

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/npcs/npc_api` |
| `scripts/net-games/npcs/menu_options` |
| `scripts/libs/direction` |
| `scripts/net-games/npcs/talk` |
| `scripts/net-games/npcs/talk_vert_menu` |
| `scripts/net-games/npcs/talk_presets` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `on_yes` | `` |
| `on_no` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_object_by_name`, `create_bot`, `get_bot_name`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `NPC` | `require("scripts/net-games/npcs/npc_api")` |
| `SFX` | `{` |
| `DESC` | `"/server/assets/net-games/sfx/card_desc.ogg",` |
| `CONFIRM` | `"/server/assets/net-games/sfx/card_confirm.ogg",` |
| `DESC_CLOSE` | `"/server/assets/net-games/sfx/card_desc_close.ogg",` |
| `BOT_NAME` | `Net.get_bot_name(bot_id)` |
| `TALK_CFG` | `{` |
| `OPTIONS` | `MenuOptions.count(40, {` |
| `EXIT_INDEX` | `41` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/sfx/card_desc.ogg` |
| `/server/assets/net-games/sfx/card_confirm.ogg` |
| `/server/assets/net-games/sfx/card_desc_close.ogg` |
| `/server/assets/ow/prog/prog_ow_charcoal_grey.png` |
| `/server/assets/ow/prog/prog_ow.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
