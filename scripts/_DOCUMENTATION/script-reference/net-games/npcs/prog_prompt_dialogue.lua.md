# `net-games/npcs/prog_prompt_dialogue.lua`

> **Source reference**
>
> Generated from `net-games/npcs/prog_prompt_dialogue.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== prog_prompt_dialogue_shared_box.lua Tiled-spawned NPC that shows a YES/NO prompt, then follows up with Dialogue.start, reusing the same textbox UI (no close/recreate). =====================================================

## Module location

- **Source:** `net-games/npcs/prog_prompt_dialogue.lua`
- **Relative reference:** `script-reference/net-games/npcs/prog_prompt_dialogue.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/dialogue` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `basic_prog_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `dbg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_cancel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_no` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_yes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `prog_ui_dialogue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `prog_ui_prompt` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 185 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
