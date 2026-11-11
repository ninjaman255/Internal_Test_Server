# 📄 `eznpcs_onceitem.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/events/eznpcs_onceitem.lua`](../../../events/eznpcs_onceitem.lua)  
> **Source lines:** 3580  
> **SHA-256 (UTF-8):** `629c2ff6c9059330dd90a9c4cee4edb3881bbb244ba3369f662d3cafc2096fe4`  
> **Named functions detected:** 131  
> **Table initializers detected:** 39

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
| 19 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 20 | `scripts/ezlibs-scripts/helpers` |
| 21 | `scripts/ezlibs-scripts/ezmemory` |
| 22 | `scripts/ezlibs-scripts/ezmenus` |
| 23 | `scripts/ezlibs-scripts/ezweather` |
| 24 | `scripts/ezlibs-custom/custom` |
| 25 | `scripts/ezlibs-custom/pets` |
| 26 | `scripts/ezlibs-custom/jukebox` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 2862 | `Net` | `virtual_input` |
| 3026 | `Net` | `player_area_transfer` |
| 3039 | `Net` | `player_join_area` |
| 3049 | `Net` | `player_join` |
| 3485 | `Net` | `object_interaction` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 142 | `is_pet_item_id` | `id` | local |
| 146 | `pet_kind_from_item_id` | `id` | local |
| 157 | `_oh_log` | `pid, msg` | local |
| 169 | `_mark_ignore_next_close` | `pid, reason` | local |
| 176 | `_open_menu_ignoring_custom` | `pid, title, color, posts, reason` | local |
| 183 | `_path_tail` | `p` | local |
| 190 | `catalog_resolve_gid` | `area_id, entry` | local |
| 213 | `catalog_entry_by_gid` | `area_id, gid` | local |
| 223 | `dprop` | `dialogue, key, default` | local |
| 229 | `cprop` | `obj_custom, key, default` | local |
| 235 | `normalize_key` | `s` | local |
| 242 | `_pick_existing_mem_area` | `fallback` | local |
| 252 | `_area_exists` | `area_id` | local |
| 262 | `resolve_mem_area_id` | `dialogue, player_id, obj_custom` | local |
| 278 | `say` | `player_id, text, mug` | local |
| 285 | `ask_yes_no` | `player_id, prompt, mug` | local |
| 290 | `ask_text` | `player_id, prompt, mug` | local |
| 295 | `fmt` | `ts` | local |
| 300 | `add_months` | `ts, months` | local |
| 309 | `compute_period` | `now_ts, months, minutes` | local |
| 317 | `resolve_manual_purchased_at` | `dialogue, now_ts` | local |
| 336 | `menu_closed_now` | `pid, secs` | local |
| 344 | `recently_closed_menu` | `pid` | local |
| 348 | `fast_close_board` | `pid` | local |
| 360 | `ensure_bucket_mem` | `BUCKET_AREA_ID` | local |
| 370 | `purge_player_key_if_invalid` | `player_id, BUCKET_AREA_ID, once_key, item_name` | local |
| 386 | `get_record_and_prune` | `BUCKET_AREA_ID, once_key` | local |
| 423 | `eznpcs.player_has_active_lease` | `player_id, once_key, bucket_area_id` | assigned/declared |
| 426 | `check_area` | `area_id` | local |
| 445 | `dir_to_offset` | `dir` | local |
| 458 | `get_cursor_point` | `player_id, dist` | local |
| 479 | `clamp_cursor_to_map` | `area_id, x, y, z` | local |
| 494 | `init_free_cursor` | `pid, s` | local |
| 509 | `get_session_cursor` | `pid, s` | local |
| 518 | `follow_preview_camera` | `pid, x, y, z` | local |
| 560 | `lock_for_preview` | `pid, s` | local |
| 571 | `unlock_after_preview` | `pid, s` | local |
| 616 | `stop_session` | `player_id, reason` | local |
| 645 | `try_resolve_test_gid` | `dialogue, area_id` | local |
| 648 | `norm` | `s` | local |
| 649 | `looks_like_bus_stop` | `s` | local |
| 681 | `resolve_removal_cursor_gid` | `area_id` | local |
| 710 | `_tmx_read_map_tilesize` | `xml` | local |
| 716 | `find_prototype_for_gid` | `area_id, target_gid` | local |
| 736 | `get_template_dims_from_layer` | `area_id, layer_name, gid` | local |
| 764 | `get_gid_dims_in_tiles` | `area_id, gid` | local |
| 776 | `resolve_object_dims` | `area_id, template_layer_name, gid` | local |
| 792 | `object_covers_point` | `o, x, y, z` | local |
| 799 | `find_oncehub_object_at` | `area_id, x, y, z` | local |
| 818 | `decode_gid_flags` | `raw` | local |
| 827 | `gid_base` | `raw_gid` | local |
| 833 | `_tmx_flip_flags_from_layer` | `area_id, layer_name, base_gid` | local |
| 858 | `resolve_preview_flip_flags` | `area_id, template_layer_name, base_gid, def_fh, def_fv, def_fr` | local |
| 880 | `ensure_preview` | `player_id` | local |
| 1054 | `_decor_ci` | `dialogue` | local |
| 1061 | `_decor_get_prop_ci` | `ci, key` | local |
| 1063 | `_catalog_by_id` | `id` | local |
| 1070 | `_player_decor_mem` | `pid` | local |
| 1076 | `decor_count_owned` | `pid, id` | local |
| 1081 | `decor_add_owned` | `pid, id, qty` | local |
| 1089 | `short_money` | `n` | local |
| 1108 | `price_for` | `dialogue, id` | local |
| 1125 | `_catalog_by_id` | `id` | local |
| 1131 | `_decor_ci` | `dialogue` | local |
| 1139 | `_decor_get_prop_ci` | `ci, key` | local |
| 1143 | `price_for_index_or_id` | `dialogue, idx, id` | local |
| 1161 | `_pmem_secret` | `pid` | local |
| 1169 | `_pmem_get` | `pid` | local |
| 1183 | `_decor_inv` | `pid` | local |
| 1188 | `decor_count_owned` | `pid, id` | local |
| 1195 | `decor_set_owned` | `pid, id, count` | local |
| 1207 | `decor_add_owned` | `pid, id, qty` | local |
| 1214 | `count_placed_in_area_by_player` | `area_id, once_key, object_id, pid` | local |
| 1236 | `decor_left_to_place` | `pid, area_id, once_key, object_id` | local |
| 1248 | `snapshot_oncehub_placements` | `area_id, once_key` | local |
| 1290 | `_remember_key_area` | `mem_area, key, area_id` | local |
| 1298 | `save_placements` | `area_id, bucket_area_id, once_key` | local |
| 1314 | `rehydrate_placements` | `area_id, bucket_area_id, once_key` | local |
| 1446 | `ensure_rehydrated` | `player_id, dialogue` | local |
| 1465 | `_cleanup_expired_hp` | `area_id, bucket_area_id, once_key` | assigned/declared |
| 1497 | `_lease_rec_for_key` | `bucket_area_id, key` | local |
| 1506 | `_apply_jukebox_song` | `area_id, bucket_area_id, once_key` | local |
| 1520 | `rehydrate_all_for_area` | `area_id` | local |
| 1523 | `try_from` | `bucket_area_id` | local |
| 1586 | `_rehydrate_from_event` | `ev` | local |
| 1595 | `_oncehub_rehydrate_for_player` | `pid` | local |
| 1607 | `_safe_get_player` | `ev` | local |
| 1611 | `_safe_get_to_area` | `ev, pid` | local |
| 1618 | `ezweather.handle_player_join` | `pid` | assigned/declared |
| 1627 | `ezweather.handle_player_transfer` | `pid` | assigned/declared |
| 1634 | `_cf_key` | `area_id, once_key, x, y, z` | local |
| 1644 | `_cf_mem` | `area_id` | local |
| 1650 | `_cf_record_bot` | `area_id, once_key, x, y, z, bot_id` | local |
| 1656 | `_cf_remove_bot` | `area_id, once_key, x, y, z, direct_id` | local |
| 1691 | `_find_card_item_id_by_title` | `pid, title` | local |
| 1707 | `_dec_player_item_count` | `pid, item_id, n` | local |
| 1720 | `_inc_inventory_by_secret` | `secret, item_id, n` | local |
| 1733 | `_refund_card_to_frame_owner` | `cp` | local |
| 1758 | `persist_area` | `area_id, bucket_area_id, once_key` | assigned/declared |
| 1788 | `place_current` | `player_id` | local |
| 1932 | `remove_current` | `player_id` | local |
| 1965 | `get_template_layer_name` | `dialogue` | local |
| 1971 | `start_place_session` | `player_id, dialogue, chosen_gid, chosen_name, chosen_id, template_layer` | local |
| 2040 | `open_place_catalog_menu` | `player_id, dialogue` | local |
| 2124 | `start_remove_session` | `player_id, dialogue` | local |
| 2160 | `open_decorate_menu` | `player_id, dialogue` | local |
| 2197 | `find_my_object` | `(none)` | local |
| 2340 | `open_pass_menu` | `player_id, npc, dialogue` | local |
| 2414 | `_get_rental_record` | `player_id, dialogue` | local |
| 2423 | `_is_current_renter` | `player_id, dialogue` | local |
| 2432 | `_find_visitor_object` | `area_id, once_key, visitor_secret` | local |
| 2447 | `open_visitor_decor_menu` | `player_id, dialogue` | local |
| 2495 | `_pets_require` | `(none)` | local |
| 2500 | `_pets_auth_renter` | `player_id, dialogue` | local |
| 2523 | `start_pet_place_session` | `player_id, dialogue, pet_id, pet_name` | local |
| 2587 | `place_pet_current` | `player_id` | local |
| 2641 | `open_pets_summon_menu` | `player_id, npc, dialogue` | local |
| 2725 | `open_pets_remove_menu` | `player_id, npc, dialogue` | local |
| 2804 | `open_pets_menu` | `player_id, npc, dialogue` | local |
| 2830 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 2889 | `action_ok` | `key, seconds` | local |
| 2900 | `nudge_cursor` | `dx, dy` | local |
| 3061 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 3097 | `finish` | `next_id` | local |
| 3106 | `save_record` | `r` | local |
| 3112 | `can_afford` | `amount` | local |
| 3117 | `grant_key_if_missing` | `(none)` | local |
| 3130 | `new_window_from` | `ts` | local |
| 3315 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 3373 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 3502 | `run_logic` | `with_lock` | local |

