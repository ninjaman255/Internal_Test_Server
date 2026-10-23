# `net-game-tourney/main.lua`

> **Source reference**
>
> Generated from `net-game-tourney/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

main.lua

## Module location

- **Source:** `net-game-tourney/main.lua`
- **Relative reference:** `script-reference/net-game-tourney/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/net-game-tourney/tournament-manager` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-ui` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `battle_results` | `Net:on(...)` subscription found in source. |
| `object_interaction` | `Net:on(...)` subscription found in source. |
| `player_area_transfer` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Source notes

- Approximate source size: 70 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
