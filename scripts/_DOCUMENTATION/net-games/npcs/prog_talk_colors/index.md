# 📄 `prog_talk_colors.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_talk_colors.lua`](../../../../net-games/npcs/prog_talk_colors.lua)  
> **Source lines:** 257  
> **SHA-256 (UTF-8):** `d869219ed42354…`  
> **Declared/assigned functions detected:** 1  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 16

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

PROG talk NPCs: one per frame dye color Tiled object names must be: prog_{color}

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/net-games/main` |
| 9 | `scripts/net-games/npcs/talk` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 15 | `ow` | `color` | local |

### Function details

#### 1. `ow(color)`

- **Location:** source line 15.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `color` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **16** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `lines` — line 28

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"{end_page}DEFAULT PROG ONLINE{p_2}"` |
| `[2]` | string literal | `"{end_line} "` |
| `[3]` | string literal | `"SIR,{p_2.2} This is the very definition of overkill.{p_0.2}.{p_0.4}.{p_0.8}"` |
| `[4]` | string literal | `"{end_page}BUT LETS TAKE A LOOK SHALL WE?!"` |

### 2. `lines` — line 47

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"LIME PROG ONLINE."` |
| `[2]` | string literal | `"Everything is GO.{p_0.2} Fast.{p_0.2} Clean.{p_0.2} Alive."` |
| `[3]` | string literal | `"{end_page}If you need momentum, borrow mine."` |

### 3. `prompt` — line 65

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `question` | string literal | `"RED PROG READY. PUSH HARD?"` |
| `yes_lines` | nested table | `{ "Yes confirmed.", "We move fast.", "We break things on purpose.", "{end_page}If it matters, we do it now.", }` |
| `no_lines` | nested table | `{ "Copy that.", "Holding position.", "{end_page}Pressure stays on standby.", }` |

### 4. `yes_lines` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Yes confirmed."` |
| `[2]` | string literal | `"We move fast."` |
| `[3]` | string literal | `"We break things on purpose."` |
| `[4]` | string literal | `"{end_page}If it matters, we do it now."` |

### 5. `no_lines` — line 75

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Copy that."` |
| `[2]` | string literal | `"Holding position."` |
| `[3]` | string literal | `"{end_page}Pressure stays on standby."` |

### 6. `lines` — line 94

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"PURPLE PROG speaking."` |
| `[2]` | string literal | `"Mystery is just data wearing a cloak."` |
| `[3]` | string literal | `"{end_page}Keep staring.{p_0.2} Patterns confess eventually."` |

### 7. `lines` — line 112

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"TURQUOISE PROG online."` |
| `[2]` | string literal | `"Breathe.{p_0.3} Smooth inputs.{p_0.3} Smooth outputs."` |
| `[3]` | string literal | `"{end_page}No rush. We still win."` |

### 8. `lines` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"PINK PROG reporting in."` |
| `[2]` | string literal | `"I made the UI cute so the bugs feel bad about existing."` |
| `[3]` | string literal | `"{end_page}It's working.{p_0.2} You're allowed to be proud."` |

### 9. `lines` — line 148

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"EMERALD PROG operational."` |
| `[2]` | string literal | `"Stable.{p_0.2} Grounded.{p_0.2} Built to last."` |
| `[3]` | string literal | `"{end_page}We don't just ship.{p_0.2} We endure."` |

### 10. `lines` — line 166

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"SAPPHIRE PROG here."` |
| `[2]` | string literal | `"Cool head.{p_0.2} Clear eyes.{p_0.2} Clean diff."` |
| `[3]` | string literal | `"{end_page}If it looks haunted, we log it until it apologizes."` |

### 11. `lines` — line 184

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"YELLOW PROG online."` |
| `[2]` | string literal | `"Good news:{p_0.2} it's bright for a reason."` |
| `[3]` | string literal | `"{end_page}Spot the issue.{p_0.2} Tag it.{p_0.2} Fix it.{p_0.2} Celebrate."` |

### 12. `lines` — line 202

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"ORANGE PROG active."` |
| `[2]` | string literal | `"I run hot.{p_0.2} I move fast.{p_0.2} I break walls."` |
| `[3]` | string literal | `"{end_page}Point me at the problem and stand back."` |

### 13. `prompt` — line 221

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `question` | string literal | `"CHARCOAL PROG READY. SHIP NOW?"` |
| `yes_lines` | nested table | `{ "Confirmed.", "No noise.", "No drama.", "{end_page}We ship.", }` |
| `no_lines` | nested table | `{ "Understood.", "Holding for clarity.", "{end_page}Signal stays clean.", }` |

### 14. `yes_lines` — line 224

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Confirmed."` |
| `[2]` | string literal | `"No noise."` |
| `[3]` | string literal | `"No drama."` |
| `[4]` | string literal | `"{end_page}We ship."` |

### 15. `no_lines` — line 231

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Understood."` |
| `[2]` | string literal | `"Holding for clarity."` |
| `[3]` | string literal | `"{end_page}Signal stays clean."` |

### 16. `lines` — line 250

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"WHITE PROG reporting."` |
| `[2]` | string literal | `"Baseline check:{p_0.2} no tricks.{p_0.2} no tint lies."` |
| `[3]` | string literal | `"{end_page}If this breaks, something else is VERY wrong."` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
