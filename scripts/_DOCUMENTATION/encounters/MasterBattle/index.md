# 📄 `MasterBattle.lua`

> ⚠️ **Archive-only reference:** The source file `encounters/MasterBattle.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `encounters/MasterBattle.lua` (not present in the current server ZIP).  
> **Source lines:** 387  
> **SHA-256 (UTF-8):** `d64cc326a0b0cc…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 82

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

Source-based reference for `encounters/MasterBattle.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **82** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Encounter1` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"FirstBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Quaker",rank=3}, {name="Zomon",rank=5}, {name="Rabiree",rank=3}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,1,0}, {0,0,0,0,0,3}, {0,0,0,0,2,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 2. `enemies` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Quaker",rank=3}` |
| `[2]` | nested table | `{name="Zomon",rank=5}` |
| `[3]` | nested table | `{name="Rabiree",rank=3}` |

### 3. `obstacles` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `positions` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,1,0}` |
| `[2]` | nested table | `{0,0,0,0,0,3}` |
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
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 8. `teams` — line 32

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 9. `FireBattle` — line 39

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"FireBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Volcano",rank=3}, {name="Volgear",rank=3}, {name="Elemperor",rank=7}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,3,2,1}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {13,1,13,13,1,15}, {1,1,13,13,1,1}, {15,1,13,13,1,13}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 10. `enemies` — line 43

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Volcano",rank=3}` |
| `[2]` | nested table | `{name="Volgear",rank=3}` |
| `[3]` | nested table | `{name="Elemperor",rank=7}` |

### 11. `obstacles` — line 48

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `positions` — line 50

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,3,2,1}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

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
| `[1]` | nested table | `{13,1,13,13,1,15}` |
| `[2]` | nested table | `{1,1,13,13,1,1}` |
| `[3]` | nested table | `{15,1,13,13,1,13}` |

### 16. `teams` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 17. `AquaBattle` — line 77

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"AquaBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Scuttle",rank=1}, {name="Shrimpy",rank=4}, {name="Piranha",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,2,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,3}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {12,12,12,12,12,12}, {16,12,16,16,12,16}, {16,16,16,16,16,16}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 18. `enemies` — line 81

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Scuttle",rank=1}` |
| `[2]` | nested table | `{name="Shrimpy",rank=4}` |
| `[3]` | nested table | `{name="Piranha",rank=4}` |

### 19. `obstacles` — line 86

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 20. `positions` — line 88

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,2,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,3}` |

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
| `[1]` | nested table | `{12,12,12,12,12,12}` |
| `[2]` | nested table | `{16,12,16,16,12,16}` |
| `[3]` | nested table | `{16,16,16,16,16,16}` |

### 24. `teams` — line 108

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 25. `ElecBattle` — line 115

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"ElecBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="JokerEye",rank=1}, {name="Scuttler",rank=1}, {name="Rabiree",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,3}, {0,0,0,1,2,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,5,5,1,1}, {7,18,18,18,18,6}, {4,1,1,1,1,4}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 26. `enemies` — line 119

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="JokerEye",rank=1}` |
| `[2]` | nested table | `{name="Scuttler",rank=1}` |
| `[3]` | nested table | `{name="Rabiree",rank=4}` |

### 27. `obstacles` — line 124

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 28. `positions` — line 126

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,3}` |
| `[2]` | nested table | `{0,0,0,1,2,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 29. `obstacle_positions` — line 131

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 30. `player_positions` — line 136

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 31. `tiles` — line 141

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,5,5,1,1}` |
| `[2]` | nested table | `{7,18,18,18,18,6}` |
| `[3]` | nested table | `{4,1,1,1,1,4}` |

### 32. `teams` — line 146

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 33. `WoodBattle` — line 153

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"WoodBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Scuttzer",rank=1}, {name="Cacter",rank=5}, {name="BombCorn",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,3,0,0}, {0,0,0,0,2,0}, {0,0,0,1,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {8,9,9,9,9,8}, {9,9,9,9,9,9}, {1,9,9,9,9,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 34. `enemies` — line 157

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Scuttzer",rank=1}` |
| `[2]` | nested table | `{name="Cacter",rank=5}` |
| `[3]` | nested table | `{name="BombCorn",rank=4}` |

### 35. `obstacles` — line 162

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 36. `positions` — line 164

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,3,0,0}` |
| `[2]` | nested table | `{0,0,0,0,2,0}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 37. `obstacle_positions` — line 169

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 38. `player_positions` — line 174

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 39. `tiles` — line 179

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{8,9,9,9,9,8}` |
| `[2]` | nested table | `{9,9,9,9,9,9}` |
| `[3]` | nested table | `{1,9,9,9,9,1}` |

### 40. `teams` — line 184

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 41. `SwordBattle` — line 191

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"SwordBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Swordy",rank=4}, {name="Zomon",rank=6}, {name="DarkMech",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,2,0}, {0,0,0,0,1,0}, {0,0,0,0,3,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,18,1,1,18,1}, {18,17,18,18,11,18}, {1,18,1,1,18,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 42. `enemies` — line 195

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Swordy",rank=4}` |
| `[2]` | nested table | `{name="Zomon",rank=6}` |
| `[3]` | nested table | `{name="DarkMech",rank=4}` |

