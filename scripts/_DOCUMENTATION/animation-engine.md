# Animation Engine — Complete Documentation

> **Documentation scope and accuracy**
>
> This reference documents the source contained in the `animation-engine.zip` archive. API behavior and examples are based on the included files. Server/runtime APIs and external dependencies are described only where their use is visible in source; this is not a claim of live integration testing.

---

## 🗂️ Table of Contents

- [🧭 Part 1 — Overview](#part-1)
- [📂 File Structure](#file-structure)
- [⚙️ Installation & Setup](#installation-setup)
- [🎯 Core API](#core-api)
- [🛑 Stopping Animations](#stopping-animations)
- [⏳ Delays](#delays)
- [🔁 Sequences](#sequences)
- [🏷️ Tagging](#tagging)
- [🧰 Utility Functions](#utility-functions)
- [🎨 Pre-built Sequences](#prebuilt-sequences)
- [🧪 Full Working Example](#full-working-example)
- [🌀 Easing Functions](#easing-functions)
- [📝 Notes](#notes)
- [✅ Summary](#summary)

---

<a id="part-1"></a>

## 🧭 Part 1 — Overview

The **Animation Engine** is a reusable **Lua system** for animating properties of sprite-like objects.

### Features

- Interpolates numeric values, including position, scale, rotation, color components, and alpha.
- Supports table-based values, such as `{x = 100, y = 200}`.
- Provides multiple easing functions, including linear, elastic, and bounce.
- Supports looping animations with infinite or fixed repetition counts, as well as ping-pong behavior.
- Supports animation tags for grouped control.
- Provides step-based sequences containing delays, animations, and callbacks.
- Includes pre-built composite effects such as summon, attack, pulse, and fade.

---

<a id="file-structure"></a>

## 📂 File Structure

| File | Purpose |
|---|---|
| `math-utils.lua` | Mathematical helpers and easing functions |
| `animation-enums.lua` | Constants and enumerations |
| `animation-engine.lua` | Core animation and sequence logic |
| `animation-sequences.lua` | Pre-built animation effects |

The engine can be loaded using:

```lua
local AnimationEngine = require("scripts.net-games.animation-engine.animation-engine")
```

---

<a id="installation-setup"></a>

## ⚙️ Installation & Setup

### 1. Load the Engine

Import the animation engine into your Lua script:

```lua
local AnimationEngine = require("scripts.net-games.animation-engine.animation-engine")
```

### 2. Update Every Frame

The engine requires `AnimationEngine.tick(dt)` to process active animations and sequences.

Call it regularly, passing the elapsed time in seconds:

```lua
AnimationEngine.tick(dt)
```

If your environment provides a network tick system, you can connect the engine to it:

```lua
Net:on("tick", function(event)
    AnimationEngine.tick(event.delta_time)
end)
```

**Note:** The `Net:on` event name and `event.delta_time` field must match the API provided by your runtime.

### 3. Optional Debug Mode

Enable debug logging when troubleshooting animations:

```lua
AnimationEngine.set_debug(true)
```

Disable it when debugging is no longer needed:

```lua
AnimationEngine.set_debug(false)
```

---

<a id="core-api"></a>

## 🎯 Core API

### `AnimationEngine.tween()`

The simplest way to animate an object's properties from their current values toward specified targets.

**Syntax**

```lua
AnimationEngine.tween(object, target_props, duration, options)
```

**Parameters**

| Parameter | Description |
|---|---|
| `object` | Lua table containing the properties to animate |
| `target_props` | Table of target property values |
| `duration` | Animation duration in seconds |
| `options` | Optional table containing animation settings |

**Example**

```lua
AnimationEngine.tween(card, {x = 300, y = 400}, 0.5, {
    easing = "bounce_out",
    on_complete = function()
        print("Animation complete!")
    end
})
```

The example moves `card` toward the specified coordinates over half a second, using the `bounce_out` easing function.

### `AnimationEngine.animate()`

Provides lower-level, explicit control over animation start and target values.

**Syntax**

```lua
AnimationEngine.animate(start_values, target_values, duration, options)
```

**Parameters**

| Parameter | Description |
|---|---|
| `start_values` | Table of initial property values |
| `target_values` | Table of target property values |
| `duration` | Animation duration in seconds |
| `options` | Optional animation settings |

Refer to the implementation in `animation-engine.lua` for the exact supported options and behavior.

### `AnimationEngine.set_to()`

Assigns property values immediately without tweening.

**Example**

```lua
AnimationEngine.set_to(card, {
    x = 100,
    y = 200,
    scale = 1.2
})
```

Use this when an object needs to be positioned or initialized instantly.

---

<a id="stopping-animations"></a>

## 🛑 Stopping Animations

The engine exposes functions for stopping individual animations, stopping tagged animations, and clearing all active animations.

```lua
AnimationEngine.stop_animation(id)
AnimationEngine.stop_animations_by_tag("myTag")
AnimationEngine.clear_all()
```

| Function | Purpose |
|---|---|
| `stop_animation(id)` | Stops the animation associated with the supplied ID |
| `stop_animations_by_tag(tag)` | Stops animations associated with the supplied tag |
| `clear_all()` | Clears active animations |

Use tags when multiple animations belong to the same object or effect and need to be stopped together.

---

<a id="delays"></a>

## ⏳ Delays

The engine can schedule a callback to execute after a specified delay.

**Example**

```lua
AnimationEngine.delay(3.0, function()
    print("Delayed callback")
end)
```

The example schedules the callback after three seconds of animation-engine time.

Make sure the engine's `tick()` function continues to run so time-dependent operations can progress.

---

<a id="sequences"></a>

## 🔁 Sequences

Sequences allow multiple animation steps, delays, and callbacks to be organized into a single flow.

**Example**

```lua
local seq_id = AnimationEngine.create_sequence(steps, {
    loop = true
})

AnimationEngine.start_sequence(seq_id)
```

The `steps` argument represents the sequence's configured step list.

### Supported Step Types

The documented step types are:

- `animate` — performs an animation step.
- `delay` — waits before continuing.
- `run` — executes a configured action.
- `callback` — invokes a callback.

The exact fields required by each step depend on the implementation. Consult the sequence logic in `animation-engine.lua` for the expected step structure.

---

<a id="tagging"></a>

## 🏷️ Tagging

Tags group related animations so they can be controlled together.

**Example**

```lua
AnimationEngine.tween(card, {x = 300}, 0.5, {
    tag = "cardMovement"
})
```

Stop animations using the same tag:

```lua
AnimationEngine.stop_animations_by_tag("cardMovement")
```

Tags are useful for managing effects that need to be canceled together, such as movement, highlighting, or pulsing.

---

<a id="utility-functions"></a>

## 🧰 Utility Functions

The engine provides utility functions for inspecting active work and configuring its behavior.

| Function | Purpose |
|---|---|
| `get_active_count()` | Returns the active animation count |
| `get_sequence_count()` | Returns the active sequence count |
| `set_debug(bool)` | Enables or disables debug logging |
| `add_easing_function(name, func)` | Registers a custom easing function |

### Registering a Custom Easing Function

```lua
AnimationEngine.add_easing_function("myEase", function(t)
    return t * t
end)
```

This example defines a quadratic function that returns the square of its input. The engine's implementation determines how the function is registered and applied during interpolation.

---

<a id="prebuilt-sequences"></a>

## 🎨 Pre-built Sequences

Pre-built effects are exposed through:

```lua
AnimationEngine.Sequences
```

These helpers provide reusable animations without requiring each effect to be assembled manually.

### Common Helpers

The documented helpers include:

```lua
Sequences.move_to()
Sequences.scale_to()
Sequences.rotate_to()
Sequences.fade_to()
Sequences.tint_to()
```

These helpers are intended for common property transitions, including movement, scaling, rotation, transparency, and tinting.

### Special Effects

The documented effects include:

| Effect | General purpose |
|---|---|
| `summon()` | Summoning-style animation |
| `attack()` | Attack-style animation |
| `pulse()` | Repeating emphasis effect |
| `bob()` | Gentle back-and-forth movement |
| `shake()` | Shaking effect |
| `marquee()` | Marquee-style effect |
| `typewriter()` | Typewriter-style presentation |
| `menuCursor()` | Menu cursor effect |
| `highlightCard()` | Card highlighting effect |
| `series()` | Composite or sequential effect |

### Animation Options

The available helpers may accept configuration options such as:

```lua
{
    duration = 0.8,
    easing = "ease_in_out",
    loop = true,
    ping_pong = true,
    tag = "effectTag"
}
```

The options shown are illustrative. Verify the individual helper's implementation to determine which options it accepts and how defaults are handled.

---

<a id="full-working-example"></a>

## 🧪 Full Working Example

The following example demonstrates loading the engine, creating an object, starting a tween and a pre-built effect, and stopping the effect after a delay.

```lua
local AnimationEngine = require("scripts.net-games.animation-engine.animation-engine")

local card = {
    x = 100,
    y = 100,
    scale = 1.0,
    rotation = 0,
    alpha = 255
}

AnimationEngine.set_debug(true)

AnimationEngine.tween(card, {
    x = 400,
    y = 300
}, 1.0, {
    easing = "ease_in_out",
    tag = "cardMove"
})

AnimationEngine.Sequences.pulse(card, {
    scale_from = 1.0,
    scale_to = 1.2,
    alpha_from = 255,
    alpha_to = 150,
    loop = true,
    tag = "cardPulse"
})

AnimationEngine.delay(3.0, function()
    AnimationEngine.stop_animations_by_tag("cardPulse")
end)
```

### Example Requirements

- The engine must be ticked regularly for animations and delays to progress.
- The `card` table must expose the properties expected by the selected animations.
- The `pulse()` options must match the actual helper implementation.
- The runtime must provide any external APIs used by the application.

This example illustrates the documented API usage; it does not establish that the code has been executed successfully in a live server environment.

---

<a id="easing-functions"></a>

## 🌀 Easing Functions

Easing functions determine how interpolation progresses over an animation's duration.

The documented easing names include:

| Easing | General behavior |
|---|---|
| `instant` | Immediate transition |
| `linear` | Constant-rate interpolation |
| `ease_in` | Starts slowly |
| `ease_out` | Finishes slowly |
| `ease_in_out` | Starts and finishes slowly |
| `smoothstep` | Smooth acceleration and deceleration |
| `elastic_out` | Elastic-style overshoot |
| `bounce_out` | Bounce-style finish |
| `sine_in_out` | Sinusoidal easing in and out |
| `circ_in_out` | Circular easing in and out |
| `back_in_out` | Back-style easing in and out |

### Adding a Custom Easing Function

```lua
AnimationEngine.add_easing_function("myEase", function(t)
    return t * t
end)
```

The example uses a quadratic function. The easing function's input and output are interpreted according to the animation engine's implementation.

---

<a id="notes"></a>

## 📝 Notes

- The engine uses `os.clock()` internally for timing.
- Animations are processed through `AnimationEngine.tick()`.
- Sound-based sequences assume that `Net.play_sound_for_player` exists in the runtime.
- For nested property paths, use custom `on_update` callbacks where supported.
- The behavior of options and callback signatures should be confirmed against the source implementation.
- Examples in this document describe intended API usage and are not a substitute for runtime testing.

---

<a id="summary"></a>

## ✅ Summary

The Animation Engine provides a reusable foundation for animating Lua objects.

Its documented capabilities include:

- Property tweening and interpolation.
- Configurable easing functions.
- Animation cancellation and tag-based grouping.
- Delays and multi-step sequences.
- Reusable animation effects.
- Debugging and utility functions.
- Extensible easing behavior.

It is designed to reduce repetitive animation code and make effects easier to reuse across game interfaces and sprite-based systems.

---

---

## Current archive coverage (2026-10-23)

This documentation bundle was refreshed against the supplied `scripts_internal_test_server.zip` snapshot. For exact per-file imports, event subscriptions, function declarations, and source location, use the linked [per-script reference library](script-reference/README.md). These references supplement rather than replace the subsystem explanations above.
