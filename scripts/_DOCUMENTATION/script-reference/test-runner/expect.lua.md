# `test-runner/expect.lua`

> **Source reference**
>
> Refreshed from the current `test-runner/expect.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

expect.lua A minimal assertion library for use with the test runner. Example: local expect = require("scripts.test-runner.expect") return function() expect(2 + 2).toBe(4) expect({a = 1}).toEqual({a = 1}) expect(function() error("oops") end).toThrow() end

## Module location

- **Source:** `test-runner/expect.lua`
- **Reference:** `script-reference/test-runner/expect.lua.md`
- **Source SHA-256 prefix:** `374fd6fde944`

## Source header notes

- expect.lua
- A minimal assertion library for use with the test runner.
- Example:
- local expect = require("scripts.test-runner.expect")
- return function()
- expect(2 + 2).toBe(4)

## Direct `require` dependencies

| Import path |
|---|
| `scripts.test-runner.expect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `deep_equal` | `a, b` |
| `check` | `x, y` |
| `format` | `v` |
| `expect` | `actual` |
| `fail` | `msg` |
| `toBe` | `expected` |
| `toEqual` | `expected` |
| `toBeTruthy` | `` |
| `toBeFalsy` | `` |
| `toBeNil` | `` |
| `toBeDefined` | `` |
| `toBeGreaterThan` | `n` |
| `toBeLessThan` | `n` |
| `toThrow` | `expected_msg` |
| `notToBe` | `expected` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
