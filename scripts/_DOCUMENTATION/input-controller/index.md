# 📁 input-controller

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)
> **Current PlayerControl references:** [Current PlayerControl integration](PLAYERCONTROL_INTEGRATION.md)


## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `buttons.lua` | 1 | 0 | 9 | 12 | [Open script reference](buttons/index.md) |
| 📄 Script | `d-pad.lua` | 1 | 6 | 23 | 190 | [Open script reference](d-pad/index.md) |
| 📄 Script | `input-controller.lua` | 1 | 47 | 23 | 672 | [Open script reference](input-controller/index.md) |
| 📄 Script | `main.lua` | 1 | 13 | 3 | 192 | [Open script reference](main/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `d-pad.lua` | `DPad.EmitButtonPressed(button, player_id)` | 7 | [Details](d-pad/index.md) |
| `d-pad.lua` | `DPad.getActiveDirectionWithMemory(pressedButtons, player_id)` | 65 | [Details](d-pad/index.md) |
| `d-pad.lua` | `DPad.resetPlayerState(player_id)` | 171 | [Details](d-pad/index.md) |
| `d-pad.lua` | `DPad.getAllDirectionRawNames()` | 180 | [Details](d-pad/index.md) |
| `input-controller.lua` | `InputController.new(player_id, button_mappings, direction_raw_names, config)` | 123 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_init(player_id, button_mappings, direction_raw_names, config)` | 129 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController.extend(overrides)` | 170 | [Details](input-controller/index.md) |
| `input-controller.lua` | `subclass.new(player_id, button_mappings, direction_raw_names, config)` | 178 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:clone(player_id)` | 189 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:is_active()` | 207 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:activate()` | 211 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:deactivate()` | 216 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:reset()` | 221 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:reload(button_mappings, direction_raw_names)` | 226 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_clear_transient_state()` | 239 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:destroy()` | 251 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:set_repeat_delays(first_repeat_delay, repeat_delay)` | 275 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:restore_repeat_delays()` | 290 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:get_repeat_delays()` | 300 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:on(event, callback)` | 308 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:off(event, callback)` | 315 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:remove_listener(event, callback)` | 322 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:claim_input(owner, force)` | 329 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:release_input(owner)` | 376 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:has_input_control(owner)` | 400 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:get_input_owner()` | 404 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_swallowing()` | 408 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_emit_edge(kind, action, state)` | 412 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:handle_raw_input(events)` | 436 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_set_action_down(action, down)` | 457 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_update_logical_states()` | 470 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_update_direction()` | 489 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_synthesize_non_direction_releases()` | 518 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:_process_holds(dt)` | 532 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:tick(delta_time)` | 552 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:is_action_down(action, owner)` | 577 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:peek_action_pressed(action, owner)` | 585 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:peek_action_released(action, owner)` | 592 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:peek_action_repeated(action, owner)` | 599 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:is_action_pressed(action, owner)` | 606 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:is_action_released(action, owner)` | 615 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:is_action_repeated(action, owner)` | 624 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:get_active_direction(owner)` | 633 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:require_release(actions, owner)` | 644 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:swallow(seconds, owner)` | 656 | [Details](input-controller/index.md) |
| `input-controller.lua` | `InputController:consume(owner)` | 664 | [Details](input-controller/index.md) |
| `main.lua` | `API.set_controller_class(class)` | 93 | [Details](main/index.md) |
| `main.lua` | `API.get_controller_class()` | 97 | [Details](main/index.md) |
| `main.lua` | `API.get_controller(player_id)` | 103 | [Details](main/index.md) |
| `main.lua` | `API.get_controller_identity(player_id)` | 108 | [Details](main/index.md) |
| `main.lua` | `API.create_controller(player_id, opts)` | 119 | [Details](main/index.md) |
| `main.lua` | `API.spawn_controller(player_id, opts)` | 127 | [Details](main/index.md) |
| `main.lua` | `API.reload_controller(player_id, opts)` | 137 | [Details](main/index.md) |
| `main.lua` | `API.set_repeat_delays(player_id, first_repeat_delay, repeat_delay)` | 150 | [Details](main/index.md) |
| `main.lua` | `API.restore_repeat_delays(player_id)` | 158 | [Details](main/index.md) |
| `main.lua` | `API.activate_controller(player_id)` | 166 | [Details](main/index.md) |
| `main.lua` | `API.deactivate_controller(player_id)` | 172 | [Details](main/index.md) |
| `main.lua` | `API.destroy_controller(player_id)` | 178 | [Details](main/index.md) |

## 📊 Collection summary

This folder subtree contains **4 Lua source files**, **66 named/assigned function detections**, and **58 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | 🎮 Input Controller Library |
