# `net-games/npcs/npc_api.lua`

> **Source reference**
>
> Generated from `net-games/npcs/npc_api.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/net-games/npcs/npc_api.lua Purpose: Remove NPC boilerplate (interaction wiring, busy guards, face-player, SFX helper). This does NOT contain dialogue/menu content defaults.

## Module location

- **Source:** `net-games/npcs/npc_api.lua`
- **Relative reference:** `script-reference/net-games/npcs/npc_api.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/startup` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_vert_menu` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `M.bind_confirm_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.face_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.play_sfx` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 56 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
