# `net-games/menuAPI/main.lua`

> **Source reference**
>
> Refreshed from the current `net-games/menuAPI/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/menuAPI/main.lua Reusable BN-style menu layer for net-games. This is a creator-side rewrite inspired by the production MenuAPI used by shadis_hp. It intentionally depends only on net-games/Displayer/Input and does not contain pet, inventory, LMenu, or server-specific business logic.

## Module location

- **Source:** `net-games/menuAPI/main.lua`
- **Reference:** `script-reference/net-games/menuAPI/main.lua.md`
- **Source SHA-256 prefix:** `9ba907047b56`

## Source header notes

- scripts/net-games/menuAPI/main.lua
- Reusable BN-style menu layer for net-games.
- This is a creator-side rewrite inspired by the production MenuAPI used by
- shadis_hp. It intentionally depends only on net-games/Displayer/Input and
- does not contain pet, inventory, LMenu, or server-specific business logic.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/displayer/displayer` |
| `scripts/input-controller/main` |
| `scripts/net-games/ui-safe` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `get_controller` | `player_id` |
| `menu_input_owner` | `player_id` |
| `guard_input` | `player_id, swallow_seconds` |
| `tint_copy` | `src` |
| `MenuAPI.get_palette` | `name` |
| `copy_table` | `src` |
| `merge` | `dst, src` |
| `resolve_type` | `value` |
| `stack_for` | `player_id, create` |
| `active` | `player_id` |
| `set_input_locked` | `player_id, locked` |
| `play_sfx` | `player_id, path` |
| `normalize_rows` | `rows` |
| `row_selectable` | `row` |
| `first_selectable` | `rows` |
| `next_selectable` | `rows, start, direction` |
| `ensure_visible` | `st` |
| `sprite_key` | `st, key` |
| `text_key` | `st, key` |
| `draw_text` | `st, key, text, x, y, options` |
| `erase_text` | `st, key` |
| `tint_options` | `tint, extra` |
| `draw_background` | `st` |
| `draw_title` | `st` |
| `clear_visible_rows` | `st` |
| `draw_rows` | `st` |
| `draw_cursor` | `st` |
| `draw_scroll` | `st` |
| `draw_profile` | `st` |
| `draw_confirm` | `st` |
| `full_draw` | `st` |
| `cleanup` | `st` |
| `move_selection` | `st, direction` |
| `confirm` | `st` |
| `handle_cancel` | `st` |
| `MenuAPI.open` | `player_id, spec` |
| `MenuAPI.close` | `player_id, opts` |
| `MenuAPI.close_all` | `player_id, opts` |
| `MenuAPI.is_open` | `player_id` |
| `MenuAPI.get_state` | `player_id` |
| `MenuAPI.get_stack` | `player_id` |
| `MenuAPI.refresh` | `player_id` |
| `MenuAPI.set_rows` | `player_id, rows, preserve_selection` |
| `MenuAPI.set_profile` | `player_id, profile` |
| `MenuAPI.set_title` | `player_id, title` |
| `MenuAPI.handle_cancel` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lock_player_input`, `unlock_player_input`, `play_sound_for_player`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `MENU_TYPES` | `{` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/sfx/screen_open.ogg` |
| `/server/assets/net-games/sfx/cursor_move.ogg` |
| `/server/assets/net-games/sfx/choose.ogg` |
| `/server/assets/net-games/sfx/cancel.ogg` |
| `/server/assets/ui/menuAPI/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
