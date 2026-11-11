# 📄 `avatar_utils.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/avatar_utils/avatar_utils.lua`](../../../../ezlibs-scripts/avatar_utils/avatar_utils.lua)  
> **Source lines:** 236  
> **SHA-256 (UTF-8):** `324b9cd971500440244e40965b23838aea4c76898a92e6e0883b4df9000d2c74`  
> **Named/assigned functions detected:** 9  
> **Table initializers detected:** 5

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/avatar_utils/avatar_utils.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 4 | `scripts/logger/logger` |
| 5 | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/lib` |
| 6 | `scripts/ezlibs-scripts/avatar_utils/base64` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 11 | `parse_duration` | `duration_str` | local |
| 23 | `get_arg_by_key` | `args, key, transform` | local |
| 41 | `assert_no_nils` | `expected_args` | local |
| 52 | `ensure_directory` | `filepath` | local |
| 66 | `set_or_update_asset` | `asset_path, asset_content` | assigned/declared |
| 80 | `avatar_utils.copy_player_avatar_to` | `player_id, new_texture_path, new_animation_path, mug_texture_path, mug_animation_path` | assigned/declared |
| 145 | `write_temp_file` | `content` | local |
| 161 | `avatar_utils.parse_animation_data` | `data` | assigned/declared |
| 222 | `avatar_utils.parse_animation_file` | `filepath` | assigned/declared |

### Detailed parameter inventory

#### 1. `parse_duration(duration_str)`

- **Line:** 11
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `duration_str` | Declared in this function; type not inferred. |

#### 2. `get_arg_by_key(args, key, transform)`

- **Line:** 23
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `args` | Declared in this function; type not inferred. |
| 2 | `key` | Declared in this function; type not inferred. |
| 3 | `transform` | Declared in this function; type not inferred. |

#### 3. `assert_no_nils(expected_args)`

- **Line:** 41
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `expected_args` | Declared in this function; type not inferred. |

#### 4. `ensure_directory(filepath)`

- **Line:** 52
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filepath` | Declared in this function; type not inferred. |

#### 5. `set_or_update_asset(asset_path, asset_content)`

- **Line:** 66
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `asset_path` | Declared in this function; type not inferred. |
| 2 | `asset_content` | Declared in this function; type not inferred. |

#### 6. `avatar_utils.copy_player_avatar_to(player_id, new_texture_path, new_animation_path, mug_texture_path, mug_animation_path)`

- **Line:** 80
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `new_texture_path` | Declared in this function; type not inferred. |
| 3 | `new_animation_path` | Declared in this function; type not inferred. |
| 4 | `mug_texture_path` | Declared in this function; type not inferred. |
| 5 | `mug_animation_path` | Declared in this function; type not inferred. |

#### 7. `write_temp_file(content)`

- **Line:** 145
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `content` | Declared in this function; type not inferred. |

#### 8. `avatar_utils.parse_animation_data(data)`

- **Line:** 161
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `data` | Declared in this function; type not inferred. |

#### 9. `avatar_utils.parse_animation_file(filepath)`

- **Line:** 222
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filepath` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 8 | `avatar_utils` |
| 179 | `avatar` |
| 186 | `expected_args` |
| 191 | `frames` |
| 198 | `expected_args` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_avatar` | 1 | 88 |
| `Net.get_player_mugshot` | 1 | 89 |
| `Net.has_asset` | 1 | 67 |
| `Net.read_asset` | 4 | 92 |
| `Net.remove_asset` | 1 | 68 |
| `Net.update_asset` | 1 | 70 |
