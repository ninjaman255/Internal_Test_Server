# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/player-control/main.lua`](../../../player-control/main.lua)  
> **Source lines:** 672  
> **SHA-256 (UTF-8):** `9d30037344dbcf0f7750bcc1fb3c1aa166c8c160876721bc1da2fb9c70d50c9f`  
> **Named functions detected:** 58  
> **Table initializers detected:** 24

> **Static reference:** Function signatures, dependency paths, and event names are extracted from current Lua. The listing does not establish runtime reachability or public API exposure. See the authored guide for semantics.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

| Line | `require` path |
|---:|---|
| 5 | `scripts/input-controller/main` |
| 6 | `scripts/player-control/resources/ui-suppression` |
| 7 | `scripts/player-control/camera-focus` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 324 | `ctrl` | `button_pressed` |
| 325 | `ctrl` | `button_repeat` |
| 326 | `ctrl` | `button_released` |
| 327 | `ctrl` | `input_owner_changed` |
| 661 | `Net` | `player_disconnect` |
| 665 | `Net` | `tick` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 24 | `lifecycle` | `kind,message,data` | local |
| 46 | `report` | `where, err` | local |
| 49 | `top` | `state` | local |
| 55 | `focused` | `state` | local |
| 59 | `safe_callback` | `session, callback, label, ...` | local |
| 67 | `release_or_queue` | `pid, handle, label` | local |
| 79 | `M.retry_cleanup` | `pid` | assigned/declared |
| 100 | `resource_for` | `pid, owner, create` | local |
| 112 | `prune_resource` | `pid, owner` | local |
| 118 | `acquire_resource` | `pid, owner, field, fn` | local |
| 129 | `release_resource` | `pid,owner,field` | local |
| 144 | `M.acquire_capture` | `pid,owner` | assigned/declared |
| 149 | `M.release_capture` | `pid,owner` | assigned/declared |
| 154 | `M.has_capture` | `pid,owner` | assigned/declared |
| 158 | `M.suppress_hud` | `pid,owner` | assigned/declared |
| 163 | `M.restore_hud` | `pid,owner` | assigned/declared |
| 169 | `M.begin_capture_scope` | `pid,owner,options` | assigned/declared |
| 178 | `scope:close` | `(none)` | assigned/declared |
| 188 | `state_for` | `pid` | local |
| 206 | `sync_focus` | `state` | local |
| 272 | `detach_state` | `state` | local |
| 289 | `attach_events` | `state` | local |
| 292 | `dispatch` | `kind,ev` | local |
| 307 | `state.pressed_handler` | `ev` | assigned/declared |
| 308 | `state.repeated_handler` | `ev` | assigned/declared |
| 309 | `state.released_handler` | `ev` | assigned/declared |
| 310 | `state.owner_handler` | `change` | assigned/declared |
| 330 | `Session:is_alive` | `(none)` | assigned/declared |
| 331 | `Session:is_current` | `(none)` | assigned/declared |
| 335 | `Session:input` | `(none)` | assigned/declared |
| 338 | `Session:poll` | `actions` | assigned/declared |
| 354 | `Session:on_pressed` | `action,fn` | assigned/declared |
| 361 | `Session:on_repeat` | `action,fn` | assigned/declared |
| 368 | `Session:on_released` | `action,fn` | assigned/declared |
| 377 | `Session:guard_input` | `seconds, actions` | assigned/declared |
| 391 | `Session:begin_native_handoff` | `options` | assigned/declared |
| 398 | `handoff:resume` | `(none)` | assigned/declared |
| 410 | `Session:set_repeat_delays` | `first,interval` | assigned/declared |
| 417 | `Session:on_close` | `fn` | assigned/declared |
| 422 | `Session:on_error` | `fn` | assigned/declared |
| 427 | `Session:on_suspend` | `fn` | assigned/declared |
| 432 | `Session:on_resume` | `fn` | assigned/declared |
| 437 | `Session:yield_to_native_ui` | `(none)` | assigned/declared |
| 442 | `Session:resume_buttons` | `(none)` | assigned/declared |
| 448 | `Session:suspend_buttons` | `(none)` | assigned/declared |
| 449 | `Session:child` | `opts` | assigned/declared |
| 454 | `restore_camera` | `lease` | local |
| 466 | `Session:close` | `(none)` | assigned/declared |
| 507 | `rollback_state` | `state` | local |
| 510 | `M.begin` | `pid,options` | assigned/declared |
| 599 | `Session:camera` | `(none)` | assigned/declared |
| 603 | `call` | `name,...` | local |
| 610 | `api:move_to` | `x,y,z` | assigned/declared |
| 611 | `api:slide_to` | `x,y,z,duration` | assigned/declared |
| 612 | `api:follow_player` | `(none)` | assigned/declared |
| 620 | `M.get_active` | `pid` | assigned/declared |
| 621 | `M.get_debug_state` | `pid` | assigned/declared |
| 640 | `M.cleanup_player` | `pid` | assigned/declared |

