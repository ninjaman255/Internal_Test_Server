# 📄 `player_session.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/player_session.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/player_session.lua)  
> **Source lines:** 590  
> **SHA-256 (UTF-8):** `2e92f11bb261604933df7d4099990c7bede62413cc178df5219ddae8f406a429`  
> **Named functions detected:** 24  
> **Table initializers detected:** 7

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
| 1 | `scripts/player-control/main` |
| 3 | `scripts/logger/logger` |
| 6 | `scripts/ezlibs-custom/nebulous-liberations/liberations/ability` |
| 7 | `scripts/ezlibs-custom/nebulous-liberations/liberations/player_selection` |
| 8 | `scripts/ezlibs-custom/nebulous-liberations/liberations/loot` |
| 9 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| 10 | `scripts/ezlibs-custom/nebulous-liberations/utils/paralyze_effect` |
| 11 | `scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect` |
| 12 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |
| 13 | `scripts/ezlibs-scripts/ezmemory` |
| 14 | `scripts/libs/emotes` |
| 15 | `scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators` |

## Event hooks

No static literal subscriptions detected.

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 32 | `is_enabled` | `value` | local |
| 36 | `normalize_identifier` | `value` | local |
| 45 | `stats_indicate_panic` | `results` | local |
| 53 | `PlayerSession:new` | `instance, player` | assigned/declared |
| 75 | `PlayerSession:emote_state` | `(none)` | assigned/declared |
| 87 | `PlayerSession:get_ability_permission` | `(none)` | assigned/declared |
| 121 | `PlayerSession:get_pass_turn_permission` | `(none)` | assigned/declared |
| 136 | `PlayerSession:initiate_encounter` | `encounter_path, data` | assigned/declared |
| 204 | `PlayerSession:heal` | `amount` | assigned/declared |
| 225 | `is_guardable_attacker` | `attacker` | local |
| 230 | `guard_is_covering_target` | `instance, target_session` | local |
| 255 | `PlayerSession:hurt` | `amount, attacker` | assigned/declared |
| 299 | `PlayerSession:paralyze` | `(none)` | assigned/declared |
| 311 | `PlayerSession:pass_turn` | `(none)` | assigned/declared |
| 325 | `PlayerSession:complete_turn` | `(none)` | assigned/declared |
| 346 | `PlayerSession:give_turn` | `(none)` | assigned/declared |
| 380 | `PlayerSession:find_matching_gates` | `(none)` | assigned/declared |
| 401 | `PlayerSession:find_gate_points` | `id` | assigned/declared |
| 415 | `PlayerSession:find_closest_guardian` | `(none)` | assigned/declared |
| 430 | `PlayerSession:liberate_panels` | `panels, results` | assigned/declared |
| 460 | `PlayerSession:get_cash` | `panel, destroy_items` | assigned/declared |
| 487 | `PlayerSession:loot_panels` | `panels, remove_traps, destroy_items` | assigned/declared |
| 564 | `PlayerSession:liberate_and_loot_panels` | `panels, results, remove_traps, destroy_items` | assigned/declared |
| 572 | `PlayerSession:handle_disconnect` | `(none)` | assigned/declared |

### Parameter inventory

#### 1. `is_enabled(value)`

- **Line:** 32
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 2. `normalize_identifier(value)`

- **Line:** 36
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 3. `stats_indicate_panic(results)`

- **Line:** 45
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `results` | Declared directly in the current Lua. Type not inferred. |

#### 4. `PlayerSession:new(instance, player)`

- **Line:** 53
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player` | Declared directly in the current Lua. Type not inferred. |

#### 5. `PlayerSession:emote_state()`

- **Line:** 75
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 6. `PlayerSession:get_ability_permission()`

- **Line:** 87
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 7. `PlayerSession:get_pass_turn_permission()`

- **Line:** 121
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 8. `PlayerSession:initiate_encounter(encounter_path, data)`

- **Line:** 136
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `encounter_path` | Declared directly in the current Lua. Type not inferred. |
| 2 | `data` | Declared directly in the current Lua. Type not inferred. |

#### 9. `PlayerSession:heal(amount)`

- **Line:** 204
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `amount` | Declared directly in the current Lua. Type not inferred. |

#### 10. `is_guardable_attacker(attacker)`

- **Line:** 225
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `attacker` | Declared directly in the current Lua. Type not inferred. |

#### 11. `guard_is_covering_target(instance, target_session)`

- **Line:** 230
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared directly in the current Lua. Type not inferred. |
| 2 | `target_session` | Declared directly in the current Lua. Type not inferred. |

#### 12. `PlayerSession:hurt(amount, attacker)`

- **Line:** 255
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `amount` | Declared directly in the current Lua. Type not inferred. |
| 2 | `attacker` | Declared directly in the current Lua. Type not inferred. |

#### 13. `PlayerSession:paralyze()`

- **Line:** 299
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 14. `PlayerSession:pass_turn()`

- **Line:** 311
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 15. `PlayerSession:complete_turn()`

- **Line:** 325
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 16. `PlayerSession:give_turn()`

- **Line:** 346
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 17. `PlayerSession:find_matching_gates()`

- **Line:** 380
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 18. `PlayerSession:find_gate_points(id)`

- **Line:** 401
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 19. `PlayerSession:find_closest_guardian()`

- **Line:** 415
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 20. `PlayerSession:liberate_panels(panels, results)`

- **Line:** 430
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `panels` | Declared directly in the current Lua. Type not inferred. |
| 2 | `results` | Declared directly in the current Lua. Type not inferred. |

#### 21. `PlayerSession:get_cash(panel, destroy_items)`

- **Line:** 460
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `panel` | Declared directly in the current Lua. Type not inferred. |
| 2 | `destroy_items` | Declared directly in the current Lua. Type not inferred. |

#### 22. `PlayerSession:loot_panels(panels, remove_traps, destroy_items)`

- **Line:** 487
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `panels` | Declared directly in the current Lua. Type not inferred. |
| 2 | `remove_traps` | Declared directly in the current Lua. Type not inferred. |
| 3 | `destroy_items` | Declared directly in the current Lua. Type not inferred. |

#### 23. `PlayerSession:liberate_and_loot_panels(panels, results, remove_traps, destroy_items)`

- **Line:** 564
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `panels` | Declared directly in the current Lua. Type not inferred. |
| 2 | `results` | Declared directly in the current Lua. Type not inferred. |
| 3 | `remove_traps` | Declared directly in the current Lua. Type not inferred. |
| 4 | `destroy_items` | Declared directly in the current Lua. Type not inferred. |

#### 24. `PlayerSession:handle_disconnect()`

- **Line:** 572
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.


## Tables

| Line | Identifier |
|---:|---|
| 18 | `BattleReason` |
| 51 | `PlayerSession` |
| 54 | `player_session` |
| 59 | `shadowsteps` |
| 142 | `results` |
| 381 | `gates` |
| 402 | `points` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.get_player_money` | 2 | 464 |
| `Net.play_sound_for_player` | 1 | 279 |
| `Net.set_player_emote` | 4 | 77 |
| `Net.set_player_emotion` | 1 | 154 |
| `Net.set_player_money` | 1 | 478 |
| `Net.slide_player_camera` | 1 | 508 |
| `Net.unlock_player_camera` | 1 | 342 |
