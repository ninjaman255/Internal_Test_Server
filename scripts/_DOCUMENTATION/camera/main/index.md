# 📄 `main.lua` — Current source reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/camera/main.lua`](../../../../../control_impl/src/scripts/camera/main.lua)  
> **Source lines:** 129  
> **SHA-256:** `e96248b61203c865d5398213cb8cee1d264cf5566492a376ad5f360119ab5206`  
> **Declared/assigned functions:** 3 · **table initializers (simple patterns):** 0 · **event subscriptions detected:** 4

> **Method:** Static source inventory. Parameters are spelled as in the source; no types, return values, or public accessibility are inferred from signatures alone. See the authored guides for behavioral descriptions.

## 🧭 Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Events](#events)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net APIs](#net-apis)

## Overview

Current reference for `camera/main.lua` in the PlayerControl-patched November 11 snapshot.

## Dependencies

| Line | Required module |
|---:|---|
| 2 | `scripts/camera/camera-manager` |
| 3 | `scripts/camera/camera-controller` |
| 4 | `scripts/enum/predefined-enums` |
| 5 | `scripts/input-controller/main` |

## Events

| Line | Emitter | Event |
|---:|---|---|
| 20 | `Net` | `player_join` |
| 47 | `Net` | `tile_interaction` |
| 105 | `Net` | `player_area_transfer` |
| 112 | `Net` | `player_disconnect` |

## Functions and parameters

| Line | Declared/assigned function | Parameters (source) | Local |
|---:|---|---|---|
| 9 | `dbg` | `...` | yes |
| 19 | `setupPlayerJoin` | `(none)` | yes |
| 46 | `setupTileInteraction` | `(none)` | yes |

### Parameter details

#### 1. `dbg(...)`

- **Declared at:** source line 9.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `...` | Exact source parameter; type not asserted. |

#### 2. `setupPlayerJoin()`

- **Declared at:** source line 19.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 3. `setupTileInteraction()`

- **Declared at:** source line 46.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.


## Tables

No simple `name = {` table initializers detected.

## Net APIs

| Called API | Occurrences | First source line |
|---|---:|---:|
| `Net.on` | 4 | 20 |
