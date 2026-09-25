# 🎮 Input Controller Library

> **A robust, server-side input handling library for Lua-based game servers.**
>
> Converts raw button presses into logical actions such as **Confirm** and
> **Cancel**, and directions such as **Left** and **UpRight**.
>
> **Core capabilities:** edge detection · repeat handling · release-required
> guards · UI input swallowing · per-player state

---

## 📚 Table of Contents

| # | Section |
|---:|---|
| 1 | [Overview](#-overview) |
| 2 | [Installation & Usage](#-installation--usage) |
| 3 | [Architecture](#-architecture) |
| 4 | [File Reference](#-file-reference) |
| 5 | [Public API (`main.lua`)](#-public-api-mainlua) |
| 6 | [InputController Class](#-inputcontroller-class) |
| 7 | [Event Handling](#-event-handling) |
| 8 | [Input Processing](#-input-processing) |
| 9 | [State Queries](#-state-queries) |
| 10 | [Consuming & Swallowing](#-consuming--swallowing) |
| 11 | [Utilities](#-utilities) |
| 12 | [DPad Module](#-dpad-module) |
| 13 | [Buttons Table](#-buttons-table) |
| 14 | [Event Payloads](#-event-payloads) |
| 15 | [Direction Handling & Combos](#-direction-handling--combos) |
| 16 | [Release-Required & Swallowing](#-release-required--swallowing) |
| 17 | [Example Usage](#-example-usage) |
| 18 | [Notes & Internals](#-notes--internals) |

---

# 🔎 Overview

The library converts **low-level input events** into **higher-level,
game-friendly input states**.

### ✨ Key Features

| Feature | What it provides |
|---|---|
| **Logical action mapping** | Map multiple raw buttons (for example, `"A"` and `"Interact"`) to one semantic action such as `"Confirm"`. |
| **Direction handling** | Combine raw direction buttons into cardinals and diagonals such as `"DownLeft"` while retaining state memory to reduce jitter. |
| **Edge events** | Detect **pressed**, **released**, and **repeated** pulses for actions and directions. |
| **Repeat control** | Configure per-action repeat behavior with an adjustable first delay and repeat rate. |
| **Release-required guards** | Prevent an action from retriggering until the physical button has been released. |
| **Swallowing** | Temporarily suppress edge events during UI handoffs and menu transitions. |
| **Per-player state** | Maintain isolated controllers for each player, automatically created and destroyed through network events. |

> **Server-side design:** The library receives raw input over the network
> through `virtual_input` events and ticks every frame to process holds and
> timeouts.

---

# 🛠️ Installation & Usage

## 1. Place the Library Files

Put the four files in:

```text
scripts/input-controller/
```

### Required Files

- `buttons.lua`
- `d-pad.lua`
- `input-controller.lua`
- `main.lua`

## 2. Require the Public API

```lua
local InputAPI = require("scripts/input-controller/main")
```

## 3. Provide the Required Network Events

| Event | Required payload |
|---|---|
| `player_join` | `player_id` |
| `player_disconnect` | `player_id` |
| `virtual_input` | `player_id` and raw input `events` |
| `tick` | `delta_time` (`number`) |

The library automatically hooks into these events to manage controllers and
drive updates.

## 4. Access a Player's Controller

```lua
local ctrl = InputAPI.get_controller(player_id)

if ctrl and ctrl:is_action_pressed("Confirm") then
    -- handle confirm
end
```

---

# 🧩 Architecture

Each module has a focused responsibility.

| File | Responsibility |
|---|---|
| `buttons.lua` | Defines mappings from logical action names to raw button-name lists. |
| `d-pad.lua` | Handles direction recognition, including cardinals, diagonals, and per-player state. |
| `input-controller.lua` | Core `InputController` class; manages raw states, logical states, edge flags, repeats, and swallowing. |
| `main.lua` | Public API; builds button mappings, maintains the controller cache, and wires network events. |

## Data Flow

```text
Raw events (virtual_input)
        │
        ▼
InputController:handle_raw_input(events)
        │
        ▼
Update raw_states, logical_states, direction
        │
        ▼
Emit pressed/released/repeat events
        │
        ▼
InputController:tick(dt)
        │
        ▼
Process holds and timeouts
```

---

# 📁 File Reference

## `buttons.lua`

A simple table maps each logical action to an array of raw button names.

```lua
{
    Confirm = {"Confirm", "A", "Interact", "Use Card"},
    Cancel  = {"Cancel", "Shoot", "Run"},
    ...
}
```

> **Default:** Actions do **not** repeat (`allow_repeat = false`).
> Repeat behavior can be customized through the `InputController`.

---

## `d-pad.lua`

Defines:

- direction raw names
- diagonal combo definitions
- stateful direction detection

See the [DPad Module](#-dpad-module) section for details.

---

## `input-controller.lua`

Contains the **`InputController` class**.

See the [InputController Class](#-inputcontroller-class).

---

## `main.lua`

The public entry point.

### Exposed API

| Member | Type | Purpose |
|---|---|---|
| `API.get_controller(player_id)` | Function | Retrieve an existing controller. |
| `API.create_controller(player_id)` | Function | Create or retrieve a controller. |
| `API.destroy_controller(player_id)` | Function | Destroy a player's controller. |
| `API.buttons` | Table | Raw mapping from `buttons.lua`. |
| `API.DPad` | Table | DPad module and direction helpers. |
| `API.InputController` | Class | Core controller class for extension or standalone use. |

The module also automatically registers the relevant network event listeners.

---

# 🌐 Public API (`main.lua`)

## `API.get_controller(player_id)`

**Signature**

```text
function(player_id: number) -> InputController|nil
```

Returns the `InputController` instance for the given player, or `nil` if one
has not been created yet.

---

## `API.create_controller(player_id)`

**Signature**

```text
function(player_id: number) -> InputController
```

Creates a new controller for the player if one does not already exist and
returns it.

The controller is automatically registered with the `player_join` event.

---

## `API.destroy_controller(player_id)`

**Signature**

```text
function(player_id: number)
```

Destroys the player's controller by calling `:destroy()` and removes it from
the controller cache.

---

## `API.buttons`

**Type:** `table`

Contains the raw mapping from `buttons.lua`.

You may **read or modify this table before creating controllers**.

---

## `API.DPad`

**Type:** `table`

The DPad module, including direction definitions and detection functions.

---

## `API.InputController`

**Type:** `class`

The `InputController` class, useful for extending the library or creating
standalone controller instances.

---

# 🎛️ InputController Class

## Constructor

### `InputController.new(player_id, button_mappings, direction_raw_names)`

**Signature**

```text
function(
    player_id: number,
    button_mappings: table,
    direction_raw_names: table
) -> InputController
```

Creates a new controller.

### Parameters

| Parameter | Type | Description |
|---|---|---|
| `player_id` | `number` | Integer identifier for the player. |
| `button_mappings` | `table` | Maps logical action names to configuration tables. |
| `direction_raw_names` | `table` | Set of raw names representing direction inputs. Typically obtained from `DPad.getAllDirectionRawNames()`. |

### Button Mapping Format

```lua
{
    Confirm = {
        names = {"Confirm", "A"},
        allow_repeat = false
    },

    Cancel = {
        names = {"Cancel", "Shoot"},
        allow_repeat = true
    }
}
```

| Field | Type | Default | Description |
|---|---|---:|---|
| `names` | `table` | — | Array of raw button strings. |
| `allow_repeat` | `boolean` | `false` | Allows `"button_repeat"` events while the action is held. |

---

# 📡 Event Handling

## `:on(event, callback)`

**Signature**

```text
function(event: string, callback: function)
```

Registers a callback for one of the supported events.

### Supported Events

| Event | Emitted when |
|---|---|
| `button_pressed` | An action or direction becomes pressed. |
| `button_released` | An action or direction is released. |
| `button_repeat` | A repeatable action repeats, or a direction repeats. |

### Event Payload

```lua
{
    player_id = number,
    action = string,
    state = number
}
```

| `state` | Meaning |
|---:|---|
| `1` | **Pressed** |
| `3` | **Released** |
| `4` | **Repeat / Scroll** |

> ⚠️ **Important:** Events are emitted only while the input is **not
> swallowed**.

---

# ⚙️ Input Processing

## `:handle_raw_input(events)`

**Signature**

```text
function(events: table)
```

Accepts raw input events and updates the controller's internal state.

### Accepted Event Formats

**Array format**

```lua
{
    { name = "A", state = 1 },
    { name = "Move Up", state = 2 }
}
```

**Map format**

```lua
{
    A = 1,
    ["Move Up"] = 2
}
```

### Supported Input States

| Numeric | String | Meaning |
|---:|---|---|
| `1` | `"pressed"` | Button was pressed. |
| `2` | `"held"` | Button remains held. |
| `3` | `"released"` | Button was released. |
| `4` | `"scroll"` | Repeat / scroll event. |

String states are matched **case-insensitively**.

### Processing Steps

1. **Normalise** incoming state values.
2. Update `raw_states`.
3. Update logical states.
4. Trigger logical press/release edges.
5. Trigger repeats when state `4` or `"scroll"` is received.

---

## `:tick(delta_time)`

**Signature**

```text
function(delta_time: number)
```

Must be called every frame with the time step in seconds.

### Responsibilities

- Advances the internal timer.
- Automatically releases non-direction buttons after `NON_DIR_UP_TIMEOUT` (`0.06s`) when no update is received.
- Updates the current direction.
- Processes hold repeats for repeatable actions.
- Clamps `delta_time` to `MAX_TICK_DT` (`0.25s`) to prevent large timing jumps.

---

# 🔍 State Queries

All query methods are **non-destructive** unless explicitly marked as
consuming an edge flag.

## Query Reference

| Method | Consumes flag? | Purpose |
|---|:---:|---|
| `:is_action_down(action)` | ❌ | Returns whether the action is currently held. |
| `:peek_action_pressed(action)` | ❌ | Checks for a press this tick. |
| `:peek_action_released(action)` | ❌ | Checks for a release this tick. |
| `:peek_action_repeated(action)` | ❌ | Checks for a repeat this tick. |
| `:is_action_pressed(action)` | ✅ | Checks **and consumes** the press flag. |
| `:is_action_released(action)` | ✅ | Checks **and consumes** the release flag. |
| `:is_action_repeated(action)` | ✅ | Checks **and consumes** the repeat flag. |
| `:get_active_direction()` | ❌ | Returns the currently active direction. |

---

## `:is_action_down(action)`

**Signature**

```text
function(action: string) -> boolean
```

Returns `true` when the logical action is currently held down.

---

## `:peek_action_pressed(action)`

**Signature**

```text
function(action: string) -> boolean
```

Returns `true` when the action was pressed during the current tick without
consuming the pressed flag.

Also respects:

- **release-required state**
- **swallowing**

---

## `:peek_action_released(action)`

**Signature**

```text
function(action: string) -> boolean
```

Returns `true` when the action was released during the current tick without
consuming the released flag.

Also respects **swallowing**.

---

## `:peek_action_repeated(action)`

**Signature**

```text
function(action: string) -> boolean
```

Returns `true` when the action repeated during the current tick without
consuming the repeat flag.

Also respects:

- **release-required state**
- **swallowing**

---

## `:is_action_pressed(action)`

**Signature**

```text
function(action: string) -> boolean
```

Same as `:peek_action_pressed()`, but **consumes the pressed flag**.

> **Recommended use:** polling loops that need to detect a single press event.

---

## `:is_action_released(action)`

**Signature**

```text
function(action: string) -> boolean
```

Same as `:peek_action_released()`, but **consumes the released flag**.

---

## `:is_action_repeated(action)`

**Signature**

```text
function(action: string) -> boolean
```

Same as `:peek_action_repeated()`, but **consumes the repeat flag**.

---

## `:get_active_direction()`

**Signature**

```text
function() -> string|nil
```

Returns the current active direction, such as:

```text
"Up"
"DownLeft"
"UpRight"
```

Returns `nil` when no direction is pressed.

---

# 🧹 Consuming & Swallowing

## `:require_release(actions)`

**Signature**

```text
function(actions: string|table)
```

Marks one or more actions as **release-required**.

While a release-required action remains held:

- New press events are ignored.
- The action must be fully released before it can trigger again.
- Pending pressed and repeat flags are cleared when the guard is applied.

### Single Action

```lua
ctrl:require_release("Confirm")
```

### Multiple Actions

```lua
ctrl:require_release({
    "Confirm",
    "Cancel"
})
```

> **Common use case:** UI buttons that must not retrigger during the same
> physical press.

---

## `:swallow(seconds)`

**Signature**

```text
function(seconds: number)
```

Temporarily suppresses **all edge events** for the specified duration.

Suppressed edges include:

- pressed
- released
- repeat

The swallow timer is **additive**, so subsequent calls extend the duration.

> **Common use case:** UI transitions, menu changes, and input handoffs.

---

## `:consume()`

**Signature**

```text
function()
```

Clears all pending:

- pressed flags
- released flags
- repeat flags

Does so **without emitting events**.

The method is called automatically after swallowing, but can also be invoked
manually.

---

## `:destroy()`

**Signature**

```text
function()
```

Cleans up the controller:

1. Consumes pending events.
2. Resets the DPad state for the player.
3. Releases controller resources.

---

# 🧰 Utilities

No additional public utilities are provided beyond the methods documented
above.

---

# 🕹️ DPad Module

The DPad module is returned by:

```lua
require("scripts/input-controller/d-pad")
```

It provides direction definitions, diagonal combinations, and stateful
direction detection.

## `DPad.Directions`

Maps direction names to arrays of raw button names.

```lua
{
    Left  = {"Move Left", "UI Left"},
    Right = {"Move Right", "UI Right"},
    Up    = {"Move Up", "UI Up"},
    Down  = {"Move Down", "UI Down"},
}
```

### Cardinal Directions

| Direction | Raw Button Names |
|---|---|
| `Left` | `"Move Left"`, `"UI Left"` |
| `Right` | `"Move Right"`, `"UI Right"` |
| `Up` | `"Move Up"`, `"UI Up"` |
| `Down` | `"Move Down"`, `"UI Down"` |

---

## `DPad.ComboDirections`

Defines diagonal combinations as sets of direction names.

```lua
{
    DownLeft  = {"Down", "Left"},
    UpLeft    = {"Up", "Left"},
    UpRight   = {"Up", "Right"},
    DownRight = {"Down", "Right"}
}
```

| Diagonal | Required directions |
|---|---|
| `DownLeft` | `Down` + `Left` |
| `UpLeft` | `Up` + `Left` |
| `UpRight` | `Up` + `Right` |
| `DownRight` | `Down` + `Right` |

---

## `DPad.getActiveDirectionWithMemory(pressedButtons, player_id)`

**Signature**

```text
function(
    pressedButtons: table,
    player_id: number
) -> string|nil
```

### Parameters

| Parameter | Description |
|---|---|
| `pressedButtons` | Array of `{ name = string }` entries for raw buttons currently pressed. |
| `player_id` | Player identifier used to maintain per-player direction memory. |

Returns a direction name from `Directions` or `ComboDirections`.

### 🧠 Stateful Direction Memory

The method uses hysteresis to reduce direction flicker:

- Remembers the **last active combo**.
- Holds that combo as long as at least **two** constituent directions remain
  pressed.

---

## `DPad.getActiveDirection(pressedButtons, player_id)`

Alias for:

```lua
DPad.getActiveDirectionWithMemory(pressedButtons, player_id)
```

---

## `DPad.resetPlayerState(player_id)`

**Signature**

```text
function(player_id: number|nil)
```

Clears remembered direction state.

| Call | Effect |
|---|---|
| `DPad.resetPlayerState(player_id)` | Reset one player's state. |
| `DPad.resetPlayerState()` | Reset all players. |

---

## `DPad.getAllDirectionRawNames()`

**Signature**

```text
function() -> table
```

Returns a set-like table whose keys are all raw button names used by any
direction.

Useful when creating an `InputController`:

```lua
local direction_raw_names = DPad.getAllDirectionRawNames()
```

---

# 🔘 Buttons Table

The `Buttons` table from `buttons.lua` contains the default mapping from
logical action names to raw button-name lists.

By default, `main.lua` builds controller mappings with:

```lua
allow_repeat = false
```

for all actions.

## Custom Actions

You can override or add mappings **before creating controllers**:

```lua
local API = require("scripts/input-controller/main")

API.buttons.MyCustomAction = {
    "Custom",
    "X"
}
```

---

# 📨 Event Payloads

All events emitted by `InputController` use a payload with the following
fields:

| Field | Type | Description |
|---|---|---|
| `player_id` | `number` | Player associated with the input. |
| `action` | `string` | Logical action or direction name. |
| `state` | `number` | `1` = pressed, `3` = released, `4` = repeat. |

## Example Listener

```lua
ctrl:on("button_pressed", function(payload)
    print("Player " .. payload.player_id .. " pressed " .. payload.action)
end)
```

---

# 🎯 Direction Handling & Combos

Directions are **not treated as normal actions**. They are managed separately
through the DPad module.

The `InputController` automatically:

1. Maps raw direction buttons to direction names.
2. Uses `DPad.getActiveDirectionWithMemory()` to calculate the current
   direction.
3. Emits pressed and released events when the active direction changes.
4. Processes direction repeats through `_process_holds`.
5. Exposes the current direction through `:get_active_direction()`.
6. Allows direction polling with `:is_action_down("Left")` and similar queries.

## 🔁 Repeat Behavior

Directions always repeat. They have `allow_repeat` enabled implicitly, and
their hold repeats are processed by `_process_holds`.

---

# 🛡️ Release-Required & Swallowing

## Release-Required Behavior

A release-required action cannot be pressed again while it remains held.

### Typical Flow

```text
Press action
    ↓
Handle action
    ↓
Mark action as release-required
    ↓
Ignore additional presses while held
    ↓
Physical release
    ↓
Action may trigger again
```

> **Purpose:** Prevent accidental double-triggers for UI confirm/cancel
> actions.

---

## Swallowing Behavior

Swallowing temporarily discards new edge events.

This is useful when opening or closing UI overlays, changing menus, or otherwise
handing input from one interface to another.

For example, swallowing input for `0.1` seconds prevents stray presses that
occur during the transition from reaching the newly opened UI.

### Typical Flow

```text
Begin UI transition
    ↓
Swallow input briefly
    ↓
Ignore pressed/released/repeat edges
    ↓
Swallow expires
    ↓
Normal input processing resumes
```

---

# 🧪 Example Usage

## Basic Setup

`main.lua` already hooks into the relevant network events, so the only required
setup is to require the API:

```lua
local InputAPI = require("scripts/input-controller/main")
```

---

## Polling for Input in a Game Loop

```lua
local function update_player(player_id)
    local ctrl = InputAPI.get_controller(player_id)
    if not ctrl then
        return
    end

    if ctrl:is_action_pressed("Confirm") then
        -- fire confirm action
    end

    if ctrl:is_action_released("Cancel") then
        -- handle cancel release
    end

    local dir = ctrl:get_active_direction()

    if dir == "Up" then
        -- move up
    elseif dir == "UpRight" then
        -- move up-right
    end
end
```

---

## Using Events

```lua
local ctrl = InputAPI.create_controller(123)

ctrl:on("button_pressed", function(payload)
    if payload.action == "Start" then
        -- toggle pause
    end
end)
```

---

## Swallowing During a Menu Transition

```lua
function open_menu(player_id)
    local ctrl = InputAPI.get_controller(player_id)

    if ctrl then
        ctrl:swallow(0.15) -- ignore inputs for 150ms
    end
end
```

---

## Requiring a Release Before Re-Press

```lua
function handle_ui_button(player_id)
    local ctrl = InputAPI.get_controller(player_id)

    if ctrl:is_action_pressed("Confirm") then
        -- do something
        ctrl:require_release("Confirm")
    end
end
```

---

# 📝 Notes & Internals

## ⏱️ Timing Constants

| Constant | Value | Purpose |
|---|---:|---|
| `NON_DIR_UP_TIMEOUT` | `0.06s` | Automatically releases non-direction buttons that stop receiving updates. |
| `FIRST_REPEAT_DELAY` | `0.30s` | Delay before the first hold repeat. |
| `REPEAT_DELAY` | `0.10s` | Interval between subsequent repeats. |
| `MAX_TICK_DT` | `0.25s` | Maximum `delta_time` processed per tick. |

---

## Timeout Handling

Non-direction raw buttons that remain marked as held but are not updated are
automatically released after `NON_DIR_UP_TIMEOUT` (`0.06s`).

> **Why:** Prevents keys from becoming stuck when update events are missed.

---

## Repeat Timing

```text
Initial press
     │
     ▼
  0.30s
     │
     ▼
First repeat
     │
     ▼
Every 0.10s
     │
     ▼
Subsequent repeats
```

---

## Tick Clamping

`delta_time` is clamped to `MAX_TICK_DT` (`0.25s`) to prevent large repeat
bursts after a long frame.

---

## Raw State Normalisation

`handle_raw_input()` accepts multiple input-state formats and normalises them
internally, allowing callers to send either numeric states or string labels.

---

## Memory Management

The controller maintains state **per player**.

To avoid retaining player-specific state after disconnecting, call:

```lua
ctrl:destroy()
```

or:

```lua
InputAPI.destroy_controller(player_id)
```

when a player disconnects.

---