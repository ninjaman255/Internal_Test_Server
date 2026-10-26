# `ezlibs-scripts/ezemitter.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezemitter.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

EventEmitter.lua A flexible event system with async capabilities. Design notes: * emit() snapshots callback lists before iterating, so listeners may safely add/remove other listeners during a call. * once-listeners are cleared BEFORE invocation, so a re-emitted event from inside a once-handler does not fire it twice. * Every callback is isolated with pcall when an error handler is installed; by default errors propagate (previous behavior). Install a handler with `set_error_handler(fn)` for non-fatal diagnostics. * async_iter / async_iter_all return (next_fn, close_fn). Calling close_fn tears down the listener and wakes any pending waiter.

## Module location

- **Source:** `ezlibs-scripts/ezemitter.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezemitter.lua.md`
- **Source SHA-256 prefix:** `21cd7063ac00`

## Source header notes

- EventEmitter.lua
- A flexible event system with async capabilities.
- Design notes:
- * emit() snapshots callback lists before iterating, so listeners may
- safely add/remove other listeners during a call.
- * once-listeners are cleared BEFORE invocation, so a re-emitted event

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `EventEmitter.new` | `` |
| `EventEmitter:set_error_handler` | `fn` |
| `EventEmitter:_call` | `callback, ...` |
| `EventEmitter:on` | `event, callback` |
| `EventEmitter:once` | `event, callback` |
| `EventEmitter:on_any` | `callback` |
| `EventEmitter:on_any_once` | `callback` |
| `snapshot` | `list` |
| `EventEmitter:emit` | `event, ...` |
| `EventEmitter:remove_listener` | `event, callback` |
| `prune` | `list` |
| `EventEmitter:remove_on_any_listener` | `callback` |
| `EventEmitter:remove_all_listeners` | `event` |
| `EventEmitter:has_listeners` | `event` |
| `EventEmitter:listener_count` | `event` |
| `make_iterator_state` | `` |
| `iterator_next` | `state` |
| `EventEmitter:async_iter` | `event` |
| `on_event` | `...` |
| `close_fn` | `` |
| `EventEmitter:async_iter_all` | `` |
| `on_any` | `event, ...` |
| `EventEmitter:destroy` | `` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
