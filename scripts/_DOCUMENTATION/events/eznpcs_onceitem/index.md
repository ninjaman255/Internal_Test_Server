# 📄 `eznpcs_onceitem.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/events/eznpcs_onceitem.lua`](../../../events/eznpcs_onceitem.lua)  
> **Source lines:** 3580  
> **SHA-256 (UTF-8):** `5b1f3d0525e0ee59ea310bb0e402dcb000da9dbe539fe2ec819906dca44ba343`  
> **Named/assigned functions detected:** 131  
> **Table initializers detected (simple pattern):** 39

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/events/eznpcs_onceitem.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 18 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 19 | `scripts/ezlibs-scripts/helpers` |
| 20 | `scripts/ezlibs-scripts/ezmemory` |
| 21 | `scripts/ezlibs-scripts/ezmenus` |
| 22 | `scripts/ezlibs-scripts/ezweather` |
| 23 | `scripts/ezlibs-custom/custom` |
| 24 | `scripts/ezlibs-custom/pets` |
| 25 | `scripts/ezlibs-custom/jukebox` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 2861 | `Net` | `virtual_input` |
| 3025 | `Net` | `player_area_transfer` |
| 3038 | `Net` | `player_join_area` |
| 3048 | `Net` | `player_join` |
| 3484 | `Net` | `object_interaction` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 141 | `is_pet_item_id` | `id` | local |
| 145 | `pet_kind_from_item_id` | `id` | local |
| 156 | `_oh_log` | `pid, msg` | local |
| 168 | `_mark_ignore_next_close` | `pid, reason` | local |
| 175 | `_open_menu_ignoring_custom` | `pid, title, color, posts, reason` | local |
| 182 | `_path_tail` | `p` | local |
| 189 | `catalog_resolve_gid` | `area_id, entry` | local |
| 212 | `catalog_entry_by_gid` | `area_id, gid` | local |
| 222 | `dprop` | `dialogue, key, default` | local |
| 228 | `cprop` | `obj_custom, key, default` | local |
| 234 | `normalize_key` | `s` | local |
| 241 | `_pick_existing_mem_area` | `fallback` | local |
| 251 | `_area_exists` | `area_id` | local |
| 261 | `resolve_mem_area_id` | `dialogue, player_id, obj_custom` | local |
| 277 | `say` | `player_id, text, mug` | local |
| 284 | `ask_yes_no` | `player_id, prompt, mug` | local |
| 289 | `ask_text` | `player_id, prompt, mug` | local |
| 294 | `fmt` | `ts` | local |
| 299 | `add_months` | `ts, months` | local |
| 308 | `compute_period` | `now_ts, months, minutes` | local |
| 316 | `resolve_manual_purchased_at` | `dialogue, now_ts` | local |
| 335 | `menu_closed_now` | `pid, secs` | local |
| 343 | `recently_closed_menu` | `pid` | local |
| 347 | `fast_close_board` | `pid` | local |
| 359 | `ensure_bucket_mem` | `BUCKET_AREA_ID` | local |
| 369 | `purge_player_key_if_invalid` | `player_id, BUCKET_AREA_ID, once_key, item_name` | local |
| 385 | `get_record_and_prune` | `BUCKET_AREA_ID, once_key` | local |
| 422 | `eznpcs.player_has_active_lease` | `player_id, once_key, bucket_area_id` | assigned/declared |
| 425 | `check_area` | `area_id` | local |
| 444 | `dir_to_offset` | `dir` | local |
| 457 | `get_cursor_point` | `player_id, dist` | local |
| 478 | `clamp_cursor_to_map` | `area_id, x, y, z` | local |
| 493 | `init_free_cursor` | `pid, s` | local |
| 508 | `get_session_cursor` | `pid, s` | local |
| 517 | `follow_preview_camera` | `pid, x, y, z` | local |
| 559 | `lock_for_preview` | `pid, s` | local |
| 570 | `unlock_after_preview` | `pid, s` | local |
| 615 | `stop_session` | `player_id, reason` | local |
| 644 | `try_resolve_test_gid` | `dialogue, area_id` | local |
| 647 | `norm` | `s` | local |
| 648 | `looks_like_bus_stop` | `s` | local |
| 680 | `resolve_removal_cursor_gid` | `area_id` | local |
| 709 | `_tmx_read_map_tilesize` | `xml` | local |
| 715 | `find_prototype_for_gid` | `area_id, target_gid` | local |
| 735 | `get_template_dims_from_layer` | `area_id, layer_name, gid` | local |
| 763 | `get_gid_dims_in_tiles` | `area_id, gid` | local |
| 775 | `resolve_object_dims` | `area_id, template_layer_name, gid` | local |
| 791 | `object_covers_point` | `o, x, y, z` | local |
| 798 | `find_oncehub_object_at` | `area_id, x, y, z` | local |
| 817 | `decode_gid_flags` | `raw` | local |
| 826 | `gid_base` | `raw_gid` | local |
| 832 | `_tmx_flip_flags_from_layer` | `area_id, layer_name, base_gid` | local |
| 857 | `resolve_preview_flip_flags` | `area_id, template_layer_name, base_gid, def_fh, def_fv, def_fr` | local |
| 879 | `ensure_preview` | `player_id` | local |
| 1053 | `_decor_ci` | `dialogue` | local |
| 1060 | `_decor_get_prop_ci` | `ci, key` | local |
| 1062 | `_catalog_by_id` | `id` | local |
| 1069 | `_player_decor_mem` | `pid` | local |
| 1075 | `decor_count_owned` | `pid, id` | local |
| 1080 | `decor_add_owned` | `pid, id, qty` | local |
| 1088 | `short_money` | `n` | local |
| 1107 | `price_for` | `dialogue, id` | local |
| 1124 | `_catalog_by_id` | `id` | local |
| 1130 | `_decor_ci` | `dialogue` | local |
| 1138 | `_decor_get_prop_ci` | `ci, key` | local |
| 1142 | `price_for_index_or_id` | `dialogue, idx, id` | local |
| 1160 | `_pmem_secret` | `pid` | local |
| 1168 | `_pmem_get` | `pid` | local |
| 1182 | `_decor_inv` | `pid` | local |
| 1187 | `decor_count_owned` | `pid, id` | local |
| 1194 | `decor_set_owned` | `pid, id, count` | local |
| 1206 | `decor_add_owned` | `pid, id, qty` | local |
| 1213 | `count_placed_in_area_by_player` | `area_id, once_key, object_id, pid` | local |
| 1235 | `decor_left_to_place` | `pid, area_id, once_key, object_id` | local |
| 1247 | `snapshot_oncehub_placements` | `area_id, once_key` | local |
| 1289 | `_remember_key_area` | `mem_area, key, area_id` | local |
| 1297 | `save_placements` | `area_id, bucket_area_id, once_key` | local |
| 1313 | `rehydrate_placements` | `area_id, bucket_area_id, once_key` | local |
| 1445 | `ensure_rehydrated` | `player_id, dialogue` | local |
| 1464 | `_cleanup_expired_hp` | `area_id, bucket_area_id, once_key` | assigned/declared |
| 1496 | `_lease_rec_for_key` | `bucket_area_id, key` | local |
| 1505 | `_apply_jukebox_song` | `area_id, bucket_area_id, once_key` | local |
| 1519 | `rehydrate_all_for_area` | `area_id` | local |
| 1522 | `try_from` | `bucket_area_id` | local |
| 1585 | `_rehydrate_from_event` | `ev` | local |
| 1594 | `_oncehub_rehydrate_for_player` | `pid` | local |
| 1606 | `_safe_get_player` | `ev` | local |
| 1610 | `_safe_get_to_area` | `ev, pid` | local |
| 1617 | `ezweather.handle_player_join` | `pid` | assigned/declared |
| 1626 | `ezweather.handle_player_transfer` | `pid` | assigned/declared |
| 1633 | `_cf_key` | `area_id, once_key, x, y, z` | local |
| 1643 | `_cf_mem` | `area_id` | local |
| 1649 | `_cf_record_bot` | `area_id, once_key, x, y, z, bot_id` | local |
| 1655 | `_cf_remove_bot` | `area_id, once_key, x, y, z, direct_id` | local |
| 1690 | `_find_card_item_id_by_title` | `pid, title` | local |
| 1706 | `_dec_player_item_count` | `pid, item_id, n` | local |
| 1719 | `_inc_inventory_by_secret` | `secret, item_id, n` | local |
| 1732 | `_refund_card_to_frame_owner` | `cp` | local |
| 1757 | `persist_area` | `area_id, bucket_area_id, once_key` | assigned/declared |
| 1787 | `place_current` | `player_id` | local |
| 1931 | `remove_current` | `player_id` | local |
| 1964 | `get_template_layer_name` | `dialogue` | local |
| 1970 | `start_place_session` | `player_id, dialogue, chosen_gid, chosen_name, chosen_id, template_layer` | local |
| 2039 | `open_place_catalog_menu` | `player_id, dialogue` | local |
| 2123 | `start_remove_session` | `player_id, dialogue` | local |
| 2159 | `open_decorate_menu` | `player_id, dialogue` | local |
| 2196 | `find_my_object` | `(none)` | local |
| 2339 | `open_pass_menu` | `player_id, npc, dialogue` | local |
| 2413 | `_get_rental_record` | `player_id, dialogue` | local |
| 2422 | `_is_current_renter` | `player_id, dialogue` | local |
| 2431 | `_find_visitor_object` | `area_id, once_key, visitor_secret` | local |
| 2446 | `open_visitor_decor_menu` | `player_id, dialogue` | local |
| 2494 | `_pets_require` | `(none)` | local |
| 2499 | `_pets_auth_renter` | `player_id, dialogue` | local |
| 2522 | `start_pet_place_session` | `player_id, dialogue, pet_id, pet_name` | local |
| 2586 | `place_pet_current` | `player_id` | local |
| 2640 | `open_pets_summon_menu` | `player_id, npc, dialogue` | local |
| 2724 | `open_pets_remove_menu` | `player_id, npc, dialogue` | local |
| 2803 | `open_pets_menu` | `player_id, npc, dialogue` | local |
| 2829 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 2888 | `action_ok` | `key, seconds` | local |
| 2899 | `nudge_cursor` | `dx, dy` | local |
| 3060 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 3096 | `finish` | `next_id` | local |
| 3105 | `save_record` | `r` | local |
| 3111 | `can_afford` | `amount` | local |
| 3116 | `grant_key_if_missing` | `(none)` | local |
| 3129 | `new_window_from` | `ts` | local |
| 3314 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 3372 | `action` | `npc, player_id, dialogue, relay_object` | assigned/declared |
| 3501 | `run_logic` | `with_lock` | local |

