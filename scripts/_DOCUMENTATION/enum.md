# enum — Complete Documentation

> **Documentation scope and accuracy**
>
> This reference describes the Lua 5.2 modules included in `enum.zip`. API behavior is based on the included source files. The core enum operations have no external runtime dependency.

## 🗂️ Table of Contents

- [🧭 Part 1 — Overview and Module Map](#part-1)
- [🧭 Part 2 — Enum API](#part-2)
- [🧭 Part 3 — EnumSet API](#part-3)
- [🧭 Part 4 — Predefined Enums and Examples](#part-4)
- [🧭 Part 5 — Integration Notes](#part-5)

---

<a id="part-1"></a>
## 🧭 Part 1 — Overview and Module Map

The `enum` library provides enum-like tables with key/value lookup, active-value tracking, copying, and a set container that returns independent enum copies.

```text
scripts/enum/
  enum.lua              # Enum constructor and value/name lookup
  enumset.lua           # Named collection of enums; access returns a copy
  predefined-enums.lua  # Example reusable enum definitions
  main.lua              # Demonstration of Enum and EnumSet usage
```

<a id="part-2"></a>
## 🧭 Part 2 — Enum API

### `Enum.new(...)`

Create an enum using one of three input forms:

```lua
local Enum = require("scripts/enum/enum")
local Color = Enum.new("RED", "GREEN", "BLUE")
local Status = Enum.new({ ACTIVE = "active", INACTIVE = "inactive" })
local Mode = Enum.new({ options = { MiniMap = "minimap", Player = "player" }, active = "minimap" })
```

- A list of string arguments maps each name to its 1-based position.
- A key/value table uses the supplied values.
- An options table may include `active` to choose the initial active value; absent an explicit active value, the implementation selects the first option.
- The implementation maintains key-to-value and value-to-key mappings and preserves option order.
- Invalid or duplicate definitions are checked by assertions in the constructor.

The enum supports active-value tracking, conversion between names and values, and copying. Consult `enum.lua` for exact method names and validation behavior in the version being integrated.

<a id="part-3"></a>
## 🧭 Part 3 — EnumSet API

`EnumSet.new(definitions)` accepts a table mapping string names to enum objects. Every value must be an enum with a `copy` method.

```lua
local Enum = require("scripts/enum/enum")
local EnumSet = require("scripts/enum/enumset")
local set = EnumSet.new({ Color = Enum.new({ RED = "red", BLUE = "blue" }) })
local color = set.Color                 -- fresh copy
local names = set:keys()                -- sorted key list
local original = set:getOriginal("Color") -- shared original; use carefully
```

- `set:get(name)` returns a copy or `nil` when the name is unknown.
- `set[name]` uses the same copy-on-access behavior.
- `set:keys()` returns available names in sorted order.
- `set:getOriginal(name)` returns the stored original without copying; mutating it can affect future copies.

<a id="part-4"></a>
## 🧭 Part 4 — Predefined Enums and Examples

`predefined-enums.lua` demonstrates reusable definitions for `CameraMode`, `Status`, `LogLevel`, and `DefaultPlayerAnimNames`. `main.lua` is a demo entry point showing how to create an `EnumSet`, retrieve independent copies, change active values, and list keys; it is not required as a runtime initializer.

<a id="part-5"></a>
## 🧭 Part 5 — Integration Notes

- Require modules through the expected paths, such as `scripts/enum/enum` and `scripts/enum/enumset`.
- The core modules use Lua tables, metatables, and standard Lua features; they do not call server-specific `Net` or `Async` APIs.
- Ordinary `EnumSet` access returns copies, so edits do not change stored definitions. `getOriginal` is the explicit exception.
- Adapt the included example definitions to the consuming application's domain.

---

## Current archive coverage (2026-10-25)

This documentation bundle was refreshed against the current `internal_test_server.zip` Library snapshot on 2026-10-25. For exact per-file imports, event subscriptions, function declarations, and source location, use the linked [per-script reference library](script-reference/README.md). These references supplement rather than replace the subsystem explanations above.
