# `persistence/save-game.lua`

> **Source reference**
>
> Generated from `persistence/save-game.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

game_save.lua Extension of persistence.lua that provides a staging area for changes. Allows you to make multiple edits, then either commit them (save) or discard them (revert) back to the last saved state. Uses the new saveData() method to avoid internal state inconsistency. Per‑player save files with sanitised secret.

## Module location

- **Source:** `persistence/save-game.lua`
- **Relative reference:** `script-reference/persistence/save-game.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/persistence/persistence` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/utils/utility` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `deep_copy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_directory_exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_save_file_exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_game_save` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `sanitize_filename_component` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:edit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:getData` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:getWorkingTable` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:isModified` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:load` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:revert` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:save` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 187 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