### Detailed parameter inventory

#### 1. `is_pet_item_id(id)`

- **Line:** 141
- **Declaration:** local
- **Nearby code comment:** Pets are sold via the Decor Shop (inventory), but are NOT placed as map objects anymore. They are summoned/removed via the Home Hub -> Pets menu, and stored separately in pets.lua.

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 2. `pet_kind_from_item_id(id)`

- **Line:** 145
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 3. `_oh_log(pid, msg)`

- **Line:** 156
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `msg` | Declared by this function; type not inferred. |

#### 4. `_mark_ignore_next_close(pid, reason)`

- **Line:** 168
- **Declaration:** local
- **Nearby code comment:** Ask custom.lua to ignore the very next board_close for this player (one-shot)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `reason` | Declared by this function; type not inferred. |

#### 5. `_open_menu_ignoring_custom(pid, title, color, posts, reason)`

- **Line:** 175
- **Declaration:** local
- **Nearby code comment:** Wrapper: mark ignore + open menu (returns the ezmenus board like normal)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `title` | Declared by this function; type not inferred. |
| 3 | `color` | Declared by this function; type not inferred. |
| 4 | `posts` | Declared by this function; type not inferred. |
| 5 | `reason` | Declared by this function; type not inferred. |

#### 6. `_path_tail(p)`

