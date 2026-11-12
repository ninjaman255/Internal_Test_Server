# 🟡 Golden Prog — Persistent Liberation Mission Selector

[🏠 Documentation index](../../index.md) · [🌌 Nebulous Liberations](index.md) · [📜 Selector API](liberations/mission_selector/index.md)

## Contents

- [Overview](#overview)
- [Map configuration](#map-configuration)
- [Mission discovery](#mission-discovery)
- [Menu and input](#menu-and-input)
- [Assets and folders](#assets-and-folders)
- [Flow and testing](#flow-and-testing)

## Overview

A permanent, ordinary **eznpcs NPC** named `Golden Liberation Prog` stands near the **Home Warp** in `areas/default.tmx`. It is not a destructible Liberation Gate. Interacting with it runs the custom eznpcs dialogue event `Liberation Mission Selector` from `mission_selector.lua`, and displays the existing Nebulous Liberations **9-slice** header/body menu.

The menu includes a **Gold Prog mugshot to the left**, centers the combined UI group on the 480×320 Displayer screen, and displays at most **five choices at once**. Both 9-slice panels size to the longest single-line option (including the `> ` cursor, padding, and header/counter), not a fixed 220px width. All choices, even currently hidden scroll rows, are measured up front so the menu does not change width as it scrolls. Unusually long text is scaled down to fit beside the mugshot rather than wrapped. Up/Down (including upward/downward diagonals) scroll through the full list (including Cancel); holding a direction uses controller repeat. Navigation consumes all transitional directional edges in one tick, avoiding double steps. Confirm selects the currently highlighted row, and Cancel closes directly. The existing lower-right Liberation interactions retain their original behavior.

## Map configuration

`areas/default.tmx` contains two new objects in `Object Layer 0`:

| ID | Type | Name | Position (Tiled object coordinates) | Properties |
|---|---|---|---|---|
| **216** | `NPC` | `Golden Liberation Prog` | **(744, 736)** | `Asset Name=prog-gold`, `Direction=Up Right`, `First Dialogue=217`, `Mug Animation Name=prog-gold`, `Dont Face Player=false` |
| **217** | `Dialogue` | `Golden Prog Mission Selection` | **(720, 736)** | `Dialogue Type=none`, `Event Name=Liberation Mission Selector` |

The existing Home Warp is object **45** at **(786, 690)**; its properties and every existing map object/tileset GID are unchanged. The next object ID is now **218**.

**To move the Prog:** reposition object 216 in Tiled. Do not change `First Dialogue=217`, the `Event Name`, or these objects' IDs without updating the references.

**If the server has a newer customized default map:** merge objects 216 and 217 instead of overwriting that map. Assign new IDs if those numbers are already occupied, and update `First Dialogue` accordingly.

## Mission discovery

`Selector.available_missions()` scans `Net.list_areas()` and includes a base area only if it has:

1. A `Liberation Config` object with a nonempty `Liberation Tileset` custom property.
2. A `Spawn Point` object named exactly `Spawn` (the source used by `Mission:get_spawn_position()`).
3. A runtime ID that does not start with `liberation_` (instance clones are excluded).

The display order gives priority to the six currently compatible imported maps, then sorts newly discovered compatible maps alphabetically. **The mission ID passed to the launcher comes from `Net.list_areas()`, never from the display label.** As compatible areas are added, they appear automatically.

| Display choice | Base TMX file | Status in extracted source |
|---|---|---|
| Easy Liberation | `LiberationEasyMode.tmx` | Compatible |
| Normal Liberation | `LiberationNormalMode.tmx` | Compatible |
| Hard Liberation | `LiberationHardMode.tmx` | Compatible |
| Beta Liberation | `NewLiberation1.tmx` | Compatible |
| Debug Liberation | `DEBUGLIB.tmx` | Compatible |
| Practice Liberation | `testlib.tmx` | Compatible |

Three legacy Cyan maps (`testground.tmx`, `liberation1.tmx`, `example liberation friendly.tmx`) have a named Spawn but no `Liberation Config`; **the current `Mission:new` rejects them**, so this menu deliberately does not offer them until those maps are migrated.

If none are available, the panel displays **No missions available** and Cancel; no mission launches.

## Menu and input

The menu is implemented by `OptionMenu.select(player_id, labels, "Liberations", { max_visible=5, centered=true, mugshot={...} })`.

The existing `PlayerControl.begin(... profile="menu")` session continues to own virtual input, engine movement lock, and cleanup. The eznpcs dialogue's separate named capture remains scoped to the conversation. On completion or disconnect, both 9-slice panels and the mugshot sprite are erased, and the session is closed. Input release guards remain active to prevent selecting the first row accidentally. The input handler does not impose an additional indefinite neutral-direction gate after those guards. It reads the two return values from `PlayerControl.Session:input()` without a Lua logical operator, so the InputController ownership token is never lost.

The menu's promise result is **zero-based**. If the chosen result is in `[0, mission_count - 1]`, the event calls `LibPlugin.start_game_for_player(player_id, missions[result+1].id)`, preserving party behavior. No gate object is changed, deleted, or disabled.

### API

```lua
local Selector = require("scripts/ezlibs-custom/nebulous-liberations/liberations/mission_selector")
Selector.register(LibPlugin)   -- executed by main.lua during startup
local available = Selector.available_missions()
```

Each `available` entry is `{ id = area_id, label = string, order = number }`. Avoid registering the same event twice. No new Net APIs are required.

## Assets and folders

| Path | Role |
|---|---|
| `assets/ezlibs-assets/eznpcs/sheet/prog-gold.png` | Golden Prog overworld sprite |
| `assets/ezlibs-assets/eznpcs/sheet/prog-gold.animation` | Overworld animations |
| `assets/ezlibs-assets/eznpcs/mug/prog-gold.png` | 3-frame Gold Prog mugshot |
| `assets/ezlibs-assets/eznpcs/mug/prog-gold.animation` | Explicit `IDLE` and `TALK` animation states cropping mugshot frames |
| `assets/ezlibs-custom/nebulous-liberations/ui/options-header.png/.animation` | Original Liberation 9-slice header |
| `assets/ezlibs-custom/nebulous-liberations/ui/options-body.png/.animation` | Original Liberation 9-slice body |

Gold Prog and the menu are provisioned through existing eznpcs/Net/Displayer APIs. Menu asset paths follow the canonical `/server/assets/...` convention.

## Flow and testing

1. Confirm all six compatible mission maps from the organized Cyan drop-in are installed and loaded by the server.
2. Open `default`, locate the Golden Prog near Home Warp, and interact with it.
3. Verify the mug is cropped to **one 40×48 frame** and shown beside the centered 9-slice menu.
4. Verify every choice stays on one line with room for its selection cursor. Scroll through more than five options and check the panel width stays fixed; verify selection and Cancel work without moving the player.
5. Launch a mission; verify a new Liberation instance is created and party members transfer using the existing mission launcher.
6. Return to `default` and confirm the **same Prog remains** ready to open the menu again.
7. Leave while the menu is open, if possible, and check the mug and menu UI are removed.

Offline tests cover mission filtering, party-launch call, five-row scroll, selection indices, mugshot cleanup, and legacy menu layout. Live ONB client rendering and transfers must be verified in-game.
