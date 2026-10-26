# `net-games/dialogue/prompt_vertical.lua`

> **Source reference**
>
> Refreshed from the current `net-games/dialogue/prompt_vertical.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/dialogue/prompt_vertical.lua Vertical menu prompt helper for net-games Dialogue (adapted to new displayer) NOTE: This version preserves the original logic but marks areas where the new displayer no longer exposes internal fields (pages, current_page, backdrop indicator). These parts will need to be reimplemented using the available APIs.

## Module location

- **Source:** `net-games/dialogue/prompt_vertical.lua`
- **Reference:** `script-reference/net-games/dialogue/prompt_vertical.lua.md`
- **Source SHA-256 prefix:** `3bfe625d59e0`

## Source header notes

- scripts/net-games/dialogue/prompt_vertical.lua
- Vertical menu prompt helper for net-games Dialogue (adapted to new displayer)
- NOTE: This version preserves the original logic but marks areas where the new
- displayer no longer exposes internal fields (pages, current_page, backdrop indicator).
- These parts will need to be reimplemented using the available APIs.

## Direct `require` dependencies

| Import path |
|---|
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
| `mdbg` | `pid, msg` |
| `merge_assets` | `overrides` |
| `play_cursor_move_sfx` | `player_id` |
| `ensure_backdrop_sprite` | `player_id` |
| `draw_backdrop` | `player_id, backdrop, z` |
| `erase_backdrop` | `player_id` |
| `get_text_width` | `text, font, scale` |
| `draw_text` | `inst, text, x, y, font, scale, z, id, tint` |
| `erase_text` | `inst, id` |
| `ensure_listener` | `` |
| `set_input_locked` | `player_id, locked` |
| `mk_id` | `player_id` |
| `clamp` | `v, a, b` |
| `ensure_tick` | `` |
| `provide_ui_assets` | `player_id, assets` |
| `alloc_ui_sprites` | `inst` |
| `draw_sprite` | `inst, sprite_id, draw_id, x, y, z, s, anim_state` |
| `draw_sprite_xy` | `inst, sprite_id, draw_id, x, y, z, sx, sy, anim_state` |
| `draw_menu_frame_overlay` | `inst, draw_id, x, y, z, s, anim_state, frame_cfg` |
| `erase_sprite` | `player_id, draw_id` |
| `normalize_ui` | `ui` |
| `normalize_layout` | `layout` |
| `PromptMenuInstance:new` | `player_id, opts` |
| `PromptMenuInstance:render_textbox` | `` |
| `PromptMenuInstance:menu_origin` | `` |
| `PromptMenuInstance:start_close` | `reason, keep_textbox` |
| `PromptMenuInstance:render_menu_window` | `` |
| `PromptMenuInstance:clear_menu_text` | `` |
| `PromptMenuInstance:update_scroll_for_selection` | `force` |
| `set_textbox_indicator_enabled` | `player_id, box_id, enabled` |
| `PromptMenuInstance:menu_overlays_visible` | `` |
| `PromptMenuInstance:set_locked` | `locked` |
| `PromptMenuInstance:update_cursor_bob` | `dt` |
| `ease_out_quad` | `x` |
| `PromptMenuInstance:render_menu_contents` | `force` |
| `PromptMenuInstance:start_text_intro` | `` |
| `PromptMenuInstance:become_ready` | `` |
| `PromptMenuInstance:select_current` | `` |
| `PromptMenuInstance:do_cancel` | `` |
| `PromptMenuInstance:restart_shop_item_intro` | `` |
| `PromptMenuInstance:update` | `_dt` |
| `PromptVertical.menu` | `player_id, opts` |
| `PromptVertical._finalize_close` | `player_id, _reason, opts` |
| `PromptVertical.close` | `player_id, _reason, opts` |
| `self._post_close_cb` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `play_sound_for_player`, `play_sound`, `player_alloc_sprite`, `player_draw_sprite`, `player_erase_sprite`, `lock_player_input`, `unlock_player_input`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `MENUDBG` | `true` |
| `DEFAULT_ASSET` | `{` |
| `MENU_W` | `238` |
| `MENU_H` | `95` |
| `CURSOR_MOVE_SFX_PATH` | `"/server/assets/net-games/sfx/cursor_move.ogg"` |
| `BACKDROP_TEXTURE` | `"/server/assets/net-games/displayer/empty_white.png"` |
| `LISTENER_ATTACHED` | `false` |
| `LISTENER_ATTACHED` | `true` |
| `STATE` | `{` |
| `TEXT` | `"text",` |
| `MENU` | `"menu",` |
| `SUBPROMPT` | `"subprompt",` |
| `CLOSING` | `"closing",` |
| `MENU_BG` | `"pv_" .. base .. "_spr_menu_bg",` |
| `MENU_FRAME` | `"pv_" .. base .. "_spr_menu_frame",` |
| `HILITE` | `"pv_" .. base .. "_spr_hilite",` |
| `CURSOR` | `"pv_" .. base .. "_spr_cursor",` |
| `SCROLL` | `"pv_" .. base .. "_spr_scroll",` |
| `SHOP_ITEM` | `"pv_" .. base .. "_spr_shop_item",` |
| `SHOP_EXIT` | `"pv_" .. base .. "_spr_shop_exit",` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/ui/prompt_vert_menu_an.png` |
| `/server/assets/net-games/ui/prompt_vert_menu_an.animation` |
| `/server/assets/net-games/ui/prompt_vert_menu_an_frame.png` |
| `/server/assets/net-games/ui/highlight_default.png` |
| `/server/assets/net-games/cursors/green_cursor.png` |
| `/server/assets/net-games/ui/scrollbar.png` |
| `/server/assets/net-games/ui/card_shop_item.png` |
| `/server/assets/net-games/ui/card_shop_exit.png` |
| `/server/assets/net-games/sfx/cursor_move.ogg` |
| `/server/assets/net-games/displayer/empty_white.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
