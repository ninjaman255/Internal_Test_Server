# 📄 `input-controller.lua` — Current source reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/input-controller/input-controller.lua`](../../../input-controller/input-controller.lua)  
> **Source lines:** 710  
> **SHA-256:** `13dafddc35fba3aab09a5558e26ff647f96a170954633733228c790a8258c09a`  
> **Declared/assigned functions:** 47 · **table initializers (simple patterns):** 22 · **event subscriptions detected:** 0

> **Method:** Static source inventory. Parameters are spelled as in the source; no types, return values, or public accessibility are inferred from signatures alone. See the authored guides for behavioral descriptions.

## 🧭 Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Events](#events)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net APIs](#net-apis)

## Overview

Current reference for `input-controller/input-controller.lua` in the PlayerControl-patched November 11 snapshot.

## Dependencies

| Line | Required module |
|---:|---|
| 28 | `scripts/utils/utility` |
| 29 | `scripts/input-controller/d-pad` |

## Events

No literal named event registrations detected.

## Functions and parameters

| Line | Declared/assigned function | Parameters (source) | Local |
|---:|---|---|---|
| 46 | `normalize_state` | `value` | yes |
| 58 | `normalize_events` | `events` | yes |
| 91 | `rebuild_action_tables` | `self` | yes |
| 112 | `sanitize_delay` | `value, fallback` | yes |
| 122 | `InputController.new` | `player_id, button_mappings, direction_raw_names, config` | no |
| 128 | `InputController:_init` | `player_id, button_mappings, direction_raw_names, config` | no |
| 169 | `InputController.extend` | `overrides` | no |
| 177 | `subclass.new` | `player_id, button_mappings, direction_raw_names, config` | no |
| 188 | `InputController:clone` | `player_id` | no |
| 206 | `InputController:is_active` | `(none)` | no |
| 210 | `InputController:activate` | `(none)` | no |
| 215 | `InputController:deactivate` | `(none)` | no |
| 220 | `InputController:reset` | `(none)` | no |
| 225 | `InputController:reload` | `button_mappings, direction_raw_names` | no |
| 238 | `InputController:_clear_transient_state` | `(none)` | no |
| 250 | `InputController:destroy` | `(none)` | no |
| 274 | `InputController:set_repeat_delays` | `first_repeat_delay, repeat_delay` | no |
| 289 | `InputController:restore_repeat_delays` | `(none)` | no |
| 299 | `InputController:get_repeat_delays` | `(none)` | no |
| 307 | `InputController:on` | `event, callback` | no |
| 314 | `InputController:off` | `event, callback` | no |
| 321 | `InputController:remove_listener` | `event, callback` | no |
| 328 | `InputController:claim_input` | `owner, force` | no |
| 363 | `InputController:release_input` | `owner` | no |
| 389 | `InputController:has_input_control` | `owner` | no |
| 393 | `InputController:get_input_owner` | `(none)` | no |
| 397 | `InputController:_swallowing` | `(none)` | no |
| 401 | `InputController:_emit_edge` | `kind, action, state` | no |
| 425 | `InputController:handle_raw_input` | `events` | no |
| 446 | `InputController:_set_action_down` | `action, down` | no |
| 459 | `InputController:_update_logical_states` | `(none)` | no |
| 478 | `InputController:_update_direction` | `(none)` | no |
| 507 | `InputController:_synthesize_non_direction_releases` | `(none)` | no |
| 521 | `InputController:_process_holds` | `dt` | no |
| 541 | `InputController:tick` | `delta_time` | no |
| 559 | `can_access_input` | `self, owner` | yes |
| 566 | `InputController:is_action_down` | `action, owner` | no |
| 574 | `InputController:peek_action_pressed` | `action, owner` | no |
| 581 | `InputController:peek_action_released` | `action, owner` | no |
| 588 | `InputController:peek_action_repeated` | `action, owner` | no |
| 595 | `InputController:is_action_pressed` | `action, owner` | no |
| 604 | `InputController:is_action_released` | `action, owner` | no |
| 613 | `InputController:is_action_repeated` | `action, owner` | no |
| 622 | `InputController:get_active_direction` | `owner` | no |
| 633 | `InputController:require_release` | `actions, owner` | no |
| 645 | `InputController:swallow` | `seconds, owner` | no |
| 653 | `InputController:consume` | `owner` | no |