- **Line:** 182
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared by this function; type not inferred. |

#### 7. `catalog_resolve_gid(area_id, entry)`

- **Line:** 189
- **Declaration:** local
- **Nearby code comment:** Resolve a catalog entry to a gid for the current map

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `entry` | Declared by this function; type not inferred. |

#### 8. `catalog_entry_by_gid(area_id, gid)`

- **Line:** 212
- **Declaration:** local
- **Nearby code comment:** Lookup friendly name/id by gid (for older placed objects that lack oncehub_name)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `gid` | Declared by this function; type not inferred. |

#### 9. `dprop(dialogue, key, default)`

- **Line:** 222
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |
| 2 | `key` | Declared by this function; type not inferred. |
| 3 | `default` | Declared by this function; type not inferred. |

#### 10. `cprop(obj_custom, key, default)`

- **Line:** 228
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `obj_custom` | Declared by this function; type not inferred. |
| 2 | `key` | Declared by this function; type not inferred. |
| 3 | `default` | Declared by this function; type not inferred. |

#### 11. `normalize_key(s)`

- **Line:** 234
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared by this function; type not inferred. |

#### 12. `_pick_existing_mem_area(fallback)`

- **Line:** 241
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fallback` | Declared by this function; type not inferred. |

#### 13. `_area_exists(area_id)`

- **Line:** 251
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |

#### 14. `resolve_mem_area_id(dialogue, player_id, obj_custom)`

- **Line:** 261
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |
| 2 | `player_id` | Declared by this function; type not inferred. |
| 3 | `obj_custom` | Declared by this function; type not inferred. |

#### 15. `say(player_id, text, mug)`

- **Line:** 277
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `text` | Declared by this function; type not inferred. |
| 3 | `mug` | Declared by this function; type not inferred. |

#### 16. `ask_yes_no(player_id, prompt, mug)`

- **Line:** 284
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `prompt` | Declared by this function; type not inferred. |
| 3 | `mug` | Declared by this function; type not inferred. |

#### 17. `ask_text(player_id, prompt, mug)`

- **Line:** 289
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `prompt` | Declared by this function; type not inferred. |
| 3 | `mug` | Declared by this function; type not inferred. |

#### 18. `fmt(ts)`

- **Line:** 294
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ts` | Declared by this function; type not inferred. |

