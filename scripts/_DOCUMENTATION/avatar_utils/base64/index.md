# 📄 `base64.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/avatar_utils/base64.lua`](../../../avatar_utils/base64.lua)  
> **Source lines:** 201  
> **SHA-256 (UTF-8):** `bce7480e262be409eb0e5c37fbda479999638526c6b1d08be0b0431cf5cd800b`  
> **Named/assigned functions detected:** 6  
> **Table initializers detected (simple pattern):** 4

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/avatar_utils/base64.lua` from the latest overlaid server archive.

## Dependencies

No statically identified literal `require` module strings.

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 31 | `extract` | ` v, from, width ` | assigned/declared |
| 35 | `extract` | ` v, from, width ` | assigned/declared |
| 55 | `base64.makeencoder` | ` s62, s63, spad ` | assigned/declared |
| 67 | `base64.makedecoder` | ` s62, s63, spad ` | assigned/declared |
| 80 | `base64.encode` | ` str, encoder, usecaching ` | assigned/declared |
| 112 | `base64.decode` | ` b64, decoder, usecaching ` | assigned/declared |

### Detailed parameter inventory

#### 1. `extract( v, from, width )`

- **Line:** 31
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared by this function; type not inferred. |
| 2 | `from` | Declared by this function; type not inferred. |
| 3 | `width` | Declared by this function; type not inferred. |

#### 2. `extract( v, from, width )`

- **Line:** 35
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared by this function; type not inferred. |
| 2 | `from` | Declared by this function; type not inferred. |
| 3 | `width` | Declared by this function; type not inferred. |

#### 3. `base64.makeencoder( s62, s63, spad )`

- **Line:** 55
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s62` | Declared by this function; type not inferred. |
| 2 | `s63` | Declared by this function; type not inferred. |
| 3 | `spad` | Declared by this function; type not inferred. |

#### 4. `base64.makedecoder( s62, s63, spad )`

- **Line:** 67
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s62` | Declared by this function; type not inferred. |
| 2 | `s63` | Declared by this function; type not inferred. |
| 3 | `spad` | Declared by this function; type not inferred. |

#### 5. `base64.encode( str, encoder, usecaching )`

- **Line:** 80
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `str` | Declared by this function; type not inferred. |
| 2 | `encoder` | Declared by this function; type not inferred. |
| 3 | `usecaching` | Declared by this function; type not inferred. |

#### 6. `base64.decode( b64, decoder, usecaching )`

- **Line:** 112
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `b64` | Declared by this function; type not inferred. |
| 2 | `decoder` | Declared by this function; type not inferred. |
| 3 | `usecaching` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 25 | `base64` |
| 56 | `encoder` |
| 68 | `decoder` |
| 84 | `cache` |

## Net API calls

No direct `Net.method(...)` call expression matched.