### Parameter inventory

#### 1. `is_pet_item_id(id)`

- **Line:** 142
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 2. `pet_kind_from_item_id(id)`

- **Line:** 146
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 3. `_oh_log(pid, msg)`

- **Line:** 157
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `msg` | Declared directly in the current Lua. Type not inferred. |

#### 4. `_mark_ignore_next_close(pid, reason)`

- **Line:** 169
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `reason` | Declared directly in the current Lua. Type not inferred. |

#### 5. `_open_menu_ignoring_custom(pid, title, color, posts, reason)`

- **Line:** 176
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `title` | Declared directly in the current Lua. Type not inferred. |
| 3 | `color` | Declared directly in the current Lua. Type not inferred. |
| 4 | `posts` | Declared directly in the current Lua. Type not inferred. |
| 5 | `reason` | Declared directly in the current Lua. Type not inferred. |

#### 6. `_path_tail(p)`

- **Line:** 183
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared directly in the current Lua. Type not inferred. |

#### 7. `catalog_resolve_gid(area_id, entry)`

- **Line:** 190
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `entry` | Declared directly in the current Lua. Type not inferred. |

#### 8. `catalog_entry_by_gid(area_id, gid)`

- **Line:** 213
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `gid` | Declared directly in the current Lua. Type not inferred. |

