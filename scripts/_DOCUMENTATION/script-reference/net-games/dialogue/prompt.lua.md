# `net-games/dialogue/prompt.lua`

> **Source reference**
>
> Generated from `net-games/dialogue/prompt.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/net-games/dialogue/prompt.lua Hardened YES/NO prompt using the public TextLayout service.

## Module location

- **Source:** `net-games/dialogue/prompt.lua`
- **Relative reference:** `script-reference/net-games/dialogue/prompt.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-display` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-layout` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input/input` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Prompt.close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Prompt.yesno` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptInstance:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptInstance:render_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptInstance:render_initial` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PromptInstance:update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `build_prompt_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_backdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_backdrop_asset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_cursor_asset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_backdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_option_virtual_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `has_asset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mk_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `options_visible` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `play_cursor_move_sfx` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_provide` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `selector_draw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `selector_erase` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_input_locked` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 410 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
