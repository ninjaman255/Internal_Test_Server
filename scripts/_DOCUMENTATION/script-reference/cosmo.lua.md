# `cosmo.lua`

> **Source reference**
>
> Generated from `cosmo.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `cosmo.lua`
- **Relative reference:** `script-reference/cosmo.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/net-games/helpers/net-helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `disable_cosmetic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `enable_cosmetic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_enabled` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `log` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `spawn_cosmo_from_tiled` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 165 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