#### 9. `dprop(dialogue, key, default)`

- **Line:** 223
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `default` | Declared directly in the current Lua. Type not inferred. |

#### 10. `cprop(obj_custom, key, default)`

- **Line:** 229
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `obj_custom` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `default` | Declared directly in the current Lua. Type not inferred. |

#### 11. `normalize_key(s)`

- **Line:** 235
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared directly in the current Lua. Type not inferred. |

#### 12. `_pick_existing_mem_area(fallback)`

- **Line:** 242
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fallback` | Declared directly in the current Lua. Type not inferred. |

#### 13. `_area_exists(area_id)`

- **Line:** 252
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 14. `resolve_mem_area_id(dialogue, player_id, obj_custom)`

- **Line:** 262
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `obj_custom` | Declared directly in the current Lua. Type not inferred. |

#### 15. `say(player_id, text, mug)`

- **Line:** 278
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `text` | Declared directly in the current Lua. Type not inferred. |
| 3 | `mug` | Declared directly in the current Lua. Type not inferred. |

#### 16. `ask_yes_no(player_id, prompt, mug)`

- **Line:** 285
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `prompt` | Declared directly in the current Lua. Type not inferred. |
| 3 | `mug` | Declared directly in the current Lua. Type not inferred. |

#### 17. `ask_text(player_id, prompt, mug)`

- **Line:** 290
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `prompt` | Declared directly in the current Lua. Type not inferred. |
| 3 | `mug` | Declared directly in the current Lua. Type not inferred. |

#### 18. `fmt(ts)`

- **Line:** 295
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ts` | Declared directly in the current Lua. Type not inferred. |

