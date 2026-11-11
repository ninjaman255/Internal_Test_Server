# 📄 `constants.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/constants.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/constants.lua)  
> **Source lines:** 174  
> **SHA-256 (UTF-8):** `19ad37136d4502…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 10

## 🗂️ Contents

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

Centralised definitions for custom properties and constants used in liberations.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **10** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Constants` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `Constants.Defaults` — line 7

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `MaxOrderPoints` | numeric literal | `9` |

### 3. `Constants.CustomProperties` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `RespawnArea` | string literal | `"Respawn Area"` |
| `WaitingArea` | string literal | `"Waiting Area"` |
| `LiberationMapFileName` | string literal | `"Liberation Map File Name"` |
| `LiberationTileset` | string literal | `"Liberation Tileset"` |
| `MaxOrderPoints` | string literal | `"Max Order Points"` |
| `LiberationEncounters` | string literal | `"Liberation Encounters"` |
| `TargetPhaseCount` | string literal | `"Target Phase Count"` |
| `TargetPlayerCount` | string literal | `"Target Player Count"` |
| `MinimumTargetPhaseCount` | string literal | `"Minimum Target Phase Count"` |
| `BackgroundTexture` | string literal | `"Background Texture"` |
| `BackgroundAnimation` | string literal | `"Background Animation"` |
| `BackgroundVelX` | string literal | `"Background Vel X"` |
| `BackgroundVelY` | string literal | `"Background Vel Y"` |
| `Song` | string literal | `"Song"` |
| `VictoryLapSong` | string literal | `"Victory Lap Song"` |
| `EncounterMusic` | string literal | `"Encounter Music"` |
| `MusicPath` | string literal | `"Path"` |
| `MusicLoopStart` | string literal | `"Loop Start"` |
| `MusicLoopEnd` | string literal | `"Loop End"` |
| `HonorHPMem` | string literal | `"Honor HPMem"` |
| `Compress` | string literal | `"Compress"` |
| `Decompress` | string literal | `"Decompress"` |
| `Boss` | string literal | `"Boss"` |
| `BossID` | string literal | `"Boss ID"` |
| `BossID1` | string literal | `"Boss ID 1"` |
| `BossID2` | string literal | `"Boss ID 2"` |
| `Type` | string literal | `"Type"` |
| `SpawnMode` | string literal | `"Spawn Mode"` |
| `TriggerBoss` | string literal | `"Trigger Boss"` |
| `SpawnOffsetX` | string literal | `"Spawn Offset X"` |
| `SpawnOffsetY` | string literal | `"Spawn Offset Y"` |
| `SpawnOffsetZ` | string literal | `"Spawn Offset Z"` |
| `AutoFacePlayer` | string literal | `"Auto Face Player"` |
| `BossHealthOverride` | string literal | `"Boss Health Override"` |
| `OWBotEncounter` | string literal | `"OW Bot Encounter"` |
| `OWEncounterPool` | string literal | `"OW Encounter Pool"` |
| `EncounterMode` | string literal | `"Encounter Mode"` |
| `EncounterCategory` | string literal | `"Encounter Category"` |
| `EnemyConfig` | string literal | `"Enemy Config"` |
| `MaxHP` | string literal | `"Max HP"` |
| `StartingHP` | string literal | `"Starting HP"` |
| `OWScale` | string literal | `"OW Scale"` |
| `BattleScale` | string literal | `"Battle Scale"` |
| `LegacyBossEncounter` | string literal | `"Boss Encounter"` |
| `DarkHoleLiberationEncounters` | string literal | `"Liberation Encounters"` |
| `MinionHealthOverride` | string literal | `"Minion Health Override"` |
| `Scale` | string literal | `"scale"` |
| `SpawnEnabled` | string literal | `"Spawn Enabled"` |
| `BossDisplayName` | string literal | `"Boss Display Name"` |
| `Shared` | string literal | `"Shared"` |
| `Spawns` | string literal | `"Spawns"` |
| `Direction` | string literal | `"Direction"` |
| `GateKey` | string literal | `"Gate Key"` |
| `GateID` | string literal | `"Gate ID"` |
| `isBoss` | string literal | `"isBoss"` |
| `Message` | string literal | `"Message"` |
| `EncounterPath` | string literal | `"Encounter Path"` |
| `SpecificLoot` | string literal | `"Specific Loot"` |
| `DamageTrap` | string literal | `"Damage Trap"` |
| `StunTrap` | string literal | `"Stun Trap"` |
| `TrapMessage` | string literal | `"Trap Message"` |
| `DamageDealt` | string literal | `"Damage Dealt"` |
| `Money` | string literal | `"Money"` |
| `NextSpawn` | string literal | `"Next Spawn"` |
| `FacingDirection` | string literal | `"Facing Direction"` |
| `GateToRemove` | string literal | `"Gate To Remove"` |
| `LiberationMapName` | string literal | `"Liberation Map Name"` |

