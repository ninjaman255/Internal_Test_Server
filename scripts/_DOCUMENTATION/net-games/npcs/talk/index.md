# 📄 `talk.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/talk.lua`](../../../../net-games/npcs/talk.lua)  
> **Source lines:** 579  
> **SHA-256 (UTF-8):** `60cac723323e3b…`  
> **Declared/assigned functions detected:** 26  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 10

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

Minimal author API for Dialogue NPCs with PROG-default UI

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 6 | `scripts/libs/direction` |
| 7 | `scripts/net-games/dialogue/dialogue` |
| 8 | `scripts/net-games/npcs/talk_presets` |
| 9 | `scripts/net-games/npcs/menu_options` |
| 10 | `scripts/displayer/displayer` |
| 62 | `scripts/net-games/npcs/talk_vert_menu` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 533 | `Net:on` | `actor_interaction` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 17 | `shallow_copy` | `t` | local |
| 23 | `deep_merge` | `dst, src` | local |
| 35 | `normalize_script` | `lines_or_text` | local |
| 44 | `stable_box_id` | `cfg` | local |
| 51 | `force_indicator_on` | `player_id, box_id` | local |
| 59 | `get_talk_vert_menu` | `(none)` | local |
| 69 | `build_ui` | `cfg, bot_name, opts` | local |
| 179 | `get_pack_from_cfg` | `cfg` | local |
| 184 | `resolve_layout` | `cfg, menu_cfg` | local |
| 197 | `resolve_flow` | `cfg, menu_cfg` | local |
| 216 | `resolve_sfx` | `cfg, menu_cfg` | local |
| 233 | `resolve_options` | `menu_cfg` | local |
| 256 | `infer_exit_index` | `options, explicit_exit_index` | local |
| 275 | `Talk.start` | `player_id, script, cfg, bot_name, extra_opts` | declared |
| 308 | `Talk.prompt_yesno` | `player_id, question, cfg, bot_name, handlers` | declared |
| 328 | `Talk.vert_menu` | `player_id, bot_name, cfg, menu_cfg` | declared |
| 369 | `pick_text` | `...` | local |
| 406 | `open_menu` | `(none)` | local |
| 433 | `on_yes` | `(none)` | assigned |
| 449 | `on_no` | `(none)` | assigned |
| 467 | `on_cancel` | `(none)` | assigned |
| 478 | `Talk.prompt_then_talk` | `player_id, question, yes_script, no_script, cfg, bot_name` | declared |
| 482 | `on_yes` | `(none)` | assigned |
| 488 | `on_no` | `(none)` | assigned |
| 510 | `Talk.npc` | `cfg` | declared |
| 574 | `Talk._build_ui` | `cfg, bot_name, opts` | declared |

### Function details

#### 1. `shallow_copy(t)`

- **Location:** source line 17.
- **Declaration style:** `local`.
- **Adjacent source comment:** Small table helpers

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 2. `deep_merge(dst, src)`

- **Location:** source line 23.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `dst` | Not explicitly documented in adjacent source annotations. |
| 2 | `src` | Not explicitly documented in adjacent source annotations. |

#### 3. `normalize_script(lines_or_text)`

- **Location:** source line 35.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `lines_or_text` | Not explicitly documented in adjacent source annotations. |

#### 4. `stable_box_id(cfg)`

- **Location:** source line 44.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 5. `force_indicator_on(player_id, box_id)`

- **Location:** source line 51.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 6. `get_talk_vert_menu()`

- **Location:** source line 59.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 7. `build_ui(cfg, bot_name, opts)`

