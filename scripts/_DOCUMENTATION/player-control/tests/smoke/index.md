# 📄 `smoke.lua` — Current source reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/player-control/tests/smoke.lua`](../../../../../../control_impl/src/scripts/player-control/tests/smoke.lua)  
> **Source lines:** 108  
> **SHA-256:** `125d1c4d9bb4dbb454c7977fb6dde096a21bda1161ad7f3dd528097ca34d2684`  
> **Declared/assigned functions:** 20 · **table initializers (simple patterns):** 6 · **event subscriptions detected:** 0

> **Method:** Static source inventory. Parameters are spelled as in the source; no types, return values, or public accessibility are inferred from signatures alone. See the authored guides for behavioral descriptions.

## 🧭 Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Events](#events)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net APIs](#net-apis)

## Overview

Current reference for `player-control/tests/smoke.lua` in the PlayerControl-patched November 11 snapshot.

## Dependencies

| Line | Required module |
|---:|---|
| 56 | `scripts/player-control/main` |

## Events

No literal named event registrations detected.

## Functions and parameters

| Line | Declared/assigned function | Parameters (source) | Local |
|---:|---|---|---|
| 7 | `Net:on` | `name, fn` | no |
| 11 | `Net.lock_player_input` | `pid` | no |
| 12 | `Net.unlock_player_input` | `pid` | no |
| 13 | `Net.toggle_player_hud` | `pid` | no |
| 16 | `InputAPI.create_controller` | `pid` | no |
| 18 | `ctrl:get_input_owner` | `(none)` | no |
| 19 | `ctrl:claim_input` | `owner` | no |
| 25 | `ctrl:release_input` | `owner` | no |
| 31 | `ctrl:has_input_control` | `owner` | no |
| 32 | `ctrl:get_repeat_delays` | `(none)` | no |
| 33 | `ctrl:set_repeat_delays` | `first,repeat_delay` | no |
| 36 | `ctrl:require_release` | `actions, owner` | no |
| 37 | `ctrl:consume` | `owner` | no |
| 38 | `ctrl:is_action_pressed` | `action,owner` | no |
| 39 | `ctrl:is_action_repeated` | `action,owner` | no |
| 40 | `ctrl:on` | `event,fn` | no |
| 44 | `ctrl:off` | `event,fn` | no |
| 48 | `ctrl:emit` | `event,data` | no |
| 54 | `InputAPI.get_controller` | `pid` | no |
| 57 | `verify` | `test_name, expected, actual` | yes |

### Parameter details

#### 1. `Net:on(name, fn)`

- **Declared at:** source line 7.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `name` | Exact source parameter; type not asserted. |
| 2 | `fn` | Exact source parameter; type not asserted. |

#### 2. `Net.lock_player_input(pid)`

- **Declared at:** source line 11.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 3. `Net.unlock_player_input(pid)`

- **Declared at:** source line 12.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 4. `Net.toggle_player_hud(pid)`

- **Declared at:** source line 13.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 5. `InputAPI.create_controller(pid)`

- **Declared at:** source line 16.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 6. `ctrl:get_input_owner()`

- **Declared at:** source line 18.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 7. `ctrl:claim_input(owner)`

- **Declared at:** source line 19.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |

#### 8. `ctrl:release_input(owner)`

- **Declared at:** source line 25.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |

#### 9. `ctrl:has_input_control(owner)`

- **Declared at:** source line 31.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |

#### 10. `ctrl:get_repeat_delays()`

- **Declared at:** source line 32.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 11. `ctrl:set_repeat_delays(first,repeat_delay)`

- **Declared at:** source line 33.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `first` | Exact source parameter; type not asserted. |
| 2 | `repeat_delay` | Exact source parameter; type not asserted. |

#### 12. `ctrl:require_release(actions, owner)`

- **Declared at:** source line 36.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `actions` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 13. `ctrl:consume(owner)`

- **Declared at:** source line 37.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `owner` | Exact source parameter; type not asserted. |

#### 14. `ctrl:is_action_pressed(action,owner)`

- **Declared at:** source line 38.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 15. `ctrl:is_action_repeated(action,owner)`

- **Declared at:** source line 39.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 16. `ctrl:on(event,fn)`

- **Declared at:** source line 40.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `event` | Exact source parameter; type not asserted. |
| 2 | `fn` | Exact source parameter; type not asserted. |

#### 17. `ctrl:off(event,fn)`

- **Declared at:** source line 44.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `event` | Exact source parameter; type not asserted. |
| 2 | `fn` | Exact source parameter; type not asserted. |

#### 18. `ctrl:emit(event,data)`

- **Declared at:** source line 48.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `event` | Exact source parameter; type not asserted. |
| 2 | `data` | Exact source parameter; type not asserted. |

#### 19. `InputAPI.get_controller(pid)`

- **Declared at:** source line 54.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 20. `verify(test_name, expected, actual)`

- **Declared at:** source line 57.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `test_name` | Exact source parameter; type not asserted. |
| 2 | `expected` | Exact source parameter; type not asserted. |
| 3 | `actual` | Exact source parameter; type not asserted. |


## Tables

| Line | Table variable |
|---:|---|
| 4 | `handlers` |
| 5 | `count` |
| 6 | `Net` |
| 14 | `InputAPI` |
| 15 | `controllers` |
| 17 | `ctrl` |

## Net APIs

| Called API | Occurrences | First source line |
|---|---:|---:|
| `Net.lock_player_input` | 1 | 11 |
| `Net.on` | 1 | 7 |
| `Net.toggle_player_hud` | 1 | 13 |
| `Net.unlock_player_input` | 1 | 12 |
