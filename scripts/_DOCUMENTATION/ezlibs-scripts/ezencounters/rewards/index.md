# 📄 `rewards.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezencounters/rewards.lua`](../../../../ezlibs-scripts/ezencounters/rewards.lua)  
> **Source lines:** 261  
> **SHA-256 (UTF-8):** `cc6c84de644b24…`  
> **Declared/assigned functions detected:** 12  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 8

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

Hybrid encounter reward selection, battle-screen packets, and ezmemory persistence. No dependency on the Endless Runner or Nebulous Liberations. Only battles explicitly managed by ezencounters or the opt-in external registration API can receive native rewards. Nebulous Liberations does NOT register battles: it continues granting panel loot independently.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 19 | `scripts/ezlibs-scripts/ezmemory` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 22 | `integer` | `value` | local |
| 29 | `log` | `message` | local |
| 33 | `Rewards.is_victory` | `stats` | declared |
| 42 | `normalize_type` | `reward_type` | local |
| 55 | `normalize_packet` | `entry, options` | local |
| 72 | `within_score` | `config, score` | local |
| 77 | `amount_for` | `config, score` | local |
| 87 | `add_config` | `out, config, stats, options` | local |
| 119 | `enemy_configuration` | `area_table, enemy` | local |
| 133 | `Rewards.collect` | `area_table, encounter_info, runtime_data, stats, options` | declared |
| 165 | `persist_currency` | `player_id, packet_type, amount, balance_before` | local |
| 189 | `Rewards.finish` | `player_id, area_table, encounter_info, runtime_data, stats, options, callbacks` | declared |

### Function details

#### 1. `integer(value)`

- **Location:** source line 22.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 2. `log(message)`

- **Location:** source line 29.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 3. `Rewards.is_victory(stats)`

- **Location:** source line 33.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `stats` | Not explicitly documented in adjacent source annotations. |

#### 4. `normalize_type(reward_type)`

- **Location:** source line 42.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `reward_type` | Not explicitly documented in adjacent source annotations. |

#### 5. `normalize_packet(entry, options)`

- **Location:** source line 55.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `entry` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 6. `within_score(config, score)`

- **Location:** source line 72.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `config` | Not explicitly documented in adjacent source annotations. |
| 2 | `score` | Not explicitly documented in adjacent source annotations. |

#### 7. `amount_for(config, score)`

- **Location:** source line 77.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `config` | Not explicitly documented in adjacent source annotations. |
| 2 | `score` | Not explicitly documented in adjacent source annotations. |

#### 8. `add_config(out, config, stats, options)`

- **Location:** source line 87.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `out` | Not explicitly documented in adjacent source annotations. |
| 2 | `config` | Not explicitly documented in adjacent source annotations. |
| 3 | `stats` | Not explicitly documented in adjacent source annotations. |
| 4 | `options` | Not explicitly documented in adjacent source annotations. |

#### 9. `enemy_configuration(area_table, enemy)`

- **Location:** source line 119.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_table` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 10. `Rewards.collect(area_table, encounter_info, runtime_data, stats, options)`

- **Location:** source line 133.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Both area-wide and per-encounter reward shapes are optional; preserve all existing encounters/bosses/special_encounters tables unchanged.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_table` | Not explicitly documented in adjacent source annotations. |
| 2 | `encounter_info` | Not explicitly documented in adjacent source annotations. |
| 3 | `runtime_data` | Not explicitly documented in adjacent source annotations. |
| 4 | `stats` | Not explicitly documented in adjacent source annotations. |
| 5 | `options` | Not explicitly documented in adjacent source annotations. |

#### 11. `persist_currency(player_id, packet_type, amount, balance_before)`

- **Location:** source line 165.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `packet_type` | Not explicitly documented in adjacent source annotations. |
| 3 | `amount` | Not explicitly documented in adjacent source annotations. |
| 4 | `balance_before` | Not explicitly documented in adjacent source annotations. |

#### 12. `Rewards.finish(player_id, area_table, encounter_info, runtime_data, stats, options, callbacks)`

- **Location:** source line 189.
- **Declaration style:** `declared`.
- **Adjacent source comment:** The caller owns the one-battle-only guard. Exactly one packet is sent for all configured and callback-added rewards, at battle_results time.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `area_table` | Not explicitly documented in adjacent source annotations. |
| 3 | `encounter_info` | Not explicitly documented in adjacent source annotations. |
| 4 | `runtime_data` | Not explicitly documented in adjacent source annotations. |
| 5 | `stats` | Not explicitly documented in adjacent source annotations. |
| 6 | `options` | Not explicitly documented in adjacent source annotations. |
| 7 | `callbacks` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **8** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Rewards` — line 20

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `return` — line 65

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | numeric literal | `1` |
| `card_id` | expression/reference | `card_id` |
| `code` | expression/reference | `code` |

### 3. `return` — line 69

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | expression/reference | `kind` |
| `value` | expression/reference | `amount` |

### 4. `out` — line 134

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `return` — line 159

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `selected` — line 208

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `packets` — line 211

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `totals` — line 212

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `money` | numeric literal | `0` |
| `bugfrags` | numeric literal | `0` |
| `hp` | numeric literal | `0` |
| `chips` | numeric literal | `0` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