### 43. `obstacles` — line 200

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 44. `positions` — line 202

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,2,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,3,0}` |

### 45. `obstacle_positions` — line 207

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 46. `player_positions` — line 212

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 47. `tiles` — line 217

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,18,1,1,18,1}` |
| `[2]` | nested table | `{18,17,18,18,11,18}` |
| `[3]` | nested table | `{1,18,1,1,18,1}` |

### 48. `teams` — line 222

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 49. `BreakBattle` — line 229

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"BreakBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Cragger",rank=4}, {name="Powie3",rank=5}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,0,1,0}, {0,0,0,0,0,1}, {0,0,0,2,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,1,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,2,1,1}, {18,2,1,1,2,18}, {1,1,2,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 50. `enemies` — line 233

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Cragger",rank=4}` |
| `[2]` | nested table | `{name="Powie3",rank=5}` |

### 51. `obstacles` — line 237

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |

### 52. `positions` — line 240

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,1,0}` |
| `[2]` | nested table | `{0,0,0,0,0,1}` |
| `[3]` | nested table | `{0,0,0,2,0,0}` |

### 53. `obstacle_positions` — line 245

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,1,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 54. `player_positions` — line 250

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 55. `tiles` — line 255

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,2,1,1}` |
| `[2]` | nested table | `{18,2,1,1,2,18}` |
| `[3]` | nested table | `{1,1,2,1,1,1}` |

### 56. `teams` — line 260

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 57. `CursorBattle` — line 267

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"CursorBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="CirSmash",rank=1}, {name="Gunner",rank=4}, }` |
| `obstacles` | nested table | `{ {name="BlastCube"}, }` |
| `positions` | nested table | `{ {0,0,0,0,0,1}, {0,0,0,0,2,0}, {0,0,0,1,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {14,1,14,1,1,11}, {1,1,1,1,11,1}, {14,1,14,11,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 58. `enemies` — line 271

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="CirSmash",rank=1}` |
| `[2]` | nested table | `{name="Gunner",rank=4}` |

### 59. `obstacles` — line 275

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="BlastCube"}` |

### 60. `positions` — line 278

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,1}` |
| `[2]` | nested table | `{0,0,0,0,2,0}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 61. `obstacle_positions` — line 283

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 62. `player_positions` — line 288

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 63. `tiles` — line 293

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{14,1,14,1,1,11}` |
| `[2]` | nested table | `{1,1,1,1,11,1}` |
| `[3]` | nested table | `{14,1,14,11,1,1}` |

### 64. `teams` — line 298

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 65. `WindBattle` — line 305

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"WindBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="WindBox",rank=4}, {name="Doomer",rank=1}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,2}, {0,0,0,2,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,1,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 66. `enemies` — line 309

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="WindBox",rank=4}` |
| `[2]` | nested table | `{name="Doomer",rank=1}` |

### 67. `obstacles` — line 313

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |

### 68. `positions` — line 316

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,2}` |
| `[3]` | nested table | `{0,0,0,2,0,0}` |

### 69. `obstacle_positions` — line 321

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,1,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 70. `player_positions` — line 326

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 71. `tiles` — line 331

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 72. `teams` — line 336

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 73. `FinalBattle` — line 343

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"FinalBattle"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="JokerEye",rank=1}, {name="Chumpy",rank=1}, {name="Catack",rank=4}, {name="Shrimpy",rank=4}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,3,0,0}, {0,0,0,2,0,1}, {0,0,0,0,4,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,1,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,18,1,1,1,1}, {16,17,6,1,1,1}, {1,9,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 74. `enemies` — line 347

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="JokerEye",rank=1}` |
| `[2]` | nested table | `{name="Chumpy",rank=1}` |
| `[3]` | nested table | `{name="Catack",rank=4}` |
| `[4]` | nested table | `{name="Shrimpy",rank=4}` |

### 75. `obstacles` — line 353

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |

### 76. `positions` — line 356

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,3,0,0}` |
| `[2]` | nested table | `{0,0,0,2,0,1}` |
| `[3]` | nested table | `{0,0,0,0,4,0}` |

### 77. `obstacle_positions` — line 361

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 78. `player_positions` — line 366

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 79. `tiles` — line 371

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,18,1,1,1,1}` |
| `[2]` | nested table | `{16,17,6,1,1,1}` |
| `[3]` | nested table | `{1,9,1,1,1,1}` |

### 80. `teams` — line 376

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 81. `return` — line 383

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `minimum_steps_before_encounter` | numeric literal | `80` |
| `encounter_chance_per_step` | numeric literal | `0.05` |
| `encounters` | nested table | `{Encounter1,FireBattle,AquaBattle,ElecBattle,WoodBattle,SwordBattle,BreakBattle,CursorBattle,WindBattle,FinalBattle}` |

### 82. `encounters` — line 386

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Encounter1` |
| `[2]` | expression/reference | `FireBattle` |
| `[3]` | expression/reference | `AquaBattle` |
| `[4]` | expression/reference | `ElecBattle` |
| `[5]` | expression/reference | `WoodBattle` |
| `[6]` | expression/reference | `SwordBattle` |
| `[7]` | expression/reference | `BreakBattle` |
| `[8]` | expression/reference | `CursorBattle` |
| `[9]` | expression/reference | `WindBattle` |
| `[10]` | expression/reference | `FinalBattle` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
