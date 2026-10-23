# `displayer/timer-system.lua`

> **Source reference**
>
> Generated from `displayer/timer-system.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Timer System with Global and Player-specific Timers

## Module location

- **Source:** `displayer/timer-system.lua`
- **Relative reference:** `script-reference/displayer/timer-system.lua.md`

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Timer:clearAllGlobalCountdowns` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:clearAllGlobalTimers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:createGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:createGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:createPlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:createPlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:emitToAllPlayers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:getAllGlobalCountdowns` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:getAllGlobalTimers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:getGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:getGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:getPlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:getPlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:handlePlayerJoin` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:handlePlayerLeave` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:init` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:pauseGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:pauseGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:pausePlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:pausePlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:removeGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:removeGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:removePlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:removePlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:resumeGlobalCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:resumeGlobalTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:resumePlayerCountdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:resumePlayerTimer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:syncGlobalTimers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Timer:updateTimers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 486 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
