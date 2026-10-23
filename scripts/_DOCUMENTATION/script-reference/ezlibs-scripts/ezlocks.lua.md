# `ezlibs-scripts/ezlocks.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezlocks.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezlocks.lua - Reusable lock/unlock behaviors

## Module location

- **Source:** `ezlibs-scripts/ezlocks.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezlocks.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `lock_attempt` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `ezlocks.check_item` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezlocks.check_money` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezlocks.check_password` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 65 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
