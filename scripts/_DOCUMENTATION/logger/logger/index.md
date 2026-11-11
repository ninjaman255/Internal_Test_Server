# 📄 `logger.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/logger/logger.lua`](../../../logger/logger.lua)  
> **Source lines:** 847  
> **SHA-256 (UTF-8):** `00e733f400a3f3978406a24b17bc99f5bc0c6c7a690ac9c2729ed72efcf29940`  
> **Named/assigned functions detected:** 59  
> **Table initializers detected:** 21

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/logger/logger.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 18 | `scripts/libs/json` |
| 680 | `scripts/ezlibs-scripts/urlencode` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 819 | `Net` | `player_join` |
| 830 | `Net` | `tick` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 24 | `SharedLogger.get_root` | `(none)` | assigned/declared |
| 54 | `wall_time` | `(none)` | local |
| 58 | `safe_component` | `value, fallback` | local |
| 70 | `copy_options` | `source` | local |
| 78 | `timestamp` | `(none)` | local |
| 82 | `join_arguments` | `...` | local |
| 92 | `normalize_path` | `path` | local |
| 96 | `directory_of` | `path` | local |
| 101 | `mkdir_recursive_lfs` | `path, lfs` | local |
| 125 | `ensure_directory` | `path` | local |
| 157 | `encode_string` | `value` | local |
| 167 | `encode_entry_jsonl` | `entry, include_timestamp` | local |
| 193 | `safe_to_string` | `value` | local |
| 200 | `readable_scalar` | `value` | local |
| 215 | `key_label` | `key` | local |
| 220 | `ordered_keys` | `record` | local |
| 235 | `compact_value` | `value, depth, active` | local |
| 253 | `expanded_lines` | `record, indentation, depth, active, lines` | local |
| 286 | `encode_entry_readable` | `entry, details, include_timestamp` | local |
| 330 | `encode_entry_legacy_jsonl` | `entry, include_timestamp` | local |
| 348 | `encode_entry` | `entry, logger` | local |
| 370 | `Logger:_should_log` | `level` | assigned/declared |
| 379 | `warn_io_failure` | `logger, detail` | local |
| 398 | `schedule_io_retry` | `logger, detail` | local |
| 406 | `Logger:flush` | `(none)` | assigned/declared |
| 451 | `inherited_options` | `logger` | local |
| 464 | `full_log_path` | `module_name` | local |
| 468 | `subsystem_log_path` | `module_name, subsystem_name` | local |
| 475 | `mirrored_loggers` | `logger` | local |
| 493 | `Logger:_append` | `entry` | assigned/declared |
| 500 | `Logger:_log` | `level, message, data` | assigned/declared |
| 538 | `arguments_and_data` | `logger, ...` | local |
| 546 | `Logger:debug` | `...` | assigned/declared |
| 547 | `Logger:info` | `...` | assigned/declared |
| 548 | `Logger:warn` | `...` | assigned/declared |
| 549 | `Logger:error` | `...` | assigned/declared |
| 552 | `Logger:shouldLog` | `level` | assigned/declared |
| 553 | `Logger:addEntry` | `level, message, data` | assigned/declared |
| 555 | `Logger:debug_data` | `message, data` | assigned/declared |
| 559 | `Logger:info_data` | `message, data` | assigned/declared |
| 563 | `Logger:warn_data` | `message, data` | assigned/declared |
| 567 | `Logger:error_data` | `message, data` | assigned/declared |
| 571 | `Logger:forceFlush` | `(none)` | assigned/declared |
| 579 | `Logger:set_min_level` | `level` | assigned/declared |
| 587 | `cache_key` | `module_name, scope, path, subsystem_name` | local |
| 592 | `make_logger` | `module_name, scope, file_path, options, subsystem_name` | assigned/declared |
| 625 | `module_name_of` | `name` | local |
| 629 | `SharedLogger.register` | `module_name, options` | assigned/declared |
| 637 | `Logger:register_subsystem` | `subsystem_name, options` | assigned/declared |
| 647 | `SharedLogger.register_subsystem` | `module_name, subsystem_name, options` | assigned/declared |
| 656 | `Logger:for_safe_secret` | `safe_secret, options` | assigned/declared |
| 673 | `resolve_safe_player_secret` | `player_id` | local |
| 693 | `Logger:for_player` | `player_id, options` | assigned/declared |
| 702 | `Logger:for_area` | `area_id, options` | assigned/declared |
| 712 | `SharedLogger.configure` | `options` | assigned/declared |
| 757 | `SharedLogger.flush_all` | `(none)` | assigned/declared |
| 768 | `legacy_file_path` | `path` | local |
| 795 | `SharedLogger.createLogger` | `config` | assigned/declared |
| 812 | `__call` | `_, config` | assigned/declared |

