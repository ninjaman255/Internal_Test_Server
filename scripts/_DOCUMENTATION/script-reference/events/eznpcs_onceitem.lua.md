# `events/eznpcs_onceitem.lua`

> **Source reference**
>
> Refreshed from the current `events/eznpcs_onceitem.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/events/eznpcs_onceitem.lua Dialogue Type "onceitem": unique, server-wide rental with renewals Dialogue Type "oncepass": renter sets/clears a visitor password for the HP checkpoint Dialogue Type "oncehub": renter hub (password + decorate HP with live preview) Checkpoint integration: Any object of type "Checkpoint" with custom property: Once Key = <same unique key as the NPC>   (e.g., "House.A.Key") Behavior: • Owner (current renter) opens immediately • Visitors open with renter-defined password (via oncepass) • Gate hides-for-session only (reappears on relog or lease change) • Password auto-clears when lease expires or changes owner Loader (in eznpcs_events.lua): helpers.safe_require(

## Module location

- **Source:** `events/eznpcs_onceitem.lua`
- **Reference:** `script-reference/events/eznpcs_onceitem.lua.md`
- **Source SHA-256 prefix:** `56b2552db0c8`

## Source header notes

- scripts/events/eznpcs_onceitem.lua
- Dialogue Type "onceitem": unique, server-wide rental with renewals
- Dialogue Type "oncepass": renter sets/clears a visitor password for the HP checkpoint
- Dialogue Type "oncehub": renter hub (password + decorate HP with live preview)
- Checkpoint integration:
- Any object of type "Checkpoint" with custom property:

## Direct `require` dependencies

| Import path |
|---|
| `scripts/events/eznpcs_onceitem` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezmenus` |
| `scripts/ezlibs-scripts/ezweather` |
| `scripts/ezlibs-custom/custom` |
| `scripts/ezlibs-custom/pets` |
| `scripts/ezlibs-custom/jukebox` |

## `Net:on` subscriptions

