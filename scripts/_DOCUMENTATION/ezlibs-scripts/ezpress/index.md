# 📄 `ezpress.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezpress.lua`](../../../ezlibs-scripts/ezpress.lua)  
> **Source lines:** 829  
> **SHA-256 (UTF-8):** `5e2ae85ba5823349656d1e6b5cad584ce47f867899dc214f36e065f17897f3e5`  
> **Named/assigned functions detected:** 39  
> **Table initializers detected:** 18

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezpress.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 30 | `scripts/logger/logger` |
| 31 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 32 | `scripts/ezlibs-scripts/ezbus` |
| 33 | `scripts/ezlibs-scripts/ezemitter` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 530 | `player_emitter` | `entered` |
| 533 | `player_emitter` | `departed` |
| 554 | `bot_emitter` | `entered` |
| 557 | `bot_emitter` | `departed` |
| 718 | `ezbus` | `bot_created` |
| 724 | `ezbus` | `bot_removed` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 72 | `is_true` | `value` | local |
| 82 | `normalize_size_mode` | `value` | local |
| 92 | `normalize_size_mode_scope` | `value` | local |
| 101 | `emit_event` | `name, payload` | local |
| 106 | `ezpress:on` | `event_name, callback` | assigned/declared |
| 111 | `ezpress:once` | `event_name, callback` | assigned/declared |
| 120 | `ezpress.get_area_scale_state` | `area_id` | assigned/declared |
| 130 | `ezpress.get_area_size_mode_scope` | `area_id` | assigned/declared |
| 144 | `animate_scale` | `player_id, scale, immediate` | local |
| 157 | `ezpress.set_scale_state` | `player_id, state, immediate, metadata` | assigned/declared |
| 203 | `ezpress.get_scale_state` | `player_id` | assigned/declared |
| 208 | `ezpress.is_compressed` | `player_id` | assigned/declared |
| 212 | `ezpress.is_enlarged` | `player_id` | assigned/declared |
| 216 | `ezpress.compress` | `player_id, immediate, metadata` | assigned/declared |
| 220 | `ezpress.decompress` | `player_id, immediate, metadata` | assigned/declared |
| 224 | `ezpress.enlarge` | `player_id, immediate, metadata` | assigned/declared |
| 232 | `animate_bot_scale` | `bot_id, scale, immediate` | local |
| 254 | `ezpress.set_bot_scale_state` | `bot_id, state, immediate, metadata` | assigned/declared |
| 296 | `ezpress.get_bot_scale_state` | `bot_id` | assigned/declared |
| 305 | `position_matches_trigger` | `pos, trigger` | local |
| 316 | `get_matching_tile` | `area_id, pos` | local |
| 334 | `ezpress.get_tile_state_at` | `area_id, pos` | assigned/declared |
| 344 | `ezpress.check_and_apply` | `player_id, area_id, pos, immediate` | assigned/declared |
| 367 | `reconcile_from_current_position` | `player_id, source, immediate` | local |
| 387 | `on_trigger_transition` | `area_id, trigger, transition, event` | local |
| 414 | `apply_bot_area_fallback` | `bot_id, area_id, immediate, source` | local |
| 431 | `reconcile_bot_from_position` | `bot_id, area_id, pos, source, immediate` | local |
| 465 | `on_bot_trigger_transition` | `area_id, trigger, transition, event` | local |
| 497 | `add_area_trigger` | `area_id, object_id, obj, target_state` | local |
| 577 | `read_tile_state_from_properties` | `props` | local |
| 591 | `ezpress.apply_area_scale_to_bots` | `area_id, immediate, metadata` | assigned/declared |
| 644 | `ezpress.apply_map_property` | `player_id, area_id, immediate, extra_metadata` | assigned/declared |
| 665 | `ezpress.handle_bot_created` | `bot_id, area_id, x, y, z` | assigned/declared |
| 709 | `ezpress.handle_bot_removed` | `bot_id` | assigned/declared |
| 734 | `ezpress.handle_player_join` | `player_id` | assigned/declared |
| 750 | `ezpress.handle_player_transfer` | `player_id` | assigned/declared |
| 764 | `ezpress.handle_player_move` | `player_id, x, y, z` | assigned/declared |
| 787 | `ezpress.handle_player_disconnect` | `player_id` | assigned/declared |
| 798 | `scan_areas` | `(none)` | local |