#### 19. `add_months(ts, months)`

- **Line:** 300
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ts` | Declared directly in the current Lua. Type not inferred. |
| 2 | `months` | Declared directly in the current Lua. Type not inferred. |

#### 20. `compute_period(now_ts, months, minutes)`

- **Line:** 309
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `now_ts` | Declared directly in the current Lua. Type not inferred. |
| 2 | `months` | Declared directly in the current Lua. Type not inferred. |
| 3 | `minutes` | Declared directly in the current Lua. Type not inferred. |

#### 21. `resolve_manual_purchased_at(dialogue, now_ts)`

- **Line:** 317
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 2 | `now_ts` | Declared directly in the current Lua. Type not inferred. |

#### 22. `menu_closed_now(pid, secs)`

- **Line:** 336
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `secs` | Declared directly in the current Lua. Type not inferred. |

#### 23. `recently_closed_menu(pid)`

- **Line:** 344
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 24. `fast_close_board(pid)`

- **Line:** 348
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 25. `ensure_bucket_mem(BUCKET_AREA_ID)`

- **Line:** 360
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `BUCKET_AREA_ID` | Declared directly in the current Lua. Type not inferred. |

#### 26. `purge_player_key_if_invalid(player_id, BUCKET_AREA_ID, once_key, item_name)`

- **Line:** 370
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `BUCKET_AREA_ID` | Declared directly in the current Lua. Type not inferred. |
| 3 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 4 | `item_name` | Declared directly in the current Lua. Type not inferred. |

#### 27. `get_record_and_prune(BUCKET_AREA_ID, once_key)`

- **Line:** 386
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `BUCKET_AREA_ID` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |

#### 28. `eznpcs.player_has_active_lease(player_id, once_key, bucket_area_id)`

- **Line:** 423
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |

#### 29. `check_area(area_id)`

- **Line:** 426
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 30. `dir_to_offset(dir)`

- **Line:** 445
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dir` | Declared directly in the current Lua. Type not inferred. |

#### 31. `get_cursor_point(player_id, dist)`

- **Line:** 458
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dist` | Declared directly in the current Lua. Type not inferred. |

#### 32. `clamp_cursor_to_map(area_id, x, y, z)`

- **Line:** 479
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 33. `init_free_cursor(pid, s)`

- **Line:** 494
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `s` | Declared directly in the current Lua. Type not inferred. |

#### 34. `get_session_cursor(pid, s)`

- **Line:** 509
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `s` | Declared directly in the current Lua. Type not inferred. |

#### 35. `follow_preview_camera(pid, x, y, z)`

- **Line:** 518
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 36. `lock_for_preview(pid, s)`

- **Line:** 560
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `s` | Declared directly in the current Lua. Type not inferred. |

#### 37. `unlock_after_preview(pid, s)`

- **Line:** 571
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `s` | Declared directly in the current Lua. Type not inferred. |

#### 38. `stop_session(player_id, reason)`

- **Line:** 616
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `reason` | Declared directly in the current Lua. Type not inferred. |

#### 39. `try_resolve_test_gid(dialogue, area_id)`

- **Line:** 645
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 40. `norm(s)`

- **Line:** 648
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared directly in the current Lua. Type not inferred. |

#### 41. `looks_like_bus_stop(s)`

- **Line:** 649
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared directly in the current Lua. Type not inferred. |

#### 42. `resolve_removal_cursor_gid(area_id)`

- **Line:** 681
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 43. `_tmx_read_map_tilesize(xml)`

- **Line:** 710
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `xml` | Declared directly in the current Lua. Type not inferred. |

#### 44. `find_prototype_for_gid(area_id, target_gid)`

- **Line:** 716
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `target_gid` | Declared directly in the current Lua. Type not inferred. |

#### 45. `get_template_dims_from_layer(area_id, layer_name, gid)`

- **Line:** 736
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `layer_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `gid` | Declared directly in the current Lua. Type not inferred. |

