# `utils/event-emitter.lua`

> **Source reference**
>
> Refreshed from the current `utils/event-emitter.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

EventEmitter.lua A flexible event system with async capabilities

## Module location

- **Source:** `utils/event-emitter.lua`
- **Reference:** `script-reference/utils/event-emitter.lua.md`
- **Source SHA-256 prefix:** `bbc33f26ed32`

## Source header notes

- EventEmitter.lua
- A flexible event system with async capabilities

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `EventEmitter.new` | `` |
| `EventEmitter:on` | `event, callback` |
| `EventEmitter:once` | `event, callback` |
| `EventEmitter:on_any` | `callback` |
| `EventEmitter:on_any_once` | `callback` |
| `EventEmitter:emit` | `event, ...` |
| `EventEmitter:remove_listener` | `event, callback` |
| `EventEmitter:remove_on_any_listener` | `callback` |
| `EventEmitter:async_iter` | `event` |
| `on_event` | `...` |
| `EventEmitter:async_iter_all` | `` |
| `on_any` | `event, ...` |
| `EventEmitter:_notify_iterators` | `event, ...` |
| `EventEmitter:destroy` | `` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
