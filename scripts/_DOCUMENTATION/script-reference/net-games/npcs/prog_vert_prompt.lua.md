# `net-games/npcs/prog_vert_prompt.lua`

> **Source reference**
>
> Generated from `net-games/npcs/prog_vert_prompt.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== prog_vert_prompt.lua Vertical prompt demo PROG (basic style, like prog_basic_nameplate) Adds: - Mugshot support in the vertical prompt UI - Mugshot support in the follow-up Dialogue (reuse_existing_box) =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt.lua`
- **Relative reference:** `script-reference/net-games/npcs/prog_vert_prompt.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/prompt_vertical` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/startup` | Import string found in source; runtime resolution depends on the server package layout. |

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
| `on_select` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 227 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
