# `net-game-tourney/tournament-core.lua`

> **Source reference**
>
> Generated from `net-game-tourney/tournament-core.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

tournament-core.lua

## Module location

- **Source:** `net-game-tourney/tournament-core.lua`
- **Relative reference:** `script-reference/net-game-tourney/tournament-core.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/net-game-tourney/tournament-state` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `TournamentCore.add_participant` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.add_spectator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.advance_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.calculate_round_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.cleanup_orphaned_tournaments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.cleanup_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.complete_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.create_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.for_each_human_viewer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.get_npc_battle_result` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.get_player_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.get_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.get_winner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.initialize_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.initialize_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.is_player_in_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.is_round_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.record_battle` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.record_battle_result` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.remove_spectator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentCore.update_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_config` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `shuffle_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 204 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
