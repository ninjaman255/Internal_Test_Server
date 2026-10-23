# `ezlibs-scripts/ezmemory.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezmemory.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezmemory.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezmemory.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/avatar_utils/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezconfig` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/json` | Import string found in source; runtime resolution depends on the server package layout. |
| `table` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `handle_player_join` | `Net:on(...)` subscription found in source. |
| `player_request` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `fragments_changed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `health_changed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `item_gained` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `item_lost` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `money_changed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `money_spent` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `object_hidden` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `tokens_changed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `_normalize_tokens` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_read` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_file` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.add_player_fragments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.add_player_tokens` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.calculate_player_modified_max_hp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.count_player_item` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.create_or_update_item` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.dangerously_override_player_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_area_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_item_id_by_name` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_item_info` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_or_create_item` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_area_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_fragments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_health` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_max_health` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_money` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_name_from_safesecret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.get_player_tokens` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.give_item_with_optional_notify` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.give_player_item` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.handle_player_avatar_change` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.hide_object_from_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.hide_object_from_player_till_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.is_loaded` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.object_is_hidden_from_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.object_is_hidden_from_player_till_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.open_shop_async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.play_anim_get` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.remove_player_item` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.save_area_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.save_items` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.save_player_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.set_direction_anim` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.set_player_fragments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.set_player_health` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.set_player_max_health` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.set_player_money` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.set_player_tokens` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.spend_player_fragments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.spend_player_money` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.spend_player_tokens` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.unhide_object_from_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.unhide_object_from_player_till_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.update_player_list` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory.wait_until_loaded` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory_load_file` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmemory_save_file` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_file_paths` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_player_area_safely` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `initialize_area_memory_file` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_all_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_player_memory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `printd` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_player_health` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 1143 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
