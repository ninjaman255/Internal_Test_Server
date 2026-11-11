# 📁 ezlibs-scripts

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)
> **Current PlayerControl references:** [HP Manager bootstrap](HP_MANAGER_BOOTSTRAP.md)


## 🗂️ Contents

**Logging note:** `ezlogger.lua` is a compatibility alias. Use [the canonical shared logger](../logger/README.md) for new scripts. All new log files are written beneath `scripts/_DEBUGGING/`.
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `avatar_utils/` | 9 | 50 | 41 | — | [Open folder index](avatar_utils/index.md) |
| 📂 Folder | `ezannounce/` | 2 | 9 | 8 | — | [Open folder index](ezannounce/index.md) |
| 📂 Folder | `ezcutscenes/` | 2 | 26 | 18 | — | [Open folder index](ezcutscenes/index.md) |
| 📂 Folder | `ezencounters/` | 2 | 29 | 28 | — | [Open folder index](ezencounters/index.md) |
| 📂 Folder | `eznpcs/` | 4 | 130 | 72 | — | [Open folder index](eznpcs/index.md) |
| 📂 Folder | `eztriggers/` | 2 | 23 | 17 | — | [Open folder index](eztriggers/index.md) |
| 📂 Folder | `ezwarps/` | 8 | 30 | 52 | — | [Open folder index](ezwarps/index.md) |
| 📂 Folder | `tests/` | 1 | 2 | 5 | — | [Open folder index](tests/index.md) |
| 📂 Folder | `utils/` | 4 | 33 | 12 | — | [Open folder index](utils/index.md) |
| 📄 Script | `announcements_feed.lua` | 1 | 0 | 1 | 16 | [Open script reference](announcements_feed/index.md) |
| 📄 Script | `condition.lua` | 1 | 8 | 1 | 93 | [Open script reference](condition/index.md) |
| 📄 Script | `direction.lua` | 1 | 4 | 5 | 96 | [Open script reference](direction/index.md) |
| 📄 Script | `ezannounce.lua` | 1 | 9 | 7 | 199 | [Open script reference](ezannounce/index.md) |
| 📄 Script | `ezbattle_results.lua` | 1 | 4 | 2 | 31 | [Open script reference](ezbattle_results/index.md) |
| 📄 Script | `ezbbs.lua` | 1 | 21 | 19 | 475 | [Open script reference](ezbbs/index.md) |
| 📄 Script | `ezbottriggers.lua` | 1 | 9 | 7 | 292 | [Open script reference](ezbottriggers/index.md) |
| 📄 Script | `ezbus.lua` | 1 | 7 | 5 | 107 | [Open script reference](ezbus/index.md) |
| 📄 Script | `ezbuttons.lua` | 1 | 67 | 29 | 1979 | [Open script reference](ezbuttons/index.md) |
| 📄 Script | `ezcache.lua` | 1 | 4 | 3 | 59 | [Open script reference](ezcache/index.md) |
| 📄 Script | `ezcheckpoints.lua` | 1 | 12 | 11 | 533 | [Open script reference](ezcheckpoints/index.md) |
| 📄 Script | `ezchristmas.lua` | 1 | 0 | 1 | 11 | [Open script reference](ezchristmas/index.md) |
| 📄 Script | `ezconfig.lua` | 1 | 0 | 0 | 8 | [Open script reference](ezconfig/index.md) |
| 📄 Script | `ezemail.lua` | 1 | 14 | 6 | 346 | [Open script reference](ezemail/index.md) |
| 📄 Script | `ezemitter.lua` | 1 | 24 | 21 | 337 | [Open script reference](ezemitter/index.md) |
| 📄 Script | `ezexplosions.lua` | 1 | 12 | 6 | 329 | [Open script reference](ezexplosions/index.md) |
| 📄 Script | `ezfarms.lua` | 1 | 27 | 51 | 632 | [Open script reference](ezfarms/index.md) |
| 📄 Script | `ezlibs-tiled-schema.lua` | 1 | 0 | 79 | 4029 | [Open script reference](ezlibs-tiled-schema/index.md) |
| 📄 Script | `ezlocks.lua` | 1 | 3 | 1 | 65 | [Open script reference](ezlocks/index.md) |
| 📄 Script | `ezlogger.lua` | 1 | 33 | 13 | 456 | [Open script reference](ezlogger/index.md) |
| 📄 Script | `ezmail.lua` | 1 | 13 | 6 | 340 | [Open script reference](ezmail/index.md) |
| 📄 Script | `ezmapinstance.lua` | 1 | 42 | 7 | 532 | [Open script reference](ezmapinstance/index.md) |
| 📄 Script | `ezmemory.lua` | 1 | 66 | 22 | 1264 | [Open script reference](ezmemory/index.md) |
| 📄 Script | `ezmenus.lua` | 1 | 4 | 1 | 45 | [Open script reference](ezmenus/index.md) |
| 📄 Script | `ezmystery.lua` | 1 | 12 | 11 | 398 | [Open script reference](ezmystery/index.md) |
| 📄 Script | `ezpress.lua` | 1 | 39 | 18 | 829 | [Open script reference](ezpress/index.md) |
| 📄 Script | `ezpushback.lua` | 1 | 27 | 15 | 574 | [Open script reference](ezpushback/index.md) |
| 📄 Script | `ezquests.lua` | 1 | 9 | 3 | 122 | [Open script reference](ezquests/index.md) |
| 📄 Script | `ezrushroads.lua` | 1 | 22 | 33 | 675 | [Open script reference](ezrushroads/index.md) |
| 📄 Script | `eztriggers.lua` | 1 | 13 | 9 | 370 | [Open script reference](eztriggers/index.md) |
| 📄 Script | `ezusers.lua` | 1 | 15 | 11 | 346 | [Open script reference](ezusers/index.md) |
| 📄 Script | `ezweather.lua` | 1 | 8 | 9 | 149 | [Open script reference](ezweather/index.md) |
| 📄 Script | `generate-ezlibs-tiled.lua` | 1 | 24 | 255 | 2309 | [Open script reference](generate-ezlibs-tiled/index.md) |
| 📄 Script | `helpers.lua` | 1 | 19 | 9 | 228 | [Open script reference](helpers/index.md) |
| 📄 Script | `json.lua` | 1 | 19 | 13 | 439 | [Open script reference](json/index.md) |
| 📄 Script | `main.lua` | 1 | 0 | 4 | 255 | [Open script reference](main/index.md) |
| 📄 Script | `object_registry.lua` | 1 | 2 | 3 | 58 | [Open script reference](object_registry/index.md) |
| 📄 Script | `sha256.lua` | 1 | 121 | 35 | 5675 | [Open script reference](sha256/index.md) |
| 📄 Script | `urlencode.lua` | 1 | 2 | 2 | 46 | [Open script reference](urlencode/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `condition.lua` | `condition.date_before(date_string)` | 6 | [Details](condition/index.md) |
| `condition.lua` | `condition.date_after(date_string)` | 10 | [Details](condition/index.md) |
| `condition.lua` | `condition.item(player_id, item_name, amount, consume)` | 14 | [Details](condition/index.md) |
| `condition.lua` | `condition.money(player_id, amount, consume)` | 23 | [Details](condition/index.md) |
| `condition.lua` | `condition.fragments(player_id, amount, consume)` | 32 | [Details](condition/index.md) |
| `condition.lua` | `condition.tokens(player_id, amount, consume)` | 41 | [Details](condition/index.md) |
| `condition.lua` | `condition.quest_flag(player_id, quest_name, flag_name, expected, op)` | 50 | [Details](condition/index.md) |
| `condition.lua` | `condition.evaluate(player_id, cond)` | 73 | [Details](condition/index.md) |
| `direction.lua` | `Direction.reverse(direction)` | 34 | [Details](direction/index.md) |
| `direction.lua` | `Direction.to_vector(direction_str)` | 38 | [Details](direction/index.md) |
| `direction.lua` | `Direction.from_points(point_a, point_b)` | 67 | [Details](direction/index.md) |
| `direction.lua` | `Direction.from_offset(x, y)` | 90 | [Details](direction/index.md) |
| `ezannounce.lua` | `ezannounce.get_feed()` | 92 | [Details](ezannounce/index.md) |
| `ezannounce.lua` | `ezannounce.send_missing(player_id)` | 99 | [Details](ezannounce/index.md) |
| `ezannounce.lua` | `ezannounce.broadcast_missing_to_online()` | 172 | [Details](ezannounce/index.md) |
| `ezannounce.lua` | `ezannounce.start_watch(interval)` | 178 | [Details](ezannounce/index.md) |
| `ezbattle_results.lua` | `ezbattle_results.store(player_id, event)` | 6 | [Details](ezbattle_results/index.md) |
| `ezbattle_results.lua` | `ezbattle_results.peek(player_id)` | 17 | [Details](ezbattle_results/index.md) |
| `ezbattle_results.lua` | `ezbattle_results.consume(player_id)` | 21 | [Details](ezbattle_results/index.md) |
| `ezbattle_results.lua` | `ezbattle_results.clear(player_id)` | 27 | [Details](ezbattle_results/index.md) |
| `ezbbs.lua` | `ezbbs.handle_player_join(player_id)` | 292 | [Details](ezbbs/index.md) |
| `ezbbs.lua` | `ezbbs.handle_player_disconnect(player_id)` | 296 | [Details](ezbbs/index.md) |
| `ezbbs.lua` | `ezbbs.handle_object_interaction(player_id, object_id, button)` | 301 | [Details](ezbbs/index.md) |
| `ezbbs.lua` | `ezbbs.handle_post_selection(player_id, post_id)` | 334 | [Details](ezbbs/index.md) |
| `ezbbs.lua` | `ezbbs.handle_textbox_response(player_id, response)` | 439 | [Details](ezbbs/index.md) |
| `ezbbs.lua` | `ezbbs.handle_board_close(player_id)` | 468 | [Details](ezbbs/index.md) |
| `ezbottriggers.lua` | `ezbottriggers.add_radius_trigger(area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id)` | 35 | [Details](ezbottriggers/index.md) |
| `ezbottriggers.lua` | `ezbottriggers.add_rectangle_trigger(area_id, trigger_object, width, height, trigger_id)` | 86 | [Details](ezbottriggers/index.md) |
| `ezbottriggers.lua` | `ezbottriggers.handle_bot_move(bot_id, x, y, z, area_id)` | 166 | [Details](ezbottriggers/index.md) |
| `ezbottriggers.lua` | `ezbottriggers.clear_radius_overlaps_for_bot(bot_id, reason)` | 238 | [Details](ezbottriggers/index.md) |
| `ezbottriggers.lua` | `ezbottriggers.clear_rectangle_overlaps_for_bot(bot_id, reason)` | 246 | [Details](ezbottriggers/index.md) |
| `ezbottriggers.lua` | `ezbottriggers.handle_bot_created(bot_id, area_id, x, y, z)` | 254 | [Details](ezbottriggers/index.md) |
| `ezbottriggers.lua` | `ezbottriggers.handle_bot_removed(bot_id)` | 269 | [Details](ezbottriggers/index.md) |
| `ezbus.lua` | `ezbus.get(name)` | 46 | [Details](ezbus/index.md) |
| `ezbus.lua` | `ezbus.destroy(name)` | 58 | [Details](ezbus/index.md) |
| `ezbus.lua` | `ezbus.destroy_all()` | 68 | [Details](ezbus/index.md) |
| `ezbus.lua` | `ezbus.exists(name)` | 75 | [Details](ezbus/index.md) |
| `ezbus.lua` | `ezbus.list()` | 80 | [Details](ezbus/index.md) |
| `ezbuttons.lua` | `ezbuttons.handle_player_disconnect(player_id)` | 492 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.camera_release(player_id)` | 587 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.camera_move(player_id, x, y, z)` | 591 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.camera_reattach(player_id)` | 595 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.is_button_active(area_id, object_id)` | 1417 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.activate_button(area_id, object_id, player_id, was_bot)` | 1421 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.deactivate_button(area_id, object_id)` | 1425 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.reset_button(area_id, object_id)` | 1429 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.define_group(area_id, group_id, button_ids, mode, options)` | 1441 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.on_group_change(area_id, group_id, callback)` | 1468 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.add_button_effect(area_id, source_id, event_name, target_id, action)` | 1476 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.add_group_effect(area_id, group_id, event_name, target_id, action)` | 1488 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.refresh_groups(area_id, player_id)` | 1500 | [Details](ezbuttons/index.md) |
| `ezbuttons.lua` | `ezbuttons.get_group_state(area_id, group_id)` | 1510 | [Details](ezbuttons/index.md) |
| `ezcache.lua` | `ezcache.add_cacheable_type(type_name)` | 6 | [Details](ezcache/index.md) |
| `ezcache.lua` | `ezcache.object_is_of_type(object)` | 11 | [Details](ezcache/index.md) |
| `ezcache.lua` | `ezcache.cache_object(area_id, object)` | 16 | [Details](ezcache/index.md) |
| `ezcache.lua` | `ezcache.get_object_by_id_cached(area_id, object_id)` | 36 | [Details](ezcache/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.handle_player_disconnect(player_id)` | 85 | [Details](ezcheckpoints/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.get_player_navi_info(player_id)` | 93 | [Details](ezcheckpoints/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.player_has_navi(player_id, name)` | 106 | [Details](ezcheckpoints/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.player_has_navi_element(player_id, element)` | 111 | [Details](ezcheckpoints/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.player_has_any_navi(player_id, names)` | 116 | [Details](ezcheckpoints/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.unlock_checkpoint_for_player(player_id, area_id, object_id, unlocking_asset_name, unlocking_sound_path, unlocking_animation_time, once, opts)` | 179 | [Details](ezcheckpoints/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.force_unlock_checkpoint(player_id, area_id, object_id, once, opts)` | 268 | [Details](ezcheckpoints/index.md) |
| `ezcheckpoints.lua` | `ezcheckpoints.relock_checkpoint(player_id, area_id, object_id)` | 290 | [Details](ezcheckpoints/index.md) |
| `ezemail.lua` | `ezemail.resend_all(player_id)` | 163 | [Details](ezemail/index.md) |
| `ezemail.lua` | `ezemail.send_once(player_id, mail, opts)` | 225 | [Details](ezemail/index.md) |
| `ezemail.lua` | `ezemail.send_temp(player_id, mail, opts)` | 271 | [Details](ezemail/index.md) |
| `ezemail.lua` | `ezemail.send_test_email(player_id, delay_seconds)` | 293 | [Details](ezemail/index.md) |
| `ezemitter.lua` | `EventEmitter.new()` | 18 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:set_error_handler(fn)` | 34 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:_call(callback, ...)` | 40 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:on(event, callback)` | 56 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:once(event, callback)` | 64 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:on_any(callback)` | 72 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:on_any_once(callback)` | 79 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:emit(event, ...)` | 93 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:remove_listener(event, callback)` | 128 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:remove_on_any_listener(callback)` | 150 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:remove_all_listeners(event)` | 161 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:has_listeners(event)` | 176 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:listener_count(event)` | 187 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:async_iter(event)` | 218 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:async_iter_all()` | 265 | [Details](ezemitter/index.md) |
| `ezemitter.lua` | `EventEmitter:destroy()` | 306 | [Details](ezemitter/index.md) |
| `ezexplosions.lua` | `ExplodingEffect:new(actor_id, opt_area_id, max_explosions, on_complete)` | 242 | [Details](ezexplosions/index.md) |
| `ezexplosions.lua` | `ExplodingEffect:remove()` | 268 | [Details](ezexplosions/index.md) |
| `ezexplosions.lua` | `ezexplosions.explode(actor_id, area_id, max_explosions, on_complete)` | 286 | [Details](ezexplosions/index.md) |
| `ezexplosions.lua` | `ezexplosions.explode_and_wait(actor_id, area_id, max_explosions, timeout_seconds)` | 293 | [Details](ezexplosions/index.md) |
| `ezfarms.lua` | `ezfarms.handle_player_join(player_id)` | 290 | [Details](ezfarms/index.md) |
| `ezfarms.lua` | `ezfarms.on_tick(delta_time)` | 299 | [Details](ezfarms/index.md) |
| `ezfarms.lua` | `ezfarms.handle_post_selection(player_id, post_id)` | 314 | [Details](ezfarms/index.md) |
| `ezfarms.lua` | `ezfarms.handle_board_close(player_id)` | 338 | [Details](ezfarms/index.md) |
| `ezfarms.lua` | `ezfarms.list_player_tools(player_id)` | 389 | [Details](ezfarms/index.md) |
| `ezfarms.lua` | `ezfarms.open_held_item_select(player_id)` | 404 | [Details](ezfarms/index.md) |
| `ezfarms.lua` | `ezfarms.handle_object_interaction(player_id, object_id)` | 443 | [Details](ezfarms/index.md) |
| `ezfarms.lua` | `ezfarms.handle_tile_interaction(player_id, x, y, z, button)` | 573 | [Details](ezfarms/index.md) |
| `ezlocks.lua` | `ezlocks.check_password(player_id, prompt_message, correct_password)` | 9 | [Details](ezlocks/index.md) |
| `ezlocks.lua` | `ezlocks.check_money(player_id, prompt_message, amount, consume)` | 22 | [Details](ezlocks/index.md) |
| `ezlocks.lua` | `ezlocks.check_item(player_id, prompt_message, required_item, amount, consume)` | 43 | [Details](ezlocks/index.md) |
| `ezlogger.lua` | `Logger:_should_log(level)` | 163 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:flush()` | 169 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:_log(level, message, data)` | 218 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:debug(...)` | 241 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:info(...)` | 245 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:warn(...)` | 249 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:error(...)` | 253 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:debug_data(message, data)` | 257 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:info_data(message, data)` | 261 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:warn_data(message, data)` | 265 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:error_data(message, data)` | 269 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:forceFlush()` | 273 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:set_min_level(level)` | 277 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `ezlogger.get(module_name, options)` | 319 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:for_safe_secret(safe_secret, options)` | 328 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:for_player(player_id, options)` | 369 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `Logger:for_area(area_id, options)` | 378 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `ezlogger.configure(options)` | 392 | [Details](ezlogger/index.md) |
| `ezlogger.lua` | `ezlogger.flush_all()` | 421 | [Details](ezlogger/index.md) |
| `ezmail.lua` | `ezemail.resend_all(player_id)` | 157 | [Details](ezmail/index.md) |
| `ezmail.lua` | `ezemail.send_once(player_id, mail, opts)` | 219 | [Details](ezmail/index.md) |
| `ezmail.lua` | `ezemail.send_temp(player_id, mail, opts)` | 265 | [Details](ezmail/index.md) |
| `ezmail.lua` | `ezemail.send_test_email(player_id, delay_seconds)` | 287 | [Details](ezmail/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.set_error_handler(handler)` | 65 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:on(event, callback)` | 141 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:once(event, callback)` | 146 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:on_any(callback)` | 151 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:on_any_once(callback)` | 156 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:off(event, callback)` | 161 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:off_any(callback)` | 166 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:emit(event, ...)` | 172 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:async_iter(event)` | 180 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `record_mt:async_iter_all()` | 186 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.on(event, callback)` | 195 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.once(event, callback)` | 200 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.on_any(callback)` | 205 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.on_any_once(callback)` | 210 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.off(event, callback)` | 215 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.off_any(callback)` | 220 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.emit(event, ...)` | 226 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.async_iter(event)` | 233 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.async_iter_all()` | 238 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.create(base_area_id, preferred_instance_id, options)` | 254 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.get(instance_id)` | 315 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.exists(instance_id)` | 320 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.is_valid(instance_id)` | 326 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.get_for_player(player_id)` | 338 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.list()` | 347 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.set_host(instance_id, player_id)` | 357 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.get_host(instance_id)` | 370 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.is_host(instance_id, player_id)` | 375 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.register_player(instance_id, player_id)` | 382 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.unregister_player(instance_id, player_id)` | 412 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.add_player(instance_id, player_id)` | 444 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.remove_player(instance_id, player_id)` | 448 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.transfer_player(instance_id, player_id, x, y, z, warp_in, direction)` | 456 | [Details](ezmapinstance/index.md) |
| `ezmapinstance.lua` | `EzMapInstance.remove(instance_id)` | 491 | [Details](ezmapinstance/index.md) |
| `ezmemory.lua` | `ezmemory.wait_until_loaded()` | 355 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.is_loaded()` | 363 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_item_info(item_id)` | 372 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.create_or_update_item(item_name, item_description, is_key)` | 379 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_item_id_by_name(item_name)` | 404 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_or_create_item(item_name, item_description, is_key)` | 415 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.save_items()` | 423 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.save_area_memory(area_id)` | 427 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.save_player_memory(safe_secret)` | 431 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.clear_area_memory(area_id)` | 438 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.dangerously_override_player_memory(safe_secret, new_memory)` | 462 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_area_memory(area_id)` | 468 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_memory(safe_secret)` | 512 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_area_memory(safe_secret, area_id)` | 532 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.update_player_list(safe_secret, name)` | 546 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_name_from_safesecret(safe_secret)` | 551 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.give_player_item(player_id, name, amount)` | 560 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.remove_player_item(player_id, name, remove_quant)` | 596 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_money(player_id)` | 631 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.spend_player_money(player_id, amount)` | 656 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.add_player_money(player_id, amount)` | 678 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.set_player_money(player_id, money)` | 699 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_fragments(player_id)` | 711 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.set_player_fragments(player_id, fragments)` | 736 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.add_player_fragments(player_id, amount)` | 752 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.spend_player_fragments(player_id, amount)` | 768 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_tokens(player_id)` | 800 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.set_player_tokens(player_id, tokens)` | 810 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.add_player_tokens(player_id, amount)` | 823 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.spend_player_tokens(player_id, amount)` | 838 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.count_player_item(player_id, item_name)` | 869 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.open_shop_async(player_id, shop_items, mugshot_texture_path, mugshot_animation_path)` | 882 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.hide_object_from_player_till_disconnect(player_id, area_id, object_id)` | 903 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.unhide_object_from_player_till_disconnect(player_id, area_id, object_id)` | 946 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.unhide_object_from_player(player_id, area_id, object_id)` | 968 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.hide_object_from_player(player_id, area_id, object_id)` | 996 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.object_is_hidden_from_player(player_id, area_id, object_id)` | 1016 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.object_is_hidden_from_player_till_disconnect(player_id, area_id, object_id)` | 1033 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.handle_player_disconnect(player_id)` | 1042 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.handle_player_join(player_id)` | 1046 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.handle_player_transfer(player_id)` | 1088 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.calculate_player_modified_max_hp(player_id, base_max_hp, hp_memory_modifier, hp_memory_item)` | 1128 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_max_health(player_id)` | 1134 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.get_player_health(player_id)` | 1140 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.set_player_max_health(player_id, new_max_health, should_heal_by_increase)` | 1146 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.set_player_health(player_id, new_health)` | 1174 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.handle_player_avatar_change(player_id, details)` | 1192 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.give_item_with_optional_notify(player_id, area_id, item_object_id, item_info, notify_player)` | 1197 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.play_anim_get(player_id)` | 1240 | [Details](ezmemory/index.md) |
| `ezmemory.lua` | `ezmemory.set_direction_anim(player_id, direction)` | 1257 | [Details](ezmemory/index.md) |
| `ezmenus.lua` | `ezmenus.open_menu(player_id, board_name, color, posts)` | 3 | [Details](ezmenus/index.md) |
| `ezmenus.lua` | `board_emitter.close_async()` | 5 | [Details](ezmenus/index.md) |
| `ezmenus.lua` | `board_emitter.selection_once()` | 19 | [Details](ezmenus/index.md) |
| `ezmystery.lua` | `ezmystery.handle_player_disconnect(player_id)` | 92 | [Details](ezmystery/index.md) |
| `ezmystery.lua` | `ezmystery.hide_random_data(player_id)` | 96 | [Details](ezmystery/index.md) |
| `ezmystery.lua` | `ezmystery.handle_player_transfer(player_id)` | 133 | [Details](ezmystery/index.md) |
| `ezmystery.lua` | `ezmystery.handle_player_join(player_id)` | 137 | [Details](ezmystery/index.md) |
| `ezpress.lua` | `ezpress:on(event_name, callback)` | 106 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress:once(event_name, callback)` | 111 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.get_area_scale_state(area_id)` | 120 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.get_area_size_mode_scope(area_id)` | 130 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.set_scale_state(player_id, state, immediate, metadata)` | 157 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.get_scale_state(player_id)` | 203 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.is_compressed(player_id)` | 208 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.is_enlarged(player_id)` | 212 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.compress(player_id, immediate, metadata)` | 216 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.decompress(player_id, immediate, metadata)` | 220 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.enlarge(player_id, immediate, metadata)` | 224 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.set_bot_scale_state(bot_id, state, immediate, metadata)` | 254 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.get_bot_scale_state(bot_id)` | 296 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.get_tile_state_at(area_id, pos)` | 334 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.check_and_apply(player_id, area_id, pos, immediate)` | 344 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.apply_area_scale_to_bots(area_id, immediate, metadata)` | 591 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.apply_map_property(player_id, area_id, immediate, extra_metadata)` | 644 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.handle_bot_created(bot_id, area_id, x, y, z)` | 665 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.handle_bot_removed(bot_id)` | 709 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.handle_player_join(player_id)` | 734 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.handle_player_transfer(player_id)` | 750 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.handle_player_move(player_id, x, y, z)` | 764 | [Details](ezpress/index.md) |
| `ezpress.lua` | `ezpress.handle_player_disconnect(player_id)` | 787 | [Details](ezpress/index.md) |
| `ezpushback.lua` | `ezpushback.get_emitter(area_id, object_id)` | 504 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.set_collision_enabled(area_id, object_id, enabled)` | 509 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_move(player_id, x, y, z)` | 517 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.on_tick(delta_time)` | 522 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_join(player_id)` | 544 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_transfer(player_id)` | 556 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_disconnect(player_id)` | 563 | [Details](ezpushback/index.md) |
| `ezquests.lua` | `ezquests.add_quest(quest)` | 9 | [Details](ezquests/index.md) |
| `ezquests.lua` | `ezquests.set_player_quest_flag(player_id,quest_name,flag_name,flag_state)` | 28 | [Details](ezquests/index.md) |
| `ezquests.lua` | `ezquests.get_player_quest_flag(player_id,quest_name,flag_name,flag_state)` | 42 | [Details](ezquests/index.md) |
| `ezquests.lua` | `ezquests.clear_player_quest_flags(player_id,quest_name)` | 54 | [Details](ezquests/index.md) |
| `ezquests.lua` | `ezquests.get_quest(quest_name)` | 65 | [Details](ezquests/index.md) |
| `ezquests.lua` | `ezquests.get_player_quest_state(player_id, quest_name)` | 74 | [Details](ezquests/index.md) |
| `ezquests.lua` | `ezquests.quest_event(player_id,quest_name,event_value)` | 83 | [Details](ezquests/index.md) |
| `ezrushroads.lua` | `ezrushroads.get_food(player_id)` | 97 | [Details](ezrushroads/index.md) |
| `ezrushroads.lua` | `ezrushroads.add_food(player_id, amount)` | 102 | [Details](ezrushroads/index.md) |
| `ezrushroads.lua` | `ezrushroads.remove_food(player_id, amount)` | 111 | [Details](ezrushroads/index.md) |
| `ezrushroads.lua` | `ezrushroads.init()` | 314 | [Details](ezrushroads/index.md) |
| `ezrushroads.lua` | `ezrushroads.handle_player_join(player_id)` | 481 | [Details](ezrushroads/index.md) |
| `ezrushroads.lua` | `ezrushroads.handle_player_disconnect(player_id)` | 505 | [Details](ezrushroads/index.md) |
| `ezrushroads.lua` | `ezrushroads.handle_player_transfer(player_id)` | 526 | [Details](ezrushroads/index.md) |
| `ezrushroads.lua` | `ezrushroads.handle_object_interaction(player_id, object_id)` | 534 | [Details](ezrushroads/index.md) |
| `eztriggers.lua` | `eztriggers.add_location_event_trigger(area_id,object)` | 20 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.add_interact_trigger(area_id,trigger_object)` | 68 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.add_radius_trigger(area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id)` | 84 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.add_rectangle_trigger(area_id, trigger_object, width, height, trigger_id)` | 143 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.handle_object_interaction(player_id,object_id,button)` | 194 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.handle_player_move(player_id, x, y, z)` | 240 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.add_event(event_object)` | 320 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.clear_radius_overlaps_for_player(player_id, reason)` | 335 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.clear_rectangle_overlaps_for_player(player_id, reason)` | 343 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.handle_player_transfer(player_id)` | 351 | [Details](eztriggers/index.md) |
| `eztriggers.lua` | `eztriggers.handle_player_disconnect(player_id)` | 359 | [Details](eztriggers/index.md) |
| `ezweather.lua` | `ezweather.start_rain_in_area(area_id)` | 25 | [Details](ezweather/index.md) |
| `ezweather.lua` | `ezweather.start_snow_in_area(area_id)` | 51 | [Details](ezweather/index.md) |
| `ezweather.lua` | `ezweather.start_fog_in_area(area_id)` | 77 | [Details](ezweather/index.md) |
| `ezweather.lua` | `ezweather.get_area_weather(area_id)` | 105 | [Details](ezweather/index.md) |
| `ezweather.lua` | `ezweather.clear_weather_in_area(area_id)` | 113 | [Details](ezweather/index.md) |
| `ezweather.lua` | `ezweather.handle_player_transfer(player_id)` | 135 | [Details](ezweather/index.md) |
| `ezweather.lua` | `ezweather.handle_player_join(player_id)` | 142 | [Details](ezweather/index.md) |
| `helpers.lua` | `helpers.indexOf(array, value)` | 27 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.extract_numbered_properties(object,property_prefix)` | 36 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.clear_table(tbl)` | 47 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.create_bbs_option(text,id)` | 54 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.deep_copy(orig)` | 61 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.split(string, delimiter)` | 65 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.get_safe_player_secret(player_id)` | 73 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.safe_require(script_path)` | 79 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.date_string_to_timestamp(date_string)` | 93 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.is_now_before_date(date_string)` | 109 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.position_overlaps_something(position,area_id)` | 118 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.get_lock(player_id,lock_id,timeout)` | 135 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.read_item_information(area_id, item_object_id)` | 160 | [Details](helpers/index.md) |
| `helpers.lua` | `helpers.ensure_directory(path)` | 183 | [Details](helpers/index.md) |
| `json.lua` | `json.encode(val, pretty)` | 179 | [Details](json/index.md) |
| `json.lua` | `json.decode(str)` | 426 | [Details](json/index.md) |
| `object_registry.lua` | `object_registry.register_handler(object_type, callback, cache)` | 13 | [Details](object_registry/index.md) |
| `object_registry.lua` | `object_registry.load_all()` | 30 | [Details](object_registry/index.md) |
| `urlencode.lua` | `urlencode.table(t)` | 29 | [Details](urlencode/index.md) |

## 📊 Collection summary

This folder subtree contains **73 Lua source files**, **1047 named/assigned function detections**, and **987 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `MODULE_DEPENDENCIES.md`](MODULE_DEPENDENCIES.md) | 🔗 ezlibs-scripts — Current Module Dependencies |
| [📘 `README-UPDATED.md`](README-UPDATED.md) | ezlibs — Complete Documentation (Formatted for Developers) |
| [📘 `ezlibs-tiled-reference.md`](ezlibs-tiled-reference.md) | Tiled Reference |
| [📘 `readme.md`](readme.md) | 📚 ezlibs Library — Complete Documentation |
