# `persistence/save-game.lua`

> **Source reference**
>
> Refreshed from the current `persistence/save-game.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

game_save.lua Extension of persistence.lua that provides a staging area for changes. Allows you to make multiple edits, then either commit them (save) or discard them (revert) back to the last saved state. Uses the new saveData() method to avoid internal state inconsistency. Per‑player save files with sanitised secret.

## Module location

- **Source:** `persistence/save-game.lua`
- **Reference:** `script-reference/persistence/save-game.lua.md`
- **Source SHA-256 prefix:** `8a1da8d304d6`

## Source header notes

- game_save.lua
- Extension of persistence.lua that provides a staging area for changes.
- Allows you to make multiple edits, then either commit them (save) or
- discard them (revert) back to the last saved state.
- Uses the new saveData() method to avoid internal state inconsistency.
- Per‑player save files with sanitised secret.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/persistence/persistence` |
| `scripts/utils/utility` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ensure_directory_exists` | `filePath` |
| `ensure_save_file_exists` | `filePath` |
| `sanitize_filename_component` | `str` |
| `deep_copy` | `orig` |
| `new` | `filePath` |
| `self:load` | `` |
| `self:edit` | `func` |
| `self:save` | `` |
| `self:revert` | `` |
| `self:getData` | `` |
| `self:isModified` | `` |
| `self:getWorkingTable` | `` |
| `get_game_save` | `player_id, index` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_secret`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `MAX_SAVE_INSTANCES` | `3` |
| `SAVE_PATH_PATTERN` | `"scripts/save-files/%s/save%d.json"` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
