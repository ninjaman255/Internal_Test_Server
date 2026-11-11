# 📁 utils

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `async.lua` | 1 | 15 | 10 | 302 | [Open script reference](async/index.md) |
| 📄 Script | `event-emitter.lua` | 1 | 14 | 18 | 265 | [Open script reference](event-emitter/index.md) |
| 📄 Script | `utility.lua` | 1 | 4 | 2 | 53 | [Open script reference](utility/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `async.lua` | `Async.create_promise(executor)` | 37 | [Details](async/index.md) |
| `async.lua` | `promise:and_then(on_fulfilled, on_rejected)` | 88 | [Details](async/index.md) |
| `async.lua` | `Async.promisify(coroutine_or_function)` | 125 | [Details](async/index.md) |
| `async.lua` | `Async.await(promise_or_iterator)` | 246 | [Details](async/index.md) |
| `async.lua` | `Async.run(main_function)` | 278 | [Details](async/index.md) |
| `async.lua` | `Async.create_validator(expected_values, error_message)` | 287 | [Details](async/index.md) |
| `event-emitter.lua` | `EventEmitter.new()` | 8 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:on(event, callback)` | 21 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:once(event, callback)` | 32 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:on_any(callback)` | 43 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:on_any_once(callback)` | 51 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:emit(event, ...)` | 59 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:remove_listener(event, callback)` | 95 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:remove_on_any_listener(callback)` | 113 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:async_iter(event)` | 127 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:async_iter_all()` | 169 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:_notify_iterators(event, ...)` | 209 | [Details](event-emitter/index.md) |
| `event-emitter.lua` | `EventEmitter:destroy()` | 233 | [Details](event-emitter/index.md) |
| `utility.lua` | `Utility.create_event_test()` | 17 | [Details](utility/index.md) |
| `utility.lua` | `Utility.resolve_multi(...)` | 37 | [Details](utility/index.md) |
| `utility.lua` | `Utility.event_to_promise(emitter, event_name)` | 45 | [Details](utility/index.md) |

## 📊 Collection summary

This folder subtree contains **3 Lua source files**, **33 named/assigned function detections**, and **30 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | Async, EventEmitter & Utility Modules |
