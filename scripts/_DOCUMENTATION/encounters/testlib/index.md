# 📄 `testlib.lua`

> ⚠️ **Archive-only reference:** The source file `encounters/testlib.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `encounters/testlib.lua` (not present in the current server ZIP).  
> **Source lines:** 248  
> **SHA-256 (UTF-8):** `8a12ae12d1b578…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 56

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

Source-based reference for `encounters/testlib.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **56** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Encounter1` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"testlib_Encounter1"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Mettaur",rank=1}, {name="Cannodumb",rank=1}, {name="Rabiree",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,3,0,0}, {0,0,0,0,0,2}, {0,0,0,0,1,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |
| `freedom_mission` | nested table | `{ enabled=true, turn_count=3, player_can_flip=false }` |

### 2. `enemies` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Mettaur",rank=1}` |
| `[2]` | nested table | `{name="Cannodumb",rank=1}` |
| `[3]` | nested table | `{name="Rabiree",rank=1}` |

### 3. `obstacles` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `positions` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,3,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,2}` |
| `[3]` | nested table | `{0,0,0,0,1,0}` |

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
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 8. `teams` — line 32

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 9. `freedom_mission` — line 37

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `turn_count` | numeric literal | `3` |
| `player_can_flip` | boolean literal | `false` |

### 10. `Encounter2` — line 44

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"testlib_Encounter2"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Cannodumb",rank=1}, {name="Mettaur",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,2}, {0,0,0,0,1,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,2,1,1}, {2,2,2,2,1,1}, {2,2,2,2,1,1}, }` |
| `freedom_mission` | nested table | `{ enabled=true, turn_count=3, player_can_flip=false }` |

### 11. `enemies` — line 48

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Cannodumb",rank=1}` |
| `[2]` | nested table | `{name="Mettaur",rank=1}` |

### 12. `obstacles` — line 52

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `positions` — line 54

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,2}` |
| `[3]` | nested table | `{0,0,0,0,1,0}` |

### 14. `obstacle_positions` — line 59

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 15. `player_positions` — line 64

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 16. `tiles` — line 69

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 17. `teams` — line 74

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,2,1,1}` |
| `[2]` | nested table | `{2,2,2,2,1,1}` |
| `[3]` | nested table | `{2,2,2,2,1,1}` |

### 18. `freedom_mission` — line 79

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `turn_count` | numeric literal | `3` |
| `player_can_flip` | boolean literal | `false` |

### 19. `Encounter3` — line 86

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"testlib_Encounter3"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Mettaur",rank=1}, {name="Rabiree",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,1,0,2,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {1,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,1,1,1,1}, {2,2,1,1,1,1}, {2,2,1,1,1,1}, }` |
| `freedom_mission` | nested table | `{ enabled=true, turn_count=3, player_can_flip=false }` |

### 20. `enemies` — line 90

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Mettaur",rank=1}` |
| `[2]` | nested table | `{name="Rabiree",rank=1}` |

### 21. `obstacles` — line 94

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 22. `positions` — line 96

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,1,0,2,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 23. `obstacle_positions` — line 101

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 24. `player_positions` — line 106

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{1,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 25. `tiles` — line 111

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 26. `teams` — line 116

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,1,1,1,1}` |
| `[2]` | nested table | `{2,2,1,1,1,1}` |
| `[3]` | nested table | `{2,2,1,1,1,1}` |

### 27. `freedom_mission` — line 121

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `turn_count` | numeric literal | `3` |
| `player_can_flip` | boolean literal | `false` |

### 28. `Encounter4` — line 128

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"testlib_Encounter4"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Mettaur",rank=1}, {name="Cannodumb",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,2}, {0,0,0,0,0,0}, {1,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,1,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {1,1,2,2,1,1}, {1,1,2,2,1,1}, {1,1,2,2,1,1}, }` |
| `freedom_mission` | nested table | `{ enabled=true, turn_count=3, player_can_flip=true }` |

### 29. `enemies` — line 132

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Mettaur",rank=1}` |
| `[2]` | nested table | `{name="Cannodumb",rank=1}` |

### 30. `obstacles` — line 136

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 31. `positions` — line 138

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,2}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{1,0,0,0,0,0}` |

### 32. `obstacle_positions` — line 143

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 33. `player_positions` — line 148

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,1,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 34. `tiles` — line 153

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 35. `teams` — line 158

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,2,2,1,1}` |
| `[2]` | nested table | `{1,1,2,2,1,1}` |
| `[3]` | nested table | `{1,1,2,2,1,1}` |

### 36. `freedom_mission` — line 163

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `turn_count` | numeric literal | `3` |
| `player_can_flip` | boolean literal | `true` |

### 37. `Encounter5` — line 170

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"testlib_Encounter5"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="BigBrute",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 38. `enemies` — line 174

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="BigBrute",rank=1}` |

### 39. `obstacles` — line 177

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 40. `positions` — line 179

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 41. `obstacle_positions` — line 184

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 42. `player_positions` — line 189

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 43. `tiles` — line 194

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 44. `teams` — line 199

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 45. `Encounter6` — line 206

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"testlib_Encounter6"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="ShadeMan",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 46. `enemies` — line 210

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="ShadeMan",rank=1}` |

### 47. `obstacles` — line 213

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 48. `positions` — line 215

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 49. `obstacle_positions` — line 220

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 50. `player_positions` — line 225

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 51. `tiles` — line 230

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 52. `teams` — line 235

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 53. `return` — line 242

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `minimum_steps_before_encounter` | numeric literal | `80` |
| `encounter_chance_per_step` | numeric literal | `0.05` |
| `encounters` | nested table | `{Encounter1,Encounter2,Encounter3,Encounter4}` |
| `bosses` | nested table | `{Encounter6}` |
| `special_encounters` | nested table | `{Encounter5}` |

### 54. `encounters` — line 245

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Encounter1` |
| `[2]` | expression/reference | `Encounter2` |
| `[3]` | expression/reference | `Encounter3` |
| `[4]` | expression/reference | `Encounter4` |

### 55. `bosses` — line 246

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Encounter6` |

### 56. `special_encounters` — line 247

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Encounter5` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
