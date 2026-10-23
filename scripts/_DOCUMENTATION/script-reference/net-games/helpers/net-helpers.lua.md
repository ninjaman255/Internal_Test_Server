# `net-games/helpers/net-helpers.lua`

> **Source reference**
>
> Generated from `net-games/helpers/net-helpers.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

===================================================== scripts/net-games/helpers/net-helpers.lua EZLIBS compatibility helpers for net-games Adds: Net:create_timer(seconds, callback) -> handle handle:cancel() Why: EZLIBS ships timer helpers; base net-games typically doesn't. We implement it in the net-games style: driven by Net:on("tick"). =====================================================

## Module location

- **Source:** `net-games/helpers/net-helpers.lua`
- **Relative reference:** `script-reference/net-games/helpers/net-helpers.lua.md`

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `NetHelpers.create_timer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `NetHelpers.patch_net` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `NetHelpers.safe_require` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `attach_tick_listener` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `handle:cancel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`ATTACHED`, `NEXT_ID`

## Source notes

- Approximate source size: 106 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
