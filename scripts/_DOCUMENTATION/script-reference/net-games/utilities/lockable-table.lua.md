# `net-games/utilities/lockable-table.lua`

> **Source reference**
>
> Refreshed from the current `net-games/utilities/lockable-table.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

lockable_table.lua

## Module location

- **Source:** `net-games/utilities/lockable-table.lua`
- **Reference:** `script-reference/net-games/utilities/lockable-table.lua.md`
- **Source SHA-256 prefix:** `8696b797cd35`

## Source header notes

- lockable_table.lua

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `is_lockable` | `t` |
| `create_lockable_table` | `t` |
| `can_modify` | `key, new_value` |
| `methods:add` | `key, value, recursive` |
| `methods:remove` | `key, recursive` |
| `methods:addMany` | `pairs, recursive` |
| `methods:removeMany` | `keys, recursive` |
| `methods:canAdd` | `key` |
| `methods:canRemove` | `key` |
| `methods:update` | `key, value, recursive` |
| `methods:replace` | `new_data, recursive` |
| `methods:clear` | `recursive` |
| `methods:getRaw` | `key` |
| `methods:setRaw` | `key, value` |
| `methods:lockKey` | `key, recursive` |
| `methods:unlockKey` | `key, recursive` |
| `methods:lockValue` | `value, recursive` |
| `methods:unlockValue` | `value, recursive` |
| `methods:lockAll` | `recursive` |
| `methods:unlockAll` | `recursive` |
| `methods:isKeyLocked` | `key` |
| `methods:isValueLocked` | `value` |
| `methods:isFullyLocked` | `` |
| `methods:getLockedKeys` | `` |
| `methods:getLockedValues` | `` |
| `methods:size` | `` |
| `methods:keys` | `` |
| `methods:values` | `` |
| `LockableTable.new` | `t` |
| `LockableTable.isLockable` | `t` |
| `LockableTable.wrap` | `t` |
| `__index` | `tbl, key` |
| `__newindex` | `tbl, key, value` |
| `__pairs` | `` |
| `__len` | `` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
