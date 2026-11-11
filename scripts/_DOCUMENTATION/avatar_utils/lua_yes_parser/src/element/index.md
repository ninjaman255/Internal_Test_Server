# 📄 `element.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/avatar_utils/lua_yes_parser/src/element.lua`](../../../../../avatar_utils/lua_yes_parser/src/element.lua)  
> **Source lines:** 419  
> **SHA-256 (UTF-8):** `a716bb5a30e4874cb20dfa6c0d0bd17d826effcbd74fd0f04111ce142ee7e9f7`  
> **Named/assigned functions detected:** 18  
> **Table initializers detected (simple pattern):** 8

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/avatar_utils/lua_yes_parser/src/element.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/avatar_utils/lua_yes_parser/src/enums` |
| 2 | `scripts/avatar_utils/lua_yes_parser/src/keyval` |
| 3 | `scripts/avatar_utils/lua_yes_parser/src/utils/trim` |

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 6 | `Element.new` | `(none)` | assigned/declared |
| 14 | `__tostring` | `self` | local |
| 23 | `this.setAttributes` | `attrs` | assigned/declared |
| 36 | `findKey` | `key` | local |
| 49 | `this.upsert` | `keyval` | assigned/declared |
| 62 | `this.hasKey` | `key` | assigned/declared |
| 66 | `this.hasKeys` | `keyList` | assigned/declared |
| 76 | `this.getKeyValue` | `key, orValue` | assigned/declared |
| 87 | `this.getKeyValueAsInt` | `key, orValue` | assigned/declared |
| 95 | `this.getKeyValueAsBool` | `key, orValue` | assigned/declared |
| 107 | `this.getKeyValueAsNumber` | `key, orValue` | assigned/declared |
| 116 | `this.printArgs` | `(none)` | assigned/declared |
| 137 | `ElementParser.new` | `(none)` | assigned/declared |
| 145 | `setDelimiterType` | `type` | local |
| 154 | `evaluateDelimiter` | `input, start` | local |
| 268 | `evaluateToken` | `input, start, nd` | local |
| 287 | `parseTokenStep` | `input, start` | local |
| 313 | `self.parseTokens` | `input, start` | assigned/declared |

### Detailed parameter inventory

#### 1. `Element.new()`

- **Line:** 6
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 2. `__tostring(self)`

- **Line:** 14
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared by this function; type not inferred. |

#### 3. `this.setAttributes(attrs)`

- **Line:** 23
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `attrs` | Declared by this function; type not inferred. |

#### 4. `findKey(key)`

- **Line:** 36
- **Declaration:** local
- **Nearby code comment:** helper func

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |

#### 5. `this.upsert(keyval)`

- **Line:** 49
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `keyval` | Declared by this function; type not inferred. |

#### 6. `this.hasKey(key)`

- **Line:** 62
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |

#### 7. `this.hasKeys(keyList)`

- **Line:** 66
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `keyList` | Declared by this function; type not inferred. |

#### 8. `this.getKeyValue(key, orValue)`

- **Line:** 76
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `orValue` | Declared by this function; type not inferred. |

#### 9. `this.getKeyValueAsInt(key, orValue)`

- **Line:** 87
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `orValue` | Declared by this function; type not inferred. |

#### 10. `this.getKeyValueAsBool(key, orValue)`

- **Line:** 95
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `orValue` | Declared by this function; type not inferred. |

#### 11. `this.getKeyValueAsNumber(key, orValue)`

- **Line:** 107
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `orValue` | Declared by this function; type not inferred. |

#### 12. `this.printArgs()`

- **Line:** 116
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 13. `ElementParser.new()`

- **Line:** 137
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 14. `setDelimiterType(type)`

- **Line:** 145
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `type` | Declared by this function; type not inferred. |

#### 15. `evaluateDelimiter(input, start)`

- **Line:** 154
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `input` | Declared by this function; type not inferred. |
| 2 | `start` | Declared by this function; type not inferred. |

#### 16. `evaluateToken(input, start, nd)`

- **Line:** 268
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `input` | Declared by this function; type not inferred. |
| 2 | `start` | Declared by this function; type not inferred. |
| 3 | `nd` | Declared by this function; type not inferred. |

#### 17. `parseTokenStep(input, start)`

- **Line:** 287
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `input` | Declared by this function; type not inferred. |
| 2 | `start` | Declared by this function; type not inferred. |

#### 18. `self.parseTokens(input, start)`

- **Line:** 313
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `input` | Declared by this function; type not inferred. |
| 2 | `start` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 5 | `Element` |
| 7 | `this` |
| 8 | `attributes` |
| 10 | `args` |
| 24 | `this.attributes` |
| 129 | `mt` |
| 136 | `ElementParser` |
| 138 | `self` |

## Net API calls

No direct `Net.method(...)` call expression matched.
