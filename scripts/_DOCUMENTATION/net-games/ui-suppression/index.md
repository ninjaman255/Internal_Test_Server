# 📄 `ui-suppression.lua` — Current source reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/ui-suppression.lua`](../../../../../control_impl/src/scripts/net-games/ui-suppression.lua)  
> **Source lines:** 128  
> **SHA-256:** `b1f0e2efffc89d22a191b2f446ff3ce420165f84a23e35d60b981113f2d223e7`  
> **Declared/assigned functions:** 14 · **table initializers (simple patterns):** 11 · **event subscriptions detected:** 0

> **Method:** Static source inventory. Parameters are spelled as in the source; no types, return values, or public accessibility are inferred from signatures alone. See the authored guides for behavioral descriptions.

## 🧭 Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Events](#events)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net APIs](#net-apis)

## Overview

Current reference for `net-games/ui-suppression.lua` in the PlayerControl-patched November 11 snapshot.

## Dependencies

No literal `require` calls detected.

## Events

No literal named event registrations detected.

## Functions and parameters

| Line | Declared/assigned function | Parameters (source) | Local |
|---:|---|---|---|
| 6 | `state_for` | `store, pid` | yes |
| 10 | `net_call` | `name, pid` | yes |
| 17 | `acquire_engine` | `store, pid, owner, kind, fn_name` | yes |
| 30 | `M.acquire_engine_hud` | `pid, owner` | no |
| 35 | `M.acquire_input_lock` | `pid, owner` | no |
| 38 | `M.register_handler` | `name, handler` | no |
| 42 | `M.acquire_element` | `pid, name, owner, options` | no |
| 52 | `M.release` | `h` | no |
| 88 | `M.register_profile` | `name, entries` | no |
| 92 | `M.acquire_profile` | `pid, name, owner, options` | no |
| 109 | `M.release_profile` | `b` | no |
| 116 | `M.cleanup_player` | `pid` | no |
| 121 | `M.get_debug_state` | `pid` | no |
| 122 | `summary` | `s` | yes |

### Parameter details

#### 1. `state_for(store, pid)`

- **Declared at:** source line 6.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `store` | Exact source parameter; type not asserted. |
| 2 | `pid` | Exact source parameter; type not asserted. |

#### 2. `net_call(name, pid)`

- **Declared at:** source line 10.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `name` | Exact source parameter; type not asserted. |
| 2 | `pid` | Exact source parameter; type not asserted. |

#### 3. `acquire_engine(store, pid, owner, kind, fn_name)`

- **Declared at:** source line 17.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `store` | Exact source parameter; type not asserted. |
| 2 | `pid` | Exact source parameter; type not asserted. |
| 3 | `owner` | Exact source parameter; type not asserted. |
| 4 | `kind` | Exact source parameter; type not asserted. |
| 5 | `fn_name` | Exact source parameter; type not asserted. |

#### 4. `M.acquire_engine_hud(pid, owner)`

- **Declared at:** source line 30.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 5. `M.acquire_input_lock(pid, owner)`

- **Declared at:** source line 35.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |
| 2 | `owner` | Exact source parameter; type not asserted. |

#### 6. `M.register_handler(name, handler)`

- **Declared at:** source line 38.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `name` | Exact source parameter; type not asserted. |
| 2 | `handler` | Exact source parameter; type not asserted. |

#### 7. `M.acquire_element(pid, name, owner, options)`

- **Declared at:** source line 42.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |
| 2 | `name` | Exact source parameter; type not asserted. |
| 3 | `owner` | Exact source parameter; type not asserted. |
| 4 | `options` | Exact source parameter; type not asserted. |

#### 8. `M.release(h)`

- **Declared at:** source line 52.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `h` | Exact source parameter; type not asserted. |

#### 9. `M.register_profile(name, entries)`

- **Declared at:** source line 88.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `name` | Exact source parameter; type not asserted. |
| 2 | `entries` | Exact source parameter; type not asserted. |

#### 10. `M.acquire_profile(pid, name, owner, options)`

- **Declared at:** source line 92.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |
| 2 | `name` | Exact source parameter; type not asserted. |
| 3 | `owner` | Exact source parameter; type not asserted. |
| 4 | `options` | Exact source parameter; type not asserted. |

#### 11. `M.release_profile(b)`

- **Declared at:** source line 109.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `b` | Exact source parameter; type not asserted. |

#### 12. `M.cleanup_player(pid)`

- **Declared at:** source line 116.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 13. `M.get_debug_state(pid)`

- **Declared at:** source line 121.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `pid` | Exact source parameter; type not asserted. |

#### 14. `summary(s)`

- **Declared at:** source line 122.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `s` | Exact source parameter; type not asserted. |


## Tables

| Line | Table variable |
|---:|---|
| 3 | `M` |
| 26 | `h` |
| 48 | `h` |
| 82 | `profiles` |
| 83 | `menu` |
| 84 | `cinematic` |
| 85 | `engine_hud_only` |
| 86 | `input_locked` |
| 95 | `b` |
| 117 | `list` |
| 123 | `r` |

## Net APIs

No direct call expressions matching `Net.<name>(` detected.
