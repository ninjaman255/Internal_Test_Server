# `test-runner/tests/demo.lua`

> **Source reference**
>
> Refreshed from the current `test-runner/tests/demo.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `test-runner/tests/demo.lua`
- **Reference:** `script-reference/test-runner/tests/demo.lua.md`
- **Source SHA-256 prefix:** `9fec9af927e9`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/net-games/helpers/net-helpers` |
| `scripts/animation-engine/animation-engine` |
| `scripts/animation-engine/animation-sequences` |
| `scripts/input-controller/main` |
| `scripts/net-games/dialogue/startup` |
| `scripts/net-games/npcs/prog_banner_dialogue` |
| `scripts/net-games/npcs/prog_basic_dialogue` |
| `scripts/net-games/npcs/prog_basic_freedraw` |
| `scripts/net-games/npcs/prog_dramatic_dialogue` |
| `scripts/net-games/npcs/prog_dyed_dialogue` |
| `scripts/net-games/npcs/prog_prompt_dialogue` |
| `scripts/net-games/npcs/prog_basic_nameplate` |
| `scripts/net-games/npcs/prog_talk_dialogue` |
| `scripts/net-games/npcs/prog_talk_colors` |
| `scripts/net-games/npcs/prog_vert_prompt` |
| `scripts/net-games/npcs/prog_vert_prompt_2` |
| `scripts/net-games/npcs/prog_vert_prompt_sapphire` |
| `scripts/net-games/npcs/prog_vert_prompt_pink` |
| `scripts/net-games/npcs/prog_vert_prompt_lime` |
| `scripts/net-games/npcs/prog_vert_prompt_charcoal_grey` |
| `scripts/net-games/npcs/prog_vert_prompt_red` |
| `scripts/net-games/npcs/prog_vert_prompt_emerald` |
| `scripts/net-games/npcs/prog_shop` |

## `Net:on` subscriptions

| Event |
|---|
| `virtual_input` |
| `actor_interaction` |
| `player_join` |
| `player_disconnect` |
| `cursor_selection` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `async` | `p` |
| `await` | `v` |
| `spawn_demo_npcs` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `list_areas`, `list_objects`, `get_object_by_id`, `create_bot`, `message_player`, `unlock_player_input`, `lock_player_input`, `provide_asset_for_player`, `set_bot_avatar`, `animate_bot_properties`

## Engine `Async` calls

`promisify`, `await`, `sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/demo/cyber_bat.png` |
| `/server/assets/demo/cyber_bat.animation` |
| `/server/assets/demo/protoman-bn5.png` |
| `/server/assets/demo/protoman-bn5.animation` |
| `/server/assets/demo/roll.png` |
| `/server/assets/demo/roll.animation` |
| `/server/assets/demo/shock.png` |
| `/server/assets/demo/shock.animation` |
| `/server/assets/demo/order_points.png` |
| `/server/assets/demo/order_points.animation` |
| `/server/assets/demo/megaman.png` |
| `/server/assets/demo/megaman.animation` |
| `/server/assets/net-games/cursors/text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
