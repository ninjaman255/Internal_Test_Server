# `net-games/dialogue/prompt.lua`

> **Source reference**
>
> Refreshed from the current `net-games/dialogue/prompt.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/dialogue/prompt.lua Hardened YES/NO prompt using the public TextLayout service.

## Module location

- **Source:** `net-games/dialogue/prompt.lua`
- **Reference:** `script-reference/net-games/dialogue/prompt.lua.md`
- **Source SHA-256 prefix:** `28ab08eb068a`

## Source header notes

- scripts/net-games/dialogue/prompt.lua
- Hardened YES/NO prompt using the public TextLayout service.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/displayer` |
| `scripts/displayer/text-layout` |
| `scripts/displayer/text-display` |
| `scripts/input/input` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `has_asset` | `path` |
| `safe_provide` | `player_id, path` |
| `play_cursor_move_sfx` | `player_id` |
| `ensure_backdrop_asset` | `player_id` |
| `draw_backdrop` | `player_id, backdrop, z` |
| `erase_backdrop` | `player_id` |
| `ensure_cursor_asset` | `player_id` |
| `selector_draw` | `player_id, draw_id, virtual_x, virtual_y, z, scale` |
| `selector_erase` | `player_id, draw_id` |
| `normalize_ui` | `ui` |
| `build_prompt_text` | `question, ui` |
| `options_visible` | `player_id, box_id` |
| `find_option_virtual_positions` | `player_id, box_id, selection` |
| `set_input_locked` | `player_id, locked` |
| `mk_id` | `player_id` |
| `PromptInstance:new` | `player_id, opts` |
| `PromptInstance:render_initial` | `` |
| `PromptInstance:render_cursor` | `` |
| `PromptInstance:update` | `dt` |
| `ensure_tick` | `` |
| `Prompt.yesno` | `player_id, opts` |
| `Prompt.close` | `player_id, _reason, opts` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`has_asset`, `provide_asset_for_player`, `play_sound_for_player`, `play_sound`, `player_alloc_sprite`, `player_draw_sprite`, `player_erase_sprite`, `lock_player_input`, `unlock_player_input`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `CURSOR_TEXTURE` | `"/server/assets/net-games/cursors/text_cursor.png"` |
| `CURSOR_ANIM` | `"/server/assets/net-games/cursors/text_cursor.animation"` |
| `CURSOR_MOVE_SFX_PATH` | `"/server/assets/net-games/sfx/cursor_move.ogg"` |
| `BACKDROP_TEXTURE` | `"/server/assets/net-games/displayer/empty_white.png"` |
| `OPTIONS_INDENT` | `"       "` |
| `OPTIONS_TEXT` | `OPTIONS_INDENT .. "Yes    No"` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/cursors/text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |
| `/server/assets/net-games/sfx/cursor_move.ogg` |
| `/server/assets/net-games/displayer/empty_white.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