- **Location:** source line 69.
- **Declaration style:** `local`.
- **Adjacent source comment:** build_ui(cfg, bot_name, opts) opts.mode = "dialogue" \| "prompt"

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 2 | `bot_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 8. `get_pack_from_cfg(cfg)`

- **Location:** source line 179.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 9. `resolve_layout(cfg, menu_cfg)`

- **Location:** source line 184.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 2 | `menu_cfg` | Not explicitly documented in adjacent source annotations. |

#### 10. `resolve_flow(cfg, menu_cfg)`

- **Location:** source line 197.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 2 | `menu_cfg` | Not explicitly documented in adjacent source annotations. |

#### 11. `resolve_sfx(cfg, menu_cfg)`

- **Location:** source line 216.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 2 | `menu_cfg` | Not explicitly documented in adjacent source annotations. |

#### 12. `resolve_options(menu_cfg)`

- **Location:** source line 233.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `menu_cfg` | Not explicitly documented in adjacent source annotations. |

#### 13. `infer_exit_index(options, explicit_exit_index)`

- **Location:** source line 256.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `options` | Not explicitly documented in adjacent source annotations. |
| 2 | `explicit_exit_index` | Not explicitly documented in adjacent source annotations. |

#### 14. `Talk.start(player_id, script, cfg, bot_name, extra_opts)`

- **Location:** source line 275.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Talk.start(player_id, script, cfg, bot_name) Most callers won't use this directly; Talk.npc() does.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `script` | Not explicitly documented in adjacent source annotations. |
| 3 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 4 | `bot_name` | Not explicitly documented in adjacent source annotations. |
| 5 | `extra_opts` | Not explicitly documented in adjacent source annotations. |

#### 15. `Talk.prompt_yesno(player_id, question, cfg, bot_name, handlers)`

- **Location:** source line 308.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Talk.prompt_yesno(player_id, question, cfg, bot_name, handlers) handlers = { on_yes = fn, on_no = fn, on_cancel = fn }

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `question` | Not explicitly documented in adjacent source annotations. |
| 3 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 4 | `bot_name` | Not explicitly documented in adjacent source annotations. |
| 5 | `handlers` | Not explicitly documented in adjacent source annotations. |

#### 16. `Talk.vert_menu(player_id, bot_name, cfg, menu_cfg)`

- **Location:** source line 328.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Talk.vert_menu(player_id, bot_name, cfg, menu_cfg) Highest-level vertical menu wrapper: prompts yes/no to open (optional) opens TalkVertMenu with preset defaults allows full override of layout/flow/sfx/ui/mug/frame

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `bot_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 4 | `menu_cfg` | Not explicitly documented in adjacent source annotations. |

#### 17. `pick_text(...)`

- **Location:** source line 369.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 18. `open_menu()`

- **Location:** source line 406.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 19. `on_yes()`

- **Location:** source line 433.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 20. `on_no()`

- **Location:** source line 449.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 21. `on_cancel()`

- **Location:** source line 467.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 22. `Talk.prompt_then_talk(player_id, question, yes_script, no_script, cfg, bot_name)`

- **Location:** source line 478.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Talk.prompt_then_talk(player_id, question, yes_script, no_script, cfg, bot_name)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `question` | Not explicitly documented in adjacent source annotations. |
| 3 | `yes_script` | Not explicitly documented in adjacent source annotations. |
| 4 | `no_script` | Not explicitly documented in adjacent source annotations. |
| 5 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 6 | `bot_name` | Not explicitly documented in adjacent source annotations. |

#### 23. `on_yes()`

- **Location:** source line 482.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 24. `on_no()`

- **Location:** source line 488.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 25. `Talk.npc(cfg)`

- **Location:** source line 510.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Talk.npc(cfg) Minimal NPC wiring with sane defaults.  Authors should only need: cfg.area_id, cfg.object, (optional) cfg.name, cfg.lines  Optional: cfg.preset / cfg.box / cfg.mug / cfg.nameplate / cfg.frame cfg.ui overrides (mugshot off, tweak offsets, etc.) cfg.prompt = { question, yes_lines, no_lines }

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 26. `Talk._build_ui(cfg, bot_name, opts)`

- **Location:** source line 574.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Internal: expose UI builder for wrappers (vert menu, etc.)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cfg` | Not explicitly documented in adjacent source annotations. |
| 2 | `bot_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `opts` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 439 | `(none)` | `de_asset_for_player(player_id, path) if Net.play_sound_for_player then pcall(` |
| 441 | `(none)` | `play_sound_for_player(player_id, path) end) elseif Net.play_sound then pcall(` |
| 533 | `event` | `id ~= false), }) local BOT_NAME = Net.get_bot_name(bot_id) Net:on("actor_interaction…` |

## 📦 Tables and data

The following **10** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Talk` — line 12

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `o` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `return` — line 37

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `lines_or_text` |

### 4. `return` — line 41

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"..."` |

### 5. `ui` — line 81

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `return` — line 194

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `base` — line 202

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `return` — line 230

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `return` — line 241

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ id = "exit", text = "Exit" }` |

### 10. `o` — line 280

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `page_advance` | expression/reference | `cfg.page_advance or "wait_for_confirm"` |
| `confirm_during_typing` | expression/reference | `(cfg.confirm_during_typing ~= false)` |
| `cancel_behavior` | expression/reference | `cfg.cancel_behavior or "battle_network"` |
| `[4]` | expression/reference | `-- These matter mainly when chaining from prompts from_prompt = (cfg.from_prompt == true)` |
| `reuse_existing_box` | expression/reference | `(cfg.reuse_existing_box == true)` |
| `ui` | expression/reference | `ui` |
| `on_finish` | expression/reference | `cfg.on_finish` |
| `debug` | expression/reference | `cfg.debug` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_bot` | 1 |
| `Net.get_bot_name` | 1 |
| `Net.get_object_by_name` | 1 |
| `Net.get_player_position` | 1 |
| `Net.on` | 1 |
| `Net.play_sound` | 1 |
| `Net.play_sound_for_player` | 1 |
| `Net.provide_asset_for_player` | 1 |
| `Net.set_bot_direction` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
