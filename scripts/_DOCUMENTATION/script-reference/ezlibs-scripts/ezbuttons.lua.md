# `ezlibs-scripts/ezbuttons.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezbuttons.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezbuttons.lua Creates trigger-based buttons (non-solid NPCs). Logical relationships are defined with groups and button/group effects. Supports five interaction behaviors: Pressure Plate, One-Time, Toggle, Custom, Timed. Supports area-wide unlock/relock via "Area Wide" flag on Unlock/Relock Behavior objects. Optional per-button flag "Bots Can Trigger" (bool, default false) causes the button to register a parallel ezbottriggers rectangle/ellipse in addition to its eztriggers one, so NPCs entering or leaving can drive the same Pressure Plate / One-Time / Toggle / Timed state machine. Custom behavior is excluded because custom scripts receive a player_id. Bot-triggered activations pass nil as th

## Module location

- **Source:** `ezlibs-scripts/ezbuttons.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezbuttons.lua.md`
- **Source SHA-256 prefix:** `34262a25359b`

## Source header notes

- ezbuttons.lua
- Creates trigger-based buttons (non-solid NPCs).
- Logical relationships are defined with groups and button/group effects.
- Supports five interaction behaviors: Pressure Plate, One-Time, Toggle, Custom, Timed.
- Supports area-wide unlock/relock via "Area Wide" flag on Unlock/Relock Behavior objects.
- Optional per-button flag "Bots Can Trigger" (bool, default false) causes the

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/object_registry` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezcheckpoints` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `player_area_transfer` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `async` | `p` |
| `await` | `v` |
| `player_is_alive` | `player_id` |
| `validate_button_object` | `area_id, object` |
| `object_to_tile_pos` | `object` |
| `normalize_ids` | `ids` |
| `find_live_contributor` | `area_id, group` |
| `first_live_from` | `ids` |
| `resolve_transition_player` | `area_id, group, event_player_id` |
| `combo_is_satisfied` | `area_id, combo` |
| `group_is_satisfied` | `area_id, group` |
| `apply_logic_action` | `area_id, target_id, action, player_id, was_bot` |
| `process_logic_event` | `event` |
| `enqueue_logic_event` | `area_id, object_id, active, player_id, was_bot` |
| `hide_button_placeholder_for_player` | `player_id, area_id, object_id` |
| `hide_button_placeholders_for_player` | `player_id` |
| `set_button_animation` | `bot_id, anim_state, loop` |
| `sync_button_animations_for_player` | `player_id` |
| `apply_area_wide_unlocks` | `player_id, area_id` |
| `cleanup_player_state` | `player_id` |
| `ezbuttons.handle_player_disconnect` | `player_id` |
| `create_button_trigger` | `area_id, object, width_px, height_px, trigger_id` |
| `smooth_camera_pan` | `player_id, from_pos, to_pos, duration` |
| `reconcile_pending_button_state` | `area_id, object_id, info` |
| `finish_deactivation` | `` |
| `start_timed_deactivation` | `area_id, object_id, info` |
| `load_custom_script` | `script_path` |
| `register_button_object` | `area_id, object, group_member` |
| `resolve_actor_id` | `event, actor_type` |
| `mark_actor_present` | `actor_id, actor_type` |
| `clear_actor_present` | `actor_id, actor_type` |
| `on_button_entered` | `event, actor_type` |
| `on_button_departed` | `event, actor_type` |
| `ezbuttons.is_button_active` | `area_id, object_id` |
| `ezbuttons.activate_button` | `area_id, object_id, player_id, was_bot` |
| `ezbuttons.deactivate_button` | `area_id, object_id` |
| `ezbuttons.reset_button` | `area_id, object_id` |
| `ezbuttons.define_group` | `area_id, group_id, button_ids, mode, options` |
| `ezbuttons.on_group_change` | `area_id, group_id, callback` |
| `ezbuttons.add_button_effect` | `area_id, source_id, event_name, target_id, action` |
| `ezbuttons.add_group_effect` | `area_id, group_id, event_name, target_id, action` |
| `ezbuttons.refresh_groups` | `area_id, player_id` |
| `ezbuttons.get_group_state` | `area_id, group_id` |
| `property_ids` | `props, prefix` |
| `configure_group_object` | `area_id, object` |
| `configure_button_combo_object` | `area_id, object` |
| `configure_combo_button_group_object` | `area_id, object` |
| `is_button_active` | `area_id, object_id` |
| `set_button_active_state` | `area_id, object_id, bot_id, active_anim, inactive_anim, active` |
| `ezbuttons.camera_release` | `player_id` |
| `ezbuttons.camera_move` | `player_id, x, y, z` |
| `ezbuttons.camera_reattach` | `player_id` |
| `perform_activation` | `area_id, object_id, player_id, info` |
| `perform_deactivation` | `area_id, object_id, info` |
| `deactivate_button_internal` | `area_id, object_id, info` |
| `activate_button` | `area_id, object_id, player_id, was_bot` |
| `deactivate_button` | `area_id, object_id` |
| `on_change` | `changed_area_id, changed_group_id, satisfied, player_id, was_bot` |
| `try_configure_pending_groups` | `area_id` |
| `try_configure_pending_combos` | `area_id` |
| `callback` | `changed_area_id, changed_group_id, satisfied, player_id, was_bot` |
| `try_configure_pending_combo_groups` | `area_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`unlock_player_camera`, `move_player_camera`, `track_with_player_camera`, `is_player`, `list_players`, `get_player_area`, `exclude_object_for_player`, `animate_bot`, `on`, `provide_asset`, `create_bot`, `get_object_by_id`, `is_player_input_locked`, `get_player_position`, `lock_player_input`, `unlock_player_input`

## Engine `Async` calls

`promisify`, `await`, `sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `TILE_SIZE` | `32` |
| `MAX_LOGIC_EVENTS_PER_DRAIN` | `1000` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/ezbuttons/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