### Detailed parameter inventory

#### 1. `SharedLogger.get_root()`

- **Line:** 24
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 2. `wall_time()`

- **Line:** 54
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 3. `safe_component(value, fallback)`

- **Line:** 58
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |
| 2 | `fallback` | Declared in this function; type not inferred. |

#### 4. `copy_options(source)`

- **Line:** 70
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `source` | Declared in this function; type not inferred. |

#### 5. `timestamp()`

- **Line:** 78
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 6. `join_arguments(...)`

- **Line:** 82
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 7. `normalize_path(path)`

- **Line:** 92
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 8. `directory_of(path)`

- **Line:** 96
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 9. `mkdir_recursive_lfs(path, lfs)`

- **Line:** 101
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |
| 2 | `lfs` | Declared in this function; type not inferred. |

#### 10. `ensure_directory(path)`

- **Line:** 125
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 11. `encode_string(value)`

- **Line:** 157
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 12. `encode_entry_jsonl(entry, include_timestamp)`

- **Line:** 167
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `include_timestamp` | Declared in this function; type not inferred. |

#### 13. `safe_to_string(value)`

- **Line:** 193
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 14. `readable_scalar(value)`

- **Line:** 200
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 15. `key_label(key)`

- **Line:** 215
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared in this function; type not inferred. |

#### 16. `ordered_keys(record)`

- **Line:** 220
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `record` | Declared in this function; type not inferred. |

#### 17. `compact_value(value, depth, active)`

- **Line:** 235
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |
| 2 | `depth` | Declared in this function; type not inferred. |
| 3 | `active` | Declared in this function; type not inferred. |

#### 18. `expanded_lines(record, indentation, depth, active, lines)`

- **Line:** 253
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `record` | Declared in this function; type not inferred. |
| 2 | `indentation` | Declared in this function; type not inferred. |
| 3 | `depth` | Declared in this function; type not inferred. |
| 4 | `active` | Declared in this function; type not inferred. |
| 5 | `lines` | Declared in this function; type not inferred. |

#### 19. `encode_entry_readable(entry, details, include_timestamp)`

- **Line:** 286
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `details` | Declared in this function; type not inferred. |
| 3 | `include_timestamp` | Declared in this function; type not inferred. |

#### 20. `encode_entry_legacy_jsonl(entry, include_timestamp)`

- **Line:** 330
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `include_timestamp` | Declared in this function; type not inferred. |

#### 21. `encode_entry(entry, logger)`

- **Line:** 348
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `logger` | Declared in this function; type not inferred. |

#### 22. `Logger:_should_log(level)`

- **Line:** 370
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `level` | Declared in this function; type not inferred. |

#### 23. `warn_io_failure(logger, detail)`

- **Line:** 379
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `logger` | Declared in this function; type not inferred. |
| 2 | `detail` | Declared in this function; type not inferred. |

#### 24. `schedule_io_retry(logger, detail)`

- **Line:** 398
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `logger` | Declared in this function; type not inferred. |
| 2 | `detail` | Declared in this function; type not inferred. |

#### 25. `Logger:flush()`

- **Line:** 406
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 26. `inherited_options(logger)`

- **Line:** 451
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `logger` | Declared in this function; type not inferred. |

#### 27. `full_log_path(module_name)`

- **Line:** 464
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `module_name` | Declared in this function; type not inferred. |

#### 28. `subsystem_log_path(module_name, subsystem_name)`

- **Line:** 468
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `module_name` | Declared in this function; type not inferred. |
| 2 | `subsystem_name` | Declared in this function; type not inferred. |

#### 29. `mirrored_loggers(logger)`

- **Line:** 475
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `logger` | Declared in this function; type not inferred. |

#### 30. `Logger:_append(entry)`

- **Line:** 493
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |

#### 31. `Logger:_log(level, message, data)`

- **Line:** 500
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `level` | Declared in this function; type not inferred. |
| 2 | `message` | Declared in this function; type not inferred. |
| 3 | `data` | Declared in this function; type not inferred. |

#### 32. `arguments_and_data(logger, ...)`

- **Line:** 538
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `logger` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 33. `Logger:debug(...)`

- **Line:** 546
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 34. `Logger:info(...)`

- **Line:** 547
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 35. `Logger:warn(...)`

- **Line:** 548
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 36. `Logger:error(...)`

