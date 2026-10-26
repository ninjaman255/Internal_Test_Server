# `utils/async.lua`

> **Source reference**
>
> Refreshed from the current `utils/async.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Async.lua Async/await and Promise utilities for Lua

## Module location

- **Source:** `utils/async.lua`
- **Reference:** `script-reference/utils/async.lua.md`
- **Source SHA-256 prefix:** `8026b72b2856`

## Source header notes

- Async.lua
- Async/await and Promise utilities for Lua

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Async.create_promise` | `executor` |
| `resolve` | `...` |
| `reject` | `error` |
| `promise:and_then` | `on_fulfilled, on_rejected` |
| `Async.promisify` | `coroutine_func` |
| `step` | `...` |
| `Async.await` | `promise_or_iterator` |
| `Async.run` | `main_function` |
| `Async.create_validator` | `expected_values, error_message` |

## Engine `Async` calls

`lua`, `create_promise`, `promisify`, `await`, `run`, `create_validator`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `PROMISE_STATE` | `{` |
| `PENDING` | `"pending",` |
| `FULFILLED` | `"fulfilled",` |
| `REJECTED` | `"rejected"` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
