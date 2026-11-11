# 📄 `ezannounce.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezannounce/ezannounce.lua`](../../../../ezlibs-scripts/ezannounce/ezannounce.lua)  
> **Source lines:** 199  
> **SHA-256 (UTF-8):** `f3f672f81a51f746d586386f2f9e43e0c1500fbebfe887c4cb57d8e25f47877c`  
> **Named/assigned functions detected:** 9  
> **Table initializers detected:** 7

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezannounce/ezannounce.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/helpers` |
| 3 | `scripts/ezlibs-scripts/ezmemory` |
| 4 | `scripts/ezlibs-scripts/ezemail` |
| 5 | `scripts/ezlibs-scripts/ezbus` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 168 | `Net` | `player_disconnect` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 45 | `_get_email_bucket` | `player_id` | local |
| 53 | `_is_active` | `ann, now` | local |
| 60 | `_feed_signature` | `feed` | local |
| 69 | `_reload_feed` | `(none)` | local |
| 92 | `ezannounce.get_feed` | `(none)` | assigned/declared |
| 99 | `ezannounce.send_missing` | `player_id` | assigned/declared |
| 172 | `ezannounce.broadcast_missing_to_online` | `(none)` | assigned/declared |
| 178 | `ezannounce.start_watch` | `interval` | assigned/declared |
| 183 | `loop` | `(none)` | local |

### Detailed parameter inventory

#### 1. `_get_email_bucket(player_id)`

- **Line:** 45
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 2. `_is_active(ann, now)`

- **Line:** 53
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ann` | Declared in this function; type not inferred. |
| 2 | `now` | Declared in this function; type not inferred. |

#### 3. `_feed_signature(feed)`

- **Line:** 60
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `feed` | Declared in this function; type not inferred. |

#### 4. `_reload_feed()`

- **Line:** 69
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 5. `ezannounce.get_feed()`

- **Line:** 92
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 6. `ezannounce.send_missing(player_id)`

- **Line:** 99
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 7. `ezannounce.broadcast_missing_to_online()`

- **Line:** 172
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 8. `ezannounce.start_watch(interval)`

- **Line:** 178
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `interval` | Declared in this function; type not inferred. |

#### 9. `loop()`

- **Line:** 183
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 7 | `ezannounce` |
| 14 | `_online` |
| 17 | `ezannounce.ANNOUNCEMENTS` |
| 62 | `ids` |
| 111 | `tomb` |
| 124 | `pending` |
| 143 | `mail` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.on` | 1 | 168 |