### Parameter details

#### 1. `normalize_state(value)`

- **Declared at:** source line 46.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `value` | Exact source parameter; type not asserted. |

#### 2. `normalize_events(events)`

- **Declared at:** source line 58.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `events` | Exact source parameter; type not asserted. |

#### 3. `rebuild_action_tables(self)`

- **Declared at:** source line 91.
- **Scope syntax:** local.
- **Nearby source comment:** Rebuild self.actions and self.raw_to_actions from self.button_mappings.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `self` | Exact source parameter; type not asserted. |

#### 4. `sanitize_delay(value, fallback)`

- **Declared at:** source line 112.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `value` | Exact source parameter; type not asserted. |
| 2 | `fallback` | Exact source parameter; type not asserted. |

#### 5. `InputController.new(player_id, button_mappings, direction_raw_names, config)`

- **Declared at:** source line 122.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |
| 2 | `button_mappings` | Exact source parameter; type not asserted. |
| 3 | `direction_raw_names` | Exact source parameter; type not asserted. |
| 4 | `config` | Exact source parameter; type not asserted. |

#### 6. `InputController:_init(player_id, button_mappings, direction_raw_names, config)`

- **Declared at:** source line 128.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |
| 2 | `button_mappings` | Exact source parameter; type not asserted. |
| 3 | `direction_raw_names` | Exact source parameter; type not asserted. |
| 4 | `config` | Exact source parameter; type not asserted. |

#### 7. `InputController.extend(overrides)`

- **Declared at:** source line 169.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Create a subclass.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `overrides` | Exact source parameter; type not asserted. |

#### 8. `subclass.new(player_id, button_mappings, direction_raw_names, config)`

- **Declared at:** source line 177.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |
| 2 | `button_mappings` | Exact source parameter; type not asserted. |
| 3 | `direction_raw_names` | Exact source parameter; type not asserted. |
| 4 | `config` | Exact source parameter; type not asserted. |

#### 9. `InputController:clone(player_id)`

- **Declared at:** source line 188.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Clone produces a new controller that inherits the source controller's current repeat cadence (not the class defaults).

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |

#### 10. `InputController:is_active()`

- **Declared at:** source line 206.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 11. `InputController:activate()`

- **Declared at:** source line 210.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 12. `InputController:deactivate()`

- **Declared at:** source line 215.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 13. `InputController:reset()`

- **Declared at:** source line 220.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 14. `InputController:reload(button_mappings, direction_raw_names)`

- **Declared at:** source line 225.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `button_mappings` | Exact source parameter; type not asserted. |
| 2 | `direction_raw_names` | Exact source parameter; type not asserted. |

#### 15. `InputController:_clear_transient_state()`

- **Declared at:** source line 238.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 16. `InputController:destroy()`

- **Declared at:** source line 250.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 17. `InputController:set_repeat_delays(first_repeat_delay, repeat_delay)`

- **Declared at:** source line 274.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Change the repeat cadence at runtime. Passing nil for either argument keeps the current value for that field.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `first_repeat_delay` | Exact source parameter; type not asserted. |
| 2 | `repeat_delay` | Exact source parameter; type not asserted. |

#### 18. `InputController:restore_repeat_delays()`

- **Declared at:** source line 289.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Revert to the cadence configured at construction time.
- **Parameters:** none explicitly declared.

#### 19. `InputController:get_repeat_delays()`

- **Declared at:** source line 299.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 20. `InputController:on(event, callback)`

- **Declared at:** source line 307.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `event` | Exact source parameter; type not asserted. |
| 2 | `callback` | Exact source parameter; type not asserted. |

#### 21. `InputController:off(event, callback)`

- **Declared at:** source line 314.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Match the underlying EventEmitter API and let consumers reliably detach subscriptions during teardown. CameraController previously tried to unsubscribe, but InputController did not expose the emitter's method.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `event` | Exact source parameter; type not asserted. |
| 2 | `callback` | Exact source parameter; type not asserted. |

#### 22. `InputController:remove_listener(event, callback)`