#### 19. `add_months(ts, months)`

- **Line:** 299
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ts` | Declared by this function; type not inferred. |
| 2 | `months` | Declared by this function; type not inferred. |

#### 20. `compute_period(now_ts, months, minutes)`

- **Line:** 308
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `now_ts` | Declared by this function; type not inferred. |
| 2 | `months` | Declared by this function; type not inferred. |
| 3 | `minutes` | Declared by this function; type not inferred. |

#### 21. `resolve_manual_purchased_at(dialogue, now_ts)`

- **Line:** 316
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |
| 2 | `now_ts` | Declared by this function; type not inferred. |

#### 22. `menu_closed_now(pid, secs)`

- **Line:** 335
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `secs` | Declared by this function; type not inferred. |

#### 23. `recently_closed_menu(pid)`

- **Line:** 343
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 24. `fast_close_board(pid)`

- **Line:** 347
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 25. `ensure_bucket_mem(BUCKET_AREA_ID)`

- **Line:** 359
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `BUCKET_AREA_ID` | Declared by this function; type not inferred. |

#### 26. `purge_player_key_if_invalid(player_id, BUCKET_AREA_ID, once_key, item_name)`

- **Line:** 369
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `BUCKET_AREA_ID` | Declared by this function; type not inferred. |
| 3 | `once_key` | Declared by this function; type not inferred. |
| 4 | `item_name` | Declared by this function; type not inferred. |

#### 27. `get_record_and_prune(BUCKET_AREA_ID, once_key)`

- **Line:** 385
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `BUCKET_AREA_ID` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |

#### 28. `eznpcs.player_has_active_lease(player_id, once_key, bucket_area_id)`

- **Line:** 422
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |
| 3 | `bucket_area_id` | Declared by this function; type not inferred. |

#### 29. `check_area(area_id)`

- **Line:** 425
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |

#### 30. `dir_to_offset(dir)`

- **Line:** 444
- **Declaration:** local
- **Nearby code comment:** ---------- Cursor helpers ----------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dir` | Declared by this function; type not inferred. |

#### 31. `get_cursor_point(player_id, dist)`

- **Line:** 457
- **Declaration:** local
- **Nearby code comment:** NEW: normalized fractional cursor distance

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dist` | Declared by this function; type not inferred. |

#### 32. `clamp_cursor_to_map(area_id, x, y, z)`

- **Line:** 478
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `x` | Declared by this function; type not inferred. |
| 3 | `y` | Declared by this function; type not inferred. |
| 4 | `z` | Declared by this function; type not inferred. |

#### 33. `init_free_cursor(pid, s)`

- **Line:** 493
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `s` | Declared by this function; type not inferred. |

#### 34. `get_session_cursor(pid, s)`

- **Line:** 508
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `s` | Declared by this function; type not inferred. |

#### 35. `follow_preview_camera(pid, x, y, z)`

- **Line:** 517
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `x` | Declared by this function; type not inferred. |
| 3 | `y` | Declared by this function; type not inferred. |
| 4 | `z` | Declared by this function; type not inferred. |

#### 36. `lock_for_preview(pid, s)`

- **Line:** 559
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `s` | Declared by this function; type not inferred. |

#### 37. `unlock_after_preview(pid, s)`

- **Line:** 570
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `s` | Declared by this function; type not inferred. |

#### 38. `stop_session(player_id, reason)`

- **Line:** 615
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `reason` | Declared by this function; type not inferred. |

#### 39. `try_resolve_test_gid(dialogue, area_id)`

- **Line:** 644
- **Declaration:** local
- **Nearby code comment:** Resolve a test GID (dialogue "Test GID" overrides; else tileset named like Bus Stop; else TMX scan)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |
| 2 | `area_id` | Declared by this function; type not inferred. |

#### 40. `norm(s)`

- **Line:** 647
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared by this function; type not inferred. |

#### 41. `looks_like_bus_stop(s)`

- **Line:** 648
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared by this function; type not inferred. |

#### 42. `resolve_removal_cursor_gid(area_id)`

- **Line:** 680
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |

#### 43. `_tmx_read_map_tilesize(xml)`

- **Line:** 709
- **Declaration:** local
- **Nearby code comment:** ---------- DIMENSIONS: prototype → TMX layer → tileset image ----------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `xml` | Declared by this function; type not inferred. |

#### 44. `find_prototype_for_gid(area_id, target_gid)`

- **Line:** 715
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `target_gid` | Declared by this function; type not inferred. |

#### 45. `get_template_dims_from_layer(area_id, layer_name, gid)`

- **Line:** 735
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `layer_name` | Declared by this function; type not inferred. |
| 3 | `gid` | Declared by this function; type not inferred. |

#### 46. `get_gid_dims_in_tiles(area_id, gid)`

- **Line:** 763
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `gid` | Declared by this function; type not inferred. |

#### 47. `resolve_object_dims(area_id, template_layer_name, gid)`

- **Line:** 775
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `template_layer_name` | Declared by this function; type not inferred. |
| 3 | `gid` | Declared by this function; type not inferred. |

#### 48. `object_covers_point(o, x, y, z)`

- **Line:** 791
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `o` | Declared by this function; type not inferred. |
| 2 | `x` | Declared by this function; type not inferred. |
| 3 | `y` | Declared by this function; type not inferred. |
| 4 | `z` | Declared by this function; type not inferred. |

#### 49. `find_oncehub_object_at(area_id, x, y, z)`

- **Line:** 798
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `x` | Declared by this function; type not inferred. |
| 3 | `y` | Declared by this function; type not inferred. |
| 4 | `z` | Declared by this function; type not inferred. |

#### 50. `decode_gid_flags(raw)`

- **Line:** 817
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw` | Declared by this function; type not inferred. |

