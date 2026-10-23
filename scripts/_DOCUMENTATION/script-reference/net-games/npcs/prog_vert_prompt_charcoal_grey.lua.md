# `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`

> **Source reference**
>
> Generated from `net-games/npcs/prog_vert_prompt_charcoal_grey.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== prog_vert_prompt_charcoal_grey.lua New NPC that mirrors Lime/Pink vertical menu flow, but uses the new helpers: - npc_api.lua (bind interaction + guards + face + sfx) - menu_options.lua (count/list -> options table) =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`
- **Relative reference:** `script-reference/net-games/npcs/prog_vert_prompt_charcoal_grey.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/menu_options` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/npc_api` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_presets` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_vert_menu` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `on_no` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_yes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`CONFIRM`, `DESC`, `DESC_CLOSE`

## Source notes

- Approximate source size: 150 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
