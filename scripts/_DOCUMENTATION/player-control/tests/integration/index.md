# 📄 `integration.lua` — Current source reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/player-control/tests/integration.lua`](../../../../player-control/tests/integration.lua)  
> **Source lines:** 39  
> **SHA-256:** `fa9e3d7b817bf277096bdce46540c33a94a34b7cbf9207db3dd9fa6fda711eb5`  
> **Declared/assigned functions:** 5 · **table initializers (simple patterns):** 4 · **event subscriptions detected:** 0

> **Method:** Static source inventory. Parameters are spelled as in the source; no types, return values, or public accessibility are inferred from signatures alone. See the authored guides for behavioral descriptions.

## 🧭 Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Events](#events)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net APIs](#net-apis)

## Overview

Current reference for `player-control/tests/integration.lua` in the PlayerControl-patched November 11 snapshot.

## Dependencies

| Line | Required module |
|---:|---|
| 17 | `scripts/input-controller/main` |
| 18 | `scripts/player-control/main` |

## Events

No literal named event registrations detected.

## Functions and parameters

| Line | Declared/assigned function | Parameters (source) | Local |
|---:|---|---|---|
| 7 | `Net:on` | `event,fn` | no |
| 11 | `Net.lock_player_input` | `id` | no |
| 12 | `Net.unlock_player_input` | `id` | no |
| 13 | `Net.toggle_player_hud` | `id` | no |
| 14 | `emit` | `name,payload` | yes |

### Parameter details

#### 1. `Net:on(event,fn)`

- **Declared at:** source line 7.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `event` | Exact source parameter; type not asserted. |
| 2 | `fn` | Exact source parameter; type not asserted. |

#### 2. `Net.lock_player_input(id)`

- **Declared at:** source line 11.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `id` | Exact source parameter; type not asserted. |

#### 3. `Net.unlock_player_input(id)`

- **Declared at:** source line 12.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `id` | Exact source parameter; type not asserted. |

#### 4. `Net.toggle_player_hud(id)`

- **Declared at:** source line 13.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `id` | Exact source parameter; type not asserted. |

#### 5. `emit(name,payload)`

- **Declared at:** source line 14.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `name` | Exact source parameter; type not asserted. |
| 2 | `payload` | Exact source parameter; type not asserted. |


## Tables

| Line | Table variable |
|---:|---|
| 4 | `callbacks` |
| 5 | `counters` |
| 6 | `Net` |
| 22 | `events` |

## Net APIs

| Called API | Occurrences | First source line |
|---|---:|---:|
| `Net.lock_player_input` | 1 | 11 |
| `Net.on` | 1 | 7 |
| `Net.toggle_player_hud` | 1 | 13 |
| `Net.unlock_player_input` | 1 | 12 |
