# `net-game-tourney/tournament-core.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/tournament-core.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

tournament-core.lua

## Module location

- **Source:** `net-game-tourney/tournament-core.lua`
- **Reference:** `script-reference/net-game-tourney/tournament-core.lua.md`
- **Source SHA-256 prefix:** `a2c6587887a4`

## Source header notes

- tournament-core.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-game-tourney/tournament-state` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `shuffle_table` | `values` |
| `normalize_config` | `config` |
| `TournamentCore.create_tournament` | `config` |
| `TournamentCore.add_participant` | `tournament_id, participant` |
| `TournamentCore.initialize_tournament` | `tournament_id` |
| `TournamentCore.initialize_positions` | `tournament_id` |
| `TournamentCore.calculate_round_positions` | `tournament_id, round` |
| `TournamentCore.update_positions` | `tournament_id, round` |
| `TournamentCore.record_battle` | `tournament_id, round, match_index, winner_id, loser_id, battle_index` |
| `TournamentCore.record_battle_result` | `tournament_id, round, match_index, winner_id, loser_id` |
| `TournamentCore.get_npc_battle_result` | `tournament_id, round, match_index, npc1_id, npc2_id, battle_index` |
| `TournamentCore.is_round_complete` | `tournament_id, round` |
| `TournamentCore.advance_round` | `tournament_id` |
| `TournamentCore.complete_round` | `tournament_id` |
| `TournamentCore.get_winner` | `tournament_id` |
| `TournamentCore.add_spectator` | `tournament_id, player_id, name` |
| `TournamentCore.remove_spectator` | `tournament_id, player_id` |
| `TournamentCore.for_each_human_viewer` | `tournament_id, callback` |
| `TournamentCore.cleanup_tournament` | `tournament_id` |
| `TournamentCore.handle_player_disconnect` | `player_id` |
| `TournamentCore.cleanup_orphaned_tournaments` | `` |
| `TournamentCore.get_tournament` | `tournament_id` |
| `TournamentCore.get_player_tournament` | `player_id` |
| `TournamentCore.is_player_in_tournament` | `player_id` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
