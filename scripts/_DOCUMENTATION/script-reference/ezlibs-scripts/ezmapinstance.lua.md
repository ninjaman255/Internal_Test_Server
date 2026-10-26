# `ezlibs-scripts/ezmapinstance.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezmapinstance.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezmapinstance.lua Reusable map cloning, instance ownership, host/party metadata, and lifecycle. This module intentionally does not register Net event handlers. Call its API from a plugin or game module that owns the instance's gameplay behavior. Event surfaces (backed by ezemitter): EzMapInstance.events            -- global; every instance event, args begin with instance_id record.events / record:on(...)  -- per-instance; args omit instance_id Built-in lifecycle events (emitted on both surfaces): "created"             record: ()                        global: (instance_id) "removed"             record: ()                        global: (instance_id) "player_joined"       record: (player_id)

## Module location

- **Source:** `ezlibs-scripts/ezmapinstance.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezmapinstance.lua.md`
- **Source SHA-256 prefix:** `2535701b131d`

## Source header notes

- ezmapinstance.lua
- Reusable map cloning, instance ownership, host/party metadata, and lifecycle.
- This module intentionally does not register Net event handlers. Call its API
- from a plugin or game module that owns the instance's gameplay behavior.
- Event surfaces (backed by ezemitter):
- EzMapInstance.events            -- global; every instance event, args begin with instance_id

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `EzMapInstance.set_error_handler` | `handler` |
| `safe_emit` | `emitter, ...` |
| `emit_event` | `record, event, ...` |
| `valid_id` | `value` |
| `copy_array` | `values` |
| `area_id_is_listed` | `area_id` |
| `find_available_id` | `preferred_id` |
| `forget_player` | `instance_id, player_id` |
| `record_mt:on` | `event, callback` |
| `record_mt:once` | `event, callback` |
| `record_mt:on_any` | `callback` |
| `record_mt:on_any_once` | `callback` |
| `record_mt:off` | `event, callback` |
| `record_mt:off_any` | `callback` |
| `record_mt:emit` | `event, ...` |
| `record_mt:async_iter` | `event` |
| `record_mt:async_iter_all` | `` |
| `EzMapInstance.on` | `event, callback` |
| `EzMapInstance.once` | `event, callback` |
| `EzMapInstance.on_any` | `callback` |
| `EzMapInstance.on_any_once` | `callback` |
| `EzMapInstance.off` | `event, callback` |
| `EzMapInstance.off_any` | `callback` |
| `EzMapInstance.emit` | `event, ...` |
| `EzMapInstance.async_iter` | `event` |
| `EzMapInstance.async_iter_all` | `` |
| `EzMapInstance.create` | `base_area_id, preferred_instance_id, options` |
| `EzMapInstance.get` | `instance_id` |
| `EzMapInstance.get_for_player` | `player_id` |
| `EzMapInstance.list` | `` |
| `EzMapInstance.set_host` | `instance_id, player_id` |
| `EzMapInstance.get_host` | `instance_id` |
| `EzMapInstance.is_host` | `instance_id, player_id` |
| `EzMapInstance.register_player` | `instance_id, player_id` |
| `EzMapInstance.unregister_player` | `instance_id, player_id` |
| `EzMapInstance.transfer_player` | `instance_id, player_id, x, y, z, warp_in` |
| `EzMapInstance.remove` | `instance_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `clone_area`, `transfer_player`, `remove_area`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `CREATED` | `"created",` |
| `REMOVED` | `"removed",` |
| `PLAYER_JOINED` | `"player_joined",` |
| `PLAYER_LEFT` | `"player_left",` |
| `HOST_CHANGED` | `"host_changed",` |
| `PLAYER_TRANSFERRED` | `"player_transferred",` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
