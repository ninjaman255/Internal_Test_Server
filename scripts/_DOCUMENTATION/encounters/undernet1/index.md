# 📄 `undernet1.lua`

> ⚠️ **Archive-only reference:** The source file `encounters/undernet1.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `encounters/undernet1.lua` (not present in the current server ZIP).  
> **Source lines:** 1113  
> **SHA-256 (UTF-8):** `84ef889440ac58…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 244

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

Source-based reference for `encounters/undernet1.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **244** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Robber` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Robber"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,1}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 2. `enemies` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 3. `obstacles` — line 8

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `positions` — line 10

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,1}` |

### 5. `obstacle_positions` — line 15

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 6. `player_positions` — line 20

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 7. `tiles` — line 25

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 8. `teams` — line 30

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 9. `Encounter2` — line 37

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter2"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,1,0,0}, {0,0,0,0,0,1}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 10. `enemies` — line 41

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 11. `obstacles` — line 44

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `positions` — line 46

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,1,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,1}` |

### 13. `obstacle_positions` — line 51

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 14. `player_positions` — line 56

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 15. `tiles` — line 61

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 16. `teams` — line 66

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 17. `Encounter3` — line 73

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter3"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,1}, {0,0,0,1,0,0}, {0,0,0,0,1,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 18. `enemies` — line 77

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 19. `obstacles` — line 80

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 20. `positions` — line 82

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,1}` |
| `[2]` | nested table | `{0,0,0,1,0,0}` |
| `[3]` | nested table | `{0,0,0,0,1,0}` |

### 21. `obstacle_positions` — line 87

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 22. `player_positions` — line 92

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 23. `tiles` — line 97

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 24. `teams` — line 102

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 25. `Encounter4` — line 109

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter4"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,1}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {2,0,0,0,0,0}, {0,0,0,1,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 26. `enemies` — line 113

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 27. `obstacles` — line 116

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |
| `[2]` | nested table | `{name="Rock"}` |

### 28. `positions` — line 120

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,1}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 29. `obstacle_positions` — line 125

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{2,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 30. `player_positions` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 31. `tiles` — line 135

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 32. `teams` — line 140

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 33. `Encounter5` — line 147

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter5"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,1,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {14,1,1,1,1,11}, {14,1,1,1,1,11}, {14,1,1,1,1,11}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 34. `enemies` — line 151

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=2}` |

### 35. `obstacles` — line 154

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 36. `positions` — line 156

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 37. `obstacle_positions` — line 161

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 38. `player_positions` — line 166

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 39. `tiles` — line 171

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{14,1,1,1,1,11}` |
| `[2]` | nested table | `{14,1,1,1,1,11}` |
| `[3]` | nested table | `{14,1,1,1,1,11}` |

### 40. `teams` — line 176

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 41. `Encounter6` — line 183

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter6"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,1,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 42. `enemies` — line 187

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=2}` |

### 43. `obstacles` — line 190

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 44. `positions` — line 192

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 45. `obstacle_positions` — line 197

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 46. `player_positions` — line 202

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 47. `tiles` — line 207

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 48. `teams` — line 212

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 49. `Encounter7` — line 219

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter7"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, {name="HeelNavi",rank=2}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,2,0,1}, {0,0,0,0,0,1}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,1,0,0,0}, {0,0,0,0,2,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,11,11,1,1,11}, {1,1,1,1,14,14}, {1,1,14,14,1,11}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 50. `enemies` — line 223

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |
| `[2]` | nested table | `{name="HeelNavi",rank=2}` |

### 51. `obstacles` — line 227

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |
| `[2]` | nested table | `{name="Rock"}` |

### 52. `positions` — line 231

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,2,0,1}` |
| `[3]` | nested table | `{0,0,0,0,0,1}` |

### 53. `obstacle_positions` — line 236

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,1,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,2,0}` |

### 54. `player_positions` — line 241

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 55. `tiles` — line 246

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,11,11,1,1,11}` |
| `[2]` | nested table | `{1,1,1,1,14,14}` |
| `[3]` | nested table | `{1,1,14,14,1,11}` |

### 56. `teams` — line 251

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 57. `Encounter8` — line 258

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter8"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,1,1,1}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,14,1,1,14,1}, {11,11,11,11,11,11}, {1,14,1,1,14,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 58. `enemies` — line 262

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=2}` |

