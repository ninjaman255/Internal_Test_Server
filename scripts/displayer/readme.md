# 🎮 Displayer Library — Complete Documentation

> **Scope and accuracy:** This document describes the Lua implementation in this archive under `scripts/displayer/`. Public API names and behavior are based on the wrapper and implementation files in this directory. `Net`, `Async`, `async`, `boom`, and the animation engine are runtime/dependency APIs, not Lua 5.2 standard-library features. Their presence here documents how this library calls them; it does not define the complete engine contract.

## 🗂️ Table of Contents

- [🧭 Part 1 — Overview and Module Map](#part-1)
- [🔌 Part 2 — Runtime Integration: Net and Async](#part-2)
- [🔤 Part 3 — Font and Glyph API](#part-3)
- [📝 Part 4 — Text, Markup, Layout, and Text Boxes](#part-4)
- [⏱️ Part 5 — Timer System and Timer Displays](#part-5)
- [🪧 Part 6 — Nameplates](#part-6)
- [📜 Part 7 — Scrolling Text Lists](#part-7)
- [🖼️ Part 8 — Scrolling Sprite Lists](#part-8)
- [🧱 Part 9 — Sliced Sprites and Text Panels](#part-9)
- [🧰 Part 10 — Builder Helpers and Utility Methods](#part-10)
- [🧹 Part 11 — Lifecycle, IDs, and Cleanup](#part-11)
- [📚 Part 12 — File-by-File Reference](#part-12)
- [🧪 Part 13 — Usage Examples](#part-13)

<a id="part-1"></a>
## 🧭 Part 1 — Overview and Module Map

`require("scripts/displayer/displayer")` returns a singleton table. During construction, the wrapper sets up these namespaces:

| Namespace | Implementation | Purpose |
|---|---|---|
| `Displayer.Builder` | `displayer.lua` | Option-table builders and text-panel style helpers |
| `Displayer.Font` | `font-system.lua` | Font glyph allocation, drawing, updating, erasing, and measurement |
| `Displayer.Text` | `text-display.lua`, `text-layout.lua` | Static text, marquees, text boxes, layout and markup |
| `Displayer.TimerDisplay` | `timer-display.lua` | Visual representation of player/global timers and countdowns |
| `Displayer.Nameplate` | `nameplate.lua` | Nameplate attached to a text box |
| `Displayer.ScrollingText` | `scrolling-text-list.lua` | Scrolling text entries within a bounded list |
| `Displayer.ScrollingSprite` | `scrolling-sprite-list.lua` | Scrolling grid/list of sprites |
| `Displayer.Timer` | `timer-system.lua` | Player and global timers/countdowns |
| `Displayer.TextPanel` | `sliced-sprite.lua` | Sliced-panel drawing and text-panel lifecycle |

The implementation also exposes `Displayer:formatTime(seconds, is_countdown)` and `Displayer:getScreenDimensions()`.

### Directory

```text
scripts/displayer/
  displayer.lua             # public singleton / API wrappers
  font-system.lua           # fonts, glyph metrics, player font assets
  text-display.lua          # text, marquee, textbox APIs
  text-layout.lua           # markup parsing, measurement, wrapping/layout
  timer-system.lua          # timer state and timer events
  timer-display.lua         # glyph-based timer/countdown visuals
  nameplate.lua             # nameplate frame and text
  scrolling-text-list.lua   # scrolling text entries
  scrolling-sprite-list.lua # scrolling sprite entries
  sliced-sprite.lua         # 3/5/9-slice sprites and text panels
  readme.md
```

<a id="part-2"></a>
## 🔌 Part 2 — Runtime Integration: `Net` and `Async`

The library uses the server's `Net` API to provision and draw per-player sprites, erase/deallocate sprite instances, play type sounds, and subscribe to runtime events. The exact call names observed in these files are:

| Call | Observed purpose in this library |
|---|---|
| `Net:on(...)` | Registers event listeners used for player lifecycle and periodic updates |
| `Net.provide_asset_for_player(player_id, ...)` | Makes texture/animation assets available to a player |
| `Net.has_asset(...)` | Checks whether an asset is available before provisioning/using it |
| `Net.player_alloc_sprite(player_id, ...)` | Allocates sprite instances for rendering |
| `Net.player_draw_sprite(player_id, ...)` | Draws or updates a sprite on the player's screen |
| `Net.player_erase_sprite(player_id, ...)` | Erases a drawn sprite instance |
| `Net.player_dealloc_sprite(player_id, ...)` | Releases an allocated sprite instance |
| `Net.emit(...)` | Emits timer/display-related events used by the implementation |
| `Net.play_sound_for_player(player_id, path)` | Plays a type sound for the relevant player |

The exact argument schema for engine functions is not inferred beyond the call sites. Consult the server's engine API for authoritative contracts.

`font-system.lua` imports `async` from `scripts/utils/async` and calls `Async.sleep(...)` in asynchronous behavior. The `async` helper and global `Async` API are distinct names in this project; neither is part of Lua 5.2. Most display operations themselves are direct wrapper calls rather than user-facing `await` operations.

### Event/lifecycle behavior visible in code

- The font system provides font assets and allocates them for players through explicit setup/allocation methods and player-related lifecycle hooks.
- Timer system tracks time through its update path and emits timer/countdown events; timer displays consume the timer system's current values/events.
- Nameplates and scrolling lists keep their own per-player state and expose cleanup/setup methods internally.
- Animated drawing and sprite effects use the project's `boom` and `AnimationEngine` dependencies in addition to `Net` drawing calls.

Do not assume that requiring a single submodule automatically registers all other submodules' listeners; the public wrapper requires/initializes its dependencies when `displayer.lua` is loaded.

<a id="part-3"></a>
## 🔤 Part 3 — Font and Glyph API

### Public calls

```lua
Displayer.Font.drawGlyph(player_id, font_name, char, x, y, options)
Displayer.Font.updateGlyph(player_id, instance_id, updates)
Displayer.Font.eraseGlyph(player_id, instance_id)
Displayer.Font.getGlyphDimensions(font_name, char)
Displayer.Font.allocateAllFontsForPlayer(player_id)
```

- `drawGlyph` returns a glyph instance ID or `nil` according to its implementation path.
- `updateGlyph` applies the supplied property updates to an existing glyph.
- `eraseGlyph` removes a glyph instance; `allocateAllFontsForPlayer` explicitly allocates the font assets for a player.
- `getGlyphDimensions` returns width and height at scale 1.

### Glyph options

The builder defaults visible in `Displayer.Builder.glyph()` are:

| Field | Default | Meaning in code |
|---|---:|---|
| `scale` | `2.0` | Glyph scale |
| `z` | `100` | Draw depth/order passed to sprite rendering |
| `r`, `g`, `b` | `255` | Tint channels |
| `opacity`, `a` | `255` | Alpha/opacity fields supported by the drawing path |
| `ro` | `0` | Rotation |
| `color_mode` | `0` | Passed to sprite color handling |

The font system defines its supported font/state assets in `FONTS`, and builds glyph metrics/state lookup tables from those definitions. Use font names actually present in `font-system.lua`; do not treat a font list in old documentation as proof that a font exists in a different server version.

<a id="part-4"></a>
## 📝 Part 4 — Text, Markup, Layout, and Text Boxes

### `Displayer.Text`

```lua
Displayer.Text.draw(player_id, text_id, text, x, y, options)
Displayer.Text.drawStatic(player_id, text_id, text, x, y, options)
Displayer.Text.removeStatic(player_id, text_id)
Displayer.Text.drawMarquee(player_id, marquee_id, text, y, options)
Displayer.Text.removeMarquee(player_id, marquee_id)
Displayer.Text.createTextBox(player_id, box_id, text, x, y, width, height, options)
Displayer.Text.advanceTextBox(player_id, box_id)
Displayer.Text.closeTextBox(player_id, box_id)
Displayer.Text.getTextBoxState(player_id, box_id)
Displayer.Text.getTextBoxData(player_id, box_id)
Displayer.Text.setKeepAlive(player_id, box_id, keep)
```

`drawStatic`, `drawMarquee`, and text-box methods are compatibility wrappers over `text-display.lua`; `draw` is the unified drawing entry point and accepts an options table describing the requested mode. `text-display.lua` owns per-player display state and delegates text measurement/layout to `text-layout.lua` and glyph rendering to the font system.

### Common option fields

| Option | Used by | Notes |
|---|---|---|
| `font` | text, marquee, textbox | Font key passed to the font system |
| `scale` | text, marquee, textbox | Glyph scale |
| `z` | text, marquee, textbox | Draw order |
| `r`, `g`, `b`, `opacity` / `a` | text styles | Tint/opacity values |
| `ro`, `color_mode` | text styles | Rotation and color mode forwarded to glyph rendering |
| `speed` | marquee/textbox | Marquee speed or text reveal rate, depending on mode |
| `loops` | marquee | Optional limit for marquee loops; implementation default allows continued looping when unset |
| `type_sound`, `type_sound_min_dt` | textbox | Sound and minimum interval for type sounds |
| `perChar` | text/textbox | Per-character style callback support where the implementation consumes it |

Builder defaults: `staticText` uses `font="THICK"`, `scale=2`, `z=100`, white tint and `opacity=255`; `marquee` additionally defaults to `speed=60`; `textBox` defaults to `speed=30` and `type_sound_min_dt=0.1`.

### Text layout and markup

`text-layout.lua` exports:

- `TextLayout.normalizeText(text)`
- `TextLayout.parseMarkup(text)`
- `TextLayout.measureLine(text, options)`
- `TextLayout.layout(text, options)`
- `TextLayout.measure(text, options)`

The module normalizes input, parses its supported markup, measures glyphs using font metrics, and calculates layout/wrapping. Exact markup syntax should be checked in `TextLayout.parseMarkup` before relying on a tag. The module is also required internally by text panels and other UI elements.

### Text-box states

`getTextBoxState(player_id, box_id)` reads the current state from the text-display implementation. The states represented in this code include `printing`, `waiting`, `completed`, and `closing`; callers should handle `nil` if the box is not found. `getTextBoxData` returns internal state data for advanced integrations, including the data used by nameplate attachment. `setKeepAlive` controls whether a box should remain alive rather than being automatically removed.

<a id="part-5"></a>
## ⏱️ Part 5 — Timer System and Timer Displays

Timer state and visuals are separate APIs. Create a timer with `Displayer.Timer`; create a visual with `Displayer.TimerDisplay`.

### Player timers/countdowns

```lua
Displayer.Timer.createPlayerTimer(player_id, timer_id, duration, callback, loop)
Displayer.Timer.createPlayerCountdown(player_id, countdown_id, duration, callback, loop)
Displayer.Timer.pausePlayerTimer(player_id, timer_id)
Displayer.Timer.resumePlayerTimer(player_id, timer_id)
Displayer.Timer.pausePlayerCountdown(player_id, countdown_id)
Displayer.Timer.resumePlayerCountdown(player_id, countdown_id)
Displayer.Timer.removePlayerTimer(player_id, timer_id)
Displayer.Timer.removePlayerCountdown(player_id, countdown_id)
Displayer.Timer.getPlayerTimer(player_id, timer_id)
Displayer.Timer.getPlayerCountdown(player_id, countdown_id)
```

### Global timers/countdowns

```lua
Displayer.Timer.createGlobalTimer(timer_id, duration, callback, loop)
Displayer.Timer.createGlobalCountdown(countdown_id, duration, callback, loop)
Displayer.Timer.pauseGlobalTimer(timer_id)
Displayer.Timer.resumeGlobalTimer(timer_id)
Displayer.Timer.pauseGlobalCountdown(countdown_id)
Displayer.Timer.resumeGlobalCountdown(countdown_id)
Displayer.Timer.removeGlobalTimer(timer_id)
Displayer.Timer.removeGlobalCountdown(countdown_id)
Displayer.Timer.getGlobalTimer(timer_id)
Displayer.Timer.getGlobalCountdown(countdown_id)
Displayer.Timer.getAllGlobalTimers()
Displayer.Timer.getAllGlobalCountdowns()
Displayer.Timer.clearAllGlobalTimers()
Displayer.Timer.clearAllGlobalCountdowns()
```

The timer system also has internal player join/leave handling, a timer update routine, and global timer synchronization for players. The callback and loop parameters are passed into the timer-system methods; check `timer-system.lua` for exact repeat/reset semantics before depending on edge cases.

### Timer visuals

```lua
Displayer.TimerDisplay.createPlayerTimer(player_id, display_id, x, y, options)
Displayer.TimerDisplay.createPlayerCountdown(player_id, display_id, x, y, options)
Displayer.TimerDisplay.createGlobalTimer(display_id, x, y, options)
Displayer.TimerDisplay.createGlobalCountdown(display_id, x, y, options)
Displayer.TimerDisplay.remove(player_id, display_id)
Displayer.TimerDisplay.setPosition(player_id, display_id, x, y)
```

The display module reads timer-system values and renders the time using font glyphs. Its options builder defaults to `font="THICK"`, `scale=2`, `z=100`, white `color`, `opacity=255`, `ro=0`, and `color_mode=0`. Global display creation omits `player_id`; removal and repositioning use the `player_id` argument accepted by the wrapper.

<a id="part-6"></a>
## 🪧 Part 6 — Nameplates

```lua
Displayer.Nameplate.attach(player_id, player_data, box_id, box_data, cfg)
Displayer.Nameplate.erase(player_id, player_data, box_data)
Displayer.Nameplate.begin_close(player_id, player_data, box_data, cfg)
```

The wrapper forwards these calls to `nameplate.lua`. The nameplate uses font and animation support to draw its frame/text and maintains data associated with the textbox. `cfg` may be a string or a table in the implementation. Table fields used by the implementation include text and layout/animation settings; confirm the defaults in `nameplate.lua` when changing anchors, frame tint, padding, bobbing, or close timing. The caller is expected to provide the player/text-box data objects supplied by the text-display API.

<a id="part-7"></a>
## 📜 Part 7 — Scrolling Text Lists

```lua
Displayer.ScrollingText.createList(player_id, list_id, x, y, width, height, config)
Displayer.ScrollingText.addText(player_id, list_id, text)
Displayer.ScrollingText.setTexts(player_id, list_id, texts)
Displayer.ScrollingText.getState(player_id, list_id)
Displayer.ScrollingText.setSpeed(player_id, list_id, speed)
Displayer.ScrollingText.removeList(player_id, list_id)
Displayer.ScrollingText.setPosition(player_id, list_id, x, y)
```

The list creates text-entry glyphs, positions them within a bounded grid/list, and scrolls entries over time. `config` fields are consumed by `scrolling-text-list.lua`; the builder exposes defaults for the font, scale, depth, scrolling/spacing timing, destruction behavior, backdrop, and initial texts. `getState` returns the list's state table when the list exists; handle a missing list.

<a id="part-8"></a>
## 🖼️ Part 8 — Scrolling Sprite Lists

```lua
Displayer.ScrollingSprite.createList(player_id, list_id, x, y, width, height, config)
Displayer.ScrollingSprite.addSprite(player_id, list_id, sprite_def)
Displayer.ScrollingSprite.setSprites(player_id, list_id, sprites)
Displayer.ScrollingSprite.getState(player_id, list_id)
Displayer.ScrollingSprite.setSpeed(player_id, list_id, speed)
Displayer.ScrollingSprite.removeList(player_id, list_id)
Displayer.ScrollingSprite.setPosition(player_id, list_id, x, y)
```

The sprite-list implementation can provision sprite assets, arrange entries into a grid, update their positions while scrolling, and remove their sprite instances. The `sprite_def` structure and supported config keys are defined in `scrolling-sprite-list.lua`; use `Displayer.Builder.spriteDef(texture_path, anim_path, anim_state, overrides)` to build a definition matching the helper's defaults (`sx=1`, `sy=1`, `width=16`, `height=16`).

<a id="part-9"></a>
## 🧱 Part 9 — Sliced Sprites and Text Panels

`Displayer.TextPanel` is the wrapper around the text-panel object in `sliced-sprite.lua`:

```lua
Displayer.TextPanel.create(player_id, panel_id, text, x, y, style, options)
Displayer.TextPanel.updateText(player_id, panel_id, new_text)
Displayer.TextPanel.setPosition(player_id, panel_id, x, y)
Displayer.TextPanel.setOptions(player_id, panel_id, new_options)
Displayer.TextPanel.remove(player_id, panel_id)
Displayer.TextPanel.get(player_id, panel_id)
```

The underlying `SlicedSprite` module also exposes `draw3`, `draw5`, `draw9`, `erase`, and `drawTextPanel`. These draw panel frames using configured sliced assets and use `text-layout.lua`/`font-system.lua` for text measurement and rendering. Style definitions and slice layout are implementation-defined in `sliced-sprite.lua`; pass styles known to that file rather than assuming arbitrary style names work.

<a id="part-10"></a>
## 🧰 Part 10 — Builder Helpers and Utility Methods

`Displayer.Builder` builds option tables; it does not itself create the displayed object.

| Helper | Result/use |
|---|---|
| `glyph(overrides)` | Glyph options |
| `staticText(overrides)` | Static text options |
| `marquee(overrides)` | Marquee options |
| `textBox(overrides)` | Text-box options |
| `timerDisplay(overrides)` | Timer display options |
| `textList(overrides)` | Scrolling text-list config |
| `spriteList(overrides)` | Scrolling sprite-list config |
| `backdrop(x, y, width, height, padding_x, padding_y, r, g, b, opacity, a)` | Backdrop option table |
| `spriteDef(texture_path, anim_path, anim_state, overrides)` | Sprite definition |
| `text(mode, overrides)` | Text options for a mode |
| `textPanelStyle(kind, parts, orientation)` | Text-panel style descriptor |
| `textPanelOptions(overrides)` | Text-panel options |
| `textPanel(text, style, options)` | Text-panel definition/helper result |

Additional utility calls:

```lua
Displayer:formatTime(seconds, is_countdown)
Displayer:getScreenDimensions()
```

`formatTime` formats a numeric duration into a display string according to its `is_countdown` flag. `getScreenDimensions` returns the dimensions hard-coded/used by the wrapper (the implementation returns `480, 320`).

<a id="part-11"></a>
## 🧹 Part 11 — Lifecycle, IDs, and Cleanup

- Most visual APIs are player-specific and take `player_id` first. Global timer displays/timers are explicit exceptions.
- IDs (`text_id`, `marquee_id`, `box_id`, `display_id`, `list_id`, `panel_id`, and glyph instance IDs) identify state held by the relevant subsystem. Keep them stable and unique within the relevant player/subsystem.
- Use the corresponding `remove`, `erase`, `close`, or timer-removal function when the display should end. Do not assume removing a timer automatically removes a separately created timer display.
- The code has per-player setup/cleanup paths for font assets, nameplates, lists, and sliced sprites. Review those paths when adding new long-lived state.
- The wrapper does not convert all lower-level calls into a common error/return contract. Check the specific function's return behavior in its implementation.
- Animation support comes from the repository's animation/boom dependencies; those are not standard Lua libraries.

<a id="part-12"></a>
## 📚 Part 12 — File-by-File Reference

| File | Responsibility |
|---|---|
| `displayer.lua` | Creates the singleton, instantiates dependencies, wires namespaces, exposes wrappers and helpers |
| `font-system.lua` | Font asset definitions, player asset setup/provisioning, glyph metrics, instance allocation/drawing/updating/erasing |
| `text-display.lua` | Unified/static text, marquees, text boxes, display state and progression |
| `text-layout.lua` | Markup parsing, text normalization, measurement and layout |
| `timer-system.lua` | Player/global timer and countdown state, updates, callbacks, pause/resume/removal and synchronization |
| `timer-display.lua` | Converts timer state to rendered glyph displays |
| `nameplate.lua` | Nameplate assets, frame/text drawing, attach/erase/close lifecycle |
| `scrolling-text-list.lua` | Text-entry objects, grid positions, scrolling and list state |
| `scrolling-sprite-list.lua` | Sprite-entry objects, asset preparation, grid positions, scrolling and list state |
| `sliced-sprite.lua` | Sliced panel rendering, style handling, text panel objects |

<a id="part-13"></a>
## 🧪 Part 13 — Usage Examples

### Draw static text

```lua
local Displayer = require("scripts/displayer/displayer")

Net:on("player_join", function(event)
    local player_id = event.player_id
    Displayer.Text.drawStatic(player_id, "welcome", "Welcome!", 24, 24, {
        font = "THICK",
        scale = 2,
        z = 100,
        r = 255, g = 255, b = 255,
        opacity = 255,
    })
end)
```

### Create and display a countdown

```lua
local Displayer = require("scripts/displayer/displayer")

Displayer.Timer.createPlayerCountdown("player-id", "round-countdown", 30, function()
    print("Countdown finished")
end, false)

Displayer.TimerDisplay.createPlayerCountdown(
    "player-id", "round-countdown-display", 24, 24,
    { font = "THICK", scale = 2 }
)
```

The player ID above is a placeholder; use a real ID from the server event/API. The timer and display IDs are separate identifiers, so the timer display ID does not have to equal the timer ID.

### Create a scrolling text list

```lua
local Displayer = require("scripts/displayer/displayer")

Displayer.ScrollingText.createList("player-id", "announcements", 16, 24, 200, 100, {
    texts = { "First message", "Second message" },
    font = "THICK",
    scale = 1,
    scroll_speed = 24,
})
```

Use the exact option keys accepted by the implementation version in the archive; the builder is available when you want defaults merged with overrides.
