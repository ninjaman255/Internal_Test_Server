# 🛠 PlayerControl v2 — Migration audit

[🏠 Home](../index.md) · [🎮 API guide](README.md) · [🔌 LegacyCapture](LEGACY_CAPTURE.md)

The v2 drop-in uses two patterns:

**Managed sessions:** `hp_manager`, its child editors, `jukebox`, `camera`, and now FootBomb. These systems use `PlayerControl.begin()` and scoped callbacks, capture, HUD or camera leases. FootBomb no longer polls to reclaim input each tick.

**Imperative compatibility:** Scripted gameplay systems whose behavior depends on existing locks now invoke `scripts/player-control/legacy-capture.lua` instead of direct engine input lock/unlock. These include Nebulous Liberations (`instance`, `player_session`, `loot`, `enemy`), Endless Runner, EZ warps and cutscenes, checkpoint/pushback/button/rushroad systems, NPC dialogue, net-games dialog/menu modules, Simon Says, tournament flow, and trains. Keyed leases keep independent capture owners from releasing each other's engine input.

## Still requiring full session or lease integration

| Area | Remaining boundary | Follow-up |
|---|---|---|
| Liberation scripted camera | Raw `Net` camera calls across asynchronous mission sequences | Move camera operations into a mission-scoped exclusive camera lease and guard late callbacks |
| Endless Runner and other scripted cinematics | Some direct camera operations remain | Obtain a camera lease when each sequence takes ownership |
| EZ cutscenes, NPC/warp transitions | Imperative capture adapter, not parent/child control scopes | Convert to scoped contexts after verifying native textbox/warp behavior |
| Raw `virtual_input` listeners | `events/eznpcs_onceitem.lua`, `net-games/main.lua`, `simon-says.lua` and engine-input test scripts | Route through existing InputController or explicitly gate by ownership |
| Tests using direct `Net.lock_player_input` | `test-runner/tests/demo.lua` intentionally exercises raw engine API | Keep isolated from normal gameplay sessions |
| Legacy repeated same-owner capture | `LegacyCapture.lock` is idempotent by feature key | Use separate keys for nested lifetimes or refactor to scoped sessions |

## Validation and hazards

* The code audit found no direct engine `Net.lock_player_input` or `Net.unlock_player_input` invocations in normal gameplay Lua outside the adapter and intentional test/demo boundary. The lower-level UISuppression wrapper invokes those APIs by name.
* `Net.toggle_player_hud` gameplay calls were moved to owned HUD capture where encountered.
* Engine-level input capture does **not** disable scripted `virtual_input`; it suppresses native movement, exactly as expected by menus and minigames.
* Exclusive camera ownership applies **only to participating callers**; legacy camera Net calls are not intercepted.
* Compatibility adapter owner keys are not nested counters. An early unlock inside the same feature still requires gameplay-level review.
* Existing input API signatures remain available to minimize regressions; new code should not directly claim focus or force InputController ownership when a managed session exists.

The full modified-file manifest in the installation ZIP is the authoritative list of changed modules for this patch.