#### 51. `gid_base(raw_gid)`

- **Line:** 826
- **Declaration:** local
- **Nearby code comment:** Return the base (unflipped) gid, ignoring TMX flip bits

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `raw_gid` | Declared by this function; type not inferred. |

#### 52. `_tmx_flip_flags_from_layer(area_id, layer_name, base_gid)`

- **Line:** 832
- **Declaration:** local
- **Nearby code comment:** Read flip flags for a gid from a specific TMX object layer (by name)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `layer_name` | Declared by this function; type not inferred. |
| 3 | `base_gid` | Declared by this function; type not inferred. |

#### 53. `resolve_preview_flip_flags(area_id, template_layer_name, base_gid, def_fh, def_fv, def_fr)`

- **Line:** 857
- **Declaration:** local
- **Nearby code comment:** Prefer live prototype object (if present), else TMX layer (Object Layer 1/2), else defaults

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `template_layer_name` | Declared by this function; type not inferred. |
| 3 | `base_gid` | Declared by this function; type not inferred. |
| 4 | `def_fh` | Declared by this function; type not inferred. |
| 5 | `def_fv` | Declared by this function; type not inferred. |
| 6 | `def_fr` | Declared by this function; type not inferred. |

#### 54. `ensure_preview(player_id)`

- **Line:** 879
- **Declaration:** local
- **Nearby code comment:** ---------- Preview follow ----------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 55. `_decor_ci(dialogue)`

- **Line:** 1053
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |

#### 56. `_decor_get_prop_ci(ci, key)`

- **Line:** 1060
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ci` | Declared by this function; type not inferred. |
| 2 | `key` | Declared by this function; type not inferred. |

#### 57. `_catalog_by_id(id)`

- **Line:** 1062
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 58. `_player_decor_mem(pid)`

- **Line:** 1069
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 59. `decor_count_owned(pid, id)`

- **Line:** 1075
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `id` | Declared by this function; type not inferred. |

#### 60. `decor_add_owned(pid, id, qty)`

- **Line:** 1080
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `id` | Declared by this function; type not inferred. |
| 3 | `qty` | Declared by this function; type not inferred. |

#### 61. `short_money(n)`

- **Line:** 1088
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `n` | Declared by this function; type not inferred. |

#### 62. `price_for(dialogue, id)`

- **Line:** 1107
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |
| 2 | `id` | Declared by this function; type not inferred. |

#### 63. `_catalog_by_id(id)`

- **Line:** 1124
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 64. `_decor_ci(dialogue)`

- **Line:** 1130
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |

#### 65. `_decor_get_prop_ci(ci, key)`

- **Line:** 1138
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ci` | Declared by this function; type not inferred. |
| 2 | `key` | Declared by this function; type not inferred. |

#### 66. `price_for_index_or_id(dialogue, idx, id)`

- **Line:** 1142
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |
| 2 | `idx` | Declared by this function; type not inferred. |
| 3 | `id` | Declared by this function; type not inferred. |

#### 67. `_pmem_secret(pid)`

- **Line:** 1160
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 68. `_pmem_get(pid)`

- **Line:** 1168
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 69. `_decor_inv(pid)`

- **Line:** 1182
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 70. `decor_count_owned(pid, id)`

