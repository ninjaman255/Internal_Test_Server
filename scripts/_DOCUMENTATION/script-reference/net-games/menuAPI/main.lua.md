# `net-games/menuAPI/main.lua`

> **Source reference**
>
> Generated from `net-games/menuAPI/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/net-games/menuAPI/main.lua Reusable BN-style menu layer for net-games. This is a creator-side rewrite inspired by the production MenuAPI used by shadis_hp. It intentionally depends only on net-games/Displayer/Input and does not contain pet, inventory, LMenu, or server-specific business logic.

## Module location

- **Source:** `net-games/menuAPI/main.lua`
- **Relative reference:** `script-reference/net-games/menuAPI/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/ui-safe` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `MenuAPI.close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.close_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.get_palette` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.get_stack` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.get_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.handle_cancel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.is_open` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.open` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.refresh` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.set_profile` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.set_rows` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `MenuAPI.set_title` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `active` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cleanup` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clear_visible_rows` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `confirm` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_background` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_confirm` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_profile` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_rows` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_scroll` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_title` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_visible` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `first_selectable` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `full_draw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `guard_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `handle_cancel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `menu_input_owner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `merge` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `move_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `next_selectable` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_rows` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `play_sfx` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_type` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `row_selectable` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_input_locked` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `sprite_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `stack_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `text_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `tint_copy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `tint_options` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 706 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
