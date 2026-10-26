# `net-game-tourney/tournament-manager.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/tournament-manager.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

tournament-manager.lua

## Module location

- **Source:** `net-game-tourney/tournament-manager.lua`
- **Reference:** `script-reference/net-game-tourney/tournament-manager.lua.md`
- **Source SHA-256 prefix:** `342cc979c26c`

## Source header notes

- tournament-manager.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-game-tourney/tournament-core` |
| `scripts/net-game-tourney/tournament-flow` |
| `scripts/net-game-tourney/tournament-ui` |
| `scripts/net-game-tourney/tournament-npcs` |
| `scripts/net-game-tourney/tournament-state` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `board_key` | `area_id, object_id` |
| `to_bool_or` | `value, fallback` |
| `clamp_int` | `value, fallback, min_value, max_value` |
| `is_scheduled_based` | `board_type` |
| `should_auto_start_on_full` | `board_type` |
| `apply_board_properties` | `queue, object` |
| `get_or_create_queue` | `area_id, object_id, object` |
| `get_queue_schedule_period` | `queue` |
| `get_queue_schedule_times` | `queue, now` |
| `seconds_until_next_scheduled_tournament` | `queue` |
| `tournament_registration_is_open` | `queue` |
| `format_duration` | `seconds` |
| `queue_player_index` | `queue, player_id` |
| `remove_player_from_queue` | `player_id, quiet` |
| `remove_waiting_spectator` | `player_id, quiet` |
| `prune_busy_queue_participants` | `queue` |
| `message_queue` | `queue, message` |
| `queue_summary` | `queue` |
| `grant_winner_rewards` | `tournament, champion` |
| `finish_queue_tournament` | `queue_key, tournament_id, champion, error_reason` |
| `create_tournament_from_queue` | `queue, automatic` |
| `start_queue_tournament` | `queue, automatic` |
| `add_player_to_queue` | `queue, player_id` |
| `add_waiting_spectator` | `queue, player_id` |
| `run_scheduled_start` | `queue` |
| `update_scheduler` | `` |
| `scan_tournament_boards` | `` |
| `spectate_active_tournament` | `queue, player_id` |
| `TournamentManager.handle_board_interaction` | `player_id, board_object, area_id` |
| `done` | `` |
| `TournamentManager.handle_player_disconnect` | `player_id` |
| `TournamentManager.handle_player_area_transfer` | `player_id` |
| `TournamentManager.cleanup_orphaned_tournaments` | `` |
| `TournamentManager.cleanup_expired_queues` | `` |
| `TournamentManager.handle_battle_result` | `player_id, battle_data` |
| `TournamentManager.configure` | `values` |
| `TournamentManager.scan_tournament_boards` | `` |
| `TournamentManager.get_queue` | `area_id, object_id` |
| `TournamentManager.init` | `` |
| `tournament.config.on_complete` | `id, champion, error_reason` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`is_player`, `message_player`, `is_player_battling`, `get_player_name`, `get_player_money`, `set_player_money`, `get_player_mugshot`, `list_areas`, `list_objects`, `get_object_by_id`, `on`

## Engine `Async` calls

`promisify`, `await`, `sleep`, `quiz_player`, `initiate_pvp`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `SETTINGS` | `{` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
