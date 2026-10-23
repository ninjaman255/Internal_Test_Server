# `HP_Manager/main.lua`

> **Source reference**
>
> Generated from `HP_Manager/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `HP_Manager/main.lua`
- **Relative reference:** `script-reference/HP_Manager/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/HP_Manager/background_manage` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/HP_Manager/constants/constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/HP_Manager/realtime_manage` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/HP_Manager/warp_manage` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-layout` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `object_interaction` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `add_desktop_icons` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `close_hp_manage` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_option_name` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_server_os` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `handle_manager_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `input_owner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_hp_manager` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `poll_manager_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `release_manager_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `take` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 539 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
