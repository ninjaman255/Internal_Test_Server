# 📄 `ezemail.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezemail.lua`](../../../ezlibs-scripts/ezemail.lua)  
> **Source lines:** 346  
> **SHA-256 (UTF-8):** `784e161fde19bc50b352a8f32b2ed59320fdd99120ec5607d61213e3d16dccb2`  
> **Named/assigned functions detected:** 14  
> **Table initializers detected:** 4

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezemail.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/helpers` |
| 3 | `scripts/ezlibs-scripts/ezmemory` |
| 4 | `scripts/ezlibs-scripts/ezbus` |
| 5 | `scripts/ezlibs-scripts/ezconfig` |
| 327 | `scripts/ezlibs-scripts/ezannounce/ezannounce` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 317 | `Net` | `player_join` |
| 336 | `Net` | `email_read` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 16 | `_preload_email_assets` | `player_id, mail` | local |
| 30 | `_get_bucket` | `player_id` | local |
| 38 | `_dbg` | `...` | local |
| 44 | `_dbg_player` | `player_id, ...` | local |
| 50 | `_percent_decode` | `s` | local |
| 57 | `_get_tombstone_set` | `(none)` | local |
| 89 | `_find_mail_in_bucket` | `bucket, email_id` | local |
| 114 | `_mark_email_read` | `player_id, email_id` | local |
| 134 | `_notify_new_mail` | `player_id, msg, delay_seconds` | local |
| 148 | `send_msg` | `(none)` | local |
| 163 | `ezemail.resend_all` | `player_id` | assigned/declared |
| 225 | `ezemail.send_once` | `player_id, mail, opts` | assigned/declared |
| 271 | `ezemail.send_temp` | `player_id, mail, opts` | assigned/declared |
| 293 | `ezemail.send_test_email` | `player_id, delay_seconds` | assigned/declared |

### Detailed parameter inventory

#### 1. `_preload_email_assets(player_id, mail)`

- **Line:** 16
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `mail` | Declared in this function; type not inferred. |

#### 2. `_get_bucket(player_id)`

- **Line:** 30
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 3. `_dbg(...)`

- **Line:** 38
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 4. `_dbg_player(player_id, ...)`

- **Line:** 44
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 5. `_percent_decode(s)`

- **Line:** 50
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared in this function; type not inferred. |

#### 6. `_get_tombstone_set()`

- **Line:** 57
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 7. `_find_mail_in_bucket(bucket, email_id)`

- **Line:** 89
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bucket` | Declared in this function; type not inferred. |
| 2 | `email_id` | Declared in this function; type not inferred. |

#### 8. `_mark_email_read(player_id, email_id)`

- **Line:** 114
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `email_id` | Declared in this function; type not inferred. |

#### 9. `_notify_new_mail(player_id, msg, delay_seconds)`

- **Line:** 134
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `msg` | Declared in this function; type not inferred. |
| 3 | `delay_seconds` | Declared in this function; type not inferred. |

#### 10. `send_msg()`

- **Line:** 148
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 11. `ezemail.resend_all(player_id)`

- **Line:** 163
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 12. `ezemail.send_once(player_id, mail, opts)`

- **Line:** 225
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `mail` | Declared in this function; type not inferred. |
| 3 | `opts` | Declared in this function; type not inferred. |

#### 13. `ezemail.send_temp(player_id, mail, opts)`

- **Line:** 271
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `mail` | Declared in this function; type not inferred. |
| 3 | `opts` | Declared in this function; type not inferred. |

#### 14. `ezemail.send_test_email(player_id, delay_seconds)`

- **Line:** 293
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `delay_seconds` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 7 | `ezemail` |
| 68 | `set` |
| 182 | `to_delete` |
| 299 | `mail` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_mugshot` | 1 | 150 |
| `Net.message_player` | 1 | 151 |
| `Net.on` | 2 | 317 |
| `Net.ring_player_hud` | 1 | 140 |
| `Net.send_player_email` | 3 | 214 |
