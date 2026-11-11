# 📁 net-games/dialogue

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `constants.lua` | 1 | 0 | 4 | 21 | [Open script reference](constants/index.md) |
| 📄 Script | `dialogue.lua` | 1 | 17 | 8 | 330 | [Open script reference](dialogue/index.md) |
| 📄 Script | `prompt.lua` | 1 | 22 | 13 | 410 | [Open script reference](prompt/index.md) |
| 📄 Script | `prompt_vertical.lua` | 1 | 46 | 22 | 1200 | [Open script reference](prompt_vertical/index.md) |
| 📄 Script | `startup.lua` | 1 | 0 | 0 | 13 | [Open script reference](startup/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `dialogue.lua` | `Dialogue.is_active(player_id)` | 205 | [Details](dialogue/index.md) |
| `dialogue.lua` | `Dialogue.prompt_yesno(player_id, opts)` | 209 | [Details](dialogue/index.md) |
| `dialogue.lua` | `Dialogue.prompt_menu(player_id, opts)` | 213 | [Details](dialogue/index.md) |
| `dialogue.lua` | `Dialogue.start(player_id, script, opts)` | 217 | [Details](dialogue/index.md) |
| `dialogue.lua` | `Dialogue.close(player_id)` | 326 | [Details](dialogue/index.md) |
| `prompt.lua` | `PromptInstance:new(player_id, opts)` | 207 | [Details](prompt/index.md) |
| `prompt.lua` | `PromptInstance:render_initial()` | 230 | [Details](prompt/index.md) |
| `prompt.lua` | `PromptInstance:render_cursor()` | 264 | [Details](prompt/index.md) |
| `prompt.lua` | `PromptInstance:update(dt)` | 270 | [Details](prompt/index.md) |
| `prompt.lua` | `Prompt.yesno(player_id, opts)` | 362 | [Details](prompt/index.md) |
| `prompt.lua` | `Prompt.close(player_id, _reason, opts)` | 375 | [Details](prompt/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:new(player_id, opts)` | 399 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:render_textbox()` | 488 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:menu_origin()` | 522 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:start_close(reason, keep_textbox)` | 535 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:render_menu_window()` | 562 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:clear_menu_text()` | 579 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:update_scroll_for_selection(force)` | 586 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:menu_overlays_visible()` | 611 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:set_locked(locked)` | 615 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:update_cursor_bob(dt)` | 632 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:render_menu_contents(force)` | 660 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:start_text_intro()` | 868 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:become_ready()` | 882 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:select_current()` | 910 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `self._post_close_cb()` | 917 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:do_cancel()` | 921 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `self._post_close_cb()` | 927 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:restart_shop_item_intro()` | 942 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptMenuInstance:update(_dt)` | 948 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptVertical.menu(player_id, opts)` | 1133 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptVertical._finalize_close(player_id, _reason, opts)` | 1146 | [Details](prompt_vertical/index.md) |
| `prompt_vertical.lua` | `PromptVertical.close(player_id, _reason, opts)` | 1192 | [Details](prompt_vertical/index.md) |

## 📊 Collection summary

This folder subtree contains **5 Lua source files**, **85 named/assigned function detections**, and **47 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
