# `net-games/npcs/talk_vert_menu.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/talk_vert_menu.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== talk_vert_menu.lua Talk-mode wrapper for PromptVertical =====================================================

## Module location

- **Source:** `net-games/npcs/talk_vert_menu.lua`
- **Reference:** `script-reference/net-games/npcs/talk_vert_menu.lua.md`
- **Source SHA-256 prefix:** `affd50f15ead`

## Source header notes

- talk_vert_menu.lua
- Talk-mode wrapper for PromptVertical

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/npcs/talk` |
| `scripts/net-games/npcs/talk_presets` |
| `scripts/net-games/dialogue/dialogue` |
| `scripts/net-games/dialogue/prompt` |
| `scripts/net-games/dialogue/prompt_vertical` |
| `scripts/displayer/displayer` |
| `scripts/input/input` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `play_sfx` | `player_id, path` |
| `set_menu_locked` | `menu, locked` |
| `set_textbox_indicator` | `player_id, box_id, enabled` |
| `resolve_frame` | `frame_key_or_table` |
| `apply_default_layout_frame` | `talk_cfg, layout` |
| `ensure_tick` | `` |
| `TalkVertMenu.is_busy` | `player_id` |
| `TalkVertMenu.open` | `player_id, bot_name, talk_cfg, menu_cfg` |
| `do_post_text_then_ack` | `` |
| `on_yes` | `` |
| `on_no` | `` |
| `on_choose` | `choice, index, menu` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `play_sound_for_player`, `play_sound`, `on`, `lock_player_input`, `unlock_player_input`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `TICK_ATTACHED` | `false` |
| `TICK_ATTACHED` | `true` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
