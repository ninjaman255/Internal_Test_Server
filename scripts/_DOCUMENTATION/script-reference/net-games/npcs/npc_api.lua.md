# `net-games/npcs/npc_api.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/npc_api.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/npcs/npc_api.lua Purpose: Remove NPC boilerplate (interaction wiring, busy guards, face-player, SFX helper). This does NOT contain dialogue/menu content defaults.

## Module location

- **Source:** `net-games/npcs/npc_api.lua`
- **Reference:** `script-reference/net-games/npcs/npc_api.lua.md`
- **Source SHA-256 prefix:** `291547111eb4`

## Source header notes

- scripts/net-games/npcs/npc_api.lua
- Purpose: Remove NPC boilerplate (interaction wiring, busy guards, face-player, SFX helper).
- This does NOT contain dialogue/menu content defaults.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/direction` |
| `scripts/net-games/dialogue/startup` |
| `scripts/net-games/dialogue/dialogue` |
| `scripts/net-games/npcs/talk_vert_menu` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `M.play_sfx` | `player_id, path` |
| `M.face_player` | `bot_id, bot_pos, player_id` |
| `M.bind_confirm_interaction` | `bot_id, bot_pos, handler, opts` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `play_sound_for_player`, `play_sound`, `get_player_position`, `set_bot_direction`, `on`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
