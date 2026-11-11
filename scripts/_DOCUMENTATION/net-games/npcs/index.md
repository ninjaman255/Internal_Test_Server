# 📁 net-games/npcs

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `menu_options.lua` | 1 | 3 | 3 | 52 | [Open script reference](menu_options/index.md) |
| 📄 Script | `npc_api.lua` | 1 | 3 | 1 | 56 | [Open script reference](npc_api/index.md) |
| 📄 Script | `prog_banner_dialogue.lua` | 1 | 5 | 4 | 164 | [Open script reference](prog_banner_dialogue/index.md) |
| 📄 Script | `prog_basic_dialogue.lua` | 1 | 2 | 4 | 124 | [Open script reference](prog_basic_dialogue/index.md) |
| 📄 Script | `prog_basic_freedraw.lua` | 1 | 4 | 3 | 128 | [Open script reference](prog_basic_freedraw/index.md) |
| 📄 Script | `prog_basic_nameplate.lua` | 1 | 2 | 5 | 135 | [Open script reference](prog_basic_nameplate/index.md) |
| 📄 Script | `prog_dramatic_dialogue.lua` | 1 | 2 | 3 | 110 | [Open script reference](prog_dramatic_dialogue/index.md) |
| 📄 Script | `prog_dyed_dialogue%28bak%29.lua` | 1 | 2 | 4 | 125 | [Open script reference](prog_dyed_dialogue%28bak%29/index.md) |
| 📄 Script | `prog_dyed_dialogue.lua` | 1 | 0 | 3 | 18 | [Open script reference](prog_dyed_dialogue/index.md) |
| 📄 Script | `prog_prompt_dialogue.lua` | 1 | 7 | 5 | 185 | [Open script reference](prog_prompt_dialogue/index.md) |
| 📄 Script | `prog_prompt_dialogue_2.lua` | 1 | 7 | 4 | 167 | [Open script reference](prog_prompt_dialogue_2/index.md) |
| 📄 Script | `prog_shop.lua` | 1 | 1 | 3 | 64 | [Open script reference](prog_shop/index.md) |
| 📄 Script | `prog_talk_colors.lua` | 1 | 1 | 16 | 257 | [Open script reference](prog_talk_colors/index.md) |
| 📄 Script | `prog_talk_dialogue.lua` | 1 | 0 | 3 | 52 | [Open script reference](prog_talk_dialogue/index.md) |
| 📄 Script | `prog_vert_prompt.lua` | 1 | 4 | 7 | 227 | [Open script reference](prog_vert_prompt/index.md) |
| 📄 Script | `prog_vert_prompt_2.lua` | 1 | 5 | 8 | 246 | [Open script reference](prog_vert_prompt_2/index.md) |
| 📄 Script | `prog_vert_prompt_charcoal_grey.lua` | 1 | 2 | 9 | 150 | [Open script reference](prog_vert_prompt_charcoal_grey/index.md) |
| 📄 Script | `prog_vert_prompt_emerald.lua` | 1 | 1 | 3 | 65 | [Open script reference](prog_vert_prompt_emerald/index.md) |
| 📄 Script | `prog_vert_prompt_lime.lua` | 1 | 5 | 10 | 171 | [Open script reference](prog_vert_prompt_lime/index.md) |
| 📄 Script | `prog_vert_prompt_pink.lua` | 1 | 1 | 2 | 51 | [Open script reference](prog_vert_prompt_pink/index.md) |
| 📄 Script | `prog_vert_prompt_red.lua` | 1 | 1 | 2 | 58 | [Open script reference](prog_vert_prompt_red/index.md) |
| 📄 Script | `prog_vert_prompt_sapphire.lua` | 1 | 8 | 8 | 255 | [Open script reference](prog_vert_prompt_sapphire/index.md) |
| 📄 Script | `talk.lua` | 1 | 26 | 10 | 579 | [Open script reference](talk/index.md) |
| 📄 Script | `talk_presets.lua` | 1 | 3 | 49 | 336 | [Open script reference](talk_presets/index.md) |
| 📄 Script | `talk_vert_menu.lua` | 1 | 12 | 6 | 409 | [Open script reference](talk_vert_menu/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `menu_options.lua` | `M.count(count, cfg)` | 14 | [Details](menu_options/index.md) |
| `menu_options.lua` | `M.list(items, cfg)` | 38 | [Details](menu_options/index.md) |
| `npc_api.lua` | `M.play_sfx(player_id, path)` | 13 | [Details](npc_api/index.md) |
| `npc_api.lua` | `M.face_player(bot_id, bot_pos, player_id)` | 24 | [Details](npc_api/index.md) |
| `npc_api.lua` | `M.bind_confirm_interaction(bot_id, bot_pos, handler, opts)` | 34 | [Details](npc_api/index.md) |
| `talk.lua` | `Talk.start(player_id, script, cfg, bot_name, extra_opts)` | 275 | [Details](talk/index.md) |
| `talk.lua` | `Talk.prompt_yesno(player_id, question, cfg, bot_name, handlers)` | 308 | [Details](talk/index.md) |
| `talk.lua` | `Talk.vert_menu(player_id, bot_name, cfg, menu_cfg)` | 328 | [Details](talk/index.md) |
| `talk.lua` | `Talk.prompt_then_talk(player_id, question, yes_script, no_script, cfg, bot_name)` | 478 | [Details](talk/index.md) |
| `talk.lua` | `Talk.npc(cfg)` | 510 | [Details](talk/index.md) |
| `talk.lua` | `Talk._build_ui(cfg, bot_name, opts)` | 574 | [Details](talk/index.md) |
| `talk_presets.lua` | `P.get_vert_menu_layout(key)` | 265 | [Details](talk_presets/index.md) |
| `talk_presets.lua` | `P.get_vert_menu_flow(key)` | 288 | [Details](talk_presets/index.md) |
| `talk_vert_menu.lua` | `TalkVertMenu.is_busy(player_id)` | 279 | [Details](talk_vert_menu/index.md) |
| `talk_vert_menu.lua` | `TalkVertMenu.open(player_id, bot_name, talk_cfg, menu_cfg)` | 293 | [Details](talk_vert_menu/index.md) |

## 📊 Collection summary

This folder subtree contains **25 Lua source files**, **107 named/assigned function detections**, and **175 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `readme.md`](readme.md) | readme.md |