### 59. `obstacles` — line 265

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 60. `positions` — line 267

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,1,1,1}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 61. `obstacle_positions` — line 272

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 62. `player_positions` — line 277

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 63. `tiles` — line 282

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,14,1,1,14,1}` |
| `[2]` | nested table | `{11,11,11,11,11,11}` |
| `[3]` | nested table | `{1,14,1,1,14,1}` |

### 64. `teams` — line 287

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 65. `Encounter9` — line 294

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter9"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=3}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,1}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,2,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {1,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 66. `enemies` — line 298

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=3}` |

### 67. `obstacles` — line 301

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |
| `[2]` | nested table | `{name="Rock"}` |

### 68. `positions` — line 305

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,1}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 69. `obstacle_positions` — line 310

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,2,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 70. `player_positions` — line 315

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{1,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 71. `tiles` — line 320

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 72. `teams` — line 325

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 73. `Encounter10` — line 332

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter10"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=4}, {name="HeelNavi",rank=3}, {name="HeelNavi",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,1,0,0}, {0,0,0,2,0,0}, {0,0,0,3,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {11,1,1,1,1,1}, {11,11,1,1,1,1}, {11,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 74. `enemies` — line 336

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=4}` |
| `[2]` | nested table | `{name="HeelNavi",rank=3}` |
| `[3]` | nested table | `{name="HeelNavi",rank=2}` |

### 75. `obstacles` — line 341

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 76. `positions` — line 343

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,1,0,0}` |
| `[2]` | nested table | `{0,0,0,2,0,0}` |
| `[3]` | nested table | `{0,0,0,3,0,0}` |

### 77. `obstacle_positions` — line 348

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 78. `player_positions` — line 353

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 79. `tiles` — line 358

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{11,1,1,1,1,1}` |
| `[2]` | nested table | `{11,11,1,1,1,1}` |
| `[3]` | nested table | `{11,1,1,1,1,1}` |

### 80. `teams` — line 363

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 81. `Encounter11` — line 370

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter11"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=4}, }` |
| `obstacles` | nested table | `{ {name="BlastCube"}, {name="BlastCube"}, }` |
| `positions` | nested table | `{ {0,0,0,1,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,1}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {2,0,0,0,0,1}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 82. `enemies` — line 374

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=4}` |

### 83. `obstacles` — line 377

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="BlastCube"}` |
| `[2]` | nested table | `{name="BlastCube"}` |

### 84. `positions` — line 381

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,1,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,1}` |

### 85. `obstacle_positions` — line 386

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{2,0,0,0,0,1}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 86. `player_positions` — line 391

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 87. `tiles` — line 396

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 88. `teams` — line 401

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 89. `Encounter12` — line 408

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter12"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, {name="HeelNavi",rank=4}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,2,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,1}, }` |
| `obstacle_positions` | nested table | `{ {0,2,0,0,0,0}, {0,0,0,1,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 90. `enemies` — line 412

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |
| `[2]` | nested table | `{name="HeelNavi",rank=4}` |

### 91. `obstacles` — line 416

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |
| `[2]` | nested table | `{name="Rock"}` |

### 92. `positions` — line 420

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,2,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,1}` |

### 93. `obstacle_positions` — line 425

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,2,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,1,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 94. `player_positions` — line 430

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 95. `tiles` — line 435

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 96. `teams` — line 440

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 97. `Encounter13` — line 447

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter13"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {17,17,1,15,17,17}, {17,17,1,1,17,17}, {15,17,1,1,17,17}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 98. `enemies` — line 451

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 99. `obstacles` — line 454

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 100. `positions` — line 456

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 101. `obstacle_positions` — line 461

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 102. `player_positions` — line 466

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 103. `tiles` — line 471

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{17,17,1,15,17,17}` |
| `[2]` | nested table | `{17,17,1,1,17,17}` |
| `[3]` | nested table | `{15,17,1,1,17,17}` |

### 104. `teams` — line 476

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 105. `Encounter14` — line 483

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter14"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,2,1,2,1}, {2,1,1,1,2,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 106. `enemies` — line 487

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 107. `obstacles` — line 490

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 108. `positions` — line 492

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 109. `obstacle_positions` — line 497

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 110. `player_positions` — line 502

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 111. `tiles` — line 507

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,2,1,2,1}` |
| `[3]` | nested table | `{2,1,1,1,2,1}` |

### 112. `teams` — line 512

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 113. `Encounter15` — line 519

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter15"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {11,1,11,1,11,1}, {1,11,1,11,11,11}, {11,1,11,1,11,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 114. `enemies` — line 523

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=4}` |

### 115. `obstacles` — line 526

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 116. `positions` — line 528

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 117. `obstacle_positions` — line 533

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 118. `player_positions` — line 538

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 119. `tiles` — line 543

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{11,1,11,1,11,1}` |
| `[2]` | nested table | `{1,11,1,11,11,11}` |
| `[3]` | nested table | `{11,1,11,1,11,1}` |

