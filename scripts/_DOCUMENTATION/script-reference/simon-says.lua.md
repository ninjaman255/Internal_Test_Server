# `simon-says.lua`

> **Source reference**
>
> Generated from `simon-says.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `simon-says.lua`
- **Relative reference:** `script-reference/simon-says.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/persistence/logger` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |
| `countdown_ended` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `virtual_input` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `end_game_cleanup` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `greet_simon` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_simon_button` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `jiggle` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `removeValue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `simon_says_press` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `spawn_simon` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 441 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
