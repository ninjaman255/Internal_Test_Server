# `input-controller/input-controller.lua`

> **Source reference**
>
> Refreshed from the current `input-controller/input-controller.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

input-controller.lua Unified sticky-state input controller with release/repeat edges and UI handoff guards. Timing is driven only by tick(delta_time); missing packet keys never imply release. Lifecycle: local ctrl = InputController.new(player_id, button_mappings, dir_names, config) ctrl:activate()     -- begin processing (default unless config.auto_activate == false) ctrl:deactivate()   -- stop processing, clear transient state (no events emitted) ctrl:reset()        -- clear transient state, keep active flag as-is ctrl:reload(m, d)   -- swap in new mappings/dir-names and reset transient state ctrl:destroy()      -- permanent teardown Repeat cadence: Per-instance. `config.first_repeat_delay`

## Module location

- **Source:** `input-controller/input-controller.lua`
- **Reference:** `script-reference/input-controller/input-controller.lua.md`
- **Source SHA-256 prefix:** `1a3388cfacf6`

## Source header notes

- input-controller.lua
- Unified sticky-state input controller with release/repeat edges and UI handoff guards.
- Timing is driven only by tick(delta_time); missing packet keys never imply release.
- Lifecycle:
- local ctrl = InputController.new(player_id, button_mappings, dir_names, config)
- ctrl:activate()     -- begin processing (default unless config.auto_activate == false)

## Direct `require` dependencies

| Import path |
|---|
| `scripts/utils/utility` |
| `scripts/input-controller/d-pad` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `normalize_state` | `value` |
| `normalize_events` | `events` |
| `rebuild_action_tables` | `self` |
| `sanitize_delay` | `value, fallback` |
| `InputController.new` | `player_id, button_mappings, direction_raw_names, config` |
| `InputController:_init` | `player_id, button_mappings, direction_raw_names, config` |
| `InputController.extend` | `overrides` |
| `subclass.new` | `player_id, button_mappings, direction_raw_names, config` |
| `InputController:clone` | `player_id` |
| `InputController:is_active` | `` |
| `InputController:activate` | `` |
| `InputController:deactivate` | `` |
| `InputController:reset` | `` |
| `InputController:reload` | `button_mappings, direction_raw_names` |
| `InputController:_clear_transient_state` | `` |
| `InputController:destroy` | `` |
| `InputController:set_repeat_delays` | `first_repeat_delay, repeat_delay` |
| `InputController:restore_repeat_delays` | `` |
| `InputController:get_repeat_delays` | `` |
| `InputController:on` | `event, callback` |
| `InputController:off` | `event, callback` |
| `InputController:remove_listener` | `event, callback` |
| `InputController:claim_input` | `owner, force` |
| `InputController:release_input` | `owner` |
| `InputController:has_input_control` | `owner` |
| `InputController:get_input_owner` | `` |
| `InputController:_swallowing` | `` |
| `InputController:_emit_edge` | `kind, action, state` |
| `InputController:handle_raw_input` | `events` |
| `InputController:_set_action_down` | `action, down` |
| `InputController:_update_logical_states` | `` |
| `InputController:_update_direction` | `` |
| `InputController:_synthesize_non_direction_releases` | `` |
| `InputController:_process_holds` | `dt` |
| `InputController:tick` | `delta_time` |
| `can_access_input` | `self, owner` |
| `InputController:is_action_down` | `action, owner` |
| `InputController:peek_action_pressed` | `action, owner` |
| `InputController:peek_action_released` | `action, owner` |
| `InputController:peek_action_repeated` | `action, owner` |
| `InputController:is_action_pressed` | `action, owner` |
| `InputController:is_action_released` | `action, owner` |
| `InputController:is_action_repeated` | `action, owner` |
| `InputController:get_active_direction` | `owner` |
| `InputController:require_release` | `actions, owner` |
| `InputController:swallow` | `seconds, owner` |
| `InputController:consume` | `owner` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `NON_DIR_UP_TIMEOUT` | `0.06` |
| `FIRST_REPEAT_DELAY` | `0.30` |
| `REPEAT_DELAY` | `0.10` |
| `MAX_TICK_DT` | `0.25` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
