# `net-games/npcs/talk.lua`

> **Source reference**
>
> Generated from `net-games/npcs/talk.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== talk.lua Minimal author API for Dialogue NPCs with PROG-default UI =====================================================

## Module location

- **Source:** `net-games/npcs/talk.lua`
- **Relative reference:** `script-reference/net-games/npcs/talk.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/menu_options` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_presets` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/talk_vert_menu` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Talk._build_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Talk.npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Talk.prompt_then_talk` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Talk.prompt_yesno` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Talk.start` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Talk.vert_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `build_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `deep_merge` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `force_indicator_on` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_pack_from_cfg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_talk_vert_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `infer_exit_index` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_script` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_cancel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_no` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_yes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `pick_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_flow` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_options` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_sfx` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `shallow_copy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `stable_box_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 579 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
