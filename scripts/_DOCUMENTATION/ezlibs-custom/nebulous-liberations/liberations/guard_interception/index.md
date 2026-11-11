# 📄 `guard_interception.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/guard_interception.lua)  
> **Source lines:** 249  
> **SHA-256 (UTF-8):** `5ace265eee6502d776f1a5e923dd94eaa4cbc3765cd5737003550732ffa1e79e`  
> **Named/assigned functions detected:** 10  
> **Table initializers detected:** 12

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/ezlibs-scripts/ezbus` |
| 2 | `scripts/libs/direction` |
| 3 | `scripts/logger/logger` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 203 | `bus` | `prepare_attack` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 21 | `get_position` | `player` | local |
| 31 | `is_guard_session` | `session` | local |
| 39 | `is_eligible_attacker` | `attacker` | local |
| 44 | `face_attacker` | `guard_player, guard_position, attacker` | local |
| 60 | `animate_interception` | `instance, guard_session, protected_session, attacker, impact_delay` | local |
| 144 | `build_attack_records` | `event` | local |
| 198 | `get_instance_bus` | `instance` | local |
| 210 | `GuardInterception.prepare_attack` | `instance, attacker, target_sessions, impact_delay` | assigned/declared |
| 222 | `GuardInterception.apply_damage` | `records, amount, attacker` | assigned/declared |
| 242 | `GuardInterception.finish_attack` | `instance, records` | assigned/declared |

### Detailed parameter inventory

#### 1. `get_position(player)`

- **Line:** 21
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player` | Declared in this function; type not inferred. |

#### 2. `is_guard_session(session)`

- **Line:** 31
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `session` | Declared in this function; type not inferred. |

#### 3. `is_eligible_attacker(attacker)`

- **Line:** 39
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `attacker` | Declared in this function; type not inferred. |

#### 4. `face_attacker(guard_player, guard_position, attacker)`

- **Line:** 44
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `guard_player` | Declared in this function; type not inferred. |
| 2 | `guard_position` | Declared in this function; type not inferred. |
| 3 | `attacker` | Declared in this function; type not inferred. |

#### 5. `animate_interception(instance, guard_session, protected_session, attacker, impact_delay)`

- **Line:** 60
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `guard_session` | Declared in this function; type not inferred. |
| 3 | `protected_session` | Declared in this function; type not inferred. |
| 4 | `attacker` | Declared in this function; type not inferred. |
| 5 | `impact_delay` | Declared in this function; type not inferred. |

#### 6. `build_attack_records(event)`

- **Line:** 144
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event` | Declared in this function; type not inferred. |

#### 7. `get_instance_bus(instance)`

- **Line:** 198
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |

#### 8. `GuardInterception.prepare_attack(instance, attacker, target_sessions, impact_delay)`

- **Line:** 210
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `attacker` | Declared in this function; type not inferred. |
| 3 | `target_sessions` | Declared in this function; type not inferred. |
| 4 | `impact_delay` | Declared in this function; type not inferred. |

#### 9. `GuardInterception.apply_damage(records, amount, attacker)`

- **Line:** 222
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `records` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |
| 3 | `attacker` | Declared in this function; type not inferred. |

#### 10. `GuardInterception.finish_attack(instance, records)`

- **Line:** 242
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `records` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 6 | `GuardInterception` |
| 7 | `registered_buses` |
| 14 | `animation_suffix` |
| 86 | `keyframes` |
| 88 | `properties` |
| 96 | `properties` |
| 104 | `properties` |
| 112 | `properties` |
| 120 | `properties` |
| 211 | `event` |
| 216 | `records` |
| 223 | `damaged` |

## Net API calls

No direct `Net.method(...)` call expression matched.
