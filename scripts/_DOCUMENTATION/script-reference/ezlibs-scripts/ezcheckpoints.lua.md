# `ezlibs-scripts/ezcheckpoints.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezcheckpoints.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezcheckpoints source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezcheckpoints.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezcheckpoints.lua.md`
- **Source SHA-256 prefix:** `606a97de1483`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/condition` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |

## `Net:on` subscriptions

| Event |
|---|
| `player_avatar_change` |
| `player_disconnect` |
| `object_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `is_player_alive` | `player_id` |
| `safe_net` | `fn, ...` |
| `ezcheckpoints.handle_player_disconnect` | `player_id` |
| `ezcheckpoints.get_player_navi_info` | `player_id` |
| `names_equal` | `a, b` |
| `ezcheckpoints.player_has_navi` | `player_id, name` |
| `ezcheckpoints.player_has_navi_element` | `player_id, element` |
| `ezcheckpoints.player_has_any_navi` | `player_id, names` |
| `evaluate_navi_check` | `player_id, navi_check` |
| `ezcheckpoints.unlock_checkpoint_for_player` | `player_id, area_id, object_id, unlocking_asset_name, unlocking_sound_path, unlocking_animation_time, once, opts` |
| `ezcheckpoints.force_unlock_checkpoint` | `player_id, area_id, object_id, once, opts` |
| `ezcheckpoints.relock_checkpoint` | `player_id, area_id, object_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`is_player`, `on`, `get_object_by_id`, `is_player_input_locked`, `lock_player_input`, `play_sound_for_player`, `provide_asset`, `create_bot`, `remove_bot`, `unlock_player_input`, `get_player_area`, `include_object_for_player`

## Engine `Async` calls

`sleep`, `message_player`, `prompt_player`, `question_player`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/ezcheckpoints/` |
| `/server/assets/ezlibs-assets/sfx/panel_change.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
