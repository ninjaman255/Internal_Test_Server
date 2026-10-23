# `ezlibs-scripts/eznpcs/dialogue_types.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/eznpcs/dialogue_types.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/eznpcs/dialogue_types.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/eznpcs/dialogue_types.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/condition` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezemail` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezencounters/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezexplosions` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezquests` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/eztiledutils` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `battle_results` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `quest_event` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `action` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_ext` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `has_asset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `merge_result_fields` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `now` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `player_won_from_stats` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_anim` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_texture` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 651 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