#### 46. `get_gid_dims_in_tiles(area_id, gid)`

- **Line:** 764
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `gid` | Declared directly in the current Lua. Type not inferred. |

#### 47. `resolve_object_dims(area_id, template_layer_name, gid)`

- **Line:** 776
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `template_layer_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `gid` | Declared directly in the current Lua. Type not inferred. |

#### 48. `object_covers_point(o, x, y, z)`

- **Line:** 792
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `o` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 49. `find_oncehub_object_at(area_id, x, y, z)`

- **Line:** 799
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 50. `decode_gid_flags(raw)`

- **Line:** 818
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw` | Declared directly in the current Lua. Type not inferred. |

#### 51. `gid_base(raw_gid)`

- **Line:** 827
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw_gid` | Declared directly in the current Lua. Type not inferred. |

#### 52. `_tmx_flip_flags_from_layer(area_id, layer_name, base_gid)`

- **Line:** 833
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `layer_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `base_gid` | Declared directly in the current Lua. Type not inferred. |

#### 53. `resolve_preview_flip_flags(area_id, template_layer_name, base_gid, def_fh, def_fv, def_fr)`

- **Line:** 858
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `template_layer_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `base_gid` | Declared directly in the current Lua. Type not inferred. |
| 4 | `def_fh` | Declared directly in the current Lua. Type not inferred. |
| 5 | `def_fv` | Declared directly in the current Lua. Type not inferred. |
| 6 | `def_fr` | Declared directly in the current Lua. Type not inferred. |

#### 54. `ensure_preview(player_id)`

- **Line:** 880
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 55. `_decor_ci(dialogue)`

- **Line:** 1054
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 56. `_decor_get_prop_ci(ci, key)`

- **Line:** 1061
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ci` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |

#### 57. `_catalog_by_id(id)`

- **Line:** 1063
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 58. `_player_decor_mem(pid)`

- **Line:** 1070
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 59. `decor_count_owned(pid, id)`

- **Line:** 1076
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 60. `decor_add_owned(pid, id, qty)`

- **Line:** 1081
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `qty` | Declared directly in the current Lua. Type not inferred. |

#### 61. `short_money(n)`

- **Line:** 1089
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `n` | Declared directly in the current Lua. Type not inferred. |

#### 62. `price_for(dialogue, id)`

- **Line:** 1108
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 2 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 63. `_catalog_by_id(id)`

- **Line:** 1125
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 64. `_decor_ci(dialogue)`

- **Line:** 1131
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 65. `_decor_get_prop_ci(ci, key)`

