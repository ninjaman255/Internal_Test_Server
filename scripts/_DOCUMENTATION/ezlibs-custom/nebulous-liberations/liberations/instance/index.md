# 📄 `instance.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/instance.lua)  
> **Source lines:** 2290  
> **SHA-256 (UTF-8):** `d9285f157aaa91d5fe4ece2e2d06bfaf509af7594a89c9cf2ff885443e1650ac`  
> **Named functions detected:** 42  
> **Table initializers detected:** 56

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
| 6 | `scripts/libs/direction` |
| 7 | `scripts/ezlibs-custom/nebulous-liberations/liberations/player_session` |
| 8 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy` |
| 9 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| 10 | `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters` |
| 11 | `scripts/ezlibs-custom/nebulous-liberations/liberations/loot` |
| 12 | `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| 13 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |
| 14 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_config` |
| 15 | `scripts/ezlibs-custom/nebulous-liberations/liberations/battle_scale` |
| 16 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates` |
| 17 | `scripts/ezlibs-custom/nebulous-liberations/liberations/logger` |
| 20 | `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry` |
| 21 | `scripts/ezlibs-custom/nebulous-liberations/liberations/camera_sequence` |
| 22 | `scripts/ezlibs-custom/nebulous-liberations/liberations/points_gauge` |
| 23 | `scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators` |
| 24 | `scripts/libs/emotes` |
| 25 | `scripts/ezlibs-scripts/ezmemory` |
| 26 | `scripts/ezlibs-scripts/helpers` |

## Event hooks

No static literal subscriptions detected.

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 28 | `includes` | `table, value` | local |
| 41 | `normalize_enemy_name` | `value` | local |
| 52 | `apply_panel_enemy_config` | `panel, enemy` | local |
| 62 | `apply_dark_hole_minion_health_to_bot` | `dark_hole, enemy` | local |
| 90 | `assign_dark_hole_bot_encounter` | `dark_hole, enemy` | local |
| 100 | `apply_dark_hole_minion_health_override` | `encounter_data, dark_hole, enemy` | local |
| 144 | `copy_music_definition` | `music` | local |
| 153 | `build_encounter_data` | `encounter_definition, overrides, persistent_enemy` | local |
| 318 | `apply_battle_visuals` | `data, source, mission, panel, encounter_definition, encounter_source` | local |
| 333 | `resolve_panel_type` | `object` | local |
| 363 | `is_panel` | `self, object` | local |
| 367 | `is_adjacent` | `position_a, position_b` | local |
| 376 | `boot_player` | `player, isVictory, mapName` | local |
| 382 | `liberate` | `self` | local |
| 424 | `normalized_reference` | `value` | local |
| 429 | `boss_group_ids_from_properties` | `properties` | local |
| 448 | `object_is_associated_with_boss` | `properties, boss_group_id` | local |
| 457 | `count_dark_holes_for_boss` | `self, boss_definition` | local |
| 467 | `convert_indestructible_panels` | `self` | local |
| 475 | `add_camera_focus` | `definition` | local |
| 615 | `liberate_panel` | `self, player_session` | local |
| 1023 | `take_enemy_turn` | `self` | local |
| 1196 | `Mission:new` | `base_area_id, new_area_id, players, max_order_points` | assigned/declared |
| 1687 | `Mission:spawn_boss` | `boss_id, force, triggered` | assigned/declared |
| 1787 | `Mission:spawn_bosses_for_cleared_dark_holes` | `(none)` | assigned/declared |
| 1797 | `Mission:handle_boss_defeated` | `enemy` | assigned/declared |
| 1854 | `Mission:set_order_points` | `value` | assigned/declared |
| 1862 | `Mission:clean_up` | `(none)` | assigned/declared |
| 1889 | `Mission:cleaning_up` | `(none)` | assigned/declared |
| 1893 | `Mission:begin` | `(none)` | assigned/declared |
| 1980 | `Mission:on_tick` | `elapsed` | assigned/declared |
| 2016 | `Mission:handle_tile_interaction` | `player_id, x, y, z, button` | assigned/declared |
| 2038 | `Mission:handle_object_interaction` | `player_id, object_id, button` | assigned/declared |
| 2146 | `Mission:handle_player_avatar_change` | `player_id` | assigned/declared |
| 2156 | `Mission:handle_player_transfer` | `player_id` | assigned/declared |
| 2194 | `Mission:handle_player_disconnect` | `player_id` | assigned/declared |
| 2218 | `Mission:get_players` | `(none)` | assigned/declared |
| 2222 | `Mission:get_spawn_position` | `(none)` | assigned/declared |
| 2226 | `Mission:get_next_spawn_from_object` | `object_id` | assigned/declared |
| 2238 | `Mission:get_panel_at` | `x, y, z` | assigned/declared |
| 2253 | `Mission:remove_panel` | `panel` | assigned/declared |
| 2279 | `Mission:get_enemy_at` | `x, y, z` | assigned/declared |

