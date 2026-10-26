# `net-game-tourney/tournament-state.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/tournament-state.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

tournament-state.lua Central state store for all tournament data. All mutation of tournament state must go through this module.

## Module location

- **Source:** `net-game-tourney/tournament-state.lua`
- **Reference:** `script-reference/net-game-tourney/tournament-state.lua.md`
- **Source SHA-256 prefix:** `31693b878bb4`

## Source header notes

- tournament-state.lua
- Central state store for all tournament data.
- All mutation of tournament state must go through this module.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-game-tourney/tournament-npcs` |
| `scripts/net-game-tourney/ui-pos` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `State.create_tournament` | `config` |
| `State.get_tournament` | `id` |
| `State.delete_tournament` | `id` |
| `State.get_all_tournaments` | `` |
| `State.add_participant` | `tournament_id, participant_data` |
| `State.remove_player_from_tournament` | `player_id` |
| `State.get_player_tournament` | `player_id` |
| `State.is_player_in_tournament` | `player_id` |
| `State.record_battle` | `tournament_id, round, match_index, winner_id, loser_id, battle_index` |
| `State.record_battle_result` | `tournament_id, round, match_index, winner_id, loser_id` |
| `State.get_npc_battle_result` | `tournament_id, round, match_index, npc1_id, npc2_id, battle_index` |
| `State.is_round_complete` | `tournament_id, round` |
| `State.advance_round` | `tournament_id` |
| `State.get_winner` | `tournament_id` |
| `State.add_spectator` | `tournament_id, player_id, name` |
| `State.remove_spectator` | `tournament_id, player_id` |
| `State.initialize_positions` | `tournament_id` |
| `State.calculate_round_positions` | `tournament_id, round` |
| `State.update_positions` | `tournament_id, round` |
| `State.cleanup_orphaned_tournaments` | `max_age_seconds` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
