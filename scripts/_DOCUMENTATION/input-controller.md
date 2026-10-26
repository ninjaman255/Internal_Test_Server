# Input Controller — Current API and Usage

> **Scope and accuracy**
>
> Refreshed from `scripts/input-controller/` in the Library archive on 2026-10-25. This documents source-visible behavior; it does not imply a live runtime test.

## Module map

| File | Responsibility |
|---|---|
| `input-controller/main.lua` | Public API, per-player registry, singleton guard, and `Net` event handlers. |
| `input-controller/input-controller.lua` | Controller state, raw input mapping, edge/repeat behavior, ownership, consumption, and lifecycle. |
| `input-controller/buttons.lua` | Default action-to-raw-button mappings. |
| `input-controller/d-pad.lua` | Direction raw names and direction mapping helpers. |

## Initialization and registry

```lua
local InputAPI = require("scripts/input-controller/main")
local controller = InputAPI.get_controller(player_id)
if not controller then
    controller = InputAPI.create_controller(player_id)
end
```

`main.lua` installs handlers for `player_join`, `player_disconnect`, `virtual_input`, and `tick`. It uses a global singleton key (`__internal_test_server_input_controller_api_v1`) so evaluating the module again in the same Lua global environment reuses the existing API and avoids duplicate handler registration. A join event creates a controller only when one is not already registered. Disconnect destroys and removes the registered controller.

Prefer `get_controller` to access the shared per-player instance. Use `create_controller` when a caller needs an idempotent ensure/create operation. `spawn_controller` deliberately creates a controller without registering it; do not use it when the intention is to share ownership of the one registered controller.

## Public API in `main.lua`

| Function/property | Behavior visible in source |
|---|---|
| `get_controller(player_id)` | Returns the registered controller or nil. |
| `get_controller_identity(player_id)` | Returns a string representation of the registered table identity for diagnostics. |
| `create_controller(player_id, opts)` | Creates/registers only if absent; returns the shared controller. |
| `spawn_controller(player_id, opts)` | Builds an unregistered controller. |
| `reload_controller(player_id, opts)` | Creates if absent, otherwise reloads mappings without destroying/recreating the instance. |
| `set_repeat_delays(player_id, first_repeat_delay, repeat_delay)` | Changes repeat cadence when a controller exists. |
| `restore_repeat_delays(player_id)` | Restores that controller's saved/default cadence. |
| `activate_controller(player_id)` / `deactivate_controller(player_id)` | Activates or deactivates the registered controller. |
| `destroy_controller(player_id)` | Destroys and removes the registered controller. |
| `set_controller_class(class)` / `get_controller_class()` | Changes or reads the class used for newly constructed controllers. |
| `buttons`, `DPad`, `InputController` | Exposes the default mappings and implementation modules. |

`create_controller` accepts `auto_activate`, `button_mappings`, `direction_raw_names`, `first_repeat_delay`, and `repeat_delay` in `opts`; the options are passed into the controller constructor. `reload_controller` accepts replacement mapping tables. Verify the current constructor and controller methods in `input-controller.lua` before adding options.

## Ownership and input consumption

The controller supports named input owners. Use the same registered controller for every system sharing a player's input stream, claim ownership for the active interaction/game, consume only the inputs that system handles, and release that ownership during every exit path (normal completion, cancellation, disconnect, map transfer, and error cleanup). For example, FootBomb currently uses a namespaced owner such as `footbomb:<instance>:<player>` and requires release handling during cleanup.

Do not create an unrelated second controller to work around an ownership conflict. Two controller instances would receive the same raw input stream independently and can disagree about edges, repeats, or consumption. For debugging, compare `get_controller_identity(player_id)` across consumers and confirm they all refer to the same shared instance.

Consult `input-controller/input-controller.lua` for the exact method names and ownership/consumption semantics; do not infer additional behavior from the convenience wrappers alone.

## Integration notes

- `Net:on` callbacks in this code use a single argument named `event`.
- Raw input is forwarded from `event.events`; tick advancement uses `event.delta_time`.
- The public module uses the global engine `Net` event API. It does not define that engine API.
- `Async` is not involved in the controller's central event forwarding path.
- Per-script reference pages are available from [the script-reference index](script-reference/README.md).
