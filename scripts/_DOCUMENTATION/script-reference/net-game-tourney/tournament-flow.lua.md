# `net-game-tourney/tournament-flow.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/tournament-flow.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

tournament-flow.lua

## Module location

- **Source:** `net-game-tourney/tournament-flow.lua`
- **Reference:** `script-reference/net-game-tourney/tournament-flow.lua.md`
- **Source SHA-256 prefix:** `83e2d3961f0d`

## Source header notes

- tournament-flow.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-game-tourney/tournament-constants` |
| `scripts/net-game-tourney/tournament-core` |
| `scripts/net-game-tourney/tournament-ui` |
| `scripts/net-game-tourney/tournament-state` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `for_each_viewer` | `tournament, callback` |
| `viewer_is_in_active_match` | `tournament, player_id` |
| `participant_for_player` | `tournament, player_id` |
| `open_board_for_player` | `player_id, tournament` |
| `TournamentFlow.close_board_for_player` | `player_id, keep_locked` |
| `TournamentFlow.show_board_to_all` | `tournament_id` |
| `TournamentFlow.hide_board_from_all` | `tournament_id, keep_locked` |
| `close_live_boards_for_tournament` | `tournament_id` |
| `message_viewers` | `tournament, message` |
| `round_key` | `round` |
| `await_with_timeout` | `promise, timeout_seconds` |
| `enemy_survived` | `stats` |
| `stats_says_player_won_encounter` | `stats` |
| `get_hp_state` | `player_id` |
| `restore_hp` | `player_id, state` |
| `force_pvp_hp` | `player_id` |
| `tournament_should_force_pvp_hp` | `tournament` |
| `wait_until_players_ready` | `player_ids` |
| `close_board_if_open` | `player_id` |
| `run_player_vs_player` | `tournament, match` |
| `cleanup` | `` |
| `run_player_vs_npc` | `tournament, player, npc` |
| `TournamentFlow.resolve_npc_battle` | `tournament_id, round, match_index, match` |
| `TournamentFlow.start_player_battle` | `tournament_id, round, match_index, match` |
| `match_should_show_battle_progress` | `match, tournament` |
| `TournamentFlow.run_round_battles` | `tournament_id, round` |
| `current_viewer_jobs` | `tournament, fn` |
| `TournamentFlow.squash_winner_before_move` | `tournament_id, round, match_index` |
| `TournamentFlow.unsquash_winner_after_move` | `tournament_id, round, match_index` |
| `TournamentFlow.greyscale_specific_loser` | `tournament_id, round, match_index` |
| `TournamentFlow.move_winner_for_match` | `tournament_id, round, match_index` |
| `TournamentFlow.spawn_progress_bar_for_match` | `tournament_id, round, match_index` |
| `TournamentFlow.remove_progress_bar_overlays` | `overlays` |
| `TournamentFlow.process_round_one_by_one` | `tournament_id, round` |
| `TournamentFlow.announce_champion` | `tournament_id` |
| `TournamentFlow.run_tournament` | `tournament_id` |
| `TournamentFlow.handle_player_disconnect` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`is_player`, `get_player_area`, `lock_player_input`, `toggle_player_hud`, `unlock_player_input`, `message_player`, `get_player_max_health`, `get_player_health`, `set_player_max_health`, `set_player_health`, `get_area_custom_property`, `is_player_battling`, `play_sound_for_player`

## Engine `Async` calls

`promisify`, `await`, `sleep`, `initiate_pvp`, `initiate_encounter`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `BATTLE_TIMEOUT_SECONDS` | `10 * 60` |
| `TOURNAMENT_PVP_HP` | `1000` |
| `FADE_SECONDS` | `0.3` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/tourney/sfx/mug-bleep.ogg` |
| `/server/assets/tourney/sfx/bar-move.ogg` |
| `/server/assets/tourney/sfx/cheer.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
