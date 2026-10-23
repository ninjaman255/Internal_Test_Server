# `test-runner/main.lua`

> **Source reference**
>
> Generated from `test-runner/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

test-runner.lua Simple test runner for scripts in "scripts/tests/". Usage: local runner = require("scripts.tests.test-runner")  -- adjust path as needed runner.run({"math_test", "string_test"})  -- run specific tests runner.run()                               -- run all tests found Each test file must return a function that performs the test. The function may return a boolean or simply error on failure.

## Module location

- **Source:** `test-runner/main.lua`
- **Relative reference:** `script-reference/test-runner/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts.tests.test-runner` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `list_test_files` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_test` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_test` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 116 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