- **Line:** 1139
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ci` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |

#### 66. `price_for_index_or_id(dialogue, idx, id)`

- **Line:** 1143
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 2 | `idx` | Declared directly in the current Lua. Type not inferred. |
| 3 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 67. `_pmem_secret(pid)`

- **Line:** 1161
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 68. `_pmem_get(pid)`

- **Line:** 1169
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 69. `_decor_inv(pid)`

- **Line:** 1183
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 70. `decor_count_owned(pid, id)`

- **Line:** 1188
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 71. `decor_set_owned(pid, id, count)`

- **Line:** 1195
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `count` | Declared directly in the current Lua. Type not inferred. |

#### 72. `decor_add_owned(pid, id, qty)`

- **Line:** 1207
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `qty` | Declared directly in the current Lua. Type not inferred. |

#### 73. `count_placed_in_area_by_player(area_id, once_key, object_id, pid)`

- **Line:** 1214
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 74. `decor_left_to_place(pid, area_id, once_key, object_id)`

- **Line:** 1236
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 4 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 75. `snapshot_oncehub_placements(area_id, once_key)`

- **Line:** 1248
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |

#### 76. `_remember_key_area(mem_area, key, area_id)`

- **Line:** 1290
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `mem_area` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 77. `save_placements(area_id, bucket_area_id, once_key)`

- **Line:** 1298
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `once_key` | Declared directly in the current Lua. Type not inferred. |

#### 78. `rehydrate_placements(area_id, bucket_area_id, once_key)`

- **Line:** 1314
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `once_key` | Declared directly in the current Lua. Type not inferred. |

#### 79. `ensure_rehydrated(player_id, dialogue)`

- **Line:** 1446
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 80. `_cleanup_expired_hp(area_id, bucket_area_id, once_key)`

- **Line:** 1465
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `once_key` | Declared directly in the current Lua. Type not inferred. |

#### 81. `_lease_rec_for_key(bucket_area_id, key)`

- **Line:** 1497
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |

#### 82. `_apply_jukebox_song(area_id, bucket_area_id, once_key)`

- **Line:** 1506
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `once_key` | Declared directly in the current Lua. Type not inferred. |

#### 83. `rehydrate_all_for_area(area_id)`

- **Line:** 1520
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 84. `try_from(bucket_area_id)`

- **Line:** 1523
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |

#### 85. `_rehydrate_from_event(ev)`

- **Line:** 1586
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared directly in the current Lua. Type not inferred. |

#### 86. `_oncehub_rehydrate_for_player(pid)`

- **Line:** 1595
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 87. `_safe_get_player(ev)`

- **Line:** 1607
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared directly in the current Lua. Type not inferred. |

#### 88. `_safe_get_to_area(ev, pid)`

- **Line:** 1611
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared directly in the current Lua. Type not inferred. |
| 2 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 89. `ezweather.handle_player_join(pid)`

- **Line:** 1618
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 90. `ezweather.handle_player_transfer(pid)`

- **Line:** 1627
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 91. `_cf_key(area_id, once_key, x, y, z)`

- **Line:** 1634
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 92. `_cf_mem(area_id)`

- **Line:** 1644
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 93. `_cf_record_bot(area_id, once_key, x, y, z, bot_id)`

- **Line:** 1650
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |
| 6 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 94. `_cf_remove_bot(area_id, once_key, x, y, z, direct_id)`

- **Line:** 1656
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |
| 6 | `direct_id` | Declared directly in the current Lua. Type not inferred. |

#### 95. `_find_card_item_id_by_title(pid, title)`

- **Line:** 1691
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `title` | Declared directly in the current Lua. Type not inferred. |

#### 96. `_dec_player_item_count(pid, item_id, n)`

- **Line:** 1707
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `item_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `n` | Declared directly in the current Lua. Type not inferred. |

#### 97. `_inc_inventory_by_secret(secret, item_id, n)`

- **Line:** 1720
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `secret` | Declared directly in the current Lua. Type not inferred. |
| 2 | `item_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `n` | Declared directly in the current Lua. Type not inferred. |

#### 98. `_refund_card_to_frame_owner(cp)`

- **Line:** 1733
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cp` | Declared directly in the current Lua. Type not inferred. |

#### 99. `persist_area(area_id, bucket_area_id, once_key)`

- **Line:** 1758
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bucket_area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `once_key` | Declared directly in the current Lua. Type not inferred. |

#### 100. `place_current(player_id)`

- **Line:** 1788
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 101. `remove_current(player_id)`

- **Line:** 1932
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 102. `get_template_layer_name(dialogue)`

- **Line:** 1965
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 103. `start_place_session(player_id, dialogue, chosen_gid, chosen_name, chosen_id, template_layer)`

- **Line:** 1971
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 3 | `chosen_gid` | Declared directly in the current Lua. Type not inferred. |
| 4 | `chosen_name` | Declared directly in the current Lua. Type not inferred. |
| 5 | `chosen_id` | Declared directly in the current Lua. Type not inferred. |
| 6 | `template_layer` | Declared directly in the current Lua. Type not inferred. |

#### 104. `open_place_catalog_menu(player_id, dialogue)`

- **Line:** 2040
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 105. `start_remove_session(player_id, dialogue)`

- **Line:** 2124
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 106. `open_decorate_menu(player_id, dialogue)`

- **Line:** 2160
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 107. `find_my_object()`

- **Line:** 2197
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 108. `open_pass_menu(player_id, npc, dialogue)`

- **Line:** 2340
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 109. `_get_rental_record(player_id, dialogue)`

- **Line:** 2414
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 110. `_is_current_renter(player_id, dialogue)`

- **Line:** 2423
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 111. `_find_visitor_object(area_id, once_key, visitor_secret)`