- **Line:** 1187
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `id` | Declared by this function; type not inferred. |

#### 71. `decor_set_owned(pid, id, count)`

- **Line:** 1194
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `id` | Declared by this function; type not inferred. |
| 3 | `count` | Declared by this function; type not inferred. |

#### 72. `decor_add_owned(pid, id, qty)`

- **Line:** 1206
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `id` | Declared by this function; type not inferred. |
| 3 | `qty` | Declared by this function; type not inferred. |

#### 73. `count_placed_in_area_by_player(area_id, once_key, object_id, pid)`

- **Line:** 1213
- **Declaration:** local
- **Nearby code comment:** Count how many of this object the CURRENT PLAYER has placed in this HP

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |
| 3 | `object_id` | Declared by this function; type not inferred. |
| 4 | `pid` | Declared by this function; type not inferred. |

#### 74. `decor_left_to_place(pid, area_id, once_key, object_id)`

- **Line:** 1235
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `area_id` | Declared by this function; type not inferred. |
| 3 | `once_key` | Declared by this function; type not inferred. |
| 4 | `object_id` | Declared by this function; type not inferred. |

#### 75. `snapshot_oncehub_placements(area_id, once_key)`

- **Line:** 1247
- **Declaration:** local
- **Nearby code comment:** Collect all placed objects for this renter in this area

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |

#### 76. `_remember_key_area(mem_area, key, area_id)`

- **Line:** 1289
- **Declaration:** local
- **Nearby code comment:** Map once_key (or "area:<id>") -> owning area_id

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `mem_area` | Declared by this function; type not inferred. |
| 2 | `key` | Declared by this function; type not inferred. |
| 3 | `area_id` | Declared by this function; type not inferred. |

#### 77. `save_placements(area_id, bucket_area_id, once_key)`

- **Line:** 1297
- **Declaration:** local
- **Nearby code comment:** Save the current placement list into area memory (bucket or live area)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `bucket_area_id` | Declared by this function; type not inferred. |
| 3 | `once_key` | Declared by this function; type not inferred. |

#### 78. `rehydrate_placements(area_id, bucket_area_id, once_key)`

- **Line:** 1313
- **Declaration:** local
- **Nearby code comment:** Recreate objects from saved list if none currently exist (prevents duplicates)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `bucket_area_id` | Declared by this function; type not inferred. |
| 3 | `once_key` | Declared by this function; type not inferred. |

#### 79. `ensure_rehydrated(player_id, dialogue)`

- **Line:** 1445
- **Declaration:** local
- **Nearby code comment:** Convenience: call this whenever the hub/menu opens

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 80. `_cleanup_expired_hp(area_id, bucket_area_id, once_key)`

- **Line:** 1464
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `bucket_area_id` | Declared by this function; type not inferred. |
| 3 | `once_key` | Declared by this function; type not inferred. |

#### 81. `_lease_rec_for_key(bucket_area_id, key)`

- **Line:** 1496
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bucket_area_id` | Declared by this function; type not inferred. |
| 2 | `key` | Declared by this function; type not inferred. |

#### 82. `_apply_jukebox_song(area_id, bucket_area_id, once_key)`

- **Line:** 1505
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `bucket_area_id` | Declared by this function; type not inferred. |
| 3 | `once_key` | Declared by this function; type not inferred. |

#### 83. `rehydrate_all_for_area(area_id)`

- **Line:** 1519
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |

#### 84. `try_from(bucket_area_id)`

- **Line:** 1522
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bucket_area_id` | Declared by this function; type not inferred. |

#### 85. `_rehydrate_from_event(ev)`

- **Line:** 1585
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared by this function; type not inferred. |

#### 86. `_oncehub_rehydrate_for_player(pid)`

- **Line:** 1594
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 87. `_safe_get_player(ev)`

- **Line:** 1606
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared by this function; type not inferred. |

#### 88. `_safe_get_to_area(ev, pid)`

