# `net-game-tourney/tournament-ui.lua`

> **Source reference**
>
> Generated from `net-game-tourney/tournament-ui.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

tournament-ui.lua

## Module location

- **Source:** `net-game-tourney/tournament-ui.lua`
- **Relative reference:** `script-reference/net-game-tourney/tournament-ui.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/tournament-constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-game-tourney/ui-pos` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `TournamentUI.acquire_tournament_music` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.add_progress_bar_with_overlay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.cleanup` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.cleanup_ui_elements` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.eliminate_participant_bars` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.fade_from_black` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.fade_to_black` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.get_participant_original_index` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.get_visual_epoch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.invalidate_player_visual_jobs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.move_participant` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.prewarm_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.release_tournament_music` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.remove_progress_bar_overlay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.show_board` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.show_champion_indicator` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.squash_mugshot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.tint_loser` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.unsquash_mugshot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.update_battling_frames` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.visual_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TournamentUI.visual_job_is_valid` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_mugshot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_revealed_eliminations` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `current_visual_epoch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_progress_bar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_revealed_paths` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_current_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_title_banner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `progress_info` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remember_text_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remember_visual_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_mug_texture` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_has_asset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_provide` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setup_background` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setup_bracket` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setup_title` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `touch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `visual_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 820 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
