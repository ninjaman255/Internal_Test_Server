# `input-controller/main.lua`

> **Source reference**
>
> Generated from `input-controller/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

main.lua – Unified input API

## Module location

- **Source:** `input-controller/main.lua`
- **Relative reference:** `script-reference/input-controller/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/input-controller/buttons` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/d-pad` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/input-controller` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/utils/utility` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |
| `virtual_input` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `API.activate_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.create_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.deactivate_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.destroy_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.get_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.get_controller_class` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.get_controller_identity` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.reload_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.restore_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.set_controller_class` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.set_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `API.spawn_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `make_controller` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 192 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
