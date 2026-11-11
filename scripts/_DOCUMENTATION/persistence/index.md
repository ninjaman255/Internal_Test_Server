# 📁 persistence

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `logger.lua` | 1 | 10 | 7 | 189 | [Open script reference](logger/index.md) |
| 📄 Script | `persistence.lua` | 1 | 21 | 12 | 373 | [Open script reference](persistence/index.md) |
| 📄 Script | `save-game.lua` | 1 | 14 | 4 | 250 | [Open script reference](save-game/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `logger.lua` | `LoggerMT:shouldLog(level)` | 73 | [Details](logger/index.md) |
| `logger.lua` | `LoggerMT:addEntry(level, msg, data)` | 80 | [Details](logger/index.md) |
| `logger.lua` | `LoggerMT:flush()` | 110 | [Details](logger/index.md) |
| `logger.lua` | `LoggerMT:debug(msg, data)` | 144 | [Details](logger/index.md) |
| `logger.lua` | `LoggerMT:info(msg, data)` | 148 | [Details](logger/index.md) |
| `logger.lua` | `LoggerMT:warn(msg, data)` | 152 | [Details](logger/index.md) |
| `logger.lua` | `LoggerMT:error(msg, data)` | 156 | [Details](logger/index.md) |
| `logger.lua` | `LoggerMT:forceFlush()` | 161 | [Details](logger/index.md) |
| `persistence.lua` | `self:_mark_dirty()` | 115 | [Details](persistence/index.md) |
| `persistence.lua` | `self:load()` | 125 | [Details](persistence/index.md) |
| `persistence.lua` | `self:getData()` | 152 | [Details](persistence/index.md) |
| `persistence.lua` | `self:setData(newData)` | 164 | [Details](persistence/index.md) |
| `persistence.lua` | `self:update(func)` | 173 | [Details](persistence/index.md) |
| `persistence.lua` | `self:removeKey(key)` | 182 | [Details](persistence/index.md) |
| `persistence.lua` | `self:setKey(key, value)` | 189 | [Details](persistence/index.md) |
| `persistence.lua` | `self:clear()` | 196 | [Details](persistence/index.md) |
| `persistence.lua` | `self:removePath(path)` | 234 | [Details](persistence/index.md) |
| `persistence.lua` | `self:setPath(path, value)` | 244 | [Details](persistence/index.md) |
| `persistence.lua` | `self:_save_internal()` | 254 | [Details](persistence/index.md) |
| `persistence.lua` | `self:save()` | 326 | [Details](persistence/index.md) |
| `persistence.lua` | `self:ready(callback)` | 348 | [Details](persistence/index.md) |
| `persistence.lua` | `self:updateAndSave(func)` | 353 | [Details](persistence/index.md) |
| `save-game.lua` | `self:load()` | 131 | [Details](save-game/index.md) |
| `save-game.lua` | `self:edit(func)` | 145 | [Details](save-game/index.md) |
| `save-game.lua` | `self:save()` | 155 | [Details](save-game/index.md) |
| `save-game.lua` | `self:revert()` | 178 | [Details](save-game/index.md) |
| `save-game.lua` | `self:getData()` | 187 | [Details](save-game/index.md) |
| `save-game.lua` | `self:isModified()` | 199 | [Details](save-game/index.md) |
| `save-game.lua` | `self:getWorkingTable()` | 205 | [Details](save-game/index.md) |

## 📊 Collection summary

This folder subtree contains **3 Lua source files**, **45 named/assigned function detections**, and **23 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | README.md |