| Event |
|---|
| `virtual_input` |
| `player_area_transfer` |
| `player_join_area` |
| `player_join` |
| `object_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `is_pet_item_id` | `id` |
| `pet_kind_from_item_id` | `id` |
| `_oh_log` | `pid, msg` |
| `_mark_ignore_next_close` | `pid, reason` |
| `_open_menu_ignoring_custom` | `pid, title, color, posts, reason` |
| `_path_tail` | `p` |
| `catalog_resolve_gid` | `area_id, entry` |
| `catalog_entry_by_gid` | `area_id, gid` |
| `dprop` | `dialogue, key, default` |
| `cprop` | `obj_custom, key, default` |
| `normalize_key` | `s` |
| `_pick_existing_mem_area` | `fallback` |
| `_area_exists` | `area_id` |
| `resolve_mem_area_id` | `dialogue, player_id, obj_custom` |
| `say` | `player_id, text, mug` |
| `ask_yes_no` | `player_id, prompt, mug` |
| `ask_text` | `player_id, prompt, mug` |
| `fmt` | `ts` |
| `add_months` | `ts, months` |
| `compute_period` | `now_ts, months, minutes` |
| `resolve_manual_purchased_at` | `dialogue, now_ts` |
| `menu_closed_now` | `pid, secs` |
| `recently_closed_menu` | `pid` |
| `fast_close_board` | `pid` |
| `ensure_bucket_mem` | `BUCKET_AREA_ID` |
| `purge_player_key_if_invalid` | `player_id, BUCKET_AREA_ID, once_key, item_name` |
| `get_record_and_prune` | `BUCKET_AREA_ID, once_key` |
| `eznpcs.player_has_active_lease` | `player_id, once_key, bucket_area_id` |
| `check_area` | `area_id` |
| `dir_to_offset` | `dir` |
| `get_cursor_point` | `player_id, dist` |
| `clamp_cursor_to_map` | `area_id, x, y, z` |
| `init_free_cursor` | `pid, s` |
| `get_session_cursor` | `pid, s` |
| `follow_preview_camera` | `pid, x, y, z` |
| `lock_for_preview` | `pid, s` |
| `unlock_after_preview` | `pid, s` |
| `stop_session` | `player_id, reason` |
| `try_resolve_test_gid` | `dialogue, area_id` |
| `norm` | `s` |
| `looks_like_bus_stop` | `s` |
| `resolve_removal_cursor_gid` | `area_id` |
| `_tmx_read_map_tilesize` | `xml` |
| `find_prototype_for_gid` | `area_id, target_gid` |
| `get_template_dims_from_layer` | `area_id, layer_name, gid` |
| `get_gid_dims_in_tiles` | `area_id, gid` |
| `resolve_object_dims` | `area_id, template_layer_name, gid` |
| `object_covers_point` | `o, x, y, z` |
| `find_oncehub_object_at` | `area_id, x, y, z` |
| `decode_gid_flags` | `raw` |
| `gid_base` | `raw_gid` |
| `_tmx_flip_flags_from_layer` | `area_id, layer_name, base_gid` |
| `resolve_preview_flip_flags` | `area_id, template_layer_name, base_gid, def_fh, def_fv, def_fr` |
| `ensure_preview` | `player_id` |
| `_decor_ci` | `dialogue` |
| `_decor_get_prop_ci` | `ci, key` |
| `_catalog_by_id` | `id` |
| `_player_decor_mem` | `pid` |
| `decor_count_owned` | `pid, id` |
| `decor_add_owned` | `pid, id, qty` |
| `short_money` | `n` |
| `price_for` | `dialogue, id` |
| `price_for_index_or_id` | `dialogue, idx, id` |
| `_pmem_secret` | `pid` |
| `_pmem_get` | `pid` |
| `_decor_inv` | `pid` |
| `decor_set_owned` | `pid, id, count` |
| `count_placed_in_area_by_player` | `area_id, once_key, object_id, pid` |
| `decor_left_to_place` | `pid, area_id, once_key, object_id` |
| `snapshot_oncehub_placements` | `area_id, once_key` |
| `_remember_key_area` | `mem_area, key, area_id` |
| `save_placements` | `area_id, bucket_area_id, once_key` |
| `rehydrate_placements` | `area_id, bucket_area_id, once_key` |
| `ensure_rehydrated` | `player_id, dialogue` |
| `_lease_rec_for_key` | `bucket_area_id, key` |
| `_apply_jukebox_song` | `area_id, bucket_area_id, once_key` |
| `rehydrate_all_for_area` | `area_id` |
| `try_from` | `bucket_area_id` |
| `_rehydrate_from_event` | `ev` |
| `_oncehub_rehydrate_for_player` | `pid` |
| `_safe_get_player` | `ev` |
| `_safe_get_to_area` | `ev, pid` |
| `_cf_key` | `area_id, once_key, x, y, z` |
| `_cf_mem` | `area_id` |
| `_cf_record_bot` | `area_id, once_key, x, y, z, bot_id` |
| `_cf_remove_bot` | `area_id, once_key, x, y, z, direct_id` |
| `_find_card_item_id_by_title` | `pid, title` |
| `_dec_player_item_count` | `pid, item_id, n` |
| `_inc_inventory_by_secret` | `secret, item_id, n` |
| `_refund_card_to_frame_owner` | `cp` |
| `place_current` | `player_id` |
| `remove_current` | `player_id` |
| `get_template_layer_name` | `dialogue` |
| `start_place_session` | `player_id, dialogue, chosen_gid, chosen_name, chosen_id, template_layer` |
| `open_place_catalog_menu` | `player_id, dialogue` |
| `start_remove_session` | `player_id, dialogue` |
| `open_decorate_menu` | `player_id, dialogue` |
| `find_my_object` | `` |
| `open_pass_menu` | `player_id, npc, dialogue` |
| `_get_rental_record` | `player_id, dialogue` |
| `_is_current_renter` | `player_id, dialogue` |
| `_find_visitor_object` | `area_id, once_key, visitor_secret` |
| `open_visitor_decor_menu` | `player_id, dialogue` |
| `_pets_require` | `` |
| `_pets_auth_renter` | `player_id, dialogue` |
| `start_pet_place_session` | `player_id, dialogue, pet_id, pet_name` |
| `place_pet_current` | `player_id` |
| `open_pets_summon_menu` | `player_id, npc, dialogue` |
| `open_pets_remove_menu` | `player_id, npc, dialogue` |
| `open_pets_menu` | `player_id, npc, dialogue` |
| `action_ok` | `key, seconds` |
| `nudge_cursor` | `dx, dy` |
| `finish` | `next_id` |
| `save_record` | `r` |
| `can_afford` | `amount` |
| `grant_key_if_missing` | `` |
| `new_window_from` | `ts` |
| `run_logic` | `with_lock` |
| `_cleanup_expired_hp` | `area_id, bucket_area_id, once_key` |
| `ezweather.handle_player_join` | `pid` |
| `ezweather.handle_player_transfer` | `pid` |
| `persist_area` | `area_id, bucket_area_id, once_key` |
| `action` | `npc, player_id, dialogue, relay_object` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_name`, `map_to_string`, `list_areas`, `close_bbs`, `get_player_area`, `get_player_position`, `get_player_direction`, `get_width`, `get_height`, `unlock_player_camera`, `move_player_camera`, `lock_player_input`, `unlock_player_input`, `track_with_player_camera`, `remove_object`, `list_objects`, `get_object_by_id`, `list_tilesets`, `get_tileset_for_tile`, `create_object`, `move_object`, `remove_bot`, `set_song`, `list_bots`, `get_bot_by_id`, `message_player`, `on`, `get_player_money`, `play_sound_for_player`