### 120. `teams` — line 548

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 121. `Encounter16` — line 555

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter16"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Cragger",rank=4}, {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,1,0}, {0,0,0,2,0,0}, {0,0,0,0,1,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,18,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 122. `enemies` — line 559

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Cragger",rank=4}` |
| `[2]` | nested table | `{name="HeelNavi",rank=1}` |

### 123. `obstacles` — line 563

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 124. `positions` — line 565

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,1,0}` |
| `[2]` | nested table | `{0,0,0,2,0,0}` |
| `[3]` | nested table | `{0,0,0,0,1,0}` |

### 125. `obstacle_positions` — line 570

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 126. `player_positions` — line 575

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 127. `tiles` — line 580

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,18,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 128. `teams` — line 585

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 129. `Encounter17` — line 592

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter17"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, {name="JokerEye",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,2,1}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,1,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,16,1,1}, {16,16,16,16,16,16}, {1,1,16,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 130. `enemies` — line 596

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |
| `[2]` | nested table | `{name="JokerEye",rank=1}` |

### 131. `obstacles` — line 600

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 132. `positions` — line 602

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,2,1}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 133. `obstacle_positions` — line 607

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 134. `player_positions` — line 612

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,1,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 135. `tiles` — line 617

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,16,1,1}` |
| `[2]` | nested table | `{16,16,16,16,16,16}` |
| `[3]` | nested table | `{1,1,16,1,1,1}` |

### 136. `teams` — line 622

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 137. `Encounter18` — line 629

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter18"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=2}, {name="HauntedCandle",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,2,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 138. `enemies` — line 633

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=2}` |
| `[2]` | nested table | `{name="HauntedCandle",rank=4}` |

### 139. `obstacles` — line 637

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 140. `positions` — line 639

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,2,0}` |

### 141. `obstacle_positions` — line 644

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 142. `player_positions` — line 649

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 143. `tiles` — line 654

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 144. `teams` — line 659

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 145. `Encounter19` — line 666

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter19"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, {name="Cragger",rank=4}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, {name="Rock"}, {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,0,2,0}, {0,0,0,0,0,1}, {0,0,0,0,1,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,2,0,0,3,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {1,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 146. `enemies` — line 670

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |
| `[2]` | nested table | `{name="Cragger",rank=4}` |

### 147. `obstacles` — line 674

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |
| `[2]` | nested table | `{name="Rock"}` |
| `[3]` | nested table | `{name="Rock"}` |

### 148. `positions` — line 679

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,2,0}` |
| `[2]` | nested table | `{0,0,0,0,0,1}` |
| `[3]` | nested table | `{0,0,0,0,1,0}` |

### 149. `obstacle_positions` — line 684

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,2,0,0,3,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 150. `player_positions` — line 689

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{1,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 151. `tiles` — line 694

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 152. `teams` — line 699

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 153. `Encounter20` — line 706

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter20"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=3}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,17,1,1,18,1}, {17,17,17,18,18,18}, {1,17,1,1,18,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 154. `enemies` — line 710

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=3}` |

### 155. `obstacles` — line 713

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 156. `positions` — line 715

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 157. `obstacle_positions` — line 720

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 158. `player_positions` — line 725

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 159. `tiles` — line 730

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,17,1,1,18,1}` |
| `[2]` | nested table | `{17,17,17,18,18,18}` |
| `[3]` | nested table | `{1,17,1,1,18,1}` |

### 160. `teams` — line 735

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 161. `Encounter21` — line 742

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter21"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,9,1,1,9,1}, {9,9,9,9,9,9}, {1,9,1,1,9,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 162. `enemies` — line 746

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=2}` |

### 163. `obstacles` — line 749

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 164. `positions` — line 751

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 165. `obstacle_positions` — line 756

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 166. `player_positions` — line 761

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 167. `tiles` — line 766

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,9,1,1,9,1}` |
| `[2]` | nested table | `{9,9,9,9,9,9}` |
| `[3]` | nested table | `{1,9,1,1,9,1}` |

### 168. `teams` — line 771

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 169. `Encounter22` — line 778

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter22"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,1}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {1,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,13,13,13,13,1}, {1,13,13,13,13,1}, {1,13,13,13,13,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 170. `enemies` — line 782

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=4}` |

