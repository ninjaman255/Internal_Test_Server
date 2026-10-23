# `net-game-tourney/tournament-flow.lua`

> **Source reference**
>
> Generated from `net-game-tourney/tournament-flow.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

tournament-flow.lua

## Module location

- **Source:** `net-game-tourney/tournament-flow.lua`
- **Relative reference:** `script-reference/net-game-tourney/tournament-flow.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/net-game-tourney/tournament-constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-core` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-state` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-ui` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `TournamentFlow.announce_champion` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.close_board_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.greyscale_specific_loser` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.hide_board_from_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.move_winner_for_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.process_round_one_by_one` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.remove_progress_bar_overlays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.resolve_npc_battle` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.run_round_battles` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.run_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.show_board_to_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.spawn_progress_bar_for_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.squash_winner_before_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.start_player_battle` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentFlow.unsquash_winner_after_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await_with_timeout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cleanup` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `close_board_if_open` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `close_live_boards_for_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `current_viewer_jobs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `enemy_survived` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `for_each_viewer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `force_pvp_hp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_hp_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `match_should_show_battle_progress` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `message_viewers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_board_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `participant_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `restore_hp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `round_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_player_vs_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_player_vs_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `stats_says_player_won_encounter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `tournament_should_force_pvp_hp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `viewer_is_in_active_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `wait_until_players_ready` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 1007 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