### 4. `Constants.PanelTypes` — line 83

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `DarkPanel` | string literal | `"Dark Panel"` |
| `DarkHole` | string literal | `"Dark Hole"` |
| `DarkHoleBuffedVirus` | string literal | `"Dark Hole Buffed Virus"` |
| `IndestructiblePanel` | string literal | `"Indestructible Panel"` |
| `ItemPanel` | string literal | `"Item Panel"` |
| `PanelGate` | string literal | `"Panel Gate"` |
| `BonusPanel` | string literal | `"Bonus Panel"` |
| `TrapPanel` | string literal | `"Trap Panel"` |

### 5. `Constants.LiberatablePanelTypes` — line 95

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Constants.PanelTypes.DarkPanel` |
| `[2]` | expression/reference | `Constants.PanelTypes.ItemPanel` |
| `[3]` | expression/reference | `Constants.PanelTypes.DarkHole` |
| `[4]` | expression/reference | `Constants.PanelTypes.BonusPanel` |
| `[5]` | expression/reference | `Constants.PanelTypes.TrapPanel` |

### 6. `Constants.WalkablePanelTypes` — line 104

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Constants.PanelTypes.DarkPanel` |
| `[2]` | expression/reference | `Constants.PanelTypes.ItemPanel` |
| `[3]` | expression/reference | `Constants.PanelTypes.TrapPanel` |

### 7. `Constants.ShadowstepPanelTypes` — line 111

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Constants.PanelTypes.DarkPanel` |
| `[2]` | expression/reference | `Constants.PanelTypes.ItemPanel` |
| `[3]` | expression/reference | `Constants.PanelTypes.TrapPanel` |

### 8. `Constants.LootAnimations` — line 118

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `Heart` | string literal | `"HEART"` |
| `Chip` | string literal | `"CHIP"` |
| `Money` | string literal | `"MONEY"` |
| `BugFrag` | string literal | `"BUGFRAG"` |
| `OrderPoint` | string literal | `"ORDER_POINT"` |
| `Invincibility` | string literal | `"INVINCIBILITY"` |
| `MajorHit` | string literal | `"MAJOR_HIT"` |
| `Key` | string literal | `"KEY"` |

### 9. `Constants.AbilityIDs` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `LongSwrd` | string literal | `"LongSwrd"` |
| `WideSwrd` | string literal | `"WideSwrd"` |
| `OldSaber` | string literal | `"OldSaber"` |
| `HevyShld` | string literal | `"HevyShld"` |
| `HexScyth` | string literal | `"HexScyth"` |
| `NumGadgt` | string literal | `"NumGadgt"` |
| `GutsHamr` | string literal | `"GutsHamr"` |
| `ShdwShoe` | string literal | `"ShdwShoe"` |

### 10. `Constants.PreloadAssets` — line 142

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/ui/options-ui.png"` |
| `[2]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/ui/options-ui.animation"` |
| `[3]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/tiles/attack indicator.png"` |
| `[4]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/tiles/attack indicator.tsx"` |
| `[5]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.png"` |
| `[6]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx"` |
| `[7]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/tiles/selected tile.png"` |
| `[8]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/tiles/selected tile.tsx"` |
| `[9]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/blur.png"` |
| `[10]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/blur.animation"` |
| `[11]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/explosion.png"` |
| `[12]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/explosion.animation"` |
| `[13]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/paralyze.png"` |
| `[14]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/paralyze.animation"` |
| `[15]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/recover.png"` |
| `[16]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/recover.animation"` |
| `[17]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/item.png"` |
| `[18]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/item.animation"` |
| `[19]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/sound effects/hurt.ogg"` |
| `[20]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/sound effects/explode.ogg"` |
| `[21]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/sound effects/paralyze.ogg"` |
| `[22]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/sound effects/recover.ogg"` |
| `[23]` | string literal | `"/server/assets/net-games/meters/liberation-order-points/base-guage-3slice.png"` |
| `[24]` | string literal | `"/server/assets/net-games/meters/liberation-order-points/base-guage-3slice.animation"` |
| `[25]` | string literal | `"/server/assets/net-games/meters/liberation-order-points/points-3slice.png"` |
| `[26]` | string literal | `"/server/assets/net-games/meters/liberation-order-points/points-3slice.animation"` |
| `[27]` | string literal | `"/server/assets/net-games/meters/liberation-order-points/point-total-3slice.png"` |
| `[28]` | string literal | `"/server/assets/net-games/meters/liberation-order-points/point-total-3slice.animation"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
