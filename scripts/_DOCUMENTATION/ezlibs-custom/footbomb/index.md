# 📁 ezlibs-custom/footbomb

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `animation_diagnostics.lua` | 1 | 4 | 4 | 99 | [Open script reference](animation_diagnostics/index.md) |
| 📄 Script | `animation_points.lua` | 1 | 2 | 1 | 20 | [Open script reference](animation_points/index.md) |
| 📄 Script | `animation_states.lua` | 1 | 0 | 1 | 19 | [Open script reference](animation_states/index.md) |
| 📄 Script | `bomb_options.lua` | 1 | 0 | 1 | 7 | [Open script reference](bomb_options/index.md) |
| 📄 Script | `constants.lua` | 1 | 0 | 13 | 113 | [Open script reference](constants/index.md) |
| 📄 Script | `main.lua` | 1 | 124 | 84 | 4718 | [Open script reference](main/index.md) |
| 📄 Script | `navi_options.lua` | 1 | 0 | 1 | 15 | [Open script reference](navi_options/index.md) |
| 📄 Script | `result_timeline.lua` | 1 | 2 | 2 | 57 | [Open script reference](result_timeline/index.md) |
| 📄 Script | `sfx_driver.lua` | 1 | 2 | 2 | 71 | [Open script reference](sfx_driver/index.md) |
| 📄 Script | `state.lua` | 1 | 0 | 7 | 27 | [Open script reference](state/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `animation_diagnostics.lua` | `Diagnostics.run(options, log)` | 82 | [Details](animation_diagnostics/index.md) |
| `animation_points.lua` | `AnimationPoints.offset(frame, point)` | 7 | [Details](animation_points/index.md) |
| `animation_points.lua` | `AnimationPoints.to_map_offset(screen_offset, tile_width, tile_height)` | 11 | [Details](animation_points/index.md) |
| `main.lua` | `FootBomb.handle_player_join(player_id)` | 4536 | [Details](main/index.md) |
| `main.lua` | `FootBomb.handle_actor_interaction(player_id, actor_id, button)` | 4546 | [Details](main/index.md) |
| `main.lua` | `FootBomb.handle_player_transfer(player_id)` | 4558 | [Details](main/index.md) |
| `main.lua` | `FootBomb.handle_player_disconnect(player_id)` | 4587 | [Details](main/index.md) |
| `result_timeline.lua` | `ResultTimeline.state_timing(state)` | 7 | [Details](result_timeline/index.md) |
| `result_timeline.lua` | `ResultTimeline.shared_response_duration(options)` | 39 | [Details](result_timeline/index.md) |
| `sfx_driver.lua` | `SfxDriver.attach(round_events, event_names, play_sound_for_inst, instance_id, file_exists)` | 34 | [Details](sfx_driver/index.md) |

## 📊 Collection summary

This folder subtree contains **10 Lua source files**, **134 named/assigned function detections**, and **116 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | FootBomb animation parser versioning |
