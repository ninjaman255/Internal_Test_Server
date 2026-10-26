# `run-tests.lua`

> **Source reference**
>
> Refreshed from the current `run-tests.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Name of files to run. These should be the file name (without the extension) The scripts in the test_list must be located in "scripts/test-runner/tests/"

## Module location

- **Source:** `run-tests.lua`
- **Reference:** `script-reference/run-tests.lua.md`
- **Source SHA-256 prefix:** `716e7fc5252f`

## Source header notes

- Name of files to run. These should be the file name (without the extension)
- The scripts in the test_list must be located in "scripts/test-runner/tests/"

## Direct `require` dependencies

| Import path |
|---|
| `scripts/test-runner/main` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