## Engine `Async` calls

`message_player`, `sleep`, `question_player`, `prompt_player`, `quiz_player`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEFAULTS` | `{` |
| `ONCEHUB` | `{` |
| `ONCEHUB_CATALOG` | `{` |
| `MENU_COLOR` | `{` |
| `YELLOW` | `{r=245,g=210,b=70},` |
| `GREEN` | `{r=60, g=170,b=90},` |
| `BLUE` | `{r=80, g=140,b=220},` |
| `ONCEHUB_DEBUG` | `false` |
| `DEFAULT_MEM_AREA` | `"WCity1"` |
| `DEFAULT_MEM_AREA` | `_pick_existing_mem_area(DEFAULT_MEM_AREA)` |
| `MENU_DEBOUNCE` | `{}  -- [pid] -> boolean` |
| `REM_CURSOR_TSX_TAIL` | `"edit_mode_tile_removal_cursor.tsx" -- filename only` |
| `REM_CURSOR_LOCAL_ID` | `0   -- tile index inside that .tsx (usually 0)` |
| `REM_CURSOR_TILE_SIZE` | `1   -- width/height to use for the cursor (in tile units)` |
| `FLIP_H` | `0x80000000` |
| `FLIP_V` | `0x40000000` |
| `FLIP_D` | `0x20000000` |
| `DECOR_DEFAULT_PRICE` | `1000` |
| `DECOR_DEFAULT_PRICE` | `DECOR_DEFAULT_PRICE or 1000` |
| `DECOR_MEM_KEY` | `"oncehub_decor_inventory_v1"` |
| `PLACEMENTS_MEM_KEY` | `"oncehub_placements_v1"` |
| `BUCKET` | `resolve_mem_area_id(dialogue, player_id, nil)` |
| `JUKEBOX_SONG_PREFIX` | `"/server/assets/jukebox/"` |
| `BUCKET_AREA_ID` | `resolve_mem_area_id(dialogue, player_id, nil)` |
| `BUCKET_AREA_ID` | `resolve_mem_area_id(dialogue, player_id, nil)` |
| `BUCKET_AREA_ID` | `resolve_mem_area_id(dialogue, player_id, nil)` |
| `BUCKET_AREA_ID` | `resolve_mem_area_id(dialogue, player_id, nil)` |
| `BUCKET` | `resolve_mem_area_id(dialogue, player_id, nil)` |
| `LABEL_SET` | `"Set visitor password"` |
| `LABEL_CLEAR` | `"Clear visitor password"` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/panel_change.ogg` |
| `/server/assets/ezlibs-assets/sfx/item_get.ogg` |
| `/server/assets/jukebox/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
