# `displayer/timer-display.lua`

> **Source reference**
>
> Refreshed from the current `displayer/timer-display.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/timer-display.lua`
- **Reference:** `script-reference/displayer/timer-display.lua.md`
- **Source SHA-256 prefix:** `11e8d17e6252`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/font-system` |
| `scripts/displayer/timer-system` |

## `Net:on` subscriptions

| Event |
|---|
| `timer_update` |
| `countdown_update` |
| `timer_remove` |
| `countdown_remove` |
| `timer_global_update` |
| `countdown_global_update` |
| `timer_global_create` |
| `countdown_global_create` |
| `timer_global_remove` |
| `countdown_global_remove` |
| `player_join` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dump` | `o` |
| `TimerDisplay:init` | `` |
| `TimerDisplay:createPlayerTimerDisplay` | `player_id, display_id, x, y, options` |
| `TimerDisplay:createPlayerCountdownDisplay` | `player_id, display_id, x, y, options` |
| `TimerDisplay:createGlobalTimerDisplay` | `display_id, x, y, options` |
| `TimerDisplay:createGlobalCountdownDisplay` | `display_id, x, y, options` |
| `TimerDisplay:_createDisplay` | `player_id, display_id, x, y, type, options` |
| `TimerDisplay:updateTimerDisplay` | `player_id, display_id, seconds` |
| `TimerDisplay:updateCountdownDisplay` | `player_id, display_id, seconds` |
| `TimerDisplay:_updateDisplay` | `player_id, display_id, seconds, is_countdown` |
| `TimerDisplay:removeDisplay` | `player_id, display_id` |
| `TimerDisplay:setDisplayPosition` | `player_id, display_id, x, y` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
