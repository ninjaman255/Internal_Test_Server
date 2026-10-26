# `net-games/npcs/prog_vert_prompt_lime.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_vert_prompt_lime.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_vert_prompt_lime.lua LIME variant of prog_vert_prompt_pink.lua. Key requirement: identical in-game flow, but implemented using Talk.lua + TalkVertMenu.lua (reusable wrapper). =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_lime.lua`
- **Reference:** `script-reference/net-games/npcs/prog_vert_prompt_lime.lua.md`
- **Source SHA-256 prefix:** `fe4e2a1387e6`

## Source header notes

- prog_vert_prompt_lime.lua
- LIME variant of prog_vert_prompt_pink.lua.
- Key requirement: identical in-game flow, but implemented
- using Talk.lua + TalkVertMenu.lua (reusable wrapper).

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/net-games/dialogue/startup` |
| `scripts/net-games/dialogue/dialogue` |
| `scripts/net-games/npcs/talk` |
| `scripts/net-games/npcs/talk_vert_menu` |
| `scripts/net-games/npcs/talk_presets` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `play_sfx` | `player_id, path` |
| `shallow_copy` | `t` |
| `build_options` | `` |
| `on_yes` | `` |
| `on_no` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `play_sound_for_player`, `play_sound`, `get_object_by_name`, `create_bot`, `get_bot_name`, `on`, `get_player_position`, `set_bot_direction`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `SFX` | `{` |
| `DESC` | `"/server/assets/net-games/sfx/card_desc.ogg",` |
| `CONFIRM` | `"/server/assets/net-games/sfx/card_confirm.ogg",` |
| `DESC_CLOSE` | `"/server/assets/net-games/sfx/card_desc_close.ogg",` |
| `BOT_NAME` | `Net.get_bot_name(bot_id)` |
| `TALK_CFG` | `{` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/sfx/card_desc.ogg` |
| `/server/assets/net-games/sfx/card_confirm.ogg` |
| `/server/assets/net-games/sfx/card_desc_close.ogg` |
| `/server/assets/ow/prog/prog_ow_lime.png` |
| `/server/assets/ow/prog/prog_ow.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
