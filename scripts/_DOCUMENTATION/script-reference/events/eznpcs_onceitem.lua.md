# `events/eznpcs_onceitem.lua`

> **Source reference**
>
> Generated from `events/eznpcs_onceitem.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

scripts/events/eznpcs_onceitem.lua Dialogue Type "onceitem": unique, server-wide rental with renewals Dialogue Type "oncepass": renter sets/clears a visitor password for the HP checkpoint Dialogue Type "oncehub": renter hub (password + decorate HP with live preview) Checkpoint integration: Any object of type "Checkpoint" with custom property: Once Key = <same unique key as the NPC>   (e.g., "House.A.Key") Behavior: • Owner (current renter) opens immediately • Visitors open with renter-defined password (via oncepass) • Gate hides-for-session only (reappears on relog or lease change) • Password auto-clears when lease expires or changes owner Loader (in eznpcs_events.lua): helpers.safe_require(

## Module location

- **Source:** `events/eznpcs_onceitem.lua`
- **Relative reference:** `script-reference/events/eznpcs_onceitem.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/events/eznpcs_onceitem` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/custom` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/jukebox` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/pets` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmenus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezweather` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `object_interaction` | `Net:on(...)` subscription found in source. |
| `player_area_transfer` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `player_join_area` | `Net:on(...)` subscription found in source. |
| `virtual_input` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `_apply_jukebox_song` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_area_exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_catalog_by_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_cf_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_cf_mem` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_cf_record_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_cf_remove_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_cleanup_expired_hp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_dec_player_item_count` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_decor_ci` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_decor_get_prop_ci` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_decor_inv` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_find_card_item_id_by_title` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_find_visitor_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_get_rental_record` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_inc_inventory_by_secret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_is_current_renter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_lease_rec_for_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_mark_ignore_next_close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_oh_log` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_oncehub_rehydrate_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_open_menu_ignoring_custom` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_path_tail` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_pets_auth_renter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_pets_require` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_pick_existing_mem_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_player_decor_mem` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_pmem_get` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_pmem_secret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_refund_card_to_frame_owner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_rehydrate_from_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_remember_key_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_safe_get_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_safe_get_to_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_tmx_flip_flags_from_layer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_tmx_read_map_tilesize` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `action` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `action_ok` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_months` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ask_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ask_yes_no` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `can_afford` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `catalog_entry_by_gid` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `catalog_resolve_gid` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `check_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clamp_cursor_to_map` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `compute_period` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `count_placed_in_area_by_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cprop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `decode_gid_flags` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `decor_add_owned` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `decor_count_owned` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `decor_left_to_place` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `decor_set_owned` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `dir_to_offset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `dprop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_bucket_mem` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_preview` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_rehydrated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.player_has_active_lease` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fast_close_board` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_my_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_oncehub_object_at` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_prototype_for_gid` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `finish` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fmt` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `follow_preview_camera` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_cursor_point` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_gid_dims_in_tiles` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_record_and_prune` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_session_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_template_dims_from_layer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_template_layer_name` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `gid_base` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `grant_key_if_missing` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `init_free_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_pet_item_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `lock_for_preview` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `looks_like_bus_stop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `menu_closed_now` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `new_window_from` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `norm` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `nudge_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `object_covers_point` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_decorate_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_pass_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_pets_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_pets_remove_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_pets_summon_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_place_catalog_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_visitor_decor_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `persist_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `pet_kind_from_item_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `place_current` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `place_pet_current` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `price_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `price_for_index_or_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `purge_player_key_if_invalid` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `recently_closed_menu` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `rehydrate_all_for_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `rehydrate_placements` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_current` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_manual_purchased_at` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_mem_area_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_object_dims` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_preview_flip_flags` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_removal_cursor_gid` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_logic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `save_placements` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `save_record` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `say` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `short_money` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `snapshot_oncehub_placements` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `start_pet_place_session` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `start_place_session` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `start_remove_session` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `stop_session` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_from` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_resolve_test_gid` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `unlock_after_preview` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`BLUE`, `DEFAULT_MEM_AREA`, `GREEN`, `YELLOW`

## Source notes

- Approximate source size: 3579 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
