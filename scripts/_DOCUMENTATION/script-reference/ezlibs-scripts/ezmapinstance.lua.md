# `ezlibs-scripts/ezmapinstance.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezmapinstance.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezmapinstance.lua Reusable map cloning, instance ownership, host/party metadata, and lifecycle. This module intentionally does not register Net event handlers. Call its API from a plugin or game module that owns the instance's gameplay behavior. Event surfaces (backed by ezemitter): EzMapInstance.events            -- global; every instance event, args begin with instance_id record.events / record:on(...)  -- per-instance; args omit instance_id Built-in lifecycle events (emitted on both surfaces): "created"             record: ()                        global: (instance_id) "removed"             record: ()                        global: (instance_id) "player_joined"       record: (player_id) 

## Module location

- **Source:** `ezlibs-scripts/ezmapinstance.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezmapinstance.lua.md`

## Functions defined in this file

| Function | Notes |
|---|---|
| `EzMapInstance.async_iter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.async_iter_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.create` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.emit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.get` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.get_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.get_host` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.is_host` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.list` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.off` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.off_any` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.on` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.on_any` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.on_any_once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.register_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.remove` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.set_error_handler` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.set_host` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.transfer_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EzMapInstance.unregister_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `area_id_is_listed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_array` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emit_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `error_handler` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_available_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `forget_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:async_iter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:async_iter_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:emit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:off` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:off_any` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:on` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:on_any` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:on_any_once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `record_mt:once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_emit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `valid_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`CREATED`, `HOST_CHANGED`, `PLAYER_JOINED`, `PLAYER_LEFT`, `PLAYER_TRANSFERRED`, `REMOVED`

## Source notes

- Approximate source size: 493 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
