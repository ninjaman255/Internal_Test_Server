# `HP_Manager/warp_manage.lua`

> **Source reference**
>
> Generated from `HP_Manager/warp_manage.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `HP_Manager/warp_manage.lua`
- **Relative reference:** `script-reference/HP_Manager/warp_manage.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/HP_Manager/constants/constants` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `board_close` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `post_selection` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `WarpManage.open` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_saved_warps` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_warp_controllers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_warp_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `save_warp_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 416 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
