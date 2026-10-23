# `net-games/npcs/prog_basic_freedraw.lua`

> **Source reference**
>
> Generated from `net-games/npcs/prog_basic_freedraw.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== prog_basic_freedraw.lua Tiled-spawned NPC that draws ALL available fonts on screen WITHOUT using Dialogue / textbox pipeline. =====================================================

## Module location

- **Source:** `net-games/npcs/prog_basic_freedraw.lua`
- **Relative reference:** `script-reference/net-games/npcs/prog_basic_freedraw.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/libs/direction` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `dbg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `display_id_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `show` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 128 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
