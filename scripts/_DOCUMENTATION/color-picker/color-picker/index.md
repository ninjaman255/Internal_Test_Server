# 📄 `color-picker.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/color-picker/color-picker.lua`](../../../color-picker/color-picker.lua)  
> **Source lines:** 77  
> **SHA-256 (UTF-8):** `1fee33096ab14403296c05b0a12d6a20037d4e9deafa2d67a3f8eb49a9d864f9`  
> **Named/assigned functions detected:** 2  
> **Table initializers detected (simple pattern):** 44

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/color-picker/color-picker.lua` from the latest overlaid server archive.

## Dependencies

No statically identified literal `require` module strings.

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 4 | `ColorPicker:getRandom` | `which` | assigned/declared |
| 17 | `ColorPicker:new` | `(none)` | assigned/declared |

### Detailed parameter inventory

#### 1. `ColorPicker:getRandom(which)`

- **Line:** 4
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `which` | Declared by this function; type not inferred. |

#### 2. `ColorPicker:new()`

- **Line:** 17
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 1 | `ColorPicker` |
| 19 | `self.Rainbow` |
| 20 | `red` |
| 21 | `orange` |
| 22 | `yellow` |
| 23 | `green` |
| 24 | `blue` |
| 25 | `indigo` |
| 26 | `violet` |
| 28 | `self.RainbowArray` |
| 36 | `ColorPicker.Colors` |
| 37 | `red` |
| 38 | `green` |
| 39 | `blue` |
| 40 | `yellow` |
| 41 | `cyan` |
| 42 | `magenta` |
| 43 | `white` |
| 44 | `black` |
| 45 | `gray` |
| 46 | `silver` |
| 47 | `maroon` |
| 48 | `olive` |
| 49 | `lime` |
| 50 | `teal` |
| 51 | `navy` |
| 52 | `purple` |
| 53 | `fuchsia` |
| 54 | `aqua` |
| 55 | `orange` |
| 56 | `pink` |
| 57 | `brown` |
| 58 | `beige` |
| 59 | `lavender` |
| 60 | `turquoise` |
| 61 | `indigo` |
| 62 | `violet` |
| 63 | `gold` |
| 64 | `coral` |
| 65 | `salmon` |
| 66 | `khaki` |
| 67 | `plum` |
| 68 | `orchid` |
| 72 | `ColorPicker.ColorArray` |

## Net API calls

No direct `Net.method(...)` call expression matched.
