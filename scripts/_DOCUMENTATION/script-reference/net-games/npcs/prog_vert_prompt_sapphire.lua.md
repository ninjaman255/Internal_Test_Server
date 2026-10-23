# `net-games/npcs/prog_vert_prompt_sapphire.lua`

> **Source reference**
>
> Generated from `net-games/npcs/prog_vert_prompt_sapphire.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== prog_vert_prompt_sapphire.lua Flow: Interact -> YES/NO prompt: "Do you wanna check out the vertical menu?" YES -> SAME textbox becomes: "Awesome. Let me know if there's anything that you like." Vertical menu opens while that line prints, and menu control unlocks after printing finishes. NO -> short line (same textbox) Assumes prompt_vertical.lua supports reuse_existing_box reset. =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_sapphire.lua`
- **Relative reference:** `script-reference/net-games/npcs/prog_vert_prompt_sapphire.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/prompt` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/prompt_vertical` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/startup` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_presets` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `build_layout_config` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `build_options` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `build_ui_config` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_frame_preset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_no` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_select` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_yes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_vertical_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 255 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
