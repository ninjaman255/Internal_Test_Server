# 📁 ezlibs-scripts/ezcutscenes

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `ezcutscenes.lua` | 1 | 12 | 7 | 349 | [Open script reference](ezcutscenes/index.md) |
| 📄 Script | `step_types.lua` | 1 | 14 | 11 | 322 | [Open script reference](step_types/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `ezcutscenes.lua` | `ezcutscenes.start(player_id, area_id, cutscene_ref, trigger_context)` | 205 | [Details](ezcutscenes/index.md) |
| `ezcutscenes.lua` | `ezcutscenes.cancel(player_id)` | 240 | [Details](ezcutscenes/index.md) |
| `ezcutscenes.lua` | `ezcutscenes.is_active(player_id)` | 245 | [Details](ezcutscenes/index.md) |
| `ezcutscenes.lua` | `ezcutscenes.get_cutscene(area_id, name)` | 249 | [Details](ezcutscenes/index.md) |
| `ezcutscenes.lua` | `ezcutscenes.handle_player_disconnect(player_id)` | 330 | [Details](ezcutscenes/index.md) |
| `ezcutscenes.lua` | `ezcutscenes.handle_player_transfer(player_id)` | 338 | [Details](ezcutscenes/index.md) |
| `step_types.lua` | `StepTypes.wait(context, props)` | 110 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.move_actor(context, props, step_object)` | 120 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.set_pose(context, props)` | 154 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.show_message(context, props)` | 180 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.ask_quiz(context, props)` | 197 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.prompt_player(context, props)` | 225 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.play_sound(context, props)` | 248 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.fade_camera(context, props)` | 257 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.move_camera(context, props, step_object)` | 273 | [Details](step_types/index.md) |
| `step_types.lua` | `StepTypes.emit_event(context, props)` | 296 | [Details](step_types/index.md) |

## 📊 Collection summary

This folder subtree contains **2 Lua source files**, **26 named/assigned function detections**, and **18 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
