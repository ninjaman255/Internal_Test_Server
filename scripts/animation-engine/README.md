# 🎬 Animation Engine Documentation

------------------------------------------------------------------------

## 📌 Overview

The **Animation Engine** is a reusable **Lua system** for animating
properties of any sprite‑like object.

### ✨ Features

-   Interpolates numeric values (*position, scale, rotation, color
    components, alpha*)
-   Supports table‑based values (e.g., `{x = 100, y = 200}`)
-   Multiple easing functions (*linear, elastic, bounce,* etc.)
-   Looping (infinite or fixed count) and **ping‑pong**
-   Animation tagging for grouped control
-   Step‑based sequences (delays, animations, callbacks)
-   Pre‑built composite effects (summon, attack, pulse, fade, etc.)

------------------------------------------------------------------------

## 📂 File Structure

  File                        Purpose
  --------------------------- ---------------------------------
  `math-utils.lua`            Math helpers & easing functions
  `animation-enums.lua`       Constants & enumerations
  `animation-engine.lua`      Core animation & sequence logic
  `animation-sequences.lua`   Pre‑built animation effects

All public functionality is exposed via:

``` lua
local AnimationEngine = require("scripts.net-games.animation-engine.animation-engine")
```

------------------------------------------------------------------------

## ⚙️ Installation & Setup

### 1️⃣ Load the Engine

``` lua
local AnimationEngine = require("scripts.net-games.animation-engine.animation-engine")
```

------------------------------------------------------------------------

### 2️⃣ Update Every Frame

The engine requires:

``` lua
AnimationEngine.tick(dt)
```

If using a network tick system:

``` lua
Net:on("tick", function (event)
    AnimationEngine.tick(event.delta_time)
end)
```

------------------------------------------------------------------------

### 3️⃣ Optional Debug Mode

``` lua
AnimationEngine.set_debug(true)
```

------------------------------------------------------------------------

# 🎯 Core API

## `AnimationEngine.tween()`

The simplest way to animate an object.

``` lua
AnimationEngine.tween(object, target_props, duration, options)
```

### Parameters

  Parameter        Description
  ---------------- --------------------------------------
  `object`         Lua table with animatable properties
  `target_props`   Target values
  `duration`       Seconds
  `options`        Optional behavior table

### Example

``` lua
AnimationEngine.tween(card, {x = 300, y = 400}, 0.5, {
    easing = "bounce_out",
    on_complete = function() print("done!") end
})
```

------------------------------------------------------------------------

## `AnimationEngine.animate()`

Lower‑level explicit animation control.

``` lua
AnimationEngine.animate(start_values, target_values, duration, options)
```

------------------------------------------------------------------------

## `AnimationEngine.set_to()`

Instant property assignment:

``` lua
AnimationEngine.set_to(card, {x = 100, y = 200, scale = 1.2})
```

------------------------------------------------------------------------

# 🛑 Stopping Animations

``` lua
AnimationEngine.stop_animation(id)
AnimationEngine.stop_animations_by_tag("myTag")
AnimationEngine.clear_all()
```

------------------------------------------------------------------------

# ⏳ Delays

``` lua
AnimationEngine.delay(3.0, function()
    print("Delayed callback")
end)
```

------------------------------------------------------------------------

# 🔁 Sequences

Create multi‑step animation flows.

``` lua
local seq_id = AnimationEngine.create_sequence(steps, {
    loop = true
})

AnimationEngine.start_sequence(seq_id)
```

Supported step types:

-   `"animate"`
-   `"delay"`
-   `"run"`
-   `"callback"`

------------------------------------------------------------------------

# 🏷 Tagging

Group animations using:

``` lua
tag = "groupName"
```

Then stop them together:

``` lua
AnimationEngine.stop_animations_by_tag("groupName")
```

------------------------------------------------------------------------

# 🧰 Utility Functions

  Function                            Purpose
  ----------------------------------- ------------------------
  `get_active_count()`                Active animation count
  `get_sequence_count()`              Active sequence count
  `set_debug(bool)`                   Enable logs
  `add_easing_function(name, func)`   Custom easing

------------------------------------------------------------------------

# 🎨 Pre‑Built Sequences

Available under:

``` lua
AnimationEngine.Sequences
```

### Common Helpers

``` lua
Sequences.move_to()
Sequences.scale_to()
Sequences.rotate_to()
Sequences.fade_to()
Sequences.tint_to()
```

### Special Effects

-   `summon()`
-   `attack()`
-   `pulse()`
-   `bob()`
-   `shake()`
-   `marquee()`
-   `typewriter()`
-   `menuCursor()`
-   `highlightCard()`
-   `series()`

Each supports standard options like:

``` lua
{
    duration = 0.8,
    easing = "ease_in_out",
    loop = true,
    ping_pong = true,
    tag = "effectTag"
}
```

------------------------------------------------------------------------

# 🧪 Full Working Example

``` lua
local AnimationEngine = require("scripts.net-games.animation-engine.animation-engine")

local card = {
    x = 100, y = 100,
    scale = 1.0,
    rotation = 0,
    alpha = 255
}

AnimationEngine.set_debug(true)

AnimationEngine.tween(card, {x = 400, y = 300}, 1.0, {
    easing = "ease_in_out",
    tag = "cardMove"
})

AnimationEngine.Sequences.pulse(card, {
    scale_from = 1.0, scale_to = 1.2,
    alpha_from = 255, alpha_to = 150,
    loop = true,
    tag = "cardPulse"
})

AnimationEngine.delay(3.0, function()
    AnimationEngine.stop_animations_by_tag("cardPulse")
end)
```

------------------------------------------------------------------------

# 🌀 Easing Functions

Available names:

    instant
    linear
    ease_in
    ease_out
    ease_in_out
    smoothstep
    elastic_out
    bounce_out
    sine_in_out
    circ_in_out
    back_in_out
    ``

    Add custom easing:

    ```lua
    AnimationEngine.add_easing_function("myEase", function(t)
        return t * t
    end)

------------------------------------------------------------------------

# 📝 Notes

-   Uses `os.clock()` internally for timing.
-   All animations process during `tick()`.
-   Sound‑based sequences assume `Net.play_sound_for_player` exists.
-   For nested property paths, use custom `on_update` callbacks.

------------------------------------------------------------------------

## ✅ Summary

This engine provides:

-   Clean tweening
-   Powerful sequencing
-   Built‑in animation effects
-   Flexible tagging system
-   Minimal boilerplate

Perfect for game UI, sprite systems, and reusable animation logic.

------------------------------------------------------------------------
