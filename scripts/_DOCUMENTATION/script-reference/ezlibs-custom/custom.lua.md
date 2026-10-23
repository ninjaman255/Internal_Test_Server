# `ezlibs-custom/custom.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/custom.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Custom plugin aggregator. Keep custom gameplay modules here so ezlibs' main dispatcher can fan out event callbacks to each module without duplicate Net:on subscriptions.

## Module location

- **Source:** `ezlibs-custom/custom.lua`
- **Relative reference:** `script-reference/ezlibs-custom/custom.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-custom/footbomb/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `dispatch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 53 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
