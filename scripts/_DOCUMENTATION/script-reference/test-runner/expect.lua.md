# `test-runner/expect.lua`

> **Source reference**
>
> Generated from `test-runner/expect.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

expect.lua A minimal assertion library for use with the test runner. Example: local expect = require("scripts.test-runner.expect") return function() expect(2 + 2).toBe(4) expect({a = 1}).toEqual({a = 1}) expect(function() error("oops") end).toThrow() end

## Module location

- **Source:** `test-runner/expect.lua`
- **Relative reference:** `script-reference/test-runner/expect.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts.test-runner.expect` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `check` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `deep_equal` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `expect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fail` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `format` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `notToBe` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toBe` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toBeDefined` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toBeFalsy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toBeGreaterThan` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toBeLessThan` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toBeNil` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toBeTruthy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toEqual` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `toThrow` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 124 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