- **Line:** 1610
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ev` | Declared by this function; type not inferred. |
| 2 | `pid` | Declared by this function; type not inferred. |

#### 89. `ezweather.handle_player_join(pid)`

- **Line:** 1617
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 90. `ezweather.handle_player_transfer(pid)`

- **Line:** 1626
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |

#### 91. `_cf_key(area_id, once_key, x, y, z)`

- **Line:** 1633
- **Declaration:** local
- **Nearby code comment:** --- Card Frame: bot-id bookkeeping in area memory -----------------------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |
| 3 | `x` | Declared by this function; type not inferred. |
| 4 | `y` | Declared by this function; type not inferred. |
| 5 | `z` | Declared by this function; type not inferred. |

#### 92. `_cf_mem(area_id)`

- **Line:** 1643
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |

#### 93. `_cf_record_bot(area_id, once_key, x, y, z, bot_id)`

- **Line:** 1649
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |
| 3 | `x` | Declared by this function; type not inferred. |
| 4 | `y` | Declared by this function; type not inferred. |
| 5 | `z` | Declared by this function; type not inferred. |
| 6 | `bot_id` | Declared by this function; type not inferred. |

#### 94. `_cf_remove_bot(area_id, once_key, x, y, z, direct_id)`

- **Line:** 1655
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |
| 3 | `x` | Declared by this function; type not inferred. |
| 4 | `y` | Declared by this function; type not inferred. |
| 5 | `z` | Declared by this function; type not inferred. |
| 6 | `direct_id` | Declared by this function; type not inferred. |

#### 95. `_find_card_item_id_by_title(pid, title)`

- **Line:** 1690
- **Declaration:** local
- **Nearby code comment:** Find a player's item_id for an exact card title (e.g. "[GR]DMGirl")

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `title` | Declared by this function; type not inferred. |

#### 96. `_dec_player_item_count(pid, item_id, n)`

- **Line:** 1706
- **Declaration:** local
- **Nearby code comment:** Decrement a player's item count and persist

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared by this function; type not inferred. |
| 2 | `item_id` | Declared by this function; type not inferred. |
| 3 | `n` | Declared by this function; type not inferred. |

#### 97. `_inc_inventory_by_secret(secret, item_id, n)`

- **Line:** 1719
- **Declaration:** local
- **Nearby code comment:** Increment by account secret (works even if user is offline)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `secret` | Declared by this function; type not inferred. |
| 2 | `item_id` | Declared by this function; type not inferred. |
| 3 | `n` | Declared by this function; type not inferred. |

#### 98. `_refund_card_to_frame_owner(cp)`

- **Line:** 1732
- **Declaration:** local
- **Nearby code comment:** Refund 1 copy to the Card Frame owner (the player who placed it)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cp` | Declared by this function; type not inferred. |

#### 99. `persist_area(area_id, bucket_area_id, once_key)`

- **Line:** 1757
- **Declaration:** table/global or assignment
- **Nearby code comment:** ---------- Actions ---------- Save both the legacy XML and the structured placements into *both* the live area AND (if present) the bucket area memory.

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `bucket_area_id` | Declared by this function; type not inferred. |
| 3 | `once_key` | Declared by this function; type not inferred. |

#### 100. `place_current(player_id)`

- **Line:** 1787
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 101. `remove_current(player_id)`

- **Line:** 1931
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 102. `get_template_layer_name(dialogue)`

- **Line:** 1964
- **Declaration:** local
- **Nearby code comment:** ---------- Start sessions ----------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dialogue` | Declared by this function; type not inferred. |

#### 103. `start_place_session(player_id, dialogue, chosen_gid, chosen_name, chosen_id, template_layer)`

- **Line:** 1970
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |
| 3 | `chosen_gid` | Declared by this function; type not inferred. |
| 4 | `chosen_name` | Declared by this function; type not inferred. |
| 5 | `chosen_id` | Declared by this function; type not inferred. |
| 6 | `template_layer` | Declared by this function; type not inferred. |

#### 104. `open_place_catalog_menu(player_id, dialogue)`

- **Line:** 2039
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 105. `start_remove_session(player_id, dialogue)`

- **Line:** 2123
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 106. `open_decorate_menu(player_id, dialogue)`

- **Line:** 2159
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 107. `find_my_object()`

- **Line:** 2196
- **Declaration:** local
- **Nearby code comment:** Helper: find the object this visitor placed (relies on earlier helper if present)
- **Parameters:** none explicitly declared.

#### 108. `open_pass_menu(player_id, npc, dialogue)`

- **Line:** 2339
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `npc` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |

#### 109. `_get_rental_record(player_id, dialogue)`

- **Line:** 2413
- **Declaration:** local
- **Nearby code comment:** Renter/record helpers

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 110. `_is_current_renter(player_id, dialogue)`

- **Line:** 2422
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 111. `_find_visitor_object(area_id, once_key, visitor_secret)`

- **Line:** 2431
- **Declaration:** local
- **Nearby code comment:** Find the object a specific visitor placed (by safe secret)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `once_key` | Declared by this function; type not inferred. |
| 3 | `visitor_secret` | Declared by this function; type not inferred. |

#### 112. `open_visitor_decor_menu(player_id, dialogue)`

- **Line:** 2446
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 113. `_pets_require()`

- **Line:** 2494
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 114. `_pets_auth_renter(player_id, dialogue)`

- **Line:** 2499
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |

#### 115. `start_pet_place_session(player_id, dialogue, pet_id, pet_name)`

- **Line:** 2522
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `dialogue` | Declared by this function; type not inferred. |
| 3 | `pet_id` | Declared by this function; type not inferred. |
| 4 | `pet_name` | Declared by this function; type not inferred. |

#### 116. `place_pet_current(player_id)`

- **Line:** 2586
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 117. `open_pets_summon_menu(player_id, npc, dialogue)`

- **Line:** 2640
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `npc` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |

#### 118. `open_pets_remove_menu(player_id, npc, dialogue)`

- **Line:** 2724
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `npc` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |

#### 119. `open_pets_menu(player_id, npc, dialogue)`

- **Line:** 2803
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `npc` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |

#### 120. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 2829
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared by this function; type not inferred. |
| 2 | `player_id` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |
| 4 | `relay_object` | Declared by this function; type not inferred. |

#### 121. `action_ok(key, seconds)`

- **Line:** 2888
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `seconds` | Declared by this function; type not inferred. |

#### 122. `nudge_cursor(dx, dy)`

- **Line:** 2899
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dx` | Declared by this function; type not inferred. |
| 2 | `dy` | Declared by this function; type not inferred. |

