# `input-controller/input-controller.lua`

> **Source reference**
>
> Generated from `input-controller/input-controller.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

input-controller.lua Unified sticky-state input controller with release/repeat edges and UI handoff guards. Timing is driven only by tick(delta_time); missing packet keys never imply release. Lifecycle: local ctrl = InputController.new(player_id, button_mappings, dir_names, config) ctrl:activate()     -- begin processing (default unless config.auto_activate == false) ctrl:deactivate()   -- stop processing, clear transient state (no events emitted) ctrl:reset()        -- clear transient state, keep active flag as-is ctrl:reload(m, d)   -- swap in new mappings/dir-names and reset transient state ctrl:destroy()      -- permanent teardown Repeat cadence: Per-instance. `config.first_repeat_delay`

## Module location

- **Source:** `input-controller/input-controller.lua`
- **Relative reference:** `script-reference/input-controller/input-controller.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/input-controller/d-pad` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/utils/utility` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `InputController.extend` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController.new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_clear_transient_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_emit_edge` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_process_holds` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_set_action_down` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_swallowing` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_synthesize_non_direction_releases` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_update_direction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:_update_logical_states` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:activate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:claim_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:clone` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:consume` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:deactivate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:get_active_direction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:get_input_owner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:get_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:handle_raw_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:has_input_control` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:is_action_down` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:is_action_pressed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:is_action_released` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:is_action_repeated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:is_active` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:off` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:on` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:peek_action_pressed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:peek_action_released` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:peek_action_repeated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:release_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:reload` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:remove_listener` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:require_release` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:reset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:restore_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:set_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:swallow` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `InputController:tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `can_access_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_events` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `rebuild_action_tables` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `sanitize_delay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `subclass.new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 664 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
