# `net-game-tourney/tournament-state.lua`

> **Source reference**
>
> Generated from `net-game-tourney/tournament-state.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

tournament-state.lua Central state store for all tournament data. All mutation of tournament state must go through this module.

## Module location

- **Source:** `net-game-tourney/tournament-state.lua`
- **Relative reference:** `script-reference/net-game-tourney/tournament-state.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/net-game-tourney/tournament-npcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/ui-pos` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `State.add_participant` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.add_spectator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.advance_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.calculate_round_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.cleanup_orphaned_tournaments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.create_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.delete_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.get_all_tournaments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.get_npc_battle_result` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.get_player_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.get_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.get_winner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.initialize_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.is_player_in_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.is_round_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.record_battle` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.record_battle_result` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.remove_player_from_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.remove_spectator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `State.update_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 507 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
