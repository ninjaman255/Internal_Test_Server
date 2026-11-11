# 📄 `ezmemory.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezmemory.lua`](../../../ezlibs-scripts/ezmemory.lua)  
> **Source lines:** 1264  
> **SHA-256 (UTF-8):** `72e3402b307feafae041cbb987ca6abe1454bf80ee3103e75325f092b8d911ef`  
> **Named/assigned functions detected:** 66  
> **Table initializers detected:** 19

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezmemory.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/json` |
| 3 | `scripts/ezlibs-scripts/helpers` |
| 4 | `table` |
| 5 | `scripts/ezlibs-scripts/ezbus` |
| 6 | `scripts/ezlibs-scripts/ezconfig` |
| 7 | `scripts/ezlibs-scripts/avatar_utils/main` |
| 1117 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 136 | `Net` | `handle_player_join` |
| 142 | `Net` | `player_request` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 59 | `ensure_file` | `path, default_content` | local |
| 90 | `get_file_paths` | `base` | local |
| 104 | `ezmemory_load_file` | `file_path` | local |
| 123 | `ezmemory_save_file` | `file_path, value` | local |
| 149 | `printd` | `...` | local |
| 154 | `normalize_player_memory` | `mem` | local |
| 167 | `is_instance_area_id` | `area_id` | local |
| 175 | `remove_area_memory_files` | `area_id` | local |
| 197 | `prune_stale_instance_memory` | `active_area_ids` | local |
| 231 | `initialize_area_memory_file` | `area_id` | local |
| 237 | `_read` | `path` | local |
| 277 | `load_all_memory` | `(none)` | local |
| 319 | `update_player_health` | `player_id` | local |
| 355 | `ezmemory.wait_until_loaded` | `(none)` | assigned/declared |
| 363 | `ezmemory.is_loaded` | `(none)` | assigned/declared |
| 372 | `ezmemory.get_item_info` | `item_id` | assigned/declared |
| 379 | `ezmemory.create_or_update_item` | `item_name, item_description, is_key` | assigned/declared |
| 404 | `ezmemory.get_item_id_by_name` | `item_name` | assigned/declared |
| 415 | `ezmemory.get_or_create_item` | `item_name, item_description, is_key` | assigned/declared |
| 423 | `ezmemory.save_items` | `(none)` | assigned/declared |
| 427 | `ezmemory.save_area_memory` | `area_id` | assigned/declared |
| 431 | `ezmemory.save_player_memory` | `safe_secret` | assigned/declared |
| 438 | `ezmemory.clear_area_memory` | `area_id` | assigned/declared |
| 462 | `ezmemory.dangerously_override_player_memory` | `safe_secret, new_memory` | assigned/declared |
| 468 | `ezmemory.get_area_memory` | `area_id` | assigned/declared |
| 475 | `_read` | `path` | local |
| 512 | `ezmemory.get_player_memory` | `safe_secret` | assigned/declared |
| 532 | `ezmemory.get_player_area_memory` | `safe_secret, area_id` | assigned/declared |
| 546 | `ezmemory.update_player_list` | `safe_secret, name` | assigned/declared |
| 551 | `ezmemory.get_player_name_from_safesecret` | `safe_secret` | assigned/declared |
| 560 | `ezmemory.give_player_item` | `player_id, name, amount` | assigned/declared |
| 596 | `ezmemory.remove_player_item` | `player_id, name, remove_quant` | assigned/declared |
| 631 | `ezmemory.get_player_money` | `player_id` | assigned/declared |
| 656 | `ezmemory.spend_player_money` | `player_id, amount` | assigned/declared |
| 678 | `ezmemory.add_player_money` | `player_id, amount` | assigned/declared |
| 699 | `ezmemory.set_player_money` | `player_id, money` | assigned/declared |
| 711 | `ezmemory.get_player_fragments` | `player_id` | assigned/declared |
| 736 | `ezmemory.set_player_fragments` | `player_id, fragments` | assigned/declared |
| 752 | `ezmemory.add_player_fragments` | `player_id, amount` | assigned/declared |
| 768 | `ezmemory.spend_player_fragments` | `player_id, amount` | assigned/declared |
| 793 | `_normalize_tokens` | `value` | local |
| 800 | `ezmemory.get_player_tokens` | `player_id` | assigned/declared |
| 810 | `ezmemory.set_player_tokens` | `player_id, tokens` | assigned/declared |
| 823 | `ezmemory.add_player_tokens` | `player_id, amount` | assigned/declared |
| 838 | `ezmemory.spend_player_tokens` | `player_id, amount` | assigned/declared |
| 869 | `ezmemory.count_player_item` | `player_id, item_name` | assigned/declared |
| 882 | `ezmemory.open_shop_async` | `player_id, shop_items, mugshot_texture_path, mugshot_animation_path` | assigned/declared |
| 903 | `ezmemory.hide_object_from_player_till_disconnect` | `player_id, area_id, object_id` | assigned/declared |
| 927 | `get_player_area_safely` | `player_id` | local |
| 946 | `ezmemory.unhide_object_from_player_till_disconnect` | `player_id, area_id, object_id` | assigned/declared |
| 968 | `ezmemory.unhide_object_from_player` | `player_id, area_id, object_id` | assigned/declared |
| 996 | `ezmemory.hide_object_from_player` | `player_id, area_id, object_id` | assigned/declared |
| 1016 | `ezmemory.object_is_hidden_from_player` | `player_id, area_id, object_id` | assigned/declared |
| 1033 | `ezmemory.object_is_hidden_from_player_till_disconnect` | `player_id, area_id, object_id` | assigned/declared |
| 1042 | `ezmemory.handle_player_disconnect` | `player_id` | assigned/declared |
| 1046 | `ezmemory.handle_player_join` | `player_id` | assigned/declared |
| 1088 | `ezmemory.handle_player_transfer` | `player_id` | assigned/declared |
| 1128 | `ezmemory.calculate_player_modified_max_hp` | `player_id, base_max_hp, hp_memory_modifier, hp_memory_item` | assigned/declared |
| 1134 | `ezmemory.get_player_max_health` | `player_id` | assigned/declared |
| 1140 | `ezmemory.get_player_health` | `player_id` | assigned/declared |
| 1146 | `ezmemory.set_player_max_health` | `player_id, new_max_health, should_heal_by_increase` | assigned/declared |
| 1174 | `ezmemory.set_player_health` | `player_id, new_health` | assigned/declared |
| 1192 | `ezmemory.handle_player_avatar_change` | `player_id, details` | assigned/declared |
| 1197 | `ezmemory.give_item_with_optional_notify` | `player_id, area_id, item_object_id, item_info, notify_player` | assigned/declared |
| 1240 | `ezmemory.play_anim_get` | `player_id` | assigned/declared |
| 1257 | `ezmemory.set_direction_anim` | `player_id, direction` | assigned/declared |

### Detailed parameter inventory

#### 1. `ensure_file(path, default_content)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |
| 2 | `default_content` | Declared in this function; type not inferred. |