- **Declared at:** source line 321.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `event` | Exact source parameter; type not asserted. |
| 2 | `callback` | Exact source parameter; type not asserted. |

#### 23. `InputController:claim_input(owner, force)`

- **Declared at:** source line 328.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Claim exclusive interactive control. A forced claim is intended for an explicit context transition (for example, entering a minigame) and not for competing systems to repeatedly steal control from each other.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |
| 2 | `force` | Exact source parameter; type not asserted. |

#### 24. `InputController:release_input(owner)`

- **Declared at:** source line 363.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |

#### 25. `InputController:has_input_control(owner)`

- **Declared at:** source line 389.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |

#### 26. `InputController:get_input_owner()`

- **Declared at:** source line 393.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 27. `InputController:_swallowing()`

- **Declared at:** source line 397.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 28. `InputController:_emit_edge(kind, action, state)`

- **Declared at:** source line 401.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `kind` | Exact source parameter; type not asserted. |
| 2 | `action` | Exact source parameter; type not asserted. |
| 3 | `state` | Exact source parameter; type not asserted. |

#### 29. `InputController:handle_raw_input(events)`

- **Declared at:** source line 425.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `events` | Exact source parameter; type not asserted. |

#### 30. `InputController:_set_action_down(action, down)`

- **Declared at:** source line 446.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `down` | Exact source parameter; type not asserted. |

#### 31. `InputController:_update_logical_states()`

- **Declared at:** source line 459.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 32. `InputController:_update_direction()`

- **Declared at:** source line 478.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 33. `InputController:_synthesize_non_direction_releases()`

- **Declared at:** source line 507.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 34. `InputController:_process_holds(dt)`

- **Declared at:** source line 521.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `dt` | Exact source parameter; type not asserted. |

#### 35. `InputController:tick(delta_time)`

- **Declared at:** source line 541.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `delta_time` | Exact source parameter; type not asserted. |

#### 36. `can_access_input(self, owner)`

- **Declared at:** source line 559.
- **Scope syntax:** local.
- **Nearby source comment:** Backward compatibility is retained while the controller is unclaimed. Once an owner exists, callers must identify themselves; legacy pollers can no longer consume the active owner's edge flags by calling without an owner.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `self` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 37. `InputController:is_action_down(action, owner)`

- **Declared at:** source line 566.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 38. `InputController:peek_action_pressed(action, owner)`

- **Declared at:** source line 574.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 39. `InputController:peek_action_released(action, owner)`

- **Declared at:** source line 581.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 40. `InputController:peek_action_repeated(action, owner)`

- **Declared at:** source line 588.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 41. `InputController:is_action_pressed(action, owner)`

- **Declared at:** source line 595.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 42. `InputController:is_action_released(action, owner)`

- **Declared at:** source line 604.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 43. `InputController:is_action_repeated(action, owner)`

- **Declared at:** source line 613.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 44. `InputController:get_active_direction(owner)`

- **Declared at:** source line 622.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |

#### 45. `InputController:require_release(actions, owner)`

- **Declared at:** source line 633.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `actions` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 46. `InputController:swallow(seconds, owner)`

- **Declared at:** source line 645.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `seconds` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 47. `InputController:consume(owner)`

- **Declared at:** source line 653.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |


## Tables

| Line | Table variable |
|---:|---|
| 31 | `InputController` |
| 59 | `out` |
| 92 | `self.actions` |
| 93 | `self.raw_to_actions` |
| 137 | `self.raw_states` |
| 138 | `self.raw_last_seen` |
| 139 | `self.logical` |
| 141 | `self.pressed_actions` |
| 142 | `self.released_actions` |
| 143 | `self.repeat_actions` |
| 144 | `self.release_required` |
| 239 | `self.raw_states` |
| 240 | `self.raw_last_seen` |
| 241 | `self.logical` |
| 243 | `self.pressed_actions` |
| 244 | `self.released_actions` |
| 245 | `self.repeat_actions` |
| 246 | `self.release_required` |
| 479 | `pressed` |
| 656 | `self.pressed_actions` |
| 657 | `self.released_actions` |
| 658 | `self.repeat_actions` |

## Net APIs

No direct call expressions matching `Net.<name>(` detected.
