# `net-games/ui-safe.lua`

> **Source reference**
>
> Refreshed from the current `net-games/ui-safe.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/ui-safe.lua Small hardened sprite helper for reusable net-games UI. Public coordinates are virtual 240x160 coordinates. Production lessons captured here: * arbitrary assets are checked before provide_asset_for_player when possible; * changing a texture/animation allocates a fresh physical sprite id to avoid stale client-side texture caching; * positions are pixel-snapped by default; * unchanged draws are not retransmitted; * all owned sprites are cleaned on disconnect.

## Module location

- **Source:** `net-games/ui-safe.lua`
- **Reference:** `script-reference/net-games/ui-safe.lua.md`
- **Source SHA-256 prefix:** `2271b874de22`

## Source header notes

- scripts/net-games/ui-safe.lua
- Small hardened sprite helper for reusable net-games UI.
- Public coordinates are virtual 240x160 coordinates.
- Production lessons captured here:
- * arbitrary assets are checked before provide_asset_for_player when possible;
- * changing a texture/animation allocates a fresh physical sprite id to avoid

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `player_state` | `player_id` |
| `confirmed_missing` | `path` |
| `UISafe.asset_exists` | `path` |
| `UISafe.safe_provide` | `player_id, path` |
| `same_draw` | `a, b` |
| `erase_entry` | `player_id, entry` |
| `allocate_entry` | `player_id, logical_id, texture_path, anim_path, anim_state` |
| `virtual_to_screen` | `v, pixel_snap` |
| `UISafe.draw` | `player_id, logical_id, texture_path, options` |
| `UISafe.erase` | `player_id, logical_id` |
| `UISafe.cleanup_player` | `player_id` |
| `UISafe.invalidate` | `player_id, logical_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`has_asset`, `provide_asset_for_player`, `player_erase_sprite`, `player_dealloc_sprite`, `player_alloc_sprite`, `player_draw_sprite`, `on`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
