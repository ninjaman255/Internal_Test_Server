# `net-games/npcs/talk.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/talk.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== talk.lua Minimal author API for Dialogue NPCs with PROG-default UI =====================================================

## Module location

- **Source:** `net-games/npcs/talk.lua`
- **Reference:** `script-reference/net-games/npcs/talk.lua.md`
- **Source SHA-256 prefix:** `60cac723323e`

## Source header notes

- talk.lua
- Minimal author API for Dialogue NPCs with PROG-default UI

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/net-games/dialogue/dialogue` |
| `scripts/net-games/npcs/talk_presets` |
| `scripts/net-games/npcs/menu_options` |
| `scripts/displayer/displayer` |
| `scripts/net-games/npcs/talk_vert_menu` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `shallow_copy` | `t` |
| `deep_merge` | `dst, src` |
| `normalize_script` | `lines_or_text` |
| `stable_box_id` | `cfg` |
| `force_indicator_on` | `player_id, box_id` |
| `get_talk_vert_menu` | `` |
| `build_ui` | `cfg, bot_name, opts` |
| `get_pack_from_cfg` | `cfg` |
| `resolve_layout` | `cfg, menu_cfg` |
| `resolve_flow` | `cfg, menu_cfg` |
| `resolve_sfx` | `cfg, menu_cfg` |
| `resolve_options` | `menu_cfg` |
| `infer_exit_index` | `options, explicit_exit_index` |
| `Talk.start` | `player_id, script, cfg, bot_name, extra_opts` |
| `Talk.prompt_yesno` | `player_id, question, cfg, bot_name, handlers` |
| `Talk.vert_menu` | `player_id, bot_name, cfg, menu_cfg` |
| `pick_text` | `...` |
| `open_menu` | `` |
| `Talk.prompt_then_talk` | `player_id, question, yes_script, no_script, cfg, bot_name` |
| `Talk.npc` | `cfg` |
| `Talk._build_ui` | `cfg, bot_name, opts` |
| `on_yes` | `` |
| `on_no` | `` |
| `on_cancel` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `play_sound_for_player`, `play_sound`, `get_object_by_name`, `create_bot`, `get_bot_name`, `on`, `get_player_position`, `set_bot_direction`

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

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
