# `displayer/timer-system.lua`

> **Source reference**
>
> Refreshed from the current `displayer/timer-system.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Timer System with Global and Player-specific Timers

## Module location

- **Source:** `displayer/timer-system.lua`
- **Reference:** `script-reference/displayer/timer-system.lua.md`
- **Source SHA-256 prefix:** `4f27a428ded6`

## Source header notes

- Timer System with Global and Player-specific Timers

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `tick` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Timer:init` | `` |
| `Timer:handlePlayerJoin` | `player_id` |
| `Timer:handlePlayerLeave` | `player_id` |
| `Timer:updateTimers` | `delta` |
| `Timer:emitToAllPlayers` | `event_name, data` |
| `Timer:pausePlayerTimer` | `player_id, timer_id` |
| `Timer:resumePlayerTimer` | `player_id, timer_id` |
| `Timer:pausePlayerCountdown` | `player_id, countdown_id` |
| `Timer:resumePlayerCountdown` | `player_id, countdown_id` |
| `Timer:removePlayerTimer` | `player_id, timer_id` |
| `Timer:removePlayerCountdown` | `player_id, countdown_id` |
| `Timer:createGlobalTimer` | `timer_id, duration, callback, loop` |
| `Timer:createGlobalCountdown` | `countdown_id, duration, callback, loop` |
| `Timer:pauseGlobalTimer` | `timer_id` |
| `Timer:resumeGlobalTimer` | `timer_id` |
| `Timer:pauseGlobalCountdown` | `countdown_id` |
| `Timer:resumeGlobalCountdown` | `countdown_id` |
| `Timer:removeGlobalTimer` | `timer_id` |
| `Timer:removeGlobalCountdown` | `countdown_id` |
| `Timer:getGlobalTimer` | `timer_id` |
| `Timer:getGlobalCountdown` | `countdown_id` |
| `Timer:syncGlobalTimers` | `player_id` |
| `Timer:createPlayerTimer` | `player_id, timer_id, duration, callback, loop` |
| `Timer:createPlayerCountdown` | `player_id, countdown_id, duration, callback, loop` |
| `Timer:getAllGlobalTimers` | `` |
| `Timer:getAllGlobalCountdowns` | `` |
| `Timer:clearAllGlobalTimers` | `` |
| `Timer:clearAllGlobalCountdowns` | `` |
| `Timer:getPlayerTimer` | `player_id, timer_id` |
| `Timer:getPlayerCountdown` | `player_id, countdown_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `emit`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