### Parameter inventory

#### 1. `includes(table, value)`

- **Line:** 28
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `table` | Declared directly in the current Lua. Type not inferred. |
| 2 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 2. `normalize_enemy_name(value)`

- **Line:** 41
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 3. `apply_panel_enemy_config(panel, enemy)`

- **Line:** 52
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `panel` | Declared directly in the current Lua. Type not inferred. |
| 2 | `enemy` | Declared directly in the current Lua. Type not inferred. |

#### 4. `apply_dark_hole_minion_health_to_bot(dark_hole, enemy)`

- **Line:** 62
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dark_hole` | Declared directly in the current Lua. Type not inferred. |
| 2 | `enemy` | Declared directly in the current Lua. Type not inferred. |

#### 5. `assign_dark_hole_bot_encounter(dark_hole, enemy)`

- **Line:** 90
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dark_hole` | Declared directly in the current Lua. Type not inferred. |
| 2 | `enemy` | Declared directly in the current Lua. Type not inferred. |

#### 6. `apply_dark_hole_minion_health_override(encounter_data, dark_hole, enemy)`

- **Line:** 100
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `encounter_data` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dark_hole` | Declared directly in the current Lua. Type not inferred. |
| 3 | `enemy` | Declared directly in the current Lua. Type not inferred. |

#### 7. `copy_music_definition(music)`

- **Line:** 144
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `music` | Declared directly in the current Lua. Type not inferred. |

#### 8. `build_encounter_data(encounter_definition, overrides, persistent_enemy)`

- **Line:** 153
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `encounter_definition` | Declared directly in the current Lua. Type not inferred. |
| 2 | `overrides` | Declared directly in the current Lua. Type not inferred. |
| 3 | `persistent_enemy` | Declared directly in the current Lua. Type not inferred. |

#### 9. `apply_battle_visuals(data, source, mission, panel, encounter_definition, encounter_source)`

- **Line:** 318
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `data` | Declared directly in the current Lua. Type not inferred. |
| 2 | `source` | Declared directly in the current Lua. Type not inferred. |
| 3 | `mission` | Declared directly in the current Lua. Type not inferred. |
| 4 | `panel` | Declared directly in the current Lua. Type not inferred. |
| 5 | `encounter_definition` | Declared directly in the current Lua. Type not inferred. |
| 6 | `encounter_source` | Declared directly in the current Lua. Type not inferred. |

#### 10. `resolve_panel_type(object)`

- **Line:** 333
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 11. `is_panel(self, object)`

- **Line:** 363
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 12. `is_adjacent(position_a, position_b)`

- **Line:** 367
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `position_a` | Declared directly in the current Lua. Type not inferred. |
| 2 | `position_b` | Declared directly in the current Lua. Type not inferred. |

#### 13. `boot_player(player, isVictory, mapName)`

- **Line:** 376
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player` | Declared directly in the current Lua. Type not inferred. |
| 2 | `isVictory` | Declared directly in the current Lua. Type not inferred. |
| 3 | `mapName` | Declared directly in the current Lua. Type not inferred. |

