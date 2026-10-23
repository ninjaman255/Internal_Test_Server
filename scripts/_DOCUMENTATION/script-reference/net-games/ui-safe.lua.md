# `net-games/ui-safe.lua`

> **Source reference**
>
> Generated from `net-games/ui-safe.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/net-games/ui-safe.lua Small hardened sprite helper for reusable net-games UI. Public coordinates are virtual 240x160 coordinates. Production lessons captured here: * arbitrary assets are checked before provide_asset_for_player when possible; * changing a texture/animation allocates a fresh physical sprite id to avoid stale client-side texture caching; * positions are pixel-snapped by default; * unchanged draws are not retransmitted; * all owned sprites are cleaned on disconnect.

## Module location

- **Source:** `net-games/ui-safe.lua`
- **Relative reference:** `script-reference/net-games/ui-safe.lua.md`

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `UISafe.asset_exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `UISafe.cleanup_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `UISafe.draw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `UISafe.erase` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `UISafe.invalidate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `UISafe.safe_provide` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `allocate_entry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `confirmed_missing` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `erase_entry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `player_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `same_draw` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `virtual_to_screen` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 164 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
