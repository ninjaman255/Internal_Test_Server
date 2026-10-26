# `ezlibs-scripts/ezbus.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezbus.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezbus.lua - Named event-bus registry. Three usage modes are supported: 1. Named emitters (recommended for cross-script communication) local EzBus = require("scripts/ezlibs-scripts/ezbus") local round_bus = EzBus.get("footbomb:round:" .. instance_id) round_bus:emit("round_complete", { ... }) Any other script can call EzBus.get(name) to reach the SAME emitter. Call EzBus.destroy(name) when the consumer is finished (e.g. instance removal) so the entry does not leak. 2. Fresh per-use emitters (per-round, per-response, etc.) local round_events = EzBus.new() 3. Backward-compatible default emitter local EzBus = require("scripts/ezlibs-scripts/ezbus") EzBus:on("some_event", cb) EzBus:emit("some_even

## Module location

- **Source:** `ezlibs-scripts/ezbus.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezbus.lua.md`
- **Source SHA-256 prefix:** `85aa9acf06e0`

## Source header notes

- ezbus.lua - Named event-bus registry.
- Three usage modes are supported:
- 1. Named emitters (recommended for cross-script communication)
- local EzBus = require("scripts/ezlibs-scripts/ezbus")
- local round_bus = EzBus.get("footbomb:round:" .. instance_id)
- round_bus:emit("round_complete", { ... })

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezemitter` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezbus.get` | `name` |
| `ezbus.destroy` | `name` |
| `ezbus.destroy_all` | `` |
| `ezbus.exists` | `name` |
| `ezbus.list` | `` |
| `__index` | `_, key` |
| `__newindex` | `_, key, value` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
