# `net-games/dialogue/dialogue.lua`

> **Source reference**
>
> Generated from `net-games/dialogue/dialogue.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/net-games/dialogue/dialogue.lua Hardened net-games dialogue lifecycle. Keeps the creator-side Displayer architecture while preserving production behavior learned from shadis_hp: held-input handoff protection, real visual teardown before unlock/on_complete, BN-style A/B behavior, and textbox reuse.

## Module location

- **Source:** `net-games/dialogue/dialogue.lua`
- **Relative reference:** `script-reference/net-games/dialogue/dialogue.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-display` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input/input` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/prompt` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/prompt_vertical` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Dialogue.close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Dialogue.is_active` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Dialogue.prompt_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Dialogue.prompt_yesno` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Dialogue.start` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `attach_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `close_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `default_opts` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_backdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_backdrop_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_listener` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_backdrop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `finish_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `gate_handoff_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `merge` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mk_box_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_input_locked` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`LISTENER_ATTACHED`

## Source notes

- Approximate source size: 330 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