#### 123. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 3060
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared by this function; type not inferred. |
| 2 | `player_id` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |
| 4 | `relay_object` | Declared by this function; type not inferred. |

#### 124. `finish(next_id)`

- **Line:** 3096
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `next_id` | Declared by this function; type not inferred. |

#### 125. `save_record(r)`

- **Line:** 3105
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `r` | Declared by this function; type not inferred. |

#### 126. `can_afford(amount)`

- **Line:** 3111
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `amount` | Declared by this function; type not inferred. |

#### 127. `grant_key_if_missing()`

- **Line:** 3116
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 128. `new_window_from(ts)`

- **Line:** 3129
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ts` | Declared by this function; type not inferred. |

#### 129. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 3314
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared by this function; type not inferred. |
| 2 | `player_id` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |
| 4 | `relay_object` | Declared by this function; type not inferred. |

#### 130. `action(npc, player_id, dialogue, relay_object)`

- **Line:** 3372
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared by this function; type not inferred. |
| 2 | `player_id` | Declared by this function; type not inferred. |
| 3 | `dialogue` | Declared by this function; type not inferred. |
| 4 | `relay_object` | Declared by this function; type not inferred. |

#### 131. `run_logic(with_lock)`

- **Line:** 3501
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `with_lock` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 28 | `DEFAULTS` |
| 60 | `sfx` |
| 65 | `ONCEHUB` |
| 76 | `sessions` |
| 79 | `ONCEHUB_CATALOG` |
| 149 | `MENU_COLOR` |
| 150 | `YELLOW` |
| 151 | `GREEN` |
| 152 | `BLUE` |
| 254 | `_AREA_ID_SET` |
| 334 | `MENU_DEBOUNCE` |
| 868 | `try_layers` |
| 924 | `data` |
| 931 | `custom_properties` |
| 956 | `info` |
| 963 | `data` |
| 970 | `custom_properties` |
| 1034 | `data` |
| 1041 | `custom_properties` |
| 1054 | `ci` |
| 1131 | `ci` |
| 1248 | `out` |
| 1254 | `new_cp` |
| 1340 | `spawn_info` |
| 1354 | `new_cp` |
| 1391 | `new_cp` |
| 1520 | `tried` |
| 1840 | `anchor` |
| 1848 | `custom_properties` |
| 1877 | `permanent_cp` |
| 1907 | `permanent` |
| 2262 | `posts` |
| 2362 | `opts` |
| 2449 | `opts` |
| 2654 | `placed_by_kind` |
| 2805 | `posts` |
| 2833 | `posts` |
| 3286 | `new_rec` |
| 3380 | `sell_rows` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.create_object` | 7 | 917 |
| `Net.get_bot_by_id` | 1 | 1677 |
| `Net.get_height` | 1 | 480 |
| `Net.get_object_by_id` | 16 | 628 |
| `Net.get_player_area` | 17 | 434 |
| `Net.get_player_name` | 5 | 159 |
| `Net.get_player_position` | 2 | 499 |
| `Net.get_width` | 1 | 479 |
| `Net.list_areas` | 3 | 242 |
| `Net.list_bots` | 1 | 1675 |
| `Net.list_objects` | 12 | 627 |
| `Net.map_to_string` | 1 | 1759 |
| `Net.message_player` | 7 | 1797 |
| `Net.on` | 5 | 2861 |
| `Net.play_sound_for_player` | 2 | 3466 |
| `Net.remove_object` | 7 | 621 |
| `Net.unlock_player_input` | 1 | 3557 |
