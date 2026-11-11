# 📄 `ezmail.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezmail.lua`](../../../ezlibs-scripts/ezmail.lua)  
> **Source lines:** 340  
> **SHA-256 (UTF-8):** `b3a252ad6661224c3f274596106f3af1c01ae46cf2a2a6934b10ad9e40253836`  
> **Named/assigned functions detected:** 13  
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

Current source inventory for `scripts/ezlibs-scripts/ezmail.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/helpers` |
| 3 | `scripts/ezlibs-scripts/ezmemory` |
| 4 | `scripts/ezlibs-scripts/ezbus` |
| 5 | `scripts/ezlibs-scripts/ezconfig` |
| 321 | `scripts/ezlibs-scripts/ezannounce/ezannounce` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 311 | `Net` | `player_join` |
| 330 | `Net` | `email_read` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 16 | `_preload_email_assets` | `player_id, mail` | local |
| 30 | `_get_bucket` | `player_id` | local |
| 38 | `_dbg` | `...` | local |
| 44 | `_percent_decode` | `s` | local |
| 51 | `_get_tombstone_set` | `(none)` | local |
| 83 | `_find_mail_in_bucket` | `bucket, email_id` | local |
| 108 | `_mark_email_read` | `player_id, email_id` | local |
| 128 | `_notify_new_mail` | `player_id, msg, delay_seconds` | local |
| 142 | `send_msg` | `(none)` | local |
| 157 | `ezemail.resend_all` | `player_id` | assigned/declared |
| 219 | `ezemail.send_once` | `player_id, mail, opts` | assigned/declared |
| 265 | `ezemail.send_temp` | `player_id, mail, opts` | assigned/declared |
| 287 | `ezemail.send_test_email` | `player_id, delay_seconds` | assigned/declared |

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

#### 4. `_percent_decode(s)`

- **Line:** 44
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared in this function; type not inferred. |

#### 5. `_get_tombstone_set()`

- **Line:** 51
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 6. `_find_mail_in_bucket(bucket, email_id)`

- **Line:** 83
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bucket` | Declared in this function; type not inferred. |
| 2 | `email_id` | Declared in this function; type not inferred. |

#### 7. `_mark_email_read(player_id, email_id)`

- **Line:** 108
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `email_id` | Declared in this function; type not inferred. |

#### 8. `_notify_new_mail(player_id, msg, delay_seconds)`

- **Line:** 128
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `msg` | Declared in this function; type not inferred. |
| 3 | `delay_seconds` | Declared in this function; type not inferred. |

#### 9. `send_msg()`

- **Line:** 142
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 10. `ezemail.resend_all(player_id)`

- **Line:** 157
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 11. `ezemail.send_once(player_id, mail, opts)`

- **Line:** 219
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `mail` | Declared in this function; type not inferred. |
| 3 | `opts` | Declared in this function; type not inferred. |

#### 12. `ezemail.send_temp(player_id, mail, opts)`

- **Line:** 265
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `mail` | Declared in this function; type not inferred. |
| 3 | `opts` | Declared in this function; type not inferred. |

#### 13. `ezemail.send_test_email(player_id, delay_seconds)`

- **Line:** 287
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `delay_seconds` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 7 | `ezemail` |
| 62 | `set` |
| 176 | `to_delete` |
| 293 | `mail` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_mugshot` | 1 | 144 |
| `Net.message_player` | 1 | 145 |
| `Net.on` | 2 | 311 |
| `Net.ring_player_hud` | 1 | 134 |
| `Net.send_player_email` | 3 | 208 |
