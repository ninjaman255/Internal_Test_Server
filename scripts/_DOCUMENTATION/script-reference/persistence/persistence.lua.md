# `persistence/persistence.lua`

> **Source reference**
>
> Generated from `persistence/persistence.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

persistence.lua Persistent JSON file storage with automatic debounced saving and per‑file instance management. Supports chained updates and waiting for save completion via promise‑returning save(). Automatically creates missing directories when saving. Now includes saveData() for direct writes without altering internal state, and dirty flag is cleared only after successful write.

## Module location

- **Source:** `persistence/persistence.lua`
- **Relative reference:** `script-reference/persistence/persistence.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/libs/json` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/utils/utility` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `async_ensure_dir` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_directory_exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_path` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:_mark_dirty` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:_save_internal` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:clear` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:getData` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:load` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:ready` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:removeKey` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:removePath` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:save` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:saveData` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:setData` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:setKey` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:setPath` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `self:updateAndSave` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `split` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 338 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
