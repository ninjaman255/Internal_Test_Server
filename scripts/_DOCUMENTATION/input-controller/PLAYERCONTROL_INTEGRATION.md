# 🎮 InputController and PlayerControl v2

[🏠 Documentation home](../index.md) · [🎮 PlayerControl API](../player-control/README.md)

`InputController` remains the per-player raw-to-logical input processor: sticky button states, action edges, held directions, repeat, input ownership, and release-required guards. `PlayerControl` owns **one logical claim per player** and directs its events to the active session rather than having nested screens repeatedly claim input.

The controller now exposes:

| Method | Purpose |
|---|---|
| `set_owned_repeat_delays(owner, first, repeat_delay)` | Apply timing only while caller owns input |
| `clear_owned_repeat_delays(owner)` | Revert to the prior timing only if caller still owns the timing policy |
| `get_default_repeat_delays()` | Obtain constructor-default repeat timings |

Input-specific event dispatch uses `EventEmitter:emit_safe`, which protects the rest of the listeners from a failing subscriber. The preexisting `emit` semantics remain unchanged elsewhere.

**Consumption:** A PlayerControl session uses either `session:poll()` or `session:on_pressed/on_repeat/on_released()` callbacks, not both. Input edges are guarded/consumed on actual focus changes, so opening a child screen while Confirm is held won't immediately choose its first option. On returning to the parent, held inputs must release before being handled.

**Important:** The engine input lock only blocks *default engine actions* such as movement; `virtual_input` continues to be delivered to this controller. Old direct raw `virtual_input` listeners outside PlayerControl still require a migration audit before exclusive logical dispatch can be guaranteed for every feature.
