# `ezlibs-custom/runner-encounters/main.lua`

> **Source reference**
>
> Generated from `scripts/ezlibs-custom/runner-encounters/main.lua` in the supplied server archive. This is a source-based reference, not a claim of live runtime testing.

## Purpose

Implements a transfer-driven endless runner as a custom ezlibs module. A private runner instance contains a visible controlled avatar proxy that follows Tiled waypoints. Proxy entry into radius/rectangle triggers starts an encounter for the real player, using a private encounter instance. When battle exit completes, the player returns to the proxy's latest position and a replacement proxy resumes the route.

## Dependencies

| Module | Purpose |
|---|---|
| `scripts/ezlibs-scripts/ezlogger` | Runner diagnostics. |
| `scripts/ezlibs-scripts/ezmapinstance` | Create/remove private runner and encounter instances. |
| `scripts/ezlibs-scripts/eztriggers/ezbottriggers` | Detect proxy overlap with encounter objects. |
| `scripts/ezlibs-scripts/ezencounters/main` | Named/path-based encounter lifecycle and events. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Controlled proxy bot and waypoint movement. |
| `scripts/ezlibs-scripts/avatar_utils/main` | Player avatar path resolution and refresh. |

## Tiled object types

- `Runner Spawn Point`: point object; optional `Runner Point Type`; `Runner First Waypoint` references the route start.
- `Waypoint`: uses the existing eznpcs waypoint properties, including `Next Waypoint 1` links.
- `Runner Radius Encounter`: point trigger with `Radius`, optional `Name`, `Path`, and `Instance Map`.
- `Runner Rectangle Encounter`: rectangle trigger with optional `Name`, `Path`, and `Instance Map`.
- `Runner Return Point`: legacy type; current return position is read from the proxy's live position.

`Name` takes precedence when both `Name` and `Path` are supplied. If `Name` is absent, `Path` is passed through `ezencounters.begin_encounter`. A trigger without either is not registered.

## Runtime responsibilities

- Handle entry into the base runner map after a Custom Warp; no entrance NPC is required.
- Prepare the player's avatar assets and create a private runner map using `ezmapinstance`.
- Transfer the real player off-map while the visible proxy follows the route.
- Register bot triggers in the actual private runner instance ID.
- Create a private encounter clone when the proxy enters a trigger and transfer the real player into it.
- Start named encounters through `ezencounters.begin_encounter_by_name` and path-based encounters through `ezencounters.begin_encounter`.
- Retain battle results, wait for battle exit, return the player to the proxy position, resume the route, and clean up temporary instances.

## Important identifiers

The base area ID identifies reusable map configuration; a private instance ID identifies a live clone. The base map's encounter configuration should not be duplicated for generated instance IDs. Use the actual instance ID for runtime transfers, bot positions, trigger registration, and cleanup.

## Related documentation

- [Runner Encounters README](../../../../ezlibs-custom/runner-encounters/README.md)
- [ezlibs Custom](../../../ezlibs-custom.md)
- [Documentation index](../../../index.md)