### Parameter inventory

#### 1. `lifecycle(kind,message,data)`

- **Line:** 24
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `kind` | Declared directly in the current Lua. Type not inferred. |
| 2 | `message` | Declared directly in the current Lua. Type not inferred. |
| 3 | `data` | Declared directly in the current Lua. Type not inferred. |

#### 2. `report(where, err)`

- **Line:** 46
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `where` | Declared directly in the current Lua. Type not inferred. |
| 2 | `err` | Declared directly in the current Lua. Type not inferred. |

#### 3. `top(state)`

- **Line:** 49
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `state` | Declared directly in the current Lua. Type not inferred. |

#### 4. `focused(state)`

- **Line:** 55
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `state` | Declared directly in the current Lua. Type not inferred. |

#### 5. `safe_callback(session, callback, label, ...)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `session` | Declared directly in the current Lua. Type not inferred. |
| 2 | `callback` | Declared directly in the current Lua. Type not inferred. |
| 3 | `label` | Declared directly in the current Lua. Type not inferred. |
| 4 | `...` | Declared directly in the current Lua. Type not inferred. |

#### 6. `release_or_queue(pid, handle, label)`

- **Line:** 67
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `handle` | Declared directly in the current Lua. Type not inferred. |
| 3 | `label` | Declared directly in the current Lua. Type not inferred. |

#### 7. `M.retry_cleanup(pid)`

- **Line:** 79
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 8. `resource_for(pid, owner, create)`

- **Line:** 100
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 3 | `create` | Declared directly in the current Lua. Type not inferred. |

#### 9. `prune_resource(pid, owner)`

- **Line:** 112
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 10. `acquire_resource(pid, owner, field, fn)`

- **Line:** 118
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 3 | `field` | Declared directly in the current Lua. Type not inferred. |
| 4 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 11. `release_resource(pid,owner,field)`

- **Line:** 129
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 3 | `field` | Declared directly in the current Lua. Type not inferred. |

#### 12. `M.acquire_capture(pid,owner)`

- **Line:** 144
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 13. `M.release_capture(pid,owner)`

- **Line:** 149
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 14. `M.has_capture(pid,owner)`

- **Line:** 154
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 15. `M.suppress_hud(pid,owner)`

- **Line:** 158
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 16. `M.restore_hud(pid,owner)`

- **Line:** 163
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 17. `M.begin_capture_scope(pid,owner,options)`

- **Line:** 169
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 3 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 18. `scope:close()`

- **Line:** 178
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 19. `state_for(pid)`

- **Line:** 188
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 20. `sync_focus(state)`

- **Line:** 206
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `state` | Declared directly in the current Lua. Type not inferred. |

#### 21. `detach_state(state)`

- **Line:** 272
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `state` | Declared directly in the current Lua. Type not inferred. |

#### 22. `attach_events(state)`

- **Line:** 289
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `state` | Declared directly in the current Lua. Type not inferred. |

#### 23. `dispatch(kind,ev)`

- **Line:** 292
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `kind` | Declared directly in the current Lua. Type not inferred. |
| 2 | `ev` | Declared directly in the current Lua. Type not inferred. |

#### 24. `state.pressed_handler(ev)`

- **Line:** 307
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared directly in the current Lua. Type not inferred. |

#### 25. `state.repeated_handler(ev)`

