# `ezlibs-scripts/ezemitter.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezemitter.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

EventEmitter.lua A flexible event system with async capabilities. Design notes: * emit() snapshots callback lists before iterating, so listeners may safely add/remove other listeners during a call. * once-listeners are cleared BEFORE invocation, so a re-emitted event from inside a once-handler does not fire it twice. * Every callback is isolated with pcall when an error handler is installed; by default errors propagate (previous behavior). Install a handler with `set_error_handler(fn)` for non-fatal diagnostics. * async_iter / async_iter_all return (next_fn, close_fn). Calling close_fn tears down the listener and wakes any pending waiter.

## Module location

- **Source:** `ezlibs-scripts/ezemitter.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezemitter.lua.md`

## Functions defined in this file

| Function | Notes |
|---|---|
| `EventEmitter.new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:_call` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:async_iter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:async_iter_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:emit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:has_listeners` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:listener_count` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:on` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:on_any` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:on_any_once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:remove_all_listeners` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:remove_listener` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:remove_on_any_listener` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `EventEmitter:set_error_handler` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `close_fn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `iterator_next` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `make_iterator_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_any` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `prune` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `snapshot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 337 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
