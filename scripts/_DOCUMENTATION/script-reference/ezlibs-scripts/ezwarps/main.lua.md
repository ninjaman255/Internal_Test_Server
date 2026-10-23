# `ezlibs-scripts/ezwarps/main.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezwarps/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezwarps/main.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezwarps/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcache` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezpress` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/arrow_animation_factory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/fall_in_animation` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/fall_off_2` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/lev_beast_in_animation` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/lev_beast_out_animation` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/log_in_animation` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/json` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `warp` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `add_custom_warp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_interact_warp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_landing` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_radius_warp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `doAnimationForWarp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezwarps.handle_custom_warp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezwarps.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezwarps.handle_player_request` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezwarps.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezwarps.player_is_in_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `log` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `prepare_player_arrival` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `process_warp_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `property_is_true` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `table_has_value` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `use_warp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 339 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
