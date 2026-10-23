# `avatar_utils/main.lua`

> **Source reference**
>
> Generated from `avatar_utils/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

NaviSpot.lua Module to cache player and bot avatar/mugshot assets. For players: copies assets from engine to local files on avatar change. For bots: registers existing local asset paths (no copying).

## Module location

- **Source:** `avatar_utils/main.lua`
- **Relative reference:** `script-reference/avatar_utils/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/avatar_utils/avatar_utils` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_avatar_change` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `get_bot_avatar_paths` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_player_avatar_paths` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_player_secret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `parse_bot_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `refresh_player_avatar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `register_bot_avatar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_player_avatar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 158 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
