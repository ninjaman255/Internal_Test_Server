# `net-games/npcs/prog_vert_prompt_lime.lua`

> **Source reference**
>
> Generated from `net-games/npcs/prog_vert_prompt_lime.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== prog_vert_prompt_lime.lua LIME variant of prog_vert_prompt_pink.lua. Key requirement: identical in-game flow, but implemented using Talk.lua + TalkVertMenu.lua (reusable wrapper). =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_lime.lua`
- **Relative reference:** `script-reference/net-games/npcs/prog_vert_prompt_lime.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/startup` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_presets` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_vert_menu` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `build_options` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_no` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_yes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `play_sfx` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `shallow_copy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`CONFIRM`, `DESC`, `DESC_CLOSE`

## Source notes

- Approximate source size: 171 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