### 171. `obstacles` — line 785

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 172. `positions` — line 787

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,1}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 173. `obstacle_positions` — line 792

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 174. `player_positions` — line 797

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{1,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 175. `tiles` — line 802

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,13,13,13,13,1}` |
| `[2]` | nested table | `{1,13,13,13,13,1}` |
| `[3]` | nested table | `{1,13,13,13,13,1}` |

### 176. `teams` — line 807

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 177. `Encounter23` — line 814

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter23"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {8,1,1,1,1,1}, {1,1,8,8,1,1}, {1,1,1,1,1,8}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 178. `enemies` — line 818

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=1}` |

### 179. `obstacles` — line 821

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 180. `positions` — line 823

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 181. `obstacle_positions` — line 828

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 182. `player_positions` — line 833

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 183. `tiles` — line 838

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{8,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,8,8,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,8}` |

### 184. `teams` — line 843

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 185. `Encounter24` — line 850

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter24"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=2}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,12,12,1,1}, {1,12,1,1,12,1}, {12,1,1,1,1,12}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 186. `enemies` — line 854

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=2}` |

### 187. `obstacles` — line 857

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 188. `positions` — line 859

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 189. `obstacle_positions` — line 864

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 190. `player_positions` — line 869

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 191. `tiles` — line 874

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,12,12,1,1}` |
| `[2]` | nested table | `{1,12,1,1,12,1}` |
| `[3]` | nested table | `{12,1,1,1,1,12}` |

### 192. `teams` — line 879

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 193. `Encounter25` — line 886

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter25"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=3}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,1}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {1,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {5,1,1,1,1,5}, {1,7,1,1,6,1}, {1,1,6,7,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 194. `enemies` — line 890

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=3}` |

### 195. `obstacles` — line 893

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 196. `positions` — line 895

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,1}` |

### 197. `obstacle_positions` — line 900

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 198. `player_positions` — line 905

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{1,0,0,0,0,0}` |

### 199. `tiles` — line 910

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{5,1,1,1,1,5}` |
| `[2]` | nested table | `{1,7,1,1,6,1}` |
| `[3]` | nested table | `{1,1,6,7,1,1}` |

### 200. `teams` — line 915

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 201. `Encounter26` — line 922

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter26"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=3}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,1,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,1,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {15,15,15,15,15,15}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 202. `enemies` — line 926

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=3}` |

### 203. `obstacles` — line 929

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 204. `positions` — line 931

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,1,0}` |

### 205. `obstacle_positions` — line 936

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 206. `player_positions` — line 941

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,1,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 207. `tiles` — line 946

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{15,15,15,15,15,15}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 208. `teams` — line 951

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 209. `Encounter27` — line 958

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter27"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="Metrid",rank=4}, {name="HeelNavi",rank=4}, }` |
| `obstacles` | nested table | `{ {name="Rock"}, }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,2}, {0,0,0,1,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,1,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {16,1,1,1,1,1}, {1,1,9,14,2,1}, {1,13,1,1,1,15}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 210. `enemies` — line 962

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Metrid",rank=4}` |
| `[2]` | nested table | `{name="HeelNavi",rank=4}` |

### 211. `obstacles` — line 966

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="Rock"}` |

### 212. `positions` — line 969

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,2}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 213. `obstacle_positions` — line 974

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,1,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 214. `player_positions` — line 979

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 215. `tiles` — line 984

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{16,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,9,14,2,1}` |
| `[3]` | nested table | `{1,13,1,1,1,15}` |

### 216. `teams` — line 989

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 217. `Encounter28` — line 996

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter28"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=2}, {name="HeelNavi",rank=1}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,2,0}, {0,0,0,1,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,8,8,8,8,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 218. `enemies` — line 1000

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=2}` |
| `[2]` | nested table | `{name="HeelNavi",rank=1}` |

### 219. `obstacles` — line 1004

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 220. `positions` — line 1006

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,2,0}` |
| `[3]` | nested table | `{0,0,0,1,0,0}` |

### 221. `obstacle_positions` — line 1011

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 222. `player_positions` — line 1016

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 223. `tiles` — line 1021

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,8,8,8,8,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 224. `teams` — line 1026

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 225. `Encounter29` — line 1033

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter29"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HeelNavi",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {11,11,11,11,11,11}, {11,11,11,11,11,11}, {11,11,11,11,11,11}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 226. `enemies` — line 1037

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HeelNavi",rank=4}` |