### Detailed parameter inventory

#### 1. `is_true(value)`

- **Line:** 72
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 2. `normalize_size_mode(value)`

- **Line:** 82
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 3. `normalize_size_mode_scope(value)`

- **Line:** 92
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 4. `emit_event(name, payload)`

- **Line:** 101
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared in this function; type not inferred. |
| 2 | `payload` | Declared in this function; type not inferred. |

#### 5. `ezpress:on(event_name, callback)`

- **Line:** 106
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event_name` | Declared in this function; type not inferred. |
| 2 | `callback` | Declared in this function; type not inferred. |

#### 6. `ezpress:once(event_name, callback)`

- **Line:** 111
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event_name` | Declared in this function; type not inferred. |
| 2 | `callback` | Declared in this function; type not inferred. |

#### 7. `ezpress.get_area_scale_state(area_id)`

- **Line:** 120
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 8. `ezpress.get_area_size_mode_scope(area_id)`

- **Line:** 130
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 9. `animate_scale(player_id, scale, immediate)`

- **Line:** 144
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `scale` | Declared in this function; type not inferred. |
| 3 | `immediate` | Declared in this function; type not inferred. |

#### 10. `ezpress.set_scale_state(player_id, state, immediate, metadata)`

- **Line:** 157
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `state` | Declared in this function; type not inferred. |
| 3 | `immediate` | Declared in this function; type not inferred. |
| 4 | `metadata` | Declared in this function; type not inferred. |

#### 11. `ezpress.get_scale_state(player_id)`

- **Line:** 203
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 12. `ezpress.is_compressed(player_id)`

- **Line:** 208
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 13. `ezpress.is_enlarged(player_id)`

- **Line:** 212
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 14. `ezpress.compress(player_id, immediate, metadata)`

- **Line:** 216
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `immediate` | Declared in this function; type not inferred. |
| 3 | `metadata` | Declared in this function; type not inferred. |

#### 15. `ezpress.decompress(player_id, immediate, metadata)`

- **Line:** 220
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `immediate` | Declared in this function; type not inferred. |
| 3 | `metadata` | Declared in this function; type not inferred. |

#### 16. `ezpress.enlarge(player_id, immediate, metadata)`

- **Line:** 224
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `immediate` | Declared in this function; type not inferred. |
| 3 | `metadata` | Declared in this function; type not inferred. |

#### 17. `animate_bot_scale(bot_id, scale, immediate)`

- **Line:** 232
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `scale` | Declared in this function; type not inferred. |
| 3 | `immediate` | Declared in this function; type not inferred. |

#### 18. `ezpress.set_bot_scale_state(bot_id, state, immediate, metadata)`

- **Line:** 254
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `state` | Declared in this function; type not inferred. |
| 3 | `immediate` | Declared in this function; type not inferred. |
| 4 | `metadata` | Declared in this function; type not inferred. |

#### 19. `ezpress.get_bot_scale_state(bot_id)`

- **Line:** 296
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |

#### 20. `position_matches_trigger(pos, trigger)`