#### 14. `liberate(self)`

- **Line:** 382
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |

#### 15. `normalized_reference(value)`

- **Line:** 424
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 16. `boss_group_ids_from_properties(properties)`

- **Line:** 429
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `properties` | Declared directly in the current Lua. Type not inferred. |

#### 17. `object_is_associated_with_boss(properties, boss_group_id)`

- **Line:** 448
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `properties` | Declared directly in the current Lua. Type not inferred. |
| 2 | `boss_group_id` | Declared directly in the current Lua. Type not inferred. |

#### 18. `count_dark_holes_for_boss(self, boss_definition)`

- **Line:** 457
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `boss_definition` | Declared directly in the current Lua. Type not inferred. |

#### 19. `convert_indestructible_panels(self)`

- **Line:** 467
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |

#### 20. `add_camera_focus(definition)`

- **Line:** 475
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `definition` | Declared directly in the current Lua. Type not inferred. |

#### 21. `liberate_panel(self, player_session)`

- **Line:** 615
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_session` | Declared directly in the current Lua. Type not inferred. |

#### 22. `take_enemy_turn(self)`

- **Line:** 1023
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |

#### 23. `Mission:new(base_area_id, new_area_id, players, max_order_points)`

- **Line:** 1196
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `new_area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `players` | Declared directly in the current Lua. Type not inferred. |
| 4 | `max_order_points` | Declared directly in the current Lua. Type not inferred. |

#### 24. `Mission:spawn_boss(boss_id, force, triggered)`