- **Line:** 549
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 37. `Logger:shouldLog(level)`

- **Line:** 552
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `level` | Declared in this function; type not inferred. |

#### 38. `Logger:addEntry(level, message, data)`

- **Line:** 553
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `level` | Declared in this function; type not inferred. |
| 2 | `message` | Declared in this function; type not inferred. |
| 3 | `data` | Declared in this function; type not inferred. |

#### 39. `Logger:debug_data(message, data)`

- **Line:** 555
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |
| 2 | `data` | Declared in this function; type not inferred. |

#### 40. `Logger:info_data(message, data)`

- **Line:** 559
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |
| 2 | `data` | Declared in this function; type not inferred. |

#### 41. `Logger:warn_data(message, data)`

- **Line:** 563
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |
| 2 | `data` | Declared in this function; type not inferred. |

#### 42. `Logger:error_data(message, data)`

- **Line:** 567
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |
| 2 | `data` | Declared in this function; type not inferred. |

#### 43. `Logger:forceFlush()`

- **Line:** 571
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 44. `Logger:set_min_level(level)`

- **Line:** 579
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `level` | Declared in this function; type not inferred. |

#### 45. `cache_key(module_name, scope, path, subsystem_name)`

- **Line:** 587
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `module_name` | Declared in this function; type not inferred. |
| 2 | `scope` | Declared in this function; type not inferred. |
| 3 | `path` | Declared in this function; type not inferred. |
| 4 | `subsystem_name` | Declared in this function; type not inferred. |

#### 46. `make_logger(module_name, scope, file_path, options, subsystem_name)`

- **Line:** 592
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `module_name` | Declared in this function; type not inferred. |
| 2 | `scope` | Declared in this function; type not inferred. |
| 3 | `file_path` | Declared in this function; type not inferred. |
| 4 | `options` | Declared in this function; type not inferred. |
| 5 | `subsystem_name` | Declared in this function; type not inferred. |

#### 47. `module_name_of(name)`

- **Line:** 625
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared in this function; type not inferred. |

#### 48. `SharedLogger.register(module_name, options)`

- **Line:** 629
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `module_name` | Declared in this function; type not inferred. |
| 2 | `options` | Declared in this function; type not inferred. |

#### 49. `Logger:register_subsystem(subsystem_name, options)`

- **Line:** 637
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `subsystem_name` | Declared in this function; type not inferred. |
| 2 | `options` | Declared in this function; type not inferred. |

#### 50. `SharedLogger.register_subsystem(module_name, subsystem_name, options)`

- **Line:** 647
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `module_name` | Declared in this function; type not inferred. |
| 2 | `subsystem_name` | Declared in this function; type not inferred. |
| 3 | `options` | Declared in this function; type not inferred. |

#### 51. `Logger:for_safe_secret(safe_secret, options)`

- **Line:** 656
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `safe_secret` | Declared in this function; type not inferred. |
| 2 | `options` | Declared in this function; type not inferred. |

#### 52. `resolve_safe_player_secret(player_id)`

- **Line:** 673
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 53. `Logger:for_player(player_id, options)`

- **Line:** 693
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `options` | Declared in this function; type not inferred. |

#### 54. `Logger:for_area(area_id, options)`

- **Line:** 702
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `options` | Declared in this function; type not inferred. |

#### 55. `SharedLogger.configure(options)`

- **Line:** 712
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `options` | Declared in this function; type not inferred. |

#### 56. `SharedLogger.flush_all()`

- **Line:** 757
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 57. `legacy_file_path(path)`

- **Line:** 768
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 58. `SharedLogger.createLogger(config)`

- **Line:** 795
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `config` | Declared in this function; type not inferred. |

#### 59. `__call(_, config)`

- **Line:** 812
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `_` | Declared in this function; type not inferred. |
| 2 | `config` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 20 | `SharedLogger` |
| 25 | `LEVEL_PRIORITY` |
| 32 | `instances` |
| 33 | `all_instances` |
| 34 | `defaults` |
| 46 | `safe_secret_by_player_id` |
| 52 | `warning_until_by_directory` |
| 71 | `out` |
| 83 | `parts` |
| 168 | `fields` |
| 221 | `keys` |
| 241 | `fields` |
| 305 | `lines` |
| 310 | `fields` |
| 331 | `fields` |
| 367 | `Logger` |
| 444 | `self.buffer` |
| 476 | `mirrors` |
| 510 | `entry` |
| 615 | `lastMessages` |
| 616 | `buffer` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_secret` | 1 | 678 |
| `Net.on` | 2 | 819 |
