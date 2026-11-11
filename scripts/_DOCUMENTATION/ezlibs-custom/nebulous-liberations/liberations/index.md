# 📁 ezlibs-custom/nebulous-liberations/liberations

[🏠 Documentation home](../../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `enemies/` | 7 | 21 | 29 | — | [Open folder index](enemies/index.md) |
| 📄 Script | `ability.lua` | 1 | 7 | 13 | 196 | [Open script reference](ability/index.md) |
| 📄 Script | `battle_scale.lua` | 1 | 4 | 5 | 138 | [Open script reference](battle_scale/index.md) |
| 📄 Script | `camera_sequence.lua` | 1 | 1 | 1 | 37 | [Open script reference](camera_sequence/index.md) |
| 📄 Script | `constants.lua` | 1 | 0 | 10 | 174 | [Open script reference](constants/index.md) |
| 📄 Script | `enemy.lua` | 1 | 4 | 4 | 194 | [Open script reference](enemy/index.md) |
| 📄 Script | `enemy_config.lua` | 1 | 11 | 4 | 156 | [Open script reference](enemy_config/index.md) |
| 📄 Script | `enemy_helpers.lua` | 1 | 15 | 9 | 344 | [Open script reference](enemy_helpers/index.md) |
| 📄 Script | `enemy_selection.lua` | 1 | 7 | 3 | 69 | [Open script reference](enemy_selection/index.md) |
| 📄 Script | `enemy_templates.lua` | 1 | 10 | 5 | 271 | [Open script reference](enemy_templates/index.md) |
| 📄 Script | `guard_interception.lua` | 1 | 10 | 14 | 249 | [Open script reference](guard_interception/index.md) |
| 📄 Script | `hp_indicators.lua` | 1 | 24 | 16 | 448 | [Open script reference](hp_indicators/index.md) |
| 📄 Script | `instance.lua` | 1 | 42 | 57 | 2289 | [Open script reference](instance/index.md) |
| 📄 Script | `logger.lua` | 1 | 0 | 1 | 12 | [Open script reference](logger/index.md) |
| 📄 Script | `loot.lua` | 1 | 16 | 20 | 368 | [Open script reference](loot/index.md) |
| 📄 Script | `option_menu.lua` | 1 | 12 | 12 | 448 | [Open script reference](option_menu/index.md) |
| 📄 Script | `panel_encounters.lua` | 1 | 16 | 14 | 511 | [Open script reference](panel_encounters/index.md) |
| 📄 Script | `panel_registry.lua` | 1 | 7 | 6 | 98 | [Open script reference](panel_registry/index.md) |
| 📄 Script | `player_selection.lua` | 1 | 11 | 3 | 152 | [Open script reference](player_selection/index.md) |
| 📄 Script | `player_session.lua` | 1 | 24 | 7 | 592 | [Open script reference](player_session/index.md) |
| 📄 Script | `points_gauge.lua` | 1 | 16 | 17 | 495 | [Open script reference](points_gauge/index.md) |
| 📄 Script | `points_guage.lua` | 1 | 10 | 6 | 183 | [Open script reference](points_guage/index.md) |
| 📄 Script | `preloader.lua` | 1 | 2 | 2 | 23 | [Open script reference](preloader/index.md) |
| 📄 Script | `selection.lua` | 1 | 9 | 8 | 189 | [Open script reference](selection/index.md) |
| 📄 Script | `tileset_embedder.lua` | 1 | 12 | 8 | 356 | [Open script reference](tileset_embedder/index.md) |
| 📄 Script | `validation.lua` | 1 | 4 | 7 | 254 | [Open script reference](validation/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `ability.lua` | `Ability.resolve_for_player(player)` | 185 | [Details](ability/index.md) |
| `battle_scale.lua` | `BattleScale.apply(data, source, options)` | 38 | [Details](battle_scale/index.md) |
| `camera_sequence.lua` | `CameraSequence.play(instance, player, start_point)` | 6 | [Details](camera_sequence/index.md) |
| `enemy.lua` | `Enemy.from(instance, position, direction, name, spawn_options)` | 96 | [Details](enemy/index.md) |
| `enemy.lua` | `Enemy.is_alive(enemy)` | 112 | [Details](enemy/index.md) |
| `enemy.lua` | `Enemy.destroy(instance, enemy)` | 126 | [Details](enemy/index.md) |
| `enemy_config.lua` | `Config.resolve(area_id, source, legacy_health_property, category)` | 64 | [Details](enemy_config/index.md) |
| `enemy_config.lua` | `Config.apply(enemy, cfg)` | 129 | [Details](enemy_config/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.play_attack_animation(enemy)` | 44 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.update_name(enemy)` | 53 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.heal(enemy, amount)` | 60 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.face_position(enemy, x, y)` | 76 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.is_occupied_by_enemy(instance, x, y, z, ignored_enemy)` | 91 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.can_spawn_on(instance, x, y, z)` | 118 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.can_move_to(instance, x, y, z, moving_enemy)` | 124 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.move(instance, enemy, x, y, z, direction)` | 132 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.offset_position_with_direction(position, direction)` | 223 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.chebyshev_tile_distance(enemy, x, y)` | 243 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.find_closest_player_session(instance, enemy)` | 250 | [Details](enemy_helpers/index.md) |
| `enemy_helpers.lua` | `EnemyHelpers.sync_health(enemy, results, encounter_data)` | 283 | [Details](enemy_helpers/index.md) |
| `enemy_selection.lua` | `EnemySelection:new(instance)` | 5 | [Details](enemy_selection/index.md) |
| `enemy_selection.lua` | `EnemySelection:set_shape(shape, shape_offset_x, shape_offset_y)` | 36 | [Details](enemy_selection/index.md) |
| `enemy_selection.lua` | `EnemySelection:move(position, direction)` | 40 | [Details](enemy_selection/index.md) |
| `enemy_selection.lua` | `EnemySelection:detect_player_sessions()` | 45 | [Details](enemy_selection/index.md) |
| `enemy_selection.lua` | `EnemySelection:indicate()` | 59 | [Details](enemy_selection/index.md) |
| `enemy_selection.lua` | `EnemySelection:remove_indicators()` | 63 | [Details](enemy_selection/index.md) |
| `enemy_templates.lua` | `EnemyTemplates.has(name)` | 21 | [Details](enemy_templates/index.md) |
| `enemy_templates.lua` | `EnemyTemplates.register(name, template)` | 25 | [Details](enemy_templates/index.md) |
| `enemy_templates.lua` | `EnemyTemplates.create(instance, position, direction, template_name, spawn_options)` | 30 | [Details](enemy_templates/index.md) |
| `enemy_templates.lua` | `EnemyTemplates.ai.simple_charge(self)` | 163 | [Details](enemy_templates/index.md) |
| `enemy_templates.lua` | `EnemyTemplates.ai.ranged(self)` | 252 | [Details](enemy_templates/index.md) |
| `guard_interception.lua` | `GuardInterception.prepare_attack(instance, attacker, target_sessions, impact_delay)` | 210 | [Details](guard_interception/index.md) |
| `guard_interception.lua` | `GuardInterception.apply_damage(records, amount, attacker)` | 222 | [Details](guard_interception/index.md) |
| `guard_interception.lua` | `GuardInterception.finish_attack(instance, records)` | 242 | [Details](guard_interception/index.md) |
| `hp_indicators.lua` | `HPIndicators.register(instance)` | 219 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.add_enemy(instance, enemy)` | 253 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.update_enemy_hp_for_enemy(enemy)` | 267 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.update_player_hp(instance, player_id, hp)` | 274 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.update_enemy_hp(instance, enemy)` | 284 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.hide_enemy(instance, enemy)` | 298 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.show_enemy(instance, enemy)` | 308 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.update_enemy_position(instance, enemy)` | 321 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.remove_enemy(instance, enemy)` | 339 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.remove_player(instance, player_id)` | 352 | [Details](hp_indicators/index.md) |
| `hp_indicators.lua` | `HPIndicators.destroy(instance)` | 375 | [Details](hp_indicators/index.md) |
| `instance.lua` | `Mission:new(base_area_id, new_area_id, players, max_order_points)` | 1195 | [Details](instance/index.md) |
| `instance.lua` | `Mission:spawn_boss(boss_id, force, triggered)` | 1686 | [Details](instance/index.md) |
| `instance.lua` | `Mission:spawn_bosses_for_cleared_dark_holes()` | 1786 | [Details](instance/index.md) |
| `instance.lua` | `Mission:handle_boss_defeated(enemy)` | 1796 | [Details](instance/index.md) |
| `instance.lua` | `Mission:set_order_points(value)` | 1853 | [Details](instance/index.md) |
| `instance.lua` | `Mission:clean_up()` | 1861 | [Details](instance/index.md) |
| `instance.lua` | `Mission:cleaning_up()` | 1888 | [Details](instance/index.md) |
| `instance.lua` | `Mission:begin()` | 1892 | [Details](instance/index.md) |
| `instance.lua` | `Mission:on_tick(elapsed)` | 1979 | [Details](instance/index.md) |
| `instance.lua` | `Mission:handle_tile_interaction(player_id, x, y, z, button)` | 2015 | [Details](instance/index.md) |
| `instance.lua` | `Mission:handle_object_interaction(player_id, object_id, button)` | 2037 | [Details](instance/index.md) |
| `instance.lua` | `Mission:handle_player_avatar_change(player_id)` | 2145 | [Details](instance/index.md) |
| `instance.lua` | `Mission:handle_player_transfer(player_id)` | 2155 | [Details](instance/index.md) |
| `instance.lua` | `Mission:handle_player_disconnect(player_id)` | 2193 | [Details](instance/index.md) |
| `instance.lua` | `Mission:get_players()` | 2217 | [Details](instance/index.md) |
| `instance.lua` | `Mission:get_spawn_position()` | 2221 | [Details](instance/index.md) |
| `instance.lua` | `Mission:get_next_spawn_from_object(object_id)` | 2225 | [Details](instance/index.md) |
| `instance.lua` | `Mission:get_panel_at(x, y, z)` | 2237 | [Details](instance/index.md) |
| `instance.lua` | `Mission:remove_panel(panel)` | 2252 | [Details](instance/index.md) |
| `instance.lua` | `Mission:get_enemy_at(x, y, z)` | 2278 | [Details](instance/index.md) |
| `loot.lua` | `Loot.spawn_item_bot(item, area_id, x, y, z)` | 219 | [Details](loot/index.md) |
| `loot.lua` | `Loot.spawn_randomized_item_bot(loot_pool, item_index, area_id, x, y, z)` | 248 | [Details](loot/index.md) |
| `loot.lua` | `Loot.loot_item_panel(instance, player_session, panel, destroy_items)` | 298 | [Details](loot/index.md) |
| `loot.lua` | `Loot.loot_bonus_panel(instance, player_session, panel)` | 340 | [Details](loot/index.md) |
| `option_menu.lua` | `OptionMenu.select(player_id, options, title)` | 345 | [Details](option_menu/index.md) |
| `panel_encounters.lua` | `PanelEncounters.resolve_terrain(instance, player)` | 80 | [Details](panel_encounters/index.md) |
| `panel_encounters.lua` | `PanelEncounters.pick_weighted(candidates)` | 186 | [Details](panel_encounters/index.md) |
| `panel_encounters.lua` | `PanelEncounters.resolve_encounter_value(reference, base_area_id)` | 213 | [Details](panel_encounters/index.md) |
| `panel_encounters.lua` | `PanelEncounters.resolve_named_encounter(base_area_id, category, reference)` | 226 | [Details](panel_encounters/index.md) |
| `panel_encounters.lua` | `PanelEncounters.resolve_dark_hole_liberation_encounters(base_area_id, object_reference)` | 263 | [Details](panel_encounters/index.md) |
| `panel_encounters.lua` | `PanelEncounters.resolve_enemy_encounter(base_area_id, default_category, enemy, properties, config)` | 366 | [Details](panel_encounters/index.md) |
| `panel_encounters.lua` | `PanelEncounters.resolve_encounter(base_area_id, category)` | 418 | [Details](panel_encounters/index.md) |
| `panel_registry.lua` | `PanelRegistry.register(type_name, definition)` | 12 | [Details](panel_registry/index.md) |
| `panel_registry.lua` | `PanelRegistry.get_type_by_gid(gid)` | 53 | [Details](panel_registry/index.md) |
| `panel_registry.lua` | `PanelRegistry.get_definition(type_name)` | 58 | [Details](panel_registry/index.md) |
| `panel_registry.lua` | `PanelRegistry.is_type(gid, type_name)` | 63 | [Details](panel_registry/index.md) |
| `panel_registry.lua` | `PanelRegistry.is_liberatable(gid)` | 69 | [Details](panel_registry/index.md) |
| `panel_registry.lua` | `PanelRegistry.is_walkable(gid)` | 79 | [Details](panel_registry/index.md) |
| `panel_registry.lua` | `PanelRegistry.is_shadowstep(gid)` | 89 | [Details](panel_registry/index.md) |
| `player_selection.lua` | `PlayerSelection:new(instance, player_id)` | 38 | [Details](player_selection/index.md) |
| `player_selection.lua` | `PlayerSelection:select_panel(panel_object)` | 103 | [Details](player_selection/index.md) |
| `player_selection.lua` | `PlayerSelection:set_include_all_liberatable_panels(enabled)` | 115 | [Details](player_selection/index.md) |
| `player_selection.lua` | `PlayerSelection:set_shape(shape, shape_offset_x, shape_offset_y)` | 119 | [Details](player_selection/index.md) |
| `player_selection.lua` | `PlayerSelection:get_panels()` | 125 | [Details](player_selection/index.md) |
| `player_selection.lua` | `PlayerSelection:clear()` | 140 | [Details](player_selection/index.md) |
| `player_selection.lua` | `PlayerSelection:count_panels()` | 145 | [Details](player_selection/index.md) |
| `player_session.lua` | `PlayerSession:new(instance, player)` | 52 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:emote_state()` | 74 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:get_ability_permission()` | 86 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:get_pass_turn_permission()` | 120 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:initiate_encounter(encounter_path, data)` | 135 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:heal(amount)` | 203 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:hurt(amount, attacker)` | 254 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:paralyze()` | 298 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:pass_turn()` | 310 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:complete_turn()` | 324 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:give_turn()` | 345 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:find_matching_gates()` | 379 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:find_gate_points(id)` | 400 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:find_closest_guardian()` | 414 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:liberate_panels(panels, results)` | 429 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:get_cash(panel, destroy_items)` | 459 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:loot_panels(panels, remove_traps, destroy_items)` | 486 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:liberate_and_loot_panels(panels, results, remove_traps, destroy_items)` | 566 | [Details](player_session/index.md) |
| `player_session.lua` | `PlayerSession:handle_disconnect()` | 574 | [Details](player_session/index.md) |
| `points_gauge.lua` | `PointsGauge:new(player_id, max_points)` | 252 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:_warn_once(tag, message, extra)` | 290 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:_draw_base()` | 321 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:_draw_fill()` | 340 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:_draw_badge()` | 387 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:show()` | 454 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:set_value(value)` | 470 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:hide()` | 479 | [Details](points_gauge/index.md) |
| `points_gauge.lua` | `PointsGauge:destroy()` | 490 | [Details](points_gauge/index.md) |
| `points_guage.lua` | `PointsGauge:new(player_id, max_points)` | 69 | [Details](points_guage/index.md) |
| `points_guage.lua` | `PointsGauge:_draw_base()` | 91 | [Details](points_guage/index.md) |
| `points_guage.lua` | `PointsGauge:_draw_fill()` | 102 | [Details](points_guage/index.md) |
| `points_guage.lua` | `PointsGauge:_draw_badge()` | 121 | [Details](points_guage/index.md) |
| `points_guage.lua` | `PointsGauge:show()` | 150 | [Details](points_guage/index.md) |
| `points_guage.lua` | `PointsGauge:set_value(value)` | 158 | [Details](points_guage/index.md) |
| `points_guage.lua` | `PointsGauge:hide()` | 167 | [Details](points_guage/index.md) |
| `points_guage.lua` | `PointsGauge:destroy()` | 178 | [Details](points_guage/index.md) |
| `preloader.lua` | `Preloader.add_asset(asset_path)` | 8 | [Details](preloader/index.md) |
| `preloader.lua` | `Preloader.update(area_id)` | 12 | [Details](preloader/index.md) |
| `selection.lua` | `Selection:new(instance)` | 22 | [Details](selection/index.md) |
| `selection.lua` | `Selection:set_filter(filter)` | 41 | [Details](selection/index.md) |
| `selection.lua` | `Selection:set_indicator(indicator)` | 54 | [Details](selection/index.md) |
| `selection.lua` | `Selection:set_shape(shape, shape_offset_x, shape_offset_y)` | 59 | [Details](selection/index.md) |
| `selection.lua` | `Selection:move(position, direction)` | 65 | [Details](selection/index.md) |
| `selection.lua` | `Selection:is_within(x, y, z)` | 72 | [Details](selection/index.md) |
| `selection.lua` | `Selection:indicate()` | 128 | [Details](selection/index.md) |
| `selection.lua` | `Selection:remove_indicators()` | 180 | [Details](selection/index.md) |
| `tileset_embedder.lua` | `Embedder.run()` | 322 | [Details](tileset_embedder/index.md) |
| `validation.lua` | `Validation.validate_area(area_id)` | 136 | [Details](validation/index.md) |
| `validation.lua` | `Validation.report(area_id)` | 243 | [Details](validation/index.md) |

## 📊 Collection summary

This folder subtree contains **32 Lua source files**, **295 named/assigned function detections**, and **281 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
