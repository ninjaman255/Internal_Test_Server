# `displayer/nameplate.lua`

> **Source reference**
>
> Generated from `displayer/nameplate.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/nameplate.lua`
- **Relative reference:** `script-reference/displayer/nameplate.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-engine` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Nameplate:_redraw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:attach` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:begin_close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:cleanupPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:ensureAssets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:erase` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:setTextAPI` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Nameplate:update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ceil_div` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 623 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
