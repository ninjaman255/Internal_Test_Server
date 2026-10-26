# `test-runner/main.lua`

> **Source reference**
>
> Refreshed from the current `test-runner/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

test-runner.lua Simple test runner for scripts in "scripts/tests/". Usage: local runner = require("scripts.tests.test-runner")  -- adjust path as needed runner.run({"math_test", "string_test"})  -- run specific tests runner.run()                               -- run all tests found Each test file must return a function that performs the test. The function may return a boolean or simply error on failure.

## Module location

- **Source:** `test-runner/main.lua`
- **Reference:** `script-reference/test-runner/main.lua.md`
- **Source SHA-256 prefix:** `a8e034f52eba`

## Source header notes

- test-runner.lua
- Simple test runner for scripts in "scripts/tests/".
- Usage:
- local runner = require("scripts.tests.test-runner")  -- adjust path as needed
- runner.run({"math_test", "string_test"})  -- run specific tests
- runner.run()                               -- run all tests found

## Direct `require` dependencies

| Import path |
|---|
| `scripts.tests.test-runner` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `list_test_files` | `` |
| `load_test` | `name` |
| `run_test` | `name` |
| `run` | `test_list` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `TEST_DIR` | `"scripts/test-runner/tests/"` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
