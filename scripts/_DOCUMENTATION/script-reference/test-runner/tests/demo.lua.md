# `test-runner/tests/demo.lua`

> **Source reference**
>
> Generated from `test-runner/tests/demo.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `test-runner/tests/demo.lua`
- **Relative reference:** `script-reference/test-runner/tests/demo.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-engine` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/animation-engine/animation-sequences` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/dialogue/startup` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/helpers/net-helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_banner_dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_basic_dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_basic_freedraw` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_basic_nameplate` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_dramatic_dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_dyed_dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_prompt_dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_shop` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_talk_colors` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_talk_dialogue` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt_2` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt_charcoal_grey` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt_emerald` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt_lime` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt_pink` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt_red` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/npcs/prog_vert_prompt_sapphire` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |
| `cursor_selection` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `virtual_input` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `spawn_demo_npcs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 354 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
