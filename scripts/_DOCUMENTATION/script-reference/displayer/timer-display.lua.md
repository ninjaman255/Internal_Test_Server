# `displayer/timer-display.lua`

> **Source reference**
>
> Generated from `displayer/timer-display.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/timer-display.lua`
- **Relative reference:** `script-reference/displayer/timer-display.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/font-system` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/timer-system` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `countdown_global_create` | `Net:on(...)` subscription found in source. |
| `countdown_global_remove` | `Net:on(...)` subscription found in source. |
| `countdown_global_update` | `Net:on(...)` subscription found in source. |
| `countdown_remove` | `Net:on(...)` subscription found in source. |
| `countdown_update` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `timer_global_create` | `Net:on(...)` subscription found in source. |
| `timer_global_remove` | `Net:on(...)` subscription found in source. |
| `timer_global_update` | `Net:on(...)` subscription found in source. |
| `timer_remove` | `Net:on(...)` subscription found in source. |
| `timer_update` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `TimerDisplay:_createDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:_updateDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:createGlobalCountdownDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:createGlobalTimerDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:createPlayerCountdownDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:createPlayerTimerDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:removeDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:setDisplayPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:updateCountdownDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TimerDisplay:updateTimerDisplay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `dump` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 525 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