#### 2. `get_file_paths(base)`

- **Line:** 90
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base` | Declared in this function; type not inferred. |

#### 3. `ezmemory_load_file(file_path)`

- **Line:** 104
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `file_path` | Declared in this function; type not inferred. |

#### 4. `ezmemory_save_file(file_path, value)`

- **Line:** 123
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `file_path` | Declared in this function; type not inferred. |
| 2 | `value` | Declared in this function; type not inferred. |

#### 5. `printd(...)`

- **Line:** 149
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 6. `normalize_player_memory(mem)`

- **Line:** 154
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `mem` | Declared in this function; type not inferred. |

#### 7. `is_instance_area_id(area_id)`

- **Line:** 167
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 8. `remove_area_memory_files(area_id)`

- **Line:** 175
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 9. `prune_stale_instance_memory(active_area_ids)`

- **Line:** 197
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `active_area_ids` | Declared in this function; type not inferred. |

#### 10. `initialize_area_memory_file(area_id)`

- **Line:** 231
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 11. `_read(path)`

- **Line:** 237
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 12. `load_all_memory()`

- **Line:** 277
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 13. `update_player_health(player_id)`

- **Line:** 319
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 14. `ezmemory.wait_until_loaded()`

- **Line:** 355
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 15. `ezmemory.is_loaded()`

- **Line:** 363
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 16. `ezmemory.get_item_info(item_id)`

- **Line:** 372
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `item_id` | Declared in this function; type not inferred. |

#### 17. `ezmemory.create_or_update_item(item_name, item_description, is_key)`

- **Line:** 379
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `item_name` | Declared in this function; type not inferred. |
| 2 | `item_description` | Declared in this function; type not inferred. |
| 3 | `is_key` | Declared in this function; type not inferred. |

#### 18. `ezmemory.get_item_id_by_name(item_name)`

- **Line:** 404
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `item_name` | Declared in this function; type not inferred. |

#### 19. `ezmemory.get_or_create_item(item_name, item_description, is_key)`

- **Line:** 415
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `item_name` | Declared in this function; type not inferred. |
| 2 | `item_description` | Declared in this function; type not inferred. |
| 3 | `is_key` | Declared in this function; type not inferred. |

#### 20. `ezmemory.save_items()`

- **Line:** 423
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 21. `ezmemory.save_area_memory(area_id)`

- **Line:** 427
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 22. `ezmemory.save_player_memory(safe_secret)`

- **Line:** 431
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `safe_secret` | Declared in this function; type not inferred. |

#### 23. `ezmemory.clear_area_memory(area_id)`

- **Line:** 438
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 24. `ezmemory.dangerously_override_player_memory(safe_secret, new_memory)`

- **Line:** 462
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `safe_secret` | Declared in this function; type not inferred. |
| 2 | `new_memory` | Declared in this function; type not inferred. |

#### 25. `ezmemory.get_area_memory(area_id)`

- **Line:** 468
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 26. `_read(path)`

- **Line:** 475
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 27. `ezmemory.get_player_memory(safe_secret)`

- **Line:** 512
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `safe_secret` | Declared in this function; type not inferred. |

#### 28. `ezmemory.get_player_area_memory(safe_secret, area_id)`

- **Line:** 532
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `safe_secret` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |

#### 29. `ezmemory.update_player_list(safe_secret, name)`

- **Line:** 546
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `safe_secret` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |

#### 30. `ezmemory.get_player_name_from_safesecret(safe_secret)`

- **Line:** 551
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `safe_secret` | Declared in this function; type not inferred. |

#### 31. `ezmemory.give_player_item(player_id, name, amount)`

- **Line:** 560
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |
| 3 | `amount` | Declared in this function; type not inferred. |

#### 32. `ezmemory.remove_player_item(player_id, name, remove_quant)`

- **Line:** 596
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |
| 3 | `remove_quant` | Declared in this function; type not inferred. |

#### 33. `ezmemory.get_player_money(player_id)`

- **Line:** 631
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 34. `ezmemory.spend_player_money(player_id, amount)`

- **Line:** 656
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 35. `ezmemory.add_player_money(player_id, amount)`

- **Line:** 678
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 36. `ezmemory.set_player_money(player_id, money)`

- **Line:** 699
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `money` | Declared in this function; type not inferred. |

#### 37. `ezmemory.get_player_fragments(player_id)`

- **Line:** 711
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 38. `ezmemory.set_player_fragments(player_id, fragments)`

- **Line:** 736
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `fragments` | Declared in this function; type not inferred. |

#### 39. `ezmemory.add_player_fragments(player_id, amount)`

- **Line:** 752
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 40. `ezmemory.spend_player_fragments(player_id, amount)`

- **Line:** 768
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 41. `_normalize_tokens(value)`

- **Line:** 793
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 42. `ezmemory.get_player_tokens(player_id)`

- **Line:** 800
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 43. `ezmemory.set_player_tokens(player_id, tokens)`

- **Line:** 810
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `tokens` | Declared in this function; type not inferred. |

#### 44. `ezmemory.add_player_tokens(player_id, amount)`

- **Line:** 823
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 45. `ezmemory.spend_player_tokens(player_id, amount)`

- **Line:** 838
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 46. `ezmemory.count_player_item(player_id, item_name)`

- **Line:** 869
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `item_name` | Declared in this function; type not inferred. |

#### 47. `ezmemory.open_shop_async(player_id, shop_items, mugshot_texture_path, mugshot_animation_path)`

- **Line:** 882
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `shop_items` | Declared in this function; type not inferred. |
| 3 | `mugshot_texture_path` | Declared in this function; type not inferred. |
| 4 | `mugshot_animation_path` | Declared in this function; type not inferred. |

#### 48. `ezmemory.hide_object_from_player_till_disconnect(player_id, area_id, object_id)`

- **Line:** 903
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |

#### 49. `get_player_area_safely(player_id)`

- **Line:** 927
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 50. `ezmemory.unhide_object_from_player_till_disconnect(player_id, area_id, object_id)`

- **Line:** 946
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |

#### 51. `ezmemory.unhide_object_from_player(player_id, area_id, object_id)`

- **Line:** 968
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |

#### 52. `ezmemory.hide_object_from_player(player_id, area_id, object_id)`

- **Line:** 996
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |

#### 53. `ezmemory.object_is_hidden_from_player(player_id, area_id, object_id)`

- **Line:** 1016
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |

#### 54. `ezmemory.object_is_hidden_from_player_till_disconnect(player_id, area_id, object_id)`

- **Line:** 1033
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |

#### 55. `ezmemory.handle_player_disconnect(player_id)`

- **Line:** 1042
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 56. `ezmemory.handle_player_join(player_id)`

- **Line:** 1046
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 57. `ezmemory.handle_player_transfer(player_id)`

- **Line:** 1088
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 58. `ezmemory.calculate_player_modified_max_hp(player_id, base_max_hp, hp_memory_modifier, hp_memory_item)`

- **Line:** 1128
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `base_max_hp` | Declared in this function; type not inferred. |
| 3 | `hp_memory_modifier` | Declared in this function; type not inferred. |
| 4 | `hp_memory_item` | Declared in this function; type not inferred. |

#### 59. `ezmemory.get_player_max_health(player_id)`

- **Line:** 1134
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 60. `ezmemory.get_player_health(player_id)`

- **Line:** 1140
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 61. `ezmemory.set_player_max_health(player_id, new_max_health, should_heal_by_increase)`

- **Line:** 1146
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `new_max_health` | Declared in this function; type not inferred. |
| 3 | `should_heal_by_increase` | Declared in this function; type not inferred. |

#### 62. `ezmemory.set_player_health(player_id, new_health)`

- **Line:** 1174
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `new_health` | Declared in this function; type not inferred. |

#### 63. `ezmemory.handle_player_avatar_change(player_id, details)`

- **Line:** 1192
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `details` | Declared in this function; type not inferred. |

#### 64. `ezmemory.give_item_with_optional_notify(player_id, area_id, item_object_id, item_info, notify_player)`

- **Line:** 1197
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `item_object_id` | Declared in this function; type not inferred. |
| 4 | `item_info` | Declared in this function; type not inferred. |
| 5 | `notify_player` | Declared in this function; type not inferred. |

#### 65. `ezmemory.play_anim_get(player_id)`

- **Line:** 1240
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 66. `ezmemory.set_direction_anim(player_id, direction)`

- **Line:** 1257
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `direction` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 9 | `ezmemory` |
| 10 | `player_memory` |
| 11 | `area_memory` |
| 12 | `player_list` |
| 13 | `player_avatar_details` |
| 14 | `items` |
| 15 | `item_name_table` |
| 16 | `objects_hidden_till_disconnect_for_player` |
| 24 | `idle_map` |
| 35 | `memory_loaded_flags` |
| 41 | `sfx` |
| 150 | `arg` |
| 198 | `active` |
| 394 | `new_item` |
| 520 | `items` |
| 524 | `meta` |
| 525 | `area_memory` |
| 886 | `shop_items_by_name` |
| 1043 | `objects_hidden_till_disconnect_for_player` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.animate_player` | 4 | 1247 |
| `Net.create_item` | 2 | 282 |
| `Net.exclude_actor_for_player` | 1 | 1122 |
| `Net.exclude_object_for_player` | 5 | 914 |
| `Net.get_area_custom_property` | 4 | 321 |
| `Net.get_player_area` | 4 | 320 |
| `Net.get_player_fragments` | 2 | 719 |
| `Net.get_player_health` | 2 | 327 |
| `Net.get_player_max_health` | 4 | 326 |
| `Net.get_player_money` | 2 | 639 |
| `Net.get_player_name` | 2 | 1048 |
| `Net.give_player_item` | 2 | 574 |
| `Net.kick_player` | 1 | 144 |
| `Net.list_areas` | 1 | 302 |
| `Net.on` | 2 | 136 |
| `Net.open_shop` | 1 | 884 |
| `Net.play_sound_for_player` | 1 | 1233 |
| `Net.provide_asset_for_player` | 1 | 138 |
| `Net.remove_player_item` | 1 | 607 |
| `Net.set_player_fragments` | 3 | 730 |
| `Net.set_player_health` | 3 | 352 |
| `Net.set_player_max_health` | 2 | 350 |
| `Net.set_player_money` | 5 | 650 |
