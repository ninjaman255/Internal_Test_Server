# `camera/main.lua`

> **Source reference**
>
> Generated from `camera/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

main.lua (Entry Point)

## Module location

- **Source:** `camera/main.lua`
- **Relative reference:** `script-reference/camera/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/camera/camera-controller` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/camera/camera-manager` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/enum/predefined-enums` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_join` | `Net:on(...)` subscription found in source. |
| `tile_interaction` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `dbg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setupPlayerJoin` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setupTileInteraction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 105 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