### 227. `obstacles` — line 1040

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 228. `positions` — line 1042

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 229. `obstacle_positions` — line 1047

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 230. `player_positions` — line 1052

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 231. `tiles` — line 1057

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{11,11,11,11,11,11}` |
| `[2]` | nested table | `{11,11,11,11,11,11}` |
| `[3]` | nested table | `{11,11,11,11,11,11}` |

### 232. `teams` — line 1062

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 233. `Encounter30` — line 1069

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"undernet1_Encounter30"` |
| `path` | string literal | `"/server/assets/ezlibs-assets/ezencounters/ezencounters.zip"` |
| `weight` | numeric literal | `10` |
| `enemies` | nested table | `{ {name="HauntedCandle",rank=4}, {name="Cragger",rank=4}, {name="Quaker",rank=4}, }` |
| `obstacles` | nested table | `{ }` |
| `positions` | nested table | `{ {0,0,0,0,0,3}, {0,0,0,0,1,0}, {0,0,0,0,0,2}, }` |
| `obstacle_positions` | nested table | `{ {0,0,0,0,0,0}, {0,0,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `player_positions` | nested table | `{ {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, }` |
| `tiles` | nested table | `{ {1,1,1,1,1,1}, {1,1,1,1,1,1}, {1,1,1,1,1,1}, }` |
| `teams` | nested table | `{ {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, }` |

### 234. `enemies` — line 1073

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{name="HauntedCandle",rank=4}` |
| `[2]` | nested table | `{name="Cragger",rank=4}` |
| `[3]` | nested table | `{name="Quaker",rank=4}` |

### 235. `obstacles` — line 1078

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 236. `positions` — line 1080

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,3}` |
| `[2]` | nested table | `{0,0,0,0,1,0}` |
| `[3]` | nested table | `{0,0,0,0,0,2}` |

### 237. `obstacle_positions` — line 1085

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,0,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 238. `player_positions` — line 1090

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{0,0,0,0,0,0}` |
| `[2]` | nested table | `{0,1,0,0,0,0}` |
| `[3]` | nested table | `{0,0,0,0,0,0}` |

### 239. `tiles` — line 1095

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1,1,1,1}` |
| `[2]` | nested table | `{1,1,1,1,1,1}` |
| `[3]` | nested table | `{1,1,1,1,1,1}` |

### 240. `teams` — line 1100

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{2,2,2,1,1,1}` |
| `[2]` | nested table | `{2,2,2,1,1,1}` |
| `[3]` | nested table | `{2,2,2,1,1,1}` |

### 241. `return` — line 1107

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `minimum_steps_before_encounter` | numeric literal | `80` |
| `encounter_chance_per_step` | numeric literal | `0.05` |
| `encounters` | nested table | `{Robber,Encounter2,Encounter3,Encounter4,Encounter5,Encounter6,Encounter7,Encounter8,Encounter9,Encounter10,Encounter11,Encounter12,Encounter13,Encounter1…` |
| `bosses` | nested table | `{}` |
| `special_encounters` | nested table | `{}` |

### 242. `encounters` — line 1110

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Robber` |
| `[2]` | expression/reference | `Encounter2` |
| `[3]` | expression/reference | `Encounter3` |
| `[4]` | expression/reference | `Encounter4` |
| `[5]` | expression/reference | `Encounter5` |
| `[6]` | expression/reference | `Encounter6` |
| `[7]` | expression/reference | `Encounter7` |
| `[8]` | expression/reference | `Encounter8` |
| `[9]` | expression/reference | `Encounter9` |
| `[10]` | expression/reference | `Encounter10` |
| `[11]` | expression/reference | `Encounter11` |
| `[12]` | expression/reference | `Encounter12` |
| `[13]` | expression/reference | `Encounter13` |
| `[14]` | expression/reference | `Encounter14` |
| `[15]` | expression/reference | `Encounter15` |
| `[16]` | expression/reference | `Encounter16` |
| `[17]` | expression/reference | `Encounter17` |
| `[18]` | expression/reference | `Encounter18` |
| `[19]` | expression/reference | `Encounter19` |
| `[20]` | expression/reference | `Encounter20` |
| `[21]` | expression/reference | `Encounter21` |
| `[22]` | expression/reference | `Encounter22` |
| `[23]` | expression/reference | `Encounter23` |
| `[24]` | expression/reference | `Encounter24` |
| `[25]` | expression/reference | `Encounter25` |
| `[26]` | expression/reference | `Encounter26` |
| `[27]` | expression/reference | `Encounter27` |
| `[28]` | expression/reference | `Encounter28` |
| `[29]` | expression/reference | `Encounter29` |
| `[30]` | expression/reference | `Encounter30` |

### 243. `bosses` — line 1111

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 244. `special_encounters` — line 1112

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
