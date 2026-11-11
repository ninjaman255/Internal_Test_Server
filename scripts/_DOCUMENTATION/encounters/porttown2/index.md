# 📄 `porttown2.lua`

> ⚠️ **Archive-only reference:** The source file `encounters/porttown2.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `encounters/porttown2.lua` (not present in the current server ZIP).  
> **Source lines:** 158  
> **SHA-256 (UTF-8):** `5c45ecd9f7623b…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 36

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

Source-based reference for `encounters/porttown2.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **36** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Encounter1` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"porttown2_Encounter1"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Fishy",rank=1}, {name="Fishy",rank=2}, {name="Gunner",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,3,0}, {0,0,0,0,0,1}, {0,0,0,0,2,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {18,1,8,8,1,18}, {18,18,8,8,18,18}, {18,1,8,8,1,18}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 2. `enemies` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Fishy",rank=1}` |
| `[2]` | nested table | `{name="Fishy",rank=2}` |
| `[3]` | nested table | `{name="Gunner",rank=2}` |

### 3. `obstacles` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `positions` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,3,0}` |
| `[2]` | nested table | `{0,0,0,0,0,1}` |
| `[3]` | nested table | `{0,0,0,0,2,0}` |

### 5. `obstacle_positions` — line 17

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 6. `player_positions` — line 22

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 7. `tiles` — line 27

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{18,1,8,8,1,18}` |
| `[2]` | nested table | `{18,18,8,8,18,18}` |
| `[3]` | nested table | `{18,1,8,8,1,18}` |

### 8. `teams` — line 32

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 9. `Encounter2` — line 39

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"porttown2_Encounter2"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Gunner",rank=1}, {name="Gunner",rank=2}, {name="Cannodumb",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,3}, {0,0,0,1,0,0}, {0,0,0,0,0,2}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,18,18,1}, {1,1,18,18,1,1}, {1,18,18,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 10. `enemies` — line 43

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Gunner",rank=1}` |
| `[2]` | nested table | `{name="Gunner",rank=2}` |
| `[3]` | nested table | `{name="Cannodumb",rank=2}` |

### 11. `obstacles` — line 48

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `positions` — line 50

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,3}` |
| `[2]` | nested table | `{0,0,0,1,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,2}` |

### 13. `obstacle_positions` — line 55

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 14. `player_positions` — line 60

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 15. `tiles` — line 65

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,18,18,1}` |
| `[2]` | nested table | `{1,1,18,18,1,1}` |
| `[3]` | nested table | `{1,18,18,1,1,1}` |

### 16. `teams` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 17. `Encounter3` — line 77

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"porttown2_Encounter3"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Ratty",rank=1}, {name="Volgear",rank=2}, {name="Ratty",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,2,0}, {0,0,0,3,1,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {8,1,1,1,1,8}, {8,1,1,1,1,8}, {8,1,1,1,1,8}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 18. `enemies` — line 81

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Ratty",rank=1}` |
| `[2]` | nested table | `{name="Volgear",rank=2}` |
| `[3]` | nested table | `{name="Ratty",rank=2}` |

### 19. `obstacles` — line 86

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 20. `positions` — line 88

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,2,0}` |
| `[3]` | nested table | `{0,0,0,3,1,0}` |

### 21. `obstacle_positions` — line 93

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 22. `player_positions` — line 98

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 23. `tiles` — line 103

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{8,1,1,1,1,8}` |
| `[2]` | nested table | `{8,1,1,1,1,8}` |
| `[3]` | nested table | `{8,1,1,1,1,8}` |

### 24. `teams` — line 108

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 25. `Encounter4` — line 115

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"porttown2_Encounter4"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Fishy",rank=2}, {name="Volgear",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,2,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,18,1,18,1,1}, {8,18,1,8,18,1}, {1,18,1,1,1,18}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 26. `enemies` — line 119

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Fishy",rank=2}` |
| `[2]` | nested table | `{name="Volgear",rank=2}` |

### 27. `obstacles` — line 123

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 28. `positions` — line 125

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,2,0,0}` |

### 29. `obstacle_positions` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 30. `player_positions` — line 135

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 31. `tiles` — line 140

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,18,1,18,1,1}` |
| `[2]` | nested table | `{8,18,1,8,18,1}` |
| `[3]` | nested table | `{1,18,1,1,1,18}` |

### 32. `teams` — line 145

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 33. `return` — line 152

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `minimum_steps_before_encounter` | numeric literal | `80` |
| `encounter_chance_per_step` | numeric literal | `0.05` |
| `encounters` | nested table | `{Encounter1,Encounter2,Encounter3,Encounter4}` |
| `bosses` | nested table | `{}` |
| `special_encounters` | nested table | `{}` |

### 34. `encounters` — line 155

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Encounter1` |
| `[2]` | expression/reference | `Encounter2` |
| `[3]` | expression/reference | `Encounter3` |
| `[4]` | expression/reference | `Encounter4` |

### 35. `bosses` — line 156

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 36. `special_encounters` — line 157

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
