# `net-game-tourney/tournament-ui.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/tournament-ui.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

tournament-ui.lua

## Module location

- **Source:** `net-game-tourney/tournament-ui.lua`
- **Reference:** `script-reference/net-game-tourney/tournament-ui.lua.md`
- **Source SHA-256 prefix:** `93bea6b46da1`

## Source header notes

- tournament-ui.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-game-tourney/tournament-constants` |
| `scripts/net-game-tourney/ui-pos` |
| `scripts/net-games/main` |
| `scripts/displayer/displayer` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `current_visual_epoch` | `player_id` |
| `TournamentUI.invalidate_player_visual_jobs` | `player_id` |
| `TournamentUI.visual_job_is_valid` | `player_id, expected_epoch` |
| `TournamentUI.get_visual_epoch` | `player_id` |
| `safe_has_asset` | `path` |
| `safe_provide` | `player_id, path` |
| `visual_id` | `tournament_id, base_id` |
| `TournamentUI.visual_id` | `tournament_id, base_id` |
| `remember_visual_id` | `player_id, id` |
| `remember_text_id` | `player_id, id` |
| `draw_ui` | `player_id, id, texture, animation, state, x, y, z, sx, sy` |
| `remove_ui` | `player_id, id` |
| `remove_text` | `player_id, id` |
| `resolve_mug_texture` | `texture` |
| `normalize_title_banner` | `value` |
| `TournamentUI.get_participant_original_index` | `tournament_data, participant_id` |
| `get_current_position` | `tournament_data, participant_id` |
| `add_mugshot` | `player_id, tournament_data, participant, index, pos` |
| `setup_background` | `player_id, tournament_data` |
| `setup_title` | `player_id, tournament_data` |
| `setup_bracket` | `player_id, tournament_data` |
| `progress_info` | `round` |
| `draw_progress_bar` | `player_id, tournament_data, round, match_index, with_overlay` |
| `TournamentUI.eliminate_participant_bars` | `player_id, tournament_data, participant_id` |
| `draw_revealed_paths` | `player_id, tournament_data` |
| `apply_revealed_eliminations` | `player_id, tournament_data` |
| `TournamentUI.show_board` | `player_id, tournament_data` |
| `TournamentUI.cleanup_ui_elements` | `player_id` |
| `TournamentUI.cleanup` | `player_id` |
| `TournamentUI.tint_loser` | `player_id, tournament_data, participant_id` |
| `TournamentUI.squash_mugshot` | `player_id, tournament_id, index, visual_epoch` |
| `TournamentUI.unsquash_mugshot` | `player_id, tournament_id, index, visual_epoch` |
| `TournamentUI.move_participant` | `player_id, tournament_data, participant_id, to_pos` |
| `TournamentUI.add_progress_bar_with_overlay` | `player_id, tournament_data, round, match_index` |
| `TournamentUI.remove_progress_bar_overlay` | `player_id, overlay_id` |
| `TournamentUI.update_battling_frames` | `player_id, tournament_data` |
| `TournamentUI.show_champion_indicator` | `player_id, tournament_data` |
| `TournamentUI.fade_to_black` | `player_id, seconds` |
| `TournamentUI.fade_from_black` | `player_id, seconds` |
| `TournamentUI.acquire_tournament_music` | `area_id` |
| `TournamentUI.release_tournament_music` | `area_id` |
| `TournamentUI.prewarm_player` | `player_id` |
| `touch` | `id, texture, anim, state` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`is_player`, `has_asset`, `provide_asset_for_player`, `fade_player_camera`, `get_song`, `get_area_name`, `set_song`, `set_area_name`

## Engine `Async` calls

`promisify`, `await`, `sleep`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
