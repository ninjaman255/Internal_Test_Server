# 📄 `predefined-enums.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/enum/predefined-enums.lua`](../../../enum/predefined-enums.lua)  
> **Source lines:** 38  
> **SHA-256 (UTF-8):** `5a85616b034d72…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 3

## 🗂️ Contents

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

Central place to define your enums for easy reuse. You can add as many as you like.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 5 | `scripts/enum/enum` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `PredefinedEnums` — line 7

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `CameraMode` | expression/reference | `Enum.new({ active = "minimap", options = { MiniMap = "minimap", PlayerControlled = "player", ServerControlled = "server", Custom = "custom" } })` |
| `Status` | expression/reference | `Enum.new({ ACTIVE = "active", INACTIVE = "inactive", PENDING = { code = 0, label = "pending" }, })` |
| `LogLevel` | expression/reference | `Enum.new({Debug = "DEBUG", Info = "INFO", Warn = "WARN", Error = "ERROR"})` |
| `DefaultPlayerAnimNames` | expression/reference | `Enum.new({ IdleDL = "IDLE_DL", IdleDR = "IDLE_DR", IdleUL = "IDLE_UL", IdleUR = "IDLE_UR", IdleU = "IDLE_U", IdleD = "IDLE_D", IdleR = "IDLE_R", IdleL = "…` |

### 2. `options` — line 10

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `MiniMap` | string literal | `"minimap"` |
| `PlayerControlled` | string literal | `"player"` |
| `ServerControlled` | string literal | `"server"` |
| `Custom` | string literal | `"custom"` |

### 3. `PENDING` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `code` | numeric literal | `0` |
| `label` | string literal | `"pending"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
