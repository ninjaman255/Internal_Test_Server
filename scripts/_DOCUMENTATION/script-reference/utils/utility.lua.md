# `utils/utility.lua`

> **Source reference**
>
> Refreshed from the current `utils/utility.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Net.lua Main module that integrates EventEmitter and Async

## Module location

- **Source:** `utils/utility.lua`
- **Reference:** `script-reference/utils/utility.lua.md`
- **Source SHA-256 prefix:** `ce404ee9ee90`

## Source header notes

- Net.lua
- Main module that integrates EventEmitter and Async

## Direct `require` dependencies

| Import path |
|---|
| `scripts/utils/event-emitter` |
| `scripts/utils/async` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Utility.create_event_test` | `` |
| `start_listening` | `` |
| `Utility.resolve_multi` | `...` |
| `Utility.event_to_promise` | `emitter, event_name` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lua`, `EventEmitter`

## Engine `Async` calls

`create_promise`, `promisify`, `await`, `run`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
