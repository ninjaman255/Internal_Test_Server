# 📄 `main.lua` — Current source reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/player-control/main.lua`](../../../../../control_impl/src/scripts/player-control/main.lua)  
> **Source lines:** 499  
> **SHA-256:** `0808f6dd9b37d635ef76a7369cea7d5ca548d604d75cd1512faa93c6dc663d1b`  
> **Declared/assigned functions:** 26 · **table initializers (simple patterns):** 17 · **event subscriptions detected:** 4

> **Method:** Static source inventory. Parameters are spelled as in the source; no types, return values, or public accessibility are inferred from signatures alone. See the authored guides for behavioral descriptions.

## 🧭 Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Events](#events)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net APIs](#net-apis)

## Overview

Current reference for `player-control/main.lua` in the PlayerControl-patched November 11 snapshot.

## Dependencies

| Line | Required module |
|---:|---|
| 5 | `scripts/input-controller/main` |
| 6 | `scripts/net-games/ui-suppression` |

## Events

| Line | Emitter | Event |
|---:|---|---|
| 209 | `ctrl` | `button_pressed` |
| 210 | `ctrl` | `button_repeat` |
| 211 | `ctrl` | `input_owner_changed` |
| 311 | `Net` | `player_disconnect` |

## Functions and parameters

| Line | Declared/assigned function | Parameters (source) | Local |
|---:|---|---|---|
| 25 | `report` | `label, err` | yes |
| 29 | `top` | `state` | yes |
| 37 | `focused` | `state` | yes |
| 43 | `sync_focus` | `state` | yes |
| 73 | `state_for` | `pid` | yes |
| 86 | `remove_stack` | `state, target` | yes |
| 92 | `Session:is_alive` | `(none)` | no |
| 93 | `Session:is_current` | `(none)` | no |
| 96 | `Session:input` | `(none)` | no |
| 103 | `Session:poll` | `actions` | no |
| 117 | `Session:on_pressed` | `action, fn` | no |
| 122 | `Session:on_repeat` | `action, fn` | no |
| 127 | `Session:yield_to_native_ui` | `(none)` | no |
| 133 | `Session:resume_buttons` | `(none)` | no |
| 139 | `Session:suspend_buttons` | `(none)` | no |
| 140 | `Session:child` | `options` | no |
| 145 | `Session:close` | `(none)` | no |
| 191 | `attach_events` | `state` | yes |
| 193 | `dispatch` | `kind, ev` | yes |
| 203 | `state.pressed_handler` | `ev` | no |
| 204 | `state.repeated_handler` | `ev` | no |
| 205 | `state.owner_handler` | `change` | no |
| 214 | `M.begin` | `player_id, options` | no |
| 284 | `M.get_active` | `player_id` | no |
| 288 | `M.get_debug_state` | `player_id` | no |
| 298 | `M.cleanup_player` | `player_id` | no |

### Parameter details

#### 1. `report(label, err)`

- **Declared at:** source line 25.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `label` | Exact source parameter; type not asserted. |
| 2 | `err` | Exact source parameter; type not asserted. |

#### 2. `top(state)`

- **Declared at:** source line 29.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `state` | Exact source parameter; type not asserted. |

#### 3. `focused(state)`

- **Declared at:** source line 37.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `state` | Exact source parameter; type not asserted. |

#### 4. `sync_focus(state)`

- **Declared at:** source line 43.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `state` | Exact source parameter; type not asserted. |

#### 5. `state_for(pid)`

- **Declared at:** source line 73.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 6. `remove_stack(state, target)`

- **Declared at:** source line 86.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `state` | Exact source parameter; type not asserted. |
| 2 | `target` | Exact source parameter; type not asserted. |

#### 7. `Session:is_alive()`

- **Declared at:** source line 92.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 8. `Session:is_current()`

- **Declared at:** source line 93.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 9. `Session:input()`

- **Declared at:** source line 96.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 10. `Session:poll(actions)`

- **Declared at:** source line 103.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `actions` | Exact source parameter; type not asserted. |

#### 11. `Session:on_pressed(action, fn)`

- **Declared at:** source line 117.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `fn` | Exact source parameter; type not asserted. |

#### 12. `Session:on_repeat(action, fn)`

- **Declared at:** source line 122.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `action` | Exact source parameter; type not asserted. |
| 2 | `fn` | Exact source parameter; type not asserted. |

#### 13. `Session:yield_to_native_ui()`

- **Declared at:** source line 127.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 14. `Session:resume_buttons()`

- **Declared at:** source line 133.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 15. `Session:suspend_buttons()`

- **Declared at:** source line 139.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 16. `Session:child(options)`

- **Declared at:** source line 140.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `options` | Exact source parameter; type not asserted. |

#### 17. `Session:close()`

- **Declared at:** source line 145.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 18. `attach_events(state)`

- **Declared at:** source line 191.
- **Scope syntax:** local.
- **Nearby source comment:** A single subscription pair per player dispatches action events. Callback invocation is isolated so an exception cannot prevent other users' inputs.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `state` | Exact source parameter; type not asserted. |

#### 19. `dispatch(kind, ev)`

- **Declared at:** source line 193.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `kind` | Exact source parameter; type not asserted. |
| 2 | `ev` | Exact source parameter; type not asserted. |

#### 20. `state.pressed_handler(ev)`

- **Declared at:** source line 203.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `ev` | Exact source parameter; type not asserted. |

#### 21. `state.repeated_handler(ev)`

- **Declared at:** source line 204.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `ev` | Exact source parameter; type not asserted. |

#### 22. `state.owner_handler(change)`

- **Declared at:** source line 205.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `change` | Exact source parameter; type not asserted. |

#### 23. `M.begin(player_id, options)`

- **Declared at:** source line 214.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |
| 2 | `options` | Exact source parameter; type not asserted. |

#### 24. `M.get_active(player_id)`

- **Declared at:** source line 284.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |

#### 25. `M.get_debug_state(player_id)`

- **Declared at:** source line 288.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |

#### 26. `M.cleanup_player(player_id)`

- **Declared at:** source line 298.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |


## Tables

| Line | Table variable |
|---:|---|
| 7 | `M` |
| 8 | `states` |
| 10 | `Session` |
| 13 | `profiles` |
| 14 | `desktop` |
| 15 | `menu` |
| 16 | `music_menu` |
| 17 | `settings_menu` |
| 18 | `native_ui` |
| 19 | `cinematic` |
| 20 | `capture_only` |
| 21 | `free_camera` |
| 23 | `guards` |
| 80 | `state` |
| 81 | `stack` |
| 106 | `events` |
| 290 | `entries` |

## Net APIs

| Called API | Occurrences | First source line |
|---|---:|---:|
| `Net.on` | 1 | 311 |
