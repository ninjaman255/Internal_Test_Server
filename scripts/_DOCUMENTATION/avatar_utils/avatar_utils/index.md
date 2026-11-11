# 📄 `avatar_utils.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/avatar_utils/avatar_utils.lua`](../../../avatar_utils/avatar_utils.lua)  
> **Source lines:** 235  
> **SHA-256 (UTF-8):** `46811ffe32d287ec1397e7e5ebcd66b8e238e8ed3a5f01d049a0a3b25dc6f38e`  
> **Named/assigned functions detected:** 9  
> **Table initializers detected (simple pattern):** 5

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/avatar_utils/avatar_utils.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 4 | `scripts/avatar_utils/lua_yes_parser/lib` |
| 5 | `scripts/avatar_utils/base64` |

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 10 | `parse_duration` | `duration_str` | local |
| 22 | `get_arg_by_key` | `args, key, transform` | local |
| 40 | `assert_no_nils` | `expected_args` | local |
| 51 | `ensure_directory` | `filepath` | local |
| 65 | `set_or_update_asset` | `asset_path, asset_content` | assigned/declared |
| 79 | `avatar_utils.copy_player_avatar_to` | `player_id, new_texture_path, new_animation_path, mug_texture_path, mug_animation_path` | assigned/declared |
| 144 | `write_temp_file` | `content` | local |
| 160 | `avatar_utils.parse_animation_data` | `data` | assigned/declared |
| 221 | `avatar_utils.parse_animation_file` | `filepath` | assigned/declared |

### Detailed parameter inventory

#### 1. `parse_duration(duration_str)`

- **Line:** 10
- **Declaration:** local
- **Nearby code comment:** Helper: parse duration from .animation file (e.g., "10f" → 166ms)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `duration_str` | Declared by this function; type not inferred. |

#### 2. `get_arg_by_key(args, key, transform)`

- **Line:** 22
- **Declaration:** local
- **Nearby code comment:** Helper: extract argument value from YES parser args

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `args` | Declared by this function; type not inferred. |
| 2 | `key` | Declared by this function; type not inferred. |
| 3 | `transform` | Declared by this function; type not inferred. |

#### 3. `assert_no_nils(expected_args)`

- **Line:** 40
- **Declaration:** local
- **Nearby code comment:** Helper: ensure all required arguments are present

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `expected_args` | Declared by this function; type not inferred. |

#### 4. `ensure_directory(filepath)`

- **Line:** 51
- **Declaration:** local
- **Nearby code comment:** Helper: create directory for a given file path (if it doesn't exist)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filepath` | Declared by this function; type not inferred. |

#### 5. `set_or_update_asset(asset_path, asset_content)`

- **Line:** 65
- **Declaration:** table/global or assignment
- **Nearby code comment:** Helper: register/update an asset with the server

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `asset_path` | Declared by this function; type not inferred. |
| 2 | `asset_content` | Declared by this function; type not inferred. |

#### 6. `avatar_utils.copy_player_avatar_to(player_id, new_texture_path, new_animation_path, mug_texture_path, mug_animation_path)`

- **Line:** 79
- **Declaration:** table/global or assignment
- **Nearby code comment:** @param new_animation_path string destination path for avatar animation @param mug_texture_path string destination path for mugshot texture @param mug_animation_path string destination path for mugshot animation @return boolean success

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `new_texture_path` | Declared by this function; type not inferred. |
| 3 | `new_animation_path` | Declared by this function; type not inferred. |
| 4 | `mug_texture_path` | Declared by this function; type not inferred. |
| 5 | `mug_animation_path` | Declared by this function; type not inferred. |

#### 7. `write_temp_file(content)`

- **Line:** 144
- **Declaration:** local
- **Nearby code comment:** Write content to a temporary file and return its path. @param content string @return string\|nil temp file path, or nil on error

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `content` | Declared by this function; type not inferred. |

#### 8. `avatar_utils.parse_animation_data(data)`

- **Line:** 160
- **Declaration:** table/global or assignment
- **Nearby code comment:** Parse animation data from a string (content of .animation file) into a Lua table. This function writes the content to a temporary file and uses lua_yes_parser. @param data string The content of the .animation file @return table\|nil parsed animation structure, or nil on failure

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `data` | Declared by this function; type not inferred. |

#### 9. `avatar_utils.parse_animation_file(filepath)`

- **Line:** 221
- **Declaration:** table/global or assignment
- **Nearby code comment:** Parse an animation file (.animation) from disk into a Lua table. This function works for any .animation file path, not just those belonging to an avatar. @param filepath string path to the .animation file @return table\|nil parsed animation structure, or nil on failure

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filepath` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 7 | `avatar_utils` |
| 178 | `avatar` |
| 185 | `expected_args` |
| 190 | `frames` |
| 197 | `expected_args` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_avatar` | 1 | 87 |
| `Net.get_player_mugshot` | 1 | 88 |
| `Net.has_asset` | 1 | 66 |
| `Net.read_asset` | 4 | 91 |
| `Net.remove_asset` | 1 | 67 |
| `Net.update_asset` | 1 | 69 |