- **Line:** 1687
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `boss_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `force` | Declared directly in the current Lua. Type not inferred. |
| 3 | `triggered` | Declared directly in the current Lua. Type not inferred. |

#### 25. `Mission:spawn_bosses_for_cleared_dark_holes()`

- **Line:** 1787
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 26. `Mission:handle_boss_defeated(enemy)`

- **Line:** 1797
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `enemy` | Declared directly in the current Lua. Type not inferred. |

#### 27. `Mission:set_order_points(value)`

- **Line:** 1854
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 28. `Mission:clean_up()`

- **Line:** 1862
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 29. `Mission:cleaning_up()`

- **Line:** 1889
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 30. `Mission:begin()`

- **Line:** 1893
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 31. `Mission:on_tick(elapsed)`

- **Line:** 1980
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `elapsed` | Declared directly in the current Lua. Type not inferred. |

#### 32. `Mission:handle_tile_interaction(player_id, x, y, z, button)`

- **Line:** 2016
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |
| 5 | `button` | Declared directly in the current Lua. Type not inferred. |

#### 33. `Mission:handle_object_interaction(player_id, object_id, button)`

- **Line:** 2038
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `button` | Declared directly in the current Lua. Type not inferred. |

#### 34. `Mission:handle_player_avatar_change(player_id)`

- **Line:** 2146
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 35. `Mission:handle_player_transfer(player_id)`

- **Line:** 2156
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 36. `Mission:handle_player_disconnect(player_id)`

- **Line:** 2194
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 37. `Mission:get_players()`

- **Line:** 2218
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 38. `Mission:get_spawn_position()`

- **Line:** 2222
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 39. `Mission:get_next_spawn_from_object(object_id)`

- **Line:** 2226
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 40. `Mission:get_panel_at(x, y, z)`

- **Line:** 2238
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `x` | Declared directly in the current Lua. Type not inferred. |
| 2 | `y` | Declared directly in the current Lua. Type not inferred. |
| 3 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 41. `Mission:remove_panel(panel)`

- **Line:** 2253
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `panel` | Declared directly in the current Lua. Type not inferred. |

#### 42. `Mission:get_enemy_at(x, y, z)`

- **Line:** 2279
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `x` | Declared directly in the current Lua. Type not inferred. |
| 2 | `y` | Declared directly in the current Lua. Type not inferred. |
| 3 | `z` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 154 | `data` |
| 159 | `data.enemies` |
| 161 | `enemy_copy` |
| 168 | `data.freedom_mission` |
| 184 | `mission` |
| 268 | `entry_summary` |
| 393 | `self.panels` |
| 397 | `self.enemies` |
| 430 | `ids` |
| 431 | `seen` |
| 470 | `converting` |
| 471 | `remaining` |
| 472 | `camera_bosses` |
| 473 | `camera_boss_seen` |
| 490 | `satisfied_bosses` |
| 542 | `sessions` |
| 609 | `DARK_HOLE_SHAPE` |
| 654 | `data` |
| 733 | `entries` |
| 809 | `data` |
| 860 | `encounter_enemy_entries` |
| 969 | `panels` |
| 980 | `panels` |
| 982 | `panel_summary` |
| 1107 | `neighbor_offsets` |
| 1110 | `neighbors` |
| 1194 | `Mission` |
| 1220 | `configured_encounter_music` |
| 1294 | `mission` |
| 1305 | `points_gauges` |
| 1306 | `points_of_interest` |
| 1308 | `player_sessions` |
| 1311 | `pending_transfer_players` |
| 1314 | `bosses` |
| 1315 | `boss_definitions` |
| 1316 | `enemies` |
| 1317 | `panels` |
| 1318 | `dark_holes` |
| 1319 | `indestructible_panels` |
| 1320 | `panel_gates` |
| 1322 | `BASIC_PANEL_GID_LIST` |
| 1323 | `ITEM_PANEL_GID_LIST` |
| 1324 | `DARK_HOLE_GID_LIST` |
| 1325 | `INDESTRUCTIBLE_PANEL_GID_LIST` |
| 1326 | `BONUS_PANEL_GID_LIST` |
| 1327 | `TRAP_PANEL_GID_LIST` |
| 1328 | `PANEL_GATE_GID_LIST` |
| 1411 | `pending_enemy_spawns` |
| 1437 | `new_panel` |
| 1445 | `data` |
| 1527 | `definition` |
| 1570 | `position` |
| 1716 | `position` |
| 1879 | `self.points_gauges` |
| 1908 | `player_ids` |
| 2009 | `player_session.shadowsteps` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.clone_area` | 1 | 1353 |
| `Net.create_object` | 1 | 1515 |
| `Net.exclude_object_for_player` | 1 | 1999 |
| `Net.get_area_custom_properties` | 7 | 409 |
| `Net.get_area_custom_property` | 4 | 1281 |
| `Net.get_area_name` | 4 | 1243 |
| `Net.get_height` | 1 | 1337 |
| `Net.get_layer_count` | 1 | 1335 |
| `Net.get_object_by_id` | 7 | 572 |
| `Net.get_object_by_name` | 1 | 2223 |
| `Net.get_player_area` | 1 | 2161 |
| `Net.get_player_max_health` | 1 | 1918 |
| `Net.get_tileset` | 3 | 1254 |
| `Net.include_object_for_player` | 1 | 2007 |
| `Net.is_player` | 4 | 2031 |
| `Net.is_player_in_widget` | 2 | 2021 |
| `Net.list_bots` | 1 | 1881 |
| `Net.list_objects` | 2 | 1203 |
| `Net.move_player_camera` | 4 | 558 |
| `Net.remove_area` | 1 | 1884 |
| `Net.remove_bot` | 3 | 395 |
| `Net.remove_object` | 3 | 1417 |
| `Net.set_background` | 1 | 407 |
| `Net.set_bot_name` | 1 | 1762 |
| `Net.set_object_data` | 2 | 578 |
| `Net.set_player_emote` | 1 | 377 |
| `Net.set_player_health` | 1 | 1919 |
| `Net.set_song` | 2 | 414 |
| `Net.slide_player_camera` | 8 | 557 |
| `Net.unlock_player_camera` | 4 | 601 |
