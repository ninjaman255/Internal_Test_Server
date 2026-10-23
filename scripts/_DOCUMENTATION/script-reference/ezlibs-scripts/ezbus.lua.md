# `ezlibs-scripts/ezbus.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezbus.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezbus.lua - Named event-bus registry. Three usage modes are supported: 1. Named emitters (recommended for cross-script communication) local EzBus = require("scripts/ezlibs-scripts/ezbus") local round_bus = EzBus.get("footbomb:round:" .. instance_id) round_bus:emit("round_complete", { ... }) Any other script can call EzBus.get(name) to reach the SAME emitter. Call EzBus.destroy(name) when the consumer is finished (e.g. instance removal) so the entry does not leak. 2. Fresh per-use emitters (per-round, per-response, etc.) local round_events = EzBus.new() 3. Backward-compatible default emitter local EzBus = require("scripts/ezlibs-scripts/ezbus") EzBus:on("some_event", cb) EzBus:emit("some_even

## Module location

- **Source:** `ezlibs-scripts/ezbus.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezbus.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezemitter` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `round_complete` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `__index` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `__newindex` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbus.destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbus.destroy_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbus.exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbus.get` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbus.list` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 107 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
