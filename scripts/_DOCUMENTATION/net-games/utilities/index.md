# 📁 net-games/utilities

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `lockable-table.lua` | 1 | 35 | 14 | 352 | [Open script reference](lockable-table/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `lockable-table.lua` | `methods:add(key, value, recursive)` | 91 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:remove(key, recursive)` | 109 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:addMany(pairs, recursive)` | 128 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:removeMany(keys, recursive)` | 138 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:canAdd(key)` | 148 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:canRemove(key)` | 152 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:update(key, value, recursive)` | 156 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:replace(new_data, recursive)` | 170 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:clear(recursive)` | 197 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:getRaw(key)` | 202 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:setRaw(key, value)` | 206 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:lockKey(key, recursive)` | 211 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:unlockKey(key, recursive)` | 220 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:lockValue(value, recursive)` | 229 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:unlockValue(value, recursive)` | 240 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:lockAll(recursive)` | 251 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:unlockAll(recursive)` | 264 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:isKeyLocked(key)` | 279 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:isValueLocked(value)` | 283 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:isFullyLocked()` | 287 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:getLockedKeys()` | 291 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:getLockedValues()` | 299 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:size()` | 307 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:keys()` | 315 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `methods:values()` | 323 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `LockableTable.new(t)` | 335 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `LockableTable.isLockable(t)` | 340 | [Details](lockable-table/index.md) |
| `lockable-table.lua` | `LockableTable.wrap(t)` | 345 | [Details](lockable-table/index.md) |

## 📊 Collection summary

This folder subtree contains **1 Lua source files**, **35 named/assigned function detections**, and **14 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | README.md |
