# `net-game-tourney/tournament-manager.lua`

> **Source reference**
>
> Generated from `net-game-tourney/tournament-manager.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

tournament-manager.lua

## Module location

- **Source:** `net-game-tourney/tournament-manager.lua`
- **Relative reference:** `script-reference/net-game-tourney/tournament-manager.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/net-game-tourney/tournament-core` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-flow` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-npcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-state` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-ui` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `TournamentManager.cleanup_expired_queues` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.cleanup_orphaned_tournaments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.configure` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.get_queue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.handle_battle_result` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.handle_board_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.handle_player_area_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentManager.scan_tournament_boards` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_player_to_queue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_waiting_spectator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_board_properties` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `board_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clamp_int` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_tournament_from_queue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `done` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `finish_queue_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `format_duration` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_or_create_queue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_queue_schedule_period` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_queue_schedule_times` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `grant_winner_rewards` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_scheduled_based` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `message_queue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `prune_busy_queue_participants` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `queue_player_index` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `queue_summary` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_player_from_queue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_waiting_spectator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_scheduled_start` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `scan_tournament_boards` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `seconds_until_next_scheduled_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `should_auto_start_on_full` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `spectate_active_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `start_queue_tournament` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `to_bool_or` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `tournament.config.on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `tournament_registration_is_open` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_scheduler` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 948 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