- **Line:** 308
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared directly in the current Lua. Type not inferred. |

#### 26. `state.released_handler(ev)`

- **Line:** 309
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared directly in the current Lua. Type not inferred. |

#### 27. `state.owner_handler(change)`

- **Line:** 310
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `change` | Declared directly in the current Lua. Type not inferred. |

#### 28. `Session:is_alive()`

- **Line:** 330
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 29. `Session:is_current()`

- **Line:** 331
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 30. `Session:input()`

- **Line:** 335
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 31. `Session:poll(actions)`

- **Line:** 338
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actions` | Declared directly in the current Lua. Type not inferred. |

#### 32. `Session:on_pressed(action,fn)`

- **Line:** 354
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `action` | Declared directly in the current Lua. Type not inferred. |
| 2 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 33. `Session:on_repeat(action,fn)`

- **Line:** 361
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `action` | Declared directly in the current Lua. Type not inferred. |
| 2 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 34. `Session:on_released(action,fn)`

- **Line:** 368
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `action` | Declared directly in the current Lua. Type not inferred. |
| 2 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 35. `Session:guard_input(seconds, actions)`

- **Line:** 377
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `seconds` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actions` | Declared directly in the current Lua. Type not inferred. |

#### 36. `Session:begin_native_handoff(options)`

- **Line:** 391
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 37. `handoff:resume()`

- **Line:** 398
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 38. `Session:set_repeat_delays(first,interval)`

- **Line:** 410
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `first` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interval` | Declared directly in the current Lua. Type not inferred. |

#### 39. `Session:on_close(fn)`

- **Line:** 417
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 40. `Session:on_error(fn)`

- **Line:** 422
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 41. `Session:on_suspend(fn)`

- **Line:** 427
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 42. `Session:on_resume(fn)`

- **Line:** 432
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared directly in the current Lua. Type not inferred. |

#### 43. `Session:yield_to_native_ui()`

- **Line:** 437
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 44. `Session:resume_buttons()`

- **Line:** 442
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 45. `Session:suspend_buttons()`

- **Line:** 448
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 46. `Session:child(opts)`

- **Line:** 449
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 47. `restore_camera(lease)`

- **Line:** 454
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `lease` | Declared directly in the current Lua. Type not inferred. |

#### 48. `Session:close()`

- **Line:** 466
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 49. `rollback_state(state)`

- **Line:** 507
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `state` | Declared directly in the current Lua. Type not inferred. |

#### 50. `M.begin(pid,options)`

- **Line:** 510
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 51. `Session:camera()`

- **Line:** 599
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 52. `call(name,...)`

- **Line:** 603
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `...` | Declared directly in the current Lua. Type not inferred. |

#### 53. `api:move_to(x,y,z)`

- **Line:** 610
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `x` | Declared directly in the current Lua. Type not inferred. |
| 2 | `y` | Declared directly in the current Lua. Type not inferred. |
| 3 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 54. `api:slide_to(x,y,z,duration)`

- **Line:** 611
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `x` | Declared directly in the current Lua. Type not inferred. |
| 2 | `y` | Declared directly in the current Lua. Type not inferred. |
| 3 | `z` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |

#### 55. `api:follow_player()`

- **Line:** 612
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 56. `M.get_active(pid)`

- **Line:** 620
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 57. `M.get_debug_state(pid)`

- **Line:** 621
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 58. `M.cleanup_player(pid)`

- **Line:** 640
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 8 | `M` |
| 11 | `event_streams` |
| 32 | `Session` |
| 35 | `profiles` |
| 36 | `desktop` |
| 37 | `music_menu` |
| 38 | `settings_menu` |
| 39 | `native_ui` |
| 40 | `capture_only` |
| 41 | `minigame` |
| 43 | `guards` |
| 107 | `resource` |
| 177 | `scope` |
| 200 | `state` |
| 201 | `stack` |
| 343 | `events` |
| 397 | `handoff` |
| 473 | `children` |
| 558 | `close_callbacks` |
| 602 | `api` |
| 623 | `entries` |
| 630 | `release` |
| 632 | `named` |
| 650 | `names` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.on` | 2 | 661 |
