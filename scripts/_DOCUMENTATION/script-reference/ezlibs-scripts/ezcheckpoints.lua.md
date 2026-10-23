# `ezlibs-scripts/ezcheckpoints.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezcheckpoints.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezcheckpoints.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezcheckpoints.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/condition` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/eztiledutils` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `object_interaction` | `Net:on(...)` subscription found in source. |
| `player_avatar_change` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `checkpoint_unlocked` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `evaluate_navi_check` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.force_unlock_checkpoint` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.get_player_navi_info` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.player_has_any_navi` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.player_has_navi` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.player_has_navi_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.relock_checkpoint` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcheckpoints.unlock_checkpoint_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_player_alive` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `names_equal` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_net` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 491 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
