# 📄 `talk_presets.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/talk_presets.lua`](../../../../net-games/npcs/talk_presets.lua)  
> **Source lines:** 336  
> **SHA-256 (UTF-8):** `14ef56db82696d4196933fcfbec36ceb3fee0d7b47c368399b6430988da59079`  
> **Named/assigned functions detected:** 3  
> **Table initializers detected (simple pattern):** 49

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/net-games/npcs/talk_presets.lua` from the latest overlaid server archive.

## Dependencies

No statically identified literal `require` module strings.

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 158 | `_shallow_copy` | `t` | local |
| 265 | `P.get_vert_menu_layout` | `key` | assigned/declared |
| 288 | `P.get_vert_menu_flow` | `key` | assigned/declared |

### Detailed parameter inventory

#### 1. `_shallow_copy(t)`

- **Line:** 158
- **Declaration:** local
- **Nearby code comment:** ---------------------------- Vertical menu layout presets (PromptVertical) ----------------------------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `t` | Declared by this function; type not inferred. |

#### 2. `P.get_vert_menu_layout(key)`

- **Line:** 265
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |

#### 3. `P.get_vert_menu_flow(key)`

- **Line:** 288
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 6 | `P` |
| 11 | `P.nameplates` |
| 12 | `prog` |
| 28 | `P.mugs` |
| 29 | `prog` |
| 44 | `prog_red` |
| 45 | `prog_sapphire` |
| 46 | `prog_emerald` |
| 47 | `prog_yellow` |
| 48 | `prog_orange` |
| 49 | `prog_purple` |
| 50 | `prog_pink` |
| 51 | `prog_turquoise` |
| 52 | `prog_charcoal_grey` |
| 53 | `prog_lime` |
| 54 | `prog_white` |
| 62 | `P.boxes` |
| 64 | `panel` |
| 74 | `backdrop` |
| 90 | `indicator` |
| 104 | `black` |
| 112 | `backdrop` |
| 122 | `indicator` |
| 139 | `P.frames` |
| 140 | `lime` |
| 141 | `red` |
| 142 | `purple` |
| 144 | `turquoise` |
| 145 | `pink` |
| 146 | `emerald` |
| 147 | `sapphire` |
| 148 | `yellow` |
| 149 | `orange` |
| 151 | `charcoal_grey` |
| 152 | `white` |
| 159 | `o` |
| 164 | `P.vert_menus` |
| 166 | `prog_prompt` |
| 195 | `prog_prompt_shop` |
| 274 | `P.vert_menu_flows` |
| 275 | `prog_prompt` |
| 280 | `confirm` |
| 281 | `post_select` |
| 284 | `sfx` |
| 298 | `P.sfx_sets` |
| 299 | `card_desc` |
| 309 | `P.packs` |
| 311 | `prog` |
| 324 | `prog_prompt` |

## Net API calls

No direct `Net.method(...)` call expression matched.
