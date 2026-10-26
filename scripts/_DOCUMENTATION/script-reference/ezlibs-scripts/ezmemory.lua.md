# `ezlibs-scripts/ezmemory.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezmemory.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezmemory source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezmemory.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezmemory.lua.md`
- **Source SHA-256 prefix:** `69f3bbf18100`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/json` |
| `scripts/ezlibs-scripts/helpers` |
| `table` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezconfig` |
| `scripts/ezlibs-scripts/avatar_utils/main` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |

## `Net:on` subscriptions

| Event |
|---|
| `handle_player_join` |
| `player_request` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ensure_file` | `path, default_content` |
| `get_file_paths` | `base` |
| `ezmemory_load_file` | `file_path` |
| `ezmemory_save_file` | `file_path, value` |
| `printd` | `...` |
| `normalize_player_memory` | `mem` |
| `initialize_area_memory_file` | `area_id` |
| `_read` | `path` |
| `load_all_memory` | `` |
| `update_player_health` | `player_id` |
| `ezmemory.wait_until_loaded` | `` |
| `ezmemory.is_loaded` | `` |
| `ezmemory.get_item_info` | `item_id` |
| `ezmemory.create_or_update_item` | `item_name, item_description, is_key` |
| `ezmemory.get_item_id_by_name` | `item_name` |
| `ezmemory.get_or_create_item` | `item_name, item_description, is_key` |
| `ezmemory.save_items` | `` |
| `ezmemory.save_area_memory` | `area_id` |
| `ezmemory.save_player_memory` | `safe_secret` |
| `ezmemory.dangerously_override_player_memory` | `safe_secret, new_memory` |
| `ezmemory.get_area_memory` | `area_id` |
| `ezmemory.get_player_memory` | `safe_secret` |
| `ezmemory.get_player_area_memory` | `safe_secret, area_id` |
| `ezmemory.update_player_list` | `safe_secret, name` |
| `ezmemory.get_player_name_from_safesecret` | `safe_secret` |
| `ezmemory.give_player_item` | `player_id, name, amount` |
| `ezmemory.remove_player_item` | `player_id, name, remove_quant` |
| `ezmemory.get_player_money` | `player_id` |
| `ezmemory.spend_player_money` | `player_id, amount` |
| `ezmemory.set_player_money` | `player_id, money` |
| `ezmemory.get_player_fragments` | `player_id` |
| `ezmemory.set_player_fragments` | `player_id, fragments` |
| `ezmemory.add_player_fragments` | `player_id, amount` |
| `ezmemory.spend_player_fragments` | `player_id, amount` |
| `_normalize_tokens` | `value` |
| `ezmemory.get_player_tokens` | `player_id` |
| `ezmemory.set_player_tokens` | `player_id, tokens` |
| `ezmemory.add_player_tokens` | `player_id, amount` |
| `ezmemory.spend_player_tokens` | `player_id, amount` |
| `ezmemory.count_player_item` | `player_id, item_name` |
| `ezmemory.open_shop_async` | `player_id, shop_items, mugshot_texture_path, mugshot_animation_path` |
| `ezmemory.hide_object_from_player_till_disconnect` | `player_id, area_id, object_id` |
| `get_player_area_safely` | `player_id` |
| `ezmemory.unhide_object_from_player_till_disconnect` | `player_id, area_id, object_id` |
| `ezmemory.unhide_object_from_player` | `player_id, area_id, object_id` |
| `ezmemory.hide_object_from_player` | `player_id, area_id, object_id` |
| `ezmemory.object_is_hidden_from_player` | `player_id, area_id, object_id` |
| `ezmemory.object_is_hidden_from_player_till_disconnect` | `player_id, area_id, object_id` |
| `ezmemory.handle_player_disconnect` | `player_id` |
| `ezmemory.handle_player_join` | `player_id` |
| `ezmemory.handle_player_transfer` | `player_id` |
| `ezmemory.calculate_player_modified_max_hp` | `player_id, base_max_hp, hp_memory_modifier, hp_memory_item` |
| `ezmemory.get_player_max_health` | `player_id` |
| `ezmemory.get_player_health` | `player_id` |
| `ezmemory.set_player_max_health` | `player_id, new_max_health, should_heal_by_increase` |
| `ezmemory.handle_player_avatar_change` | `player_id, details` |
| `ezmemory.give_item_with_optional_notify` | `player_id, area_id, item_object_id, item_info, notify_player` |
| `ezmemory.play_anim_get` | `player_id` |
| `ezmemory.set_direction_anim` | `player_id, direction` |
| `ezmemory.set_player_health` | `player_id, new_health` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `provide_asset_for_player`, `kick_player`, `create_item`, `list_areas`, `get_player_area`, `get_area_custom_property`, `get_player_max_health`, `get_player_health`, `set_player_max_health`, `set_player_health`, `give_player_item`, `remove_player_item`, `get_player_money`, `set_player_money`, `get_player_fragments`, `set_player_fragments`, `open_shop`, `exclude_object_for_player`, `is_player`, `include_object_for_player`, `get_player_name`, `exclude_actor_for_player`, `play_sound_for_player`, `animate_player`

## Engine `Async` calls

`read_file`, `write_file`, `sleep`, `await`, `message_player`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/item_get.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
