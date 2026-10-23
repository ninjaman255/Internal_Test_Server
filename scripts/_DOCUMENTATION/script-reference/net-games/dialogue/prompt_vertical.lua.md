# `net-games/dialogue/prompt_vertical.lua`

> **Source reference**
>
> Generated from `net-games/dialogue/prompt_vertical.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/net-games/dialogue/prompt_vertical.lua Vertical menu prompt helper for net-games Dialogue (adapted to new displayer) NOTE: This version preserves the original logic but marks areas where the new displayer no longer exposes internal fields (pages, current_page, backdrop indicator). These parts will need to be reimplemented using the available APIs.

## Module location

- **Source:** `net-games/dialogue/prompt_vertical.lua`
- **Relative reference:** `script-reference/net-games/dialogue/prompt_vertical.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input/input` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `PromptMenuInstance:become_ready` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:clear_menu_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:do_cancel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:menu_origin` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:menu_overlays_visible` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:render_menu_contents` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:render_menu_window` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:render_textbox` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:restart_shop_item_intro` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:select_current` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:set_locked` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:start_close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:start_text_intro` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:update_cursor_bob` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptMenuInstance:update_scroll_for_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptVertical._finalize_close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptVertical.close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptVertical.menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `alloc_ui_sprites` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clamp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_backdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_menu_frame_overlay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_sprite_xy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ease_out_quad` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_backdrop_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_listener` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_backdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_text_width` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mdbg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `merge_assets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mk_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `play_cursor_move_sfx` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide_ui_assets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self._post_close_cb` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_input_locked` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_textbox_indicator_enabled` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`CLOSING`, `CURSOR`, `HILITE`, `LISTENER_ATTACHED`, `MENU`, `MENU_BG`, `MENU_FRAME`, `SCROLL`, `SHOP_EXIT`, `SHOP_ITEM`, `SUBPROMPT`, `TEXT`

## Source notes

- Approximate source size: 1200 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
