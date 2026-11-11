# 📄 `save-game.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/persistence/save-game.lua`](../../../persistence/save-game.lua)  
> **Source lines:** 187  
> **SHA-256 (UTF-8):** `8a1da8d304d69d7ce395dd9fde310af8dd0ede9547115313ab1075b1a5182b33`  
> **Named/assigned functions detected:** 13  
> **Table initializers detected (simple pattern):** 4

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/persistence/save-game.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 8 | `scripts/persistence/persistence` |
| 9 | `scripts/utils/utility` |

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 23 | `ensure_directory_exists` | `filePath` | local |
| 42 | `ensure_save_file_exists` | `filePath` | local |
| 57 | `sanitize_filename_component` | `str` | local |
| 64 | `deep_copy` | `orig` | local |
| 76 | `new` | `filePath` | local |
| 88 | `self:load` | `(none)` | assigned/declared |
| 98 | `self:edit` | `func` | assigned/declared |
| 106 | `self:save` | `(none)` | assigned/declared |
| 124 | `self:revert` | `(none)` | assigned/declared |
| 132 | `self:getData` | `(none)` | assigned/declared |
| 143 | `self:isModified` | `(none)` | assigned/declared |
| 147 | `self:getWorkingTable` | `(none)` | assigned/declared |
| 158 | `get_game_save` | `player_id, index` | local |

### Detailed parameter inventory

#### 1. `ensure_directory_exists(filePath)`

- **Line:** 23
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filePath` | Declared by this function; type not inferred. |

#### 2. `ensure_save_file_exists(filePath)`

- **Line:** 42
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filePath` | Declared by this function; type not inferred. |

#### 3. `sanitize_filename_component(str)`

- **Line:** 57
- **Declaration:** local
- **Nearby code comment:** ---------------------------------------------------------------------------- Sanitisation and deep copy ----------------------------------------------------------------------------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `str` | Declared by this function; type not inferred. |

#### 4. `deep_copy(orig)`

- **Line:** 64
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `orig` | Declared by this function; type not inferred. |

#### 5. `new(filePath)`

- **Line:** 76
- **Declaration:** local
- **Nearby code comment:** ---------------------------------------------------------------------------- Game save instance constructor ----------------------------------------------------------------------------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filePath` | Declared by this function; type not inferred. |

#### 6. `self:load()`

- **Line:** 88
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 7. `self:edit(func)`

- **Line:** 98
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `func` | Declared by this function; type not inferred. |

#### 8. `self:save()`

- **Line:** 106
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 9. `self:revert()`

- **Line:** 124
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 10. `self:getData()`

- **Line:** 132
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 11. `self:isModified()`

- **Line:** 143
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 12. `self:getWorkingTable()`

- **Line:** 147
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 13. `get_game_save(player_id, index)`

- **Line:** 158
- **Declaration:** local
- **Nearby code comment:** Factory: returns the singleton game_save instance for a given player and save slot

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `index` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 16 | `instances` |
| 66 | `copy` |
| 79 | `self` |
| 136 | `copy` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_secret` | 1 | 166 |
