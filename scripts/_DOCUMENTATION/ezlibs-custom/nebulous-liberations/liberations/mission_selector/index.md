# 📄 `mission_selector.lua` — Persistent Gold Prog API reference

[🏠 Documentation home](../../../../index.md) · [⬆ Liberation modules](../index.md) · [🟡 Integration and Tiled setup](../../GOLDEN_PROG_MISSIONS.md)

**Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/mission_selector.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/mission_selector.lua)

## Contents

- [Dependencies](#dependencies)
- [Functions](#functions)
- [Data and configuration](#data-and-configuration)
- [Event flow](#event-flow)

## Dependencies

| Module | Use |
|---|---|
| `eznpcs/eznpcs` | `EzNPCs.add_event` registration |
| `liberations/option_menu` | Existing 9-slice PlayerControl menu |
| `liberations/constants` | `Liberation Tileset` property name |
| `logger/logger` | `mission-selector` subsystem logs |

## Functions

| Function | Arguments | Result |
|---|---|---|
| `is_base_area(area_id)` | Runtime area ID | `true` unless it is a `liberation_` clone instance |
| `has_liberation_configuration(area_id)` | Runtime area ID | Checks `Liberation Config` / tileset and named `Spawn` |
| `Selector.available_missions()` | None | Sorted array of `{id,label,order}` for configured, loaded mission maps |
| `Selector.register(plugin)` | Nebulous Liberations plugin exposing `start_game_for_player` | Registers `Liberation Mission Selector` with eznpcs |

## Data and configuration

| Table | Fields | Purpose |
|---|---|---|
| `MENU_CONFIG` | `max_visible=5`, `centered=true`, `mugshot` | Centered 9-slice selector, five visible choices and cropped mug |
| `MENU_CONFIG.mugshot` | `texture_path`, `animation_path`, `anim_state`, `width`, `height`, `scale` | Gold Prog mug on the left of the menu |
| `KNOWN_MISSIONS` | Runtime ID/name → `{label,order}` | Friendly display names for six imported compatible missions |
| `missions` | Array `{id,label,order}` | Actual current `Net.list_areas()` results; never launch by display string |

## Event flow

When an NPC with `First Dialogue` targeting a Dialogue object of `Event Name = Liberation Mission Selector` is interacted with, eznpcs invokes the event. It discovers available base areas and opens the 9-slice menu. On successful confirmation, it verifies the player still exists in the original area and invokes `plugin.start_game_for_player(player_id, mission.id)`. Cancel and disconnect do not launch. The NPC object remains available for repeat use.
