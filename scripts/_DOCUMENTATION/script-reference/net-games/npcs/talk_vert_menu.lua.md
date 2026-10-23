# `net-games/npcs/talk_vert_menu.lua`

> **Source reference**
>
> Generated from `net-games/npcs/talk_vert_menu.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== talk_vert_menu.lua Talk-mode wrapper for PromptVertical =====================================================

## Module location

- **Source:** `net-games/npcs/talk_vert_menu.lua`
- **Relative reference:** `script-reference/net-games/npcs/talk_vert_menu.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input/input` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/prompt` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/prompt_vertical` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_presets` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `TalkVertMenu.is_busy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TalkVertMenu.open` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_default_layout_frame` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `do_post_text_then_ack` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_choose` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_no` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_yes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `play_sfx` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_frame` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_menu_locked` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_textbox_indicator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`TICK_ATTACHED`

## Source notes

- Approximate source size: 409 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
