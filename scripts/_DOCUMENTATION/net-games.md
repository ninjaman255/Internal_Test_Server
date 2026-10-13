# net-games — Complete Documentation

> **Documentation scope and accuracy**
>
> This reference documents the source contained in the `net-games.zip` archive. API behavior and examples are based on the included files. Server/runtime APIs and external dependencies are described only where their use is visible in source; this is not a claim of live integration testing.


> **Scope and accuracy:** This document describes the Lua source in `scripts/net-games/` from the supplied archive. Public functions, defaults, and integration points below are taken from those files. Engine functions on `Net`, `Async`, `Input`, `AnimationEngine`, and `boom` are external dependencies; only the calls visible in this repository are documented. Lua 5.2 is the language baseline. Runtime APIs are not Lua-standard APIs.

## 🗂️ Table of Contents

- [🧭 Part 1 — Overview and Directory Map](#part-1)
- [🔌 Part 2 — Runtime APIs and Event/Async Patterns](#part-2)
- [🧩 Part 3 — `main.lua`: Frame/UI API](#part-3)
- [🧱 Part 4 — `layout-manager.lua`](#part-4)
- [💬 Part 5 — Dialogue System](#part-5)
- [🧑‍💻 Part 6 — NPC Authoring API](#part-6)
- [📋 Part 7 — `MenuAPI`](#part-7)
- [🛡️ Part 8 — `ui-safe.lua`](#part-8)
- [🧰 Part 9 — Helpers and Lockable Table](#part-9)
- [🗺️ Part 10 — NPC Examples and Presets](#part-10)
- [📚 Part 11 — File-by-File Reference](#part-11)
- [🧪 Part 12 — Usage Examples](#part-12)
- [⚠️ Part 13 — Defensive Use and Verified Limitations](#part-13)

<a id="part-1"></a>
## 🧭 Part 1 — Overview and Directory Map

`net-games` is a collection of reusable game/UI systems rather than a single monolithic public API. The files expose separate modules for sprite/UI animation, layouts, dialogue, prompts, NPC authoring, menu stacks, and helpers.

```text
scripts/net-games/
  main.lua                    # returns `frame`; sprites, UI transforms, text and timers
  layout-manager.lua          # layout/resource/sprite arrangement and animation
  bn-textbox.lua              # compact Battle Network-style textbox wrapper
  ui-safe.lua                 # defensive sprite provisioning/allocation/drawing
  helpers/net-helpers.lua      # Net.create_timer fallback and safe_require
  dialogue/
    constants.lua             # dialogue mode constants
    dialogue.lua              # dialogue sessions and prompt wrappers
    prompt.lua                # yes/no prompt implementation
    prompt_vertical.lua       # vertical menu implementation
    startup.lua               # startup hook/module setup
  menuAPI/
    main.lua                  # MenuAPI singleton
    README.md
  npcs/
    talk.lua                  # higher-level NPC authoring wrapper
    talk_presets.lua          # UI presets
    talk_vert_menu.lua        # vertical menu flow wrapper
    talk.lua / talk_presets.lua / talk_vert_menu.lua
    npc_api.lua, menu_options.lua
    prog_*.lua                # runnable/demo NPC scripts
    readme.md                 # NPC authoring guide
  utilities/
    lockable-table.lua
    README.md
```

The `main.lua` module returns a local `frame` table. It does not assign that table to `_G` in the inspected source. Other modules explicitly assign globals where shown: `MenuAPI` assigns `_G.MenuAPI`, and `LayoutManager` assigns `_G.LayoutManager`.

<a id="part-2"></a>
## 🔌 Part 2 — Runtime APIs and Event/Async Patterns

### `Net` calls used by this directory

These are names observed in the source, grouped by the feature that uses them. This is a source inventory, not a substitute for the server engine's API specification.

| API | Observed use |
|---|---|
| `Net:on(event_name, function(event) ... end)` | Player lifecycle, tick/update, and input/event listeners. Handlers in this code conventionally receive one `event` parameter. |
| `Net.emit(...)` | Emits events from UI/timer-related code paths. |
| `Net.has_asset(path)` | Asset-existence checks in safe provisioning paths. |
| `Net.provide_asset_for_player(player_id, path)` | Provides texture/animation assets to a player. |
| `Net.player_alloc_sprite(player_id, sprite_id, definition)` | Allocates physical sprite instances. |
| `Net.player_draw_sprite(player_id, draw_definition)` | Draws/updates UI sprites. |
| `Net.player_erase_sprite(player_id, draw_id)` | Erases a drawn sprite. |
| `Net.player_dealloc_sprite(player_id, sprite_id)` | Deallocates sprite instances. |
| `Net.play_sound(path)` / `Net.play_sound_for_player(player_id, path)` | Plays UI sound effects, globally or for a player. |
| `Net.create_bot(...)`, `Net.remove_bot(...)` | Used by example NPC scripts to create/remove bots. |
| `Net.get_object_by_name(area_id, name)` | Locates map objects used as NPC positions. |
| `Net.get_bot_name(bot_id)`, `Net.get_bot_position(bot_id)`, `Net.set_bot_direction(...)`, `Net.animate_bot(...)`, `Net.animate_bot_properties(...)`, `Net.move_bot(...)`, `Net.transfer_bot(...)`, `Net.is_bot(...)` | Bot identity, animation, movement, direction, transfer, and checks in NPC scripts. |
| `Net.get_player_area(player_id)`, `Net.get_player_position(player_id)`, `Net.set_player_position(...)`, `Net.move_player(...)`, `Net.transfer_player(...)`, `Net.set_player_animation(...)`, `Net.animate_player_properties(...)` | Player position, area, transfer, and animation paths. |
| `Net.lock_player_input(player_id)`, `Net.unlock_player_input(player_id)` | UI/dialogue input ownership and handoff. |
| `Net.exclude_actor_for_player(...)` | Actor visibility/exclusion behavior in the frame system. |
| `Net.create_timer(...)` | Used by `net-helpers.lua` as a compatibility hook if the runtime lacks it; the helper patches `Net` only when missing. |

### Async conventions

- `main.lua` defines local `async(p)` by creating a coroutine and returning `Async.promisify(co)`, and defines local `await(v)` using `Async.await(v)`. These helpers are local to that module.
- `scripts/net-games/helpers/net-helpers.lua` implements its timer with a `Net:on` update listener and elapsed-time bookkeeping rather than requiring `Async.sleep`.
- The dialogue and menu implementations are primarily event/tick driven. Do not assume a public function returns a Promise unless its code explicitly returns one.
- `Async` and the lowercase `async` helper are distinct identifiers in this project. Neither is part of Lua 5.2.

### External dependencies

- `scripts/displayer/displayer`: glyph, text, textbox and timer-display rendering.
- `scripts/input-controller/main` and `scripts/input/input`: input handling.
- `scripts/animation-engine/animation-engine` and `animation-sequences`: UI/layout animation.
- `scripts/boom/main`: sprite/resource helpers used by layouts and effects.
- `scripts/libs/direction`: direction utilities used by NPC scripts.

<a id="part-3"></a>
## 🧩 Part 3 — `main.lua`: Frame/UI API

Import with:

```lua
local frame = require("scripts/net-games/main")
```

The returned `frame` table has the following public methods. These names/signatures are read from function declarations in `main.lua`; optional parameters are omitted here where the declaration uses a long parameter list, so consult the source for exact options and animation semantics.

### Player/cosmetic/map elements

| Function | Purpose visible in code |
|---|---|
| `frame.move_frozen_player(player_id, x, y, z)` | Moves a player while the framework's frozen-player behavior is active. |
| `frame.animate_frozen_player(player_id, anim_state)` | Changes the frozen player's animation state. |
| `frame.set_cosmetic(cosmetic_id, player_id, texture, animation, state, x, y, visible, player_xoffset, player_yoffset)` | Creates/updates a cosmetic sprite associated with a player. |
| `frame.remove_cosmetic(cosmetic_id, player_id)` | Removes a cosmetic. |
| `frame.add_map_element(name, player_id, texture, animation, animation_state, x, y, z, exclude)` | Adds a map/UI sprite element. |
| `frame.change_map_element(name, player_id, animation_state, loop)` | Changes its animation state/loop behavior. |
| `frame.move_map_element(name, player_id, x, y, z)` | Changes map element position/depth. |
| `frame.remove_map_element(name, player_id)` | Removes a map element. |

### UI element creation and direct changes

| Function | Purpose |
|---|---|
| `frame.add_ui_element(...)` | Allocates/provides and creates a UI element; see source declaration around line 430 for the complete positional argument list. |
| `frame.update_ui_element(sprite_id, player_id, properties)` | Applies property updates. |
| `frame.set_ui_animation(sprite_id, player_id, animation_state)` | Sets animation state. |
| `frame.remove_ui_element(sprite_id, player_id)` | Removes a UI element. |
| `frame.get_ui_element_proxy(sprite_id, player_id)` | Gets the proxy used for element property access. |
| `frame.set_ui_element_instant(sprite_id, player_id, properties)` | Applies properties immediately. |
| `frame.reset_ui_element(sprite_id, player_id, initial_values)` | Resets properties using supplied initial values. |
| `frame.get_ui_element_properties(sprite_id, player_id)` | Reads tracked UI properties. |

### UI transforms and effects

The following methods are implemented on `frame` and use the animation engine to animate element properties. Their parameters include a `sprite_id`, `player_id`, target/offset values, duration, easing, and where applicable callbacks/loop options.

- Position: `slide_ui_element`, `relative_slide_ui_element`, `set_slide_ui_element`, `move_ui_element`.
- Scale: `scale_ui_element`, `relative_scale_ui_element`, `pulse_scale_ui_element`.
- Rotation: `rotate_ui_element`, `relative_rotate_ui_element`.
- Combined transform: `transform_ui_element`, `relative_transform_ui_element`.
- Opacity: `set_opacity_ui_element`, `relative_set_opacity_ui_element`.
- Tint: `set_ui_element_color`, `relative_set_ui_element_color`, `color_pulse_from_current`, `color_pulse_ui_element`, `color_pulse_rgb`.
- Motion/effects: `bob_ui_element`, `summon_ui_element`, `complex_summon_ui_element`, `summon_ui_element_relative`, `complex_summon_ui_element_relative`, `menu_cursor_ui_element`, `shake_ui_element`.
- Animation control/status: `stop_ui_animation`, `has_active_animations`, `is_animation_running`.

The source declarations around lines 736–1916 are the authority for exact argument order and accepted easing/option names. Animation properties and easing behavior are delegated to this project's `AnimationEngine`/`boom`, not Lua's standard library.

### Cursor helpers

```lua
frame.spawn_cursor(sprite_id, player_id, options)
frame.remove_cursor(cursor_id, player_id)
frame.move_cursor_to_selection(cursor_id, player_id, selection_name)
frame.get_current_cursor_selection(cursor_id, player_id)
frame.lock_cursor(cursor_id, player_id, locked)
frame.is_cursor_locked(cursor_id, player_id)
frame.update_cursor_options(cursor_id, player_id, new_options)
```

These methods maintain cursor state and use the frame UI infrastructure. Cursor option keys and selection metadata are defined in the implementation.

### Camera, text, marquee, and timer convenience methods

```lua
frame.detach_camera(player_id)
frame.draw_text(text_id, player_id, text, x, y, z, font, scale)
frame.update_text(text_id, player_id, text)
frame.remove_text(text_id, player_id)
frame.draw_advanced_text(player_id, text, opts)
frame.draw_marquee_text(marquee_id, player_id, text, y, font, scale, z_order, speed, backdrop)
frame.set_marquee_position(player_id, marquee_id, x, y)
frame.set_marquee_speed(player_id, marquee_id, speed)

frame.spawn_timer(timer_id, player_id, x, y, duration, loop)
frame.resume_timer(timer_id, player_id)
frame.pause_timer(timer_id, player_id)
frame.remove_timer(timer_id, player_id)
frame.update_timer(timer_id, player_id, duration)
frame.spawn_countdown(countdown_id, player_id, x, y, duration, loop)
frame.resume_countdown(countdown_id, player_id)
frame.pause_countdown(countdown_id, player_id)
frame.remove_countdown(countdown_id, player_id)
frame.update_countdown(countdown_id, player_id, duration)
```

These are compatibility/convenience methods over cached text, marquee and timer state; for more extensive text/timer behavior use the `Displayer` API directly.

<a id="part-4"></a>
## 🧱 Part 4 — `layout-manager.lua`

Import with `require("scripts/net-games/layout-manager")`; the module also assigns `_G.LayoutManager`.

### Layout and sprite lifecycle

```lua
LayoutManager.create_layout(player_id, layout_id, options)
LayoutManager.add_sprite(player_id, layout_id, resource_id, object_id, properties)
LayoutManager.remove_sprite(player_id, layout_id, object_id, properties)
LayoutManager.remove_layout(player_id, layout_id)
LayoutManager.arrange_layout(player_id, layout_id)
```

A layout is scoped by player and layout ID. Sprites within it have object IDs, resource IDs, and property tables. The module tracks resources, instances, layouts and dirty layouts internally.

### Property control and animation

```lua
LayoutManager.set_layout_property(player_id, layout_id, property, value, mode, duration, easing, sound)
LayoutManager.set_sprite_property(player_id, layout_id, object_id, property, value, mode, duration, easing, sound)
LayoutManager.get_sprite_proxy(player_id, layout_id, object_id)
LayoutManager.animate_layout_property(player_id, layout_id, property, target, duration, options)
LayoutManager.animate_sprite_property(player_id, layout_id, object_id, property, target, duration, options)
```

### Ordering and animated structural operations

```lua
LayoutManager.reorder_sprite(player_id, layout_id, object_id, new_index)
LayoutManager.swap_sprites(player_id, layout_id, object_id_a, object_id_b, swap_properties)
LayoutManager.move_sprite_before(player_id, layout_id, object_id_to_move, reference_object_id)
LayoutManager.move_sprite_after(player_id, layout_id, object_id_to_move, reference_object_id)

LayoutManager.add_sprite_animated(player_id, layout_id, resource_id, object_id, properties, anim_options)
LayoutManager.remove_sprite_animated(player_id, layout_id, object_id, anim_options)
LayoutManager.swap_sprites_animated(player_id, layout_id, object_id_a, object_id_b, swap_properties, anim_options)
LayoutManager.reorder_sprite_animated(player_id, layout_id, object_id, new_index, anim_options)
LayoutManager.move_sprite_before_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)
LayoutManager.move_sprite_after_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)
```

`LayoutManager.on_tick(delta_time)` is the update entry point; `LayoutManager.clear_player(player_id)` clears a player's layout state. Animated operations and property modes are implementation-defined; use the option fields and accepted properties found in `layout-manager.lua`.

<a id="part-5"></a>
## 💬 Part 5 — Dialogue System

### Constants

`require("scripts/net-games/dialogue/constants")` returns:

- `AdvanceMode.INPUT = "input"`, `AdvanceMode.TIMER = "timer"`
- `PageAdvance.WAIT_FOR_CONFIRM = "wait_for_confirm"`, `AUTO_ADVANCE = "auto_advance"`, `AUTO_ADVANCE_OR_CONFIRM = "auto_advance_or_confirm"`
- `InputMode.DIALOGUE_OWNS_INPUT = "dialogue_owns_input"`, `OVERLAY_ONLY = "overlay_only"`

These values are constants used by dialogue implementation paths; they are not engine-wide enums.

### `Dialogue`

```lua
local Dialogue = require("scripts/net-games/dialogue/dialogue")

Dialogue.is_active(player_id)
Dialogue.prompt_yesno(player_id, opts)
Dialogue.prompt_menu(player_id, opts)
Dialogue.start(player_id, script, opts)
Dialogue.close(player_id)
```

`script` is normalized/consumed by the dialogue implementation; `opts` controls UI and flow. `Dialogue` keeps `Dialogue.instances` and attaches its input listener once. `prompt_yesno` delegates to `Prompt.yesno`; `prompt_menu` delegates to `PromptVertical.menu`. The implementation uses `Displayer`, `TextDisplay`, and `Input`.

Options that are directly used by the higher-level `Talk` wrapper include `page_advance`, `confirm_during_typing`, `cancel_behavior`, `from_prompt`, `reuse_existing_box`, `ui`, `on_finish`, and `debug`. Other options are read by the implementation; inspect `dialogue.lua` before relying on undocumented names.

### Lower-level prompts

```lua
Prompt.yesno(player_id, opts)
Prompt.close(player_id, reason, opts)

PromptVertical.menu(player_id, opts)
PromptVertical.close(player_id, reason, opts)
```

The vertical prompt module also has `_finalize_close`, which is an internal lifecycle function. `Prompt` and `PromptVertical` keep per-player instances and update them through tick/input listeners. Use `Dialogue` or `Talk` for normal authoring unless the lower-level prompt configuration is needed.

<a id="part-6"></a>
## 🧑‍💻 Part 6 — NPC Authoring API

The recommended author-facing module is `scripts/net-games/npcs/talk.lua`, imported as `Talk`. It wraps dialogue UI defaults and presets so NPC scripts can focus on dialogue content and reactions.

### `Talk` functions

```lua
Talk.start(player_id, script, cfg, bot_name, extra_opts)
Talk.prompt_yesno(player_id, question, cfg, bot_name, handlers)
Talk.vert_menu(player_id, bot_name, cfg, menu_cfg)
Talk.prompt_then_talk(player_id, question, yes_script, no_script, cfg, bot_name)
Talk.npc(cfg)
Talk._build_ui(cfg, bot_name, opts)
```

- `Talk.start`: starts a script; a string is normalized to one line and a table is used as the script list. `cfg` supplies preset and flow settings; `extra_opts` is merged over the generated options.
- `Talk.prompt_yesno`: displays a yes/no prompt. `handlers` may contain `on_yes`, `on_no`, and `on_cancel` callbacks.
- `Talk.vert_menu`: checks that dialogue/menu is not already busy, resolves menu options/layout/flow/sounds, and opens the vertical menu flow.
- `Talk.prompt_then_talk`: combines a yes/no prompt with follow-up scripts.
- `Talk.npc`: higher-level NPC setup/interaction helper; see its implementation for required `cfg` fields and the exact event binding behavior.
- `_build_ui` is present in the returned module but is an implementation-oriented helper; most authors should use the higher-level functions.

### `Talk` configuration details observed in code

- Preset selection checks `cfg.preset`, then `cfg.pack`, then defaults to `"prog"`.
- The UI chooses box/mug/nameplate presets, with per-NPC overrides under `cfg.ui` merged last.
- `cfg.frame` can refer to a frame preset key or a frame table; the frame tint is applied to the textbox panel and nameplate overlay when available.
- `cfg.from_prompt` and `cfg.reuse_existing_box` are specifically used for prompt-to-dialogue transitions. The wrapper re-enables the existing box's indicator when both are true.
- Default flow values in `Talk.start` include `page_advance = "wait_for_confirm"`, `confirm_during_typing = true` unless explicitly false, and `cancel_behavior = "battle_network"`.

### Prompt-to-dialogue transition

When dialogue follows a prompt in the same box, set both flags in the follow-up config:

```lua
local next_cfg = {}
for k, v in pairs(cfg) do next_cfg[k] = v end
next_cfg.from_prompt = true
next_cfg.reuse_existing_box = true
Talk.start(player_id, { "Follow-up line." }, next_cfg, bot_name)
```

This matches the explicit transition logic in `talk.lua`; it is not a general Lua requirement.

### NPC utility modules

- `talk_presets.lua` exports tables for nameplates, mugshots, boxes, frame dyes, vertical menu layouts/flows, and helper functions `get_vert_menu_layout(key)` / `get_vert_menu_flow(key)`.
- `talk_vert_menu.lua` exposes `TalkVertMenu.is_busy(player_id)` and `TalkVertMenu.open(player_id, bot_name, talk_cfg, menu_cfg)`.
- `menu_options.lua` exports `count(count, cfg)` and `list(items, cfg)` to generate menu option lists.
- `npc_api.lua` exports `play_sfx(player_id, path)`, `face_player(bot_id, bot_pos, player_id)`, and `bind_confirm_interaction(bot_id, bot_pos, handler, opts)`.

<a id="part-7"></a>
## 📋 Part 7 — `MenuAPI`

Import with `require("scripts/net-games/menuAPI/main")`. The module sets `_G.MenuAPI` and returns `MenuAPI`.

### Opening a menu

```lua
local MenuAPI = require("scripts/net-games/menuAPI/main")

MenuAPI.open(player_id, {
    type = "scroll_list",
    title = "Choose one",
    rows = {
        { id = "a", text = "Alpha", right = "10" },
        { id = "b", text = "Beta" },
    },
    on_select = function(row, index)
        print("selected", row.id, index)
    end,
})
```

Built-in types defined in `MENU_TYPES` are `scroll_list`, `info_window`, `compact_menu`, `confirm_prompt`, and `profile_list`. Menu options include rows and callbacks; row rendering supports fields consumed by the implementation, including icon texture/animation/state, `enabled`, `right`, and per-row `on_select`.

### Public functions

```lua
MenuAPI.get_palette(name)
MenuAPI.open(player_id, spec)
MenuAPI.push(player_id, spec) -- alias of open
MenuAPI.close(player_id, opts)
MenuAPI.close_all(player_id, opts)
MenuAPI.is_open(player_id)
MenuAPI.get_state(player_id)
MenuAPI.get_stack(player_id)
MenuAPI.refresh(player_id)
MenuAPI.set_rows(player_id, rows, preserve_selection)
MenuAPI.set_profile(player_id, profile)
MenuAPI.set_title(player_id, title)
MenuAPI.handle_cancel(player_id)
```

The implementation maintains a stack per player, coordinates input with `InputController`, uses `Displayer` for visuals and `ui-safe.lua` for safer sprite cleanup, and supports partial refreshes. `set_rows(..., true)` attempts to preserve the selected row by matching row IDs. `confirm_prompt` reads `default_selection`, `lines`, and `on_result(yes)` as shown by the module's own README and implementation.

The default art paths referenced in the module README are under `/server/assets/ui/menuAPI/` (`menu1.png`, `menu2.png`, `menu3.png`, `cursor.png`, `scroll.png`). Asset availability depends on the actual server asset bundle; the Lua code alone does not install these files.

<a id="part-8"></a>
## 🛡️ Part 8 — `ui-safe.lua`

Import with `require("scripts/net-games/ui-safe")`. Public functions:

```lua
UISafe.asset_exists(path)
UISafe.safe_provide(player_id, path)
UISafe.draw(player_id, logical_id, texture_path, options)
UISafe.erase(player_id, logical_id)
UISafe.cleanup_player(player_id)
```

`ui-safe.lua` maintains per-player entries keyed by logical ID. The implementation:

- checks asset availability using `Net.has_asset` when that function exists;
- calls `Net.provide_asset_for_player` through `pcall` and returns false on a confirmed failure;
- allocates a new physical sprite ID when a logical sprite changes texture/animation path, to avoid stale texture reuse;
- converts its public virtual 240×160 coordinates to screen coordinates by multiplying by 2, pixel-snapping unless `pixel_snap=false`;
- avoids retransmitting an unchanged draw based on a set of tracked properties;
- erases/deallocates owned sprites during replacement/cleanup.

`draw` options read in the implementation include `anim_path` or `animation_path`, `anim_state`, `x`, `y`, `z`, `sx`, `sy`, `scale`, tint/opacity/alpha, rotation/origin, `color_mode`, and `pixel_snap`. `asset_exists` means “not confirmed missing” when the engine cannot verify asset existence; it should not be interpreted as a guaranteed positive filesystem check in that case.

<a id="part-9"></a>
## 🧰 Part 9 — Helpers and Lockable Table

### `helpers/net-helpers.lua`

```lua
local NetHelpers = require("scripts/net-games/helpers/net-helpers")
NetHelpers.create_timer(seconds, callback)
NetHelpers.safe_require(path)
NetHelpers.patch_net()
```

- `create_timer` stores a callback and remaining duration and returns a handle with `:cancel()`. It registers an update listener once and updates its timers from tick deltas.
- `safe_require` wraps `require` in `pcall`, logs failure, and returns `nil, error` when loading fails; on success it returns the module and `nil`.
- `patch_net` only adds `Net.create_timer = NetHelpers.create_timer` if `Net` exists and `Net.create_timer` is absent. It returns false if `Net` is unavailable, true after the patch check.

### `utilities/lockable-table.lua`

This module provides lockable tables and is documented in `utilities/README.md`. Public module operations visible in the implementation include `new`, `wrap`, and `isLockable`; instances support data manipulation methods (`add`, `remove`, `update`, `addMany`, `removeMany`, `replace`, `clear`), locking/unlocking methods for keys, values, and the entire table, lock-state checks, and size/locked-item inspection. Check the utility README and implementation for argument details, return values, and recursive behavior.

<a id="part-10"></a>
## 🗺️ Part 10 — NPC Examples and Presets

The `npcs/prog_*.lua` files are example/active scripts rather than one central API. They demonstrate use of the dialogue layers, preset customization, free-draw text, nameplates, prompts, vertical menus, colors and shop flows. Some scripts resolve an NPC map object with `Net.get_object_by_name(area_id, obj_name)` and create a bot with `Net.create_bot`; their expected map object names and area IDs are script-specific. Read each script before copying it into a different map.

`npcs/readme.md` documents four authoring levels: simple dialogue, yes/no prompt, vertical menu, and the condensed `Talk.vert_menu` wrapper. The preferred authoring pattern is to keep dialogue strings/options in one `texts` structure where the selected helper supports it. The exact option keys are the ones consumed by `talk.lua`, `talk_presets.lua`, and `talk_vert_menu.lua`.

<a id="part-11"></a>
## 📚 Part 11 — File-by-File Reference

| File | Responsibility |
|---|---|
| `main.lua` | Frame UI/cosmetic/map elements, transforms, cursors, text and timer convenience functions |
| `layout-manager.lua` | Layouts, resources, sprite ordering, properties and animated operations |
| `bn-textbox.lua` | Short wrapper for Battle Network-style dialogue textbox behavior |
| `ui-safe.lua` | Defensive per-player sprite allocation/drawing and cleanup |
| `helpers/net-helpers.lua` | Tick-driven timer fallback, safe module loading, conditional Net patch |
| `dialogue/constants.lua` | Dialogue flow/input constants |
| `dialogue/dialogue.lua` | Dialogue instance lifecycle and high-level prompts |
| `dialogue/prompt.lua` | Yes/no prompt state and rendering |
| `dialogue/prompt_vertical.lua` | Vertical prompt/menu state and rendering |
| `dialogue/startup.lua` | Dialogue startup integration |
| `menuAPI/main.lua` | Stacked reusable menu API |
| `npcs/talk.lua` | Author-facing dialogue/prompt/menu API |
| `npcs/talk_presets.lua` | Textbox, nameplate, mugshot, frame and menu presets |
| `npcs/talk_vert_menu.lua` | Vertical menu flow for NPCs |
| `npcs/menu_options.lua` | Option-list construction helpers |
| `npcs/npc_api.lua` | NPC sound, facing, and confirm-interaction helpers |
| `npcs/prog_*.lua` | Example NPC scripts and UI demonstrations |
| `utilities/lockable-table.lua` | Lockable table data structure |

<a id="part-12"></a>
## 🧪 Part 12 — Usage Examples

### Start a dialogue using the author API

```lua
local Talk = require("scripts/net-games/npcs/talk")

local cfg = {
    area_id = "default",
    object = "ExampleNPC",
    preset = "prog",
}

-- `player_id` and `bot_name` should come from your NPC interaction flow.
Talk.start(player_id, {
    "Welcome to the network.",
    "Choose your next move carefully.",
}, cfg, bot_name)
```

### Open a menu

```lua
local MenuAPI = require("scripts/net-games/menuAPI/main")

MenuAPI.open(player_id, {
    type = "scroll_list",
    title = "Network",
    rows = {
        { id = "status", text = "Status" },
        { id = "exit", text = "Exit" },
    },
    on_select = function(row, index)
        if row.id == "exit" then
            MenuAPI.close(player_id)
        end
    end,
})
```

### Draw through `ui-safe`

```lua
local UISafe = require("scripts/net-games/ui-safe")

local ok = UISafe.draw(player_id, "sample-icon",
    "/server/assets/ui/sample.png", {
        x = 20,
        y = 20,
        z = 100,
        scale = 2,
        pixel_snap = true,
    }
)

if not ok then
    print("Could not create the UI sprite")
end
```

<a id="part-13"></a>
## ⚠️ Part 13 — Defensive Use and Verified Limitations

- `Net` and its method signatures are provided by the game server, not Lua 5.2. This README records only the names/argument patterns visible at call sites.
- Event payloads and runtime return values should be validated. The code contains defensive `pcall` use in helpers such as `ui-safe.lua`, but that does not imply every module protects every engine call.
- Asset paths are strings in source; the archive alone does not prove that every referenced asset exists in the live deployment.
- The demo NPC scripts can expect particular map object names, area IDs, and assets. These are not automatically valid on every map.
- Some functions accept long positional argument lists, especially `frame.add_ui_element` and animation helpers. Use the source declaration as the definitive signature rather than guessing the meaning/order of arguments.
- Only standard Lua 5.2 behavior should be assumed for language features. `Net`, `Async`, `Input`, `AnimationEngine`, `boom`, and the repository's other modules are project/runtime APIs.
