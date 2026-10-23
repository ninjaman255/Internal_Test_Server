# `ezlibs-scripts/ezbuttons.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezbuttons.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezbuttons.lua Creates trigger-based buttons (non-solid NPCs). Logical relationships are defined with groups and button/group effects. Supports five interaction behaviors: Pressure Plate, One-Time, Toggle, Custom, Timed. Supports area-wide unlock/relock via "Area Wide" flag on Unlock/Relock Behavior objects. Optional per-button flag "Bots Can Trigger" (bool, default false) causes the button to register a parallel ezbottriggers rectangle/ellipse in addition to its eztriggers one, so NPCs entering or leaving can drive the same Pressure Plate / One-Time / Toggle / Timed state machine. Custom behavior is excluded because custom scripts receive a player_id. Bot-triggered activations pass nil as th

## Module location

- **Source:** `ezlibs-scripts/ezbuttons.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezbuttons.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcheckpoints` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/eztiledutils` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_area_transfer` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `ezbuttons.group_` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `activate_button` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_area_wide_unlocks` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_group_checkpoint_action` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_logic_action` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `callback` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cleanup_player_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clear_actor_present` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `combo_is_satisfied` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `configure_button_combo_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `configure_combo_button_group_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `configure_group_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_button_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_button_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `deactivate_button` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `deactivate_button_internal` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `enqueue_logic_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.activate_button` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.add_button_effect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.add_group_effect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.deactivate_button` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.define_group` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.get_group_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.is_button_active` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.on_group_change` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.refresh_groups` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbuttons.reset_button` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_live_contributor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `finish_deactivation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `first_live_from` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `group_is_satisfied` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_button_placeholder_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_button_placeholders_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_button_active` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_custom_script` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mark_actor_present` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_ids` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `object_to_tile_pos` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_button_departed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_button_entered` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_change` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `perform_activation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `perform_deactivation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `player_is_alive` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `process_logic_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `property_ids` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `reconcile_pending_button_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `register_button_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_actor_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_transition_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `route_group_callback` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_button_active_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_button_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `start_timed_deactivation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `sync_button_animations_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_configure_pending_combo_groups` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_configure_pending_combos` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_configure_pending_groups` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `validate_button_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 1786 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