- **Line:** 2432
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `once_key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `visitor_secret` | Declared directly in the current Lua. Type not inferred. |

#### 112. `open_visitor_decor_menu(player_id, dialogue)`

- **Line:** 2447
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 113. `_pets_require()`

- **Line:** 2495
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 114. `_pets_auth_renter(player_id, dialogue)`

- **Line:** 2500
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 115. `start_pet_place_session(player_id, dialogue, pet_id, pet_name)`

- **Line:** 2523
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 3 | `pet_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `pet_name` | Declared directly in the current Lua. Type not inferred. |

#### 116. `place_pet_current(player_id)`

- **Line:** 2587
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 117. `open_pets_summon_menu(player_id, npc, dialogue)`

- **Line:** 2641
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 118. `open_pets_remove_menu(player_id, npc, dialogue)`

- **Line:** 2725
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 119. `open_pets_menu(player_id, npc, dialogue)`

- **Line:** 2804
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 120. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 2830
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 121. `action_ok(key, seconds)`

- **Line:** 2889
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared directly in the current Lua. Type not inferred. |
| 2 | `seconds` | Declared directly in the current Lua. Type not inferred. |

#### 122. `nudge_cursor(dx, dy)`

- **Line:** 2900
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dx` | Declared directly in the current Lua. Type not inferred. |
| 2 | `dy` | Declared directly in the current Lua. Type not inferred. |

#### 123. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 3061
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 124. `finish(next_id)`

- **Line:** 3097
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `next_id` | Declared directly in the current Lua. Type not inferred. |

#### 125. `save_record(r)`

- **Line:** 3106
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `r` | Declared directly in the current Lua. Type not inferred. |

#### 126. `can_afford(amount)`

- **Line:** 3112
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `amount` | Declared directly in the current Lua. Type not inferred. |

#### 127. `grant_key_if_missing()`

- **Line:** 3117
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 128. `new_window_from(ts)`

- **Line:** 3130
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ts` | Declared directly in the current Lua. Type not inferred. |

#### 129. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 3315
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 130. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 3373
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 131. `run_logic(with_lock)`

- **Line:** 3502
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `with_lock` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 29 | `DEFAULTS` |
| 61 | `sfx` |
| 66 | `ONCEHUB` |
| 77 | `sessions` |
| 80 | `ONCEHUB_CATALOG` |
| 150 | `MENU_COLOR` |
| 151 | `YELLOW` |
| 152 | `GREEN` |
| 153 | `BLUE` |
| 255 | `_AREA_ID_SET` |
| 335 | `MENU_DEBOUNCE` |
| 869 | `try_layers` |
| 925 | `data` |
| 932 | `custom_properties` |
| 957 | `info` |
| 964 | `data` |
| 971 | `custom_properties` |
| 1035 | `data` |
| 1042 | `custom_properties` |
| 1055 | `ci` |
| 1132 | `ci` |
| 1249 | `out` |
| 1255 | `new_cp` |
| 1341 | `spawn_info` |
| 1355 | `new_cp` |
| 1392 | `new_cp` |
| 1521 | `tried` |
| 1841 | `anchor` |
| 1849 | `custom_properties` |
| 1878 | `permanent_cp` |
| 1908 | `permanent` |
| 2263 | `posts` |
| 2363 | `opts` |
| 2450 | `opts` |
| 2655 | `placed_by_kind` |
| 2806 | `posts` |
| 2834 | `posts` |
| 3287 | `new_rec` |
| 3381 | `sell_rows` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.create_object` | 7 | 918 |
| `Net.get_bot_by_id` | 1 | 1678 |
| `Net.get_height` | 1 | 481 |
| `Net.get_object_by_id` | 16 | 629 |
| `Net.get_player_area` | 17 | 435 |
| `Net.get_player_name` | 5 | 160 |
| `Net.get_player_position` | 2 | 500 |
| `Net.get_width` | 1 | 480 |
| `Net.list_areas` | 3 | 243 |
| `Net.list_bots` | 1 | 1676 |
| `Net.list_objects` | 12 | 628 |
| `Net.map_to_string` | 1 | 1760 |
| `Net.message_player` | 7 | 1798 |
| `Net.on` | 5 | 2862 |
| `Net.play_sound_for_player` | 2 | 3467 |
| `Net.remove_object` | 7 | 622 |