- **Line:** 305
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pos` | Declared in this function; type not inferred. |
| 2 | `trigger` | Declared in this function; type not inferred. |

#### 21. `get_matching_tile(area_id, pos)`

- **Line:** 316
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `pos` | Declared in this function; type not inferred. |

#### 22. `ezpress.get_tile_state_at(area_id, pos)`

- **Line:** 334
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `pos` | Declared in this function; type not inferred. |

#### 23. `ezpress.check_and_apply(player_id, area_id, pos, immediate)`

- **Line:** 344
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `pos` | Declared in this function; type not inferred. |
| 4 | `immediate` | Declared in this function; type not inferred. |

#### 24. `reconcile_from_current_position(player_id, source, immediate)`

- **Line:** 367
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `source` | Declared in this function; type not inferred. |
| 3 | `immediate` | Declared in this function; type not inferred. |

#### 25. `on_trigger_transition(area_id, trigger, transition, event)`

- **Line:** 387
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `trigger` | Declared in this function; type not inferred. |
| 3 | `transition` | Declared in this function; type not inferred. |
| 4 | `event` | Declared in this function; type not inferred. |

#### 26. `apply_bot_area_fallback(bot_id, area_id, immediate, source)`

- **Line:** 414
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `immediate` | Declared in this function; type not inferred. |
| 4 | `source` | Declared in this function; type not inferred. |

#### 27. `reconcile_bot_from_position(bot_id, area_id, pos, source, immediate)`

- **Line:** 431
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `pos` | Declared in this function; type not inferred. |
| 4 | `source` | Declared in this function; type not inferred. |
| 5 | `immediate` | Declared in this function; type not inferred. |

#### 28. `on_bot_trigger_transition(area_id, trigger, transition, event)`

- **Line:** 465
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `trigger` | Declared in this function; type not inferred. |
| 3 | `transition` | Declared in this function; type not inferred. |
| 4 | `event` | Declared in this function; type not inferred. |

#### 29. `add_area_trigger(area_id, object_id, obj, target_state)`

- **Line:** 497
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `obj` | Declared in this function; type not inferred. |
| 4 | `target_state` | Declared in this function; type not inferred. |

#### 30. `read_tile_state_from_properties(props)`

- **Line:** 577
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `props` | Declared in this function; type not inferred. |

#### 31. `ezpress.apply_area_scale_to_bots(area_id, immediate, metadata)`

- **Line:** 591
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `immediate` | Declared in this function; type not inferred. |
| 3 | `metadata` | Declared in this function; type not inferred. |

#### 32. `ezpress.apply_map_property(player_id, area_id, immediate, extra_metadata)`

- **Line:** 644
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `immediate` | Declared in this function; type not inferred. |
| 4 | `extra_metadata` | Declared in this function; type not inferred. |

#### 33. `ezpress.handle_bot_created(bot_id, area_id, x, y, z)`

- **Line:** 665
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `x` | Declared in this function; type not inferred. |
| 4 | `y` | Declared in this function; type not inferred. |
| 5 | `z` | Declared in this function; type not inferred. |

#### 34. `ezpress.handle_bot_removed(bot_id)`

- **Line:** 709
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |

#### 35. `ezpress.handle_player_join(player_id)`

- **Line:** 734
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 36. `ezpress.handle_player_transfer(player_id)`

- **Line:** 750
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 37. `ezpress.handle_player_move(player_id, x, y, z)`

- **Line:** 764
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 38. `ezpress.handle_player_disconnect(player_id)`

- **Line:** 787
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 39. `scan_areas()`

- **Line:** 798
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 43 | `ezpress` |
| 47 | `player_scale_state` |
| 49 | `bot_scale_state` |
| 51 | `bots_by_area` |
| 53 | `active_tile_by_player` |
| 55 | `active_tile_by_bot` |
| 57 | `area_triggers` |
| 64 | `SCALE_STATES` |
| 148 | `properties` |
| 181 | `payload` |
| 234 | `config` |
| 236 | `properties` |
| 277 | `payload` |
| 357 | `metadata` |
| 488 | `pos` |
| 498 | `trigger` |
| 680 | `pos` |
| 769 | `pos` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.animate_player_properties` | 1 | 146 |
| `Net.get_player_area` | 4 | 183 |
| `Net.get_player_position` | 4 | 346 |
| `Net.play_sound_for_player` | 1 | 179 |
