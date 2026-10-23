# Tiled Reference

Auto-generated from `generate-ezlibs-tiled.lua`. Do not edit by hand.

## Enums

### ButtonBehavior

- `Pressure Plate`
- `One-Time`
- `Toggle`
- `Custom`
- `Timed`

### ButtonChainType

- `Any`
- `Exclusive`

### ButtonComboMode

- `Inclusive`
- `Exclusive`

### ButtonEffectAction

- `activate`
- `deactivate`
- `toggle`
- `reset`

### ButtonEffectEvent

- `activated`
- `deactivated`

### ButtonGroupEvent

- `completed`
- `incomplete`

### ButtonGroupMode

- `all_active`
- `any_active`
- `combination`

### CompressionMode

- `Compress`
- `Normalize`
- `Enlarge`

### CurrencyType

- `money`
- `fragments`
- `tokens`

### CutsceneStepType

- `Wait`
- `Move Actor`
- `Set Pose`
- `Show Message`
- `Ask Quiz`
- `Prompt Player`
- `Play Sound`
- `Fade Camera`
- `Move Camera`
- `Emit Event`

### DialogueType

- `first`
- `question`
- `quiz`
- `random`
- `itemcheck`
- `before`
- `after`
- `shop`
- `password`
- `quest_switch`
- `quest_event`
- `item`
- `email`
- `questcheck`
- `battle_npc`

### Direction

- `Up`
- `Down`
- `Left`
- `Right`
- `Up Left`
- `Up Right`
- `Down Left`
- `Down Right`

### ItemType

- `item`
- `keyitem`
- `money`
- `fragments`
- `tokens`

### KeyType

- `money`
- `fragments`
- `tokens`
- `item`
- `bossgate`
- `navi_name`
- `navi_element`
- `navi_list`

### MysteryType

- `keyitem`
- `item`
- `money`
- `random`
- `quiz`
- `fragments`
- `tokens`
- `encounter`

### NPCSpawnMode

- `Once`
- `Interval`

### NaviElement

- `None`
- `Fire`
- `Aqua`
- `Elec`
- `Wood`
- `Sword`
- `Break`
- `Cursor`
- `Wind`
- `Summon`
- `Plus`

### QuizFailAction

- `retry`
- `hide_once`
- `hide_temp`
- `explode`

### SizeModeScope

- `Player`
- `Area Wide`

### TriggerShape

- `rect`
- `ellipse`

### WaypointType

- `first`
- `random`
- `before`
- `after`

## Classes

### Checkpoint
**Category:** gameplay
Lockable Security Cube that gates progression.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Unlocking Animation Time` | number |  | 0 | appearance | Seconds to play the unlock animation; 0 skips it. |
| `Unlocking Asset Name` | string |  | `bn5cubegreen_bot` | appearance | Asset played during the unlock animation. |
| `Unlocking Sound Path` | string |  | `/server/assets/ezlibs-assets/sfx/panel_change.ogg` | appearance | Sound asset to play when the checkpoint unlocks. |
| `Consume` | bool |  | false | gameplay | Whether to consume the key on unlock. |
| `Description` | string |  | `It's a Security Cube` | gameplay | Shown to the player before the unlock check. |
| `Key Item Name` | string |  | `""` | gameplay | Item name required when Key Type == 'item'. |
| `Key Type` | string (KeyType) |  | `money` | gameplay | How to unlock when Password is empty. Ignored when Password is set. |
| `Navi 1` | string |  | `""` | gameplay | First entry in the approved-Navi list (any match unlocks). |
| `Navi 10` | string |  | `""` | gameplay |  |
| `Navi 2` | string |  | `""` | gameplay |  |
| `Navi 3` | string |  | `""` | gameplay |  |
| `Navi 4` | string |  | `""` | gameplay |  |
| `Navi 5` | string |  | `""` | gameplay |  |
| `Navi 6` | string |  | `""` | gameplay |  |
| `Navi 7` | string |  | `""` | gameplay |  |
| `Navi 8` | string |  | `""` | gameplay |  |
| `Navi 9` | string |  | `""` | gameplay |  |
| `Navi Element` | string (NaviElement) |  | `""` | gameplay | Navi element required to unlock (case-insensitive). |
| `Navi Name` | string |  | `""` | gameplay | Exact Navi name required to unlock (case-insensitive). |
| `Once` | bool |  | false | gameplay | If true, stays hidden permanently; else hidden till disconnect. |
| `Password` | string |  | `""` | gameplay | If set, requires typing this password to unlock. Overrides Key Type. |
| `Required Keys` | number |  | 1 | gameplay | Amount required for money / fragments / tokens / item. |
| `Skip Prompt` | bool |  | false | gameplay | If true, attempts the unlock without asking the player. |
| `Unlock Failed Message` | string |  | `You were unable to unlock the Security Cube` | gameplay | Shown when the unlock check fails. |
| `Unlocked Message` | string |  | `The Security Cube was unlocked!` | gameplay | Shown on successful unlock. |

**Template properties:** `Navi N` — add additional numbered instances manually in Tiled.

**Conditional properties**

- `Key Item Name`: Only used when Key Type == 'item'. Only meaningful when `Key Type` == `item`.
- `Navi 1`: Only used when Key Type == 'navi_list'. Only meaningful when `Key Type` == `navi_list`.
- `Navi Element`: Only used when Key Type == 'navi_element'. Only meaningful when `Key Type` == `navi_element`.
- `Navi Name`: Only used when Key Type == 'navi_name'. Only meaningful when `Key Type` == `navi_name`.

### Mystery Data
**Category:** gameplay
Pickup or event; behaviour branches on `Type`.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Quiz List` | object |  | `""` | dialogue | Root Quiz List object. |
| `Amount` | number |  | 1 | gameplay |  |
| `Cost Amount` | number |  | 1 | gameplay |  |
| `Cost Failure Message` | string |  | `""` | gameplay |  |
| `Cost Type` | string (CurrencyType) |  | `""` | gameplay | If non-empty, the object charges this currency on use. |
| `Description` | string |  | `""` | gameplay |  |
| `Explosion Count` | number |  | 3 | gameplay |  |
| `Failure Message` | string |  | `""` | gameplay |  |
| `Locked` | bool |  | false | gameplay |  |
| `Name` | string |  | `""` | gameplay |  |
| `Next 1` | object |  | `""` | gameplay |  |
| `Next 10` | object |  | `""` | gameplay |  |
| `Next 2` | object |  | `""` | gameplay |  |
| `Next 3` | object |  | `""` | gameplay |  |
| `Next 4` | object |  | `""` | gameplay |  |
| `Next 5` | object |  | `""` | gameplay |  |
| `Next 6` | object |  | `""` | gameplay |  |
| `Next 7` | object |  | `""` | gameplay |  |
| `Next 8` | object |  | `""` | gameplay |  |
| `Next 9` | object |  | `""` | gameplay |  |
| `On Fail` | string (QuizFailAction) |  | `retry` | gameplay |  |
| `Once` | bool |  | false | gameplay |  |
| `Password Locked` | string |  | `""` | gameplay |  |
| `Reward Amount` | number |  | 1 | gameplay |  |
| `Reward Description` | string |  | `""` | gameplay |  |
| `Reward Name` | string |  | `""` | gameplay |  |
| `Reward Type` | string (ItemType) |  | `item` | gameplay |  |
| `Type` | string (MysteryType) |  | `item` | gameplay | Selects the event flow. |

**Conditional properties**

- `Quiz List`: Only used when Type == 'quiz'. Only meaningful when `Type` == `quiz`.
- `Cost Amount`: Only used when Cost Type is set. Only meaningful when `Cost Type` is set.
- `Cost Failure Message`: Only used when Cost Type is set. Only meaningful when `Cost Type` is set.
- `Reward Amount`: Only used when Type == 'quiz'. Only meaningful when `Type` == `quiz`.
- `Reward Description`: Only used when Type == 'quiz'. Only meaningful when `Type` == `quiz`.
- `Reward Name`: Only used when Type == 'quiz'. Only meaningful when `Type` == `quiz`.
- `Reward Type`: Only used when Type == 'quiz'. Only meaningful when `Type` == `quiz`.

### Quiz List
**Category:** dialogue
Ordered chain of Quiz Question objects.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Next 1` | object |  | `""` | dialogue |  |
| `Next 10` | object |  | `""` | dialogue |  |
| `Next 2` | object |  | `""` | dialogue |  |
| `Next 3` | object |  | `""` | dialogue |  |
| `Next 4` | object |  | `""` | dialogue |  |
| `Next 5` | object |  | `""` | dialogue |  |
| `Next 6` | object |  | `""` | dialogue |  |
| `Next 7` | object |  | `""` | dialogue |  |
| `Next 8` | object |  | `""` | dialogue |  |
| `Next 9` | object |  | `""` | dialogue |  |

**Template properties:** `Next N` — add additional numbered instances manually in Tiled.

### Quiz Question
**Category:** dialogue
Single quiz entry.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Correct Answer` | number |  | 1 | dialogue |  |
| `Option 1` | string |  | `""` | dialogue |  |
| `Option 2` | string |  | `""` | dialogue |  |
| `Option 3` | string |  | `""` | dialogue |  |
| `Question` | string |  | `""` | dialogue |  |

### Location Trigger

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Event Name` | string |  | `""` |  |  |
| `Name` | string |  | `""` |  |  |

### Server Warp

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Address` | string |  | `""` |  |  |
| `Arrival Animation` | string |  | `""` |  |  |
| `Data` | string |  | `""` |  |  |
| `Direction` | string (Direction) |  | `Down` |  |  |
| `Dont Teleport` | bool |  | false |  |  |
| `Incoming Data` | string |  | `""` |  |  |
| `Port` | number |  | 0 |  |  |
| `Warp In` | bool |  | false |  |  |
| `Warp Out` | bool |  | false |  |  |

### Custom Warp

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Arrival Animation` | string |  | `""` |  |  |
| `Direction` | string (Direction) |  | `Down` |  |  |
| `Dont Teleport` | bool |  | false |  |  |
| `Incoming Data` | string |  | `""` |  |  |
| `Leave Animation` | string |  | `""` |  |  |
| `Target Area` | string |  | `""` |  |  |
| `Target Object` | string |  | `""` |  |  |
| `Warp In` | bool |  | false |  |  |

### Interact Warp

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Arrival Animation` | string |  | `""` |  |  |
| `Direction` | string (Direction) |  | `Down` |  |  |
| `Dont Teleport` | bool |  | false |  |  |
| `Incoming Data` | string |  | `""` |  |  |
| `Leave Animation` | string |  | `""` |  |  |
| `Target Area` | string |  | `""` |  |  |
| `Target Object` | string |  | `""` |  |  |
| `Warp In` | bool |  | false |  |  |

### Radius Warp

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Activation Radius` | number |  | 1 |  |  |
| `Arrival Animation` | string |  | `""` |  |  |
| `Direction` | string (Direction) |  | `Down` |  |  |
| `Dont Teleport` | bool |  | false |  |  |
| `Incoming Data` | string |  | `""` |  |  |
| `Leave Animation` | string |  | `""` |  |  |
| `Target Area` | string |  | `""` |  |  |
| `Target Object` | string |  | `""` |  |  |
| `Warp In` | bool |  | false |  |  |

### NPC
**Category:** gameplay
Placed non-player character. Set `Template Only` to use an NPC purely as a reference target for NPC Spawners without spawning it as a standalone NPC.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Animation Name` | string |  | `""` | appearance | Idle animation; uses asset default if empty. |
| `Asset Name` | string | yes | `""` | appearance | Sprite asset name (no extension). |
| `Direction` | string (Direction) | yes | `Down` | appearance | Initial facing (Tiled default populates it). |
| `Dont Face Player` | bool |  | false | appearance | If true, the NPC does not turn to face the player. |
| `Mug Animation Name` | string |  | `""` | appearance | Portrait animation used while talking. |
| `First Dialogue` | object |  | `""` | dialogue | Reference to the root Dialogue object. |
| `Cutscene` | string |  | `""` | gameplay | Optional cutscene name. Plays before First Dialogue on the first interaction; subsequent interactions go straight to dialogue. |
| `Next Waypoint 1` | object |  | `""` | gameplay | First waypoint in the NPC's path. |
| `Player Exclusive` | bool |  | false | advanced | Only spawned for the owning player. |
| `Quest Exclusive` | string |  | `""` | advanced | Quest name; when set, the NPC is created per-player for that quest. |
| `Quest NPC` | bool |  | false | advanced | NPC is tied to quest state (see Quest Exclusive / Quest State). |
| `Quest State` | string |  | `active` | advanced | Required quest state for the NPC to appear. |
| `Template Only` | bool |  | false | advanced | If true, this NPC is used only as a reference target for NPC Spawners and does not spawn as a regular NPC on its own. Properties (Asset Name, Direction, Next Waypoint 1, First Dialogue, Cutscene, etc.) are still read by the spawner when it creates a bot from this template. |

**Conditional properties**

- `Cutscene`: Only used if a Cutscene with this Name exists in the area.
- `Quest State`: Only used when Quest Exclusive is set. Only meaningful when `Quest Exclusive` is set.

### Pushback NPC
**Category:** gameplay
NPC with a moving collision zone that pushes the player.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Move Animation State` | string |  | `MOVE` | appearance | Bot animation state played during the push. |
| `Animation Name` | string |  | `""` | gameplay |  |
| `Asset Name` | string |  | `male-navi-exe6_teal` | gameplay |  |
| `Collision Enabled` | bool |  | true | gameplay | Enables the push collision zone. |
| `Collision Height` | number |  | 1.5 | gameplay | Collision rectangle height. |
| `Collision Width` | number |  | 1.5 | gameplay | Collision rectangle width. |
| `Direction` | string (Direction) |  | `Down` | gameplay |  |
| `Dont Face Player` | bool |  | false | gameplay |  |
| `First Dialogue` | object |  | `""` | gameplay |  |
| `Mug Animation Name` | string |  | `""` | gameplay |  |
| `Next Waypoint 1` | object |  | `""` | gameplay |  |
| `Player Exclusive` | bool |  | false | gameplay |  |
| `Push Cooldown` | number |  | 0.75 | gameplay | Seconds before the same player can be pushed again. |
| `Push Distance` | number |  | 1 | gameplay | Distance the player is pushed beyond the rectangle edge. |
| `Push Duration` | number |  | 0.28 | gameplay | Seconds the push animation lasts. |
| `Quest Exclusive` | string |  | `""` | gameplay |  |
| `Quest NPC` | bool |  | false | gameplay |  |
| `Quest State` | string |  | `active` | gameplay |  |
| `Template Only` | bool |  | false | advanced | If true, this NPC is used only as a reference target for NPC Spawners and does not spawn as a regular NPC on its own. |

**Conditional properties**

- `Template Only`: Only meaningful if the referenced spawner does not also need collision push behaviour on the spawned bot.

### NPC Spawner
**Category:** gameplay
Spawns NPCs from a template object, lets them follow a waypoint path, and optionally warps them out when the path completes. Supports one-per-entry spawning (Once mode) and continuous spawning at an interval while a player stays inside (Interval mode).

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Warp Out Animation` | string |  | `""` | appearance | Optional animation state to play before the NPC is removed (e.g. WARP_OUT). Empty = remove immediately after the delay with no animation. |
| `Warp Out Animation Duration` | number |  | 0.5 | appearance | Seconds the Warp Out Animation plays before the NPC is removed. Should match the animation's total duration. |
| `Max Alive` | number |  | 0 | gameplay | Cap on concurrently live NPCs. 0 = unlimited. While at cap, spawning pauses; when a slot frees (warp-out, external removal), the next spawn fires immediately rather than waiting for another interval. |
| `NPC Template` | object | yes | `""` | gameplay | Reference to an NPC object to spawn. The referenced NPC should have `Template Only` enabled so it doesn't also spawn as a regular NPC on map load. |
| `Once` | bool |  | false | gameplay | If true, spawn at most one NPC per session. If false, Once-mode spawners re-arm when the player leaves and can spawn again on the next entry (immediate-mode spawners are always one-shot regardless of this flag). Ignored in Interval mode. |
| `Spawn Interval` | number |  | 3 | gameplay | Seconds between spawns in Interval mode. The first NPC spawns immediately on entry; subsequent NPCs follow at this interval, subject to Max Alive. If Max Alive pauses spawning, the next spawn fires as soon as a slot opens. |
| `Spawn Mode` | string (NPCSpawnMode) |  | `Once` | gameplay | How the spawner triggers:<br>• Once — spawn one NPC per trigger entry (see Once).<br>• Interval — spawn a new NPC every Spawn Interval seconds while a player stays inside Trigger Radius, up to Max Alive concurrent NPCs. |
| `Trigger Radius` | number |  | 0 | gameplay | If > 0, spawning is gated on a player being within this radius (in tiles) around the spawner. 0 = spawn immediately on area load (Once mode only; Interval falls back to Once with a warning). |
| `Warp Out At End` | bool |  | false | gameplay | If true, each spawned NPC is removed after reaching the final waypoint in its path. If false, spawned NPCs stay at the last waypoint indefinitely (and, in Interval mode, count toward Max Alive). |
| `Warp Out Delay` | number |  | 0 | gameplay | Seconds to wait after the path completes before starting the warp-out animation. |

**Conditional properties**

- `Warp Out Animation`: Only used when Warp Out At End is true. Only meaningful when `Warp Out At End` is set.
- `Warp Out Animation Duration`: Only used when Warp Out At End and Warp Out Animation are both set. Only meaningful when `Warp Out At End` is set.
- `Max Alive`: Only used when Spawn Mode == 'Interval'; Once mode is implicitly limited to one NPC at a time. Only meaningful when `Spawn Mode` == `Interval`.
- `Once`: Only affects Once mode; Interval mode ignores it. Only meaningful when `Spawn Mode` == `Once`.
- `Spawn Interval`: Only used when Spawn Mode == 'Interval'. Only meaningful when `Spawn Mode` == `Interval`.
- `Warp Out Delay`: Only used when Warp Out At End is true. Only meaningful when `Warp Out At End` is set.

### FootBomb Controller
**Category:** gameplay
Interaction actor for the FootBomb minigame.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Animation Name` | string |  | `""` | gameplay |  |
| `Asset Name` | string |  | `male-navi-exe6_teal` | gameplay |  |
| `Direction` | string (Direction) |  | `Down` | gameplay |  |
| `Dont Face Player` | bool |  | false | gameplay |  |
| `Instance Map` | string |  | `footbomb` | gameplay | Map loaded for a match. |
| `Mug Animation Name` | string |  | `""` | gameplay |  |
| `Mugshot` | string |  | `""` | gameplay |  |
| `Points to Win` | number | yes | 10 | gameplay | Match target score. |

### Waypoint
**Category:** gameplay
Navigation node for NPCs. Move Animation handles travel; Wait Animation handles the arrival hold. Set Move Duration > 0 for scripted (jump-style) movement where the animation has intrinsic timing.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Direction` | string (Direction) |  | `""` | appearance | Facing applied when the NPC arrives at this waypoint (and during Wait Time). |
| `Move Animation` | string |  | `""` | appearance | Animation state played while travelling toward this waypoint (e.g. WALK_UR, RUN, FOOTBOMB_JUMP_LEFT). When set, the animation itself encodes facing; Move Direction is ignored during travel. |
| `Move Direction` | string (Direction) |  | `""` | appearance | Direction to face while travelling toward this waypoint. Empty = keep whatever direction the NPC was already facing. |
| `Move Duration` | number |  | 0 | appearance | If > 0, switches to scripted movement: the NPC's position is animated over exactly this many seconds via keyframes, matching the animation's intrinsic timing. Required for jump-style animations to stay in sync with the sprite. Leave at 0 for normal walking. |
| `Move Loop` | bool |  | true | appearance | Whether Move Animation loops. Set false for one-shot animations like jump arcs; the final frame holds until movement completes. |
| `Wait Animation` | string |  | `""` | appearance | Animation state held while the NPC waits at this waypoint during Wait Time. Use for END/hold poses (e.g. FOOTBOMB_JUMP_LEFT_END) that should persist after arrival. Empty = keep whatever the Move Animation ended on. |
| `Wait Loop` | bool |  | true | appearance | Whether Wait Animation loops. Keep true for single-frame holds so the engine doesn't revert to the default idle. |
| `Date` | string |  | `""` | gameplay |  |
| `Next Waypoint 1` | object |  | `""` | gameplay |  |
| `Next Waypoint 2` | object |  | `""` | gameplay |  |
| `Next Waypoint 3` | object |  | `""` | gameplay |  |
| `Next Waypoint 4` | object |  | `""` | gameplay |  |
| `Next Waypoint 5` | object |  | `""` | gameplay |  |
| `Wait Time` | number |  | 0 | gameplay |  |
| `Waypoint Type` | string (WaypointType) |  | `first` | gameplay | How the next waypoint is selected. |

**Template properties:** `Next Waypoint N` — add additional numbered instances manually in Tiled.

**Conditional properties**

- `Move Animation`: Move Loop controls whether it restarts each cycle. For animations with intrinsic timing (jumps), also set Move Duration > 0 to sync position with the animation.
- `Move Direction`: Ignored when Move Animation is set; the animation's encoded facing wins.
- `Move Duration`: Only meaningful when Move Animation is set. Leave 0 for walk cycles; set to the animation's total duration for one-shot arcs. Only meaningful when `Move Animation` is set.
- `Move Loop`: Only meaningful when Move Animation is set. Only meaningful when `Move Animation` is set.
- `Wait Animation`: Only visible when Wait Time > 0 (the pose is applied on arrival and immediately overridden once travel resumes).
- `Wait Loop`: Only used when Wait Animation is set. Only meaningful when `Wait Animation` is set.
- `Date`: Only used when Waypoint Type is 'before' or 'after'. Only meaningful when `Waypoint Type` in {`before`, `after`}.

### Radius Encounter

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Name` | string |  | `""` |  |  |
| `Once` | bool |  | false |  |  |
| `Path` | file |  | `""` |  |  |
| `Radius` | number |  | 1 |  |  |

### Water Refill

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|

### Item
**Category:** gameplay
Inventory or shop item reference.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Amount` | number |  | 1 | gameplay |  |
| `Description` | string |  | `""` | gameplay |  |
| `Name` | string |  | `""` | gameplay |  |
| `Price` | number |  | 999999 | gameplay |  |
| `Type` | string (ItemType) |  | `item` | gameplay |  |

### Dialogue
**Category:** dialogue
Dialogue node. Many properties are type-specific; see the Conditional section.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Mug Animation Path` | string |  | `""` | appearance |  |
| `Mug Texture Path` | string |  | `""` | appearance |  |
| `Body 1` | string |  | `""` | dialogue |  |
| `Body 10` | string |  | `""` | dialogue |  |
| `Body 2` | string |  | `""` | dialogue |  |
| `Body 3` | string |  | `""` | dialogue |  |
| `Body 4` | string |  | `""` | dialogue |  |
| `Body 5` | string |  | `""` | dialogue |  |
| `Body 6` | string |  | `""` | dialogue |  |
| `Body 7` | string |  | `""` | dialogue |  |
| `Body 8` | string |  | `""` | dialogue |  |
| `Body 9` | string |  | `""` | dialogue |  |
| `Date` | string |  | `""` | dialogue |  |
| `Dialogue Type` | string (DialogueType) |  | `first` | dialogue |  |
| `Dont Notify` | bool |  | false | dialogue |  |
| `Email From` | string |  | `???` | dialogue |  |
| `Email Icon` | number |  | 1 | dialogue |  |
| `Email Id` | string |  | `""` | dialogue |  |
| `Email Title` | string |  | `Mail` | dialogue |  |
| `Encounter Name` | string |  | `""` | dialogue |  |
| `Event Name` | string |  | `""` | dialogue |  |
| `Event Value` | string |  | `""` | dialogue |  |
| `Failure Message` | string |  | `""` | dialogue |  |
| `Item 1` | object |  | `""` | dialogue | Item reference used by item / itemcheck / shop types. |
| `Item 2` | object |  | `""` | dialogue |  |
| `Mugshot` | string |  | `""` | dialogue |  |
| `Next 1` | object |  | `""` | dialogue | Primary next-Dialogue reference. |
| `Next 2` | object |  | `""` | dialogue |  |
| `Next 3` | object |  | `""` | dialogue |  |
| `Next 4` | object |  | `""` | dialogue |  |
| `Next 5` | object |  | `""` | dialogue |  |
| `Notify Delay` | number |  | 1.5 | dialogue |  |
| `Notify Message` | string |  | `Looks like you got an e-mail.` | dialogue |  |
| `Persist` | bool |  | true | dialogue |  |
| `Quest Name` | string |  | `""` | dialogue |  |
| `Take Item` | bool |  | false | dialogue |  |
| `Text 1` | string |  | `""` | dialogue | Primary text; meaning varies by Dialogue Type. |
| `Text 2` | string |  | `""` | dialogue |  |
| `Text 3` | string |  | `""` | dialogue |  |
| `Kick On Loss` | bool |  | true | gameplay | If true, kick the player when they lose. If false, leave them in place with input unlocked (useful for scripted losses where the player stays in the map). |

**Template properties:** `Text N`, `Next N`, `Item N`, `Body N` — add additional numbered instances manually in Tiled.

**Conditional properties**

- `Mug Animation Path`: Only used when Dialogue Type == 'email'. Only meaningful when `Dialogue Type` == `email`.
- `Mug Texture Path`: Only used when Dialogue Type == 'email'. Only meaningful when `Dialogue Type` == `email`.
- `Date`: Only used by Dialogue Type 'before' or 'after'. Only meaningful when `Dialogue Type` in {`before`, `after`}.
- `Dont Notify`: Only used by Dialogue Type 'item' or 'email'. Only meaningful when `Dialogue Type` in {`item`, `email`}.
- `Email From`: Only used when Dialogue Type == 'email'. Only meaningful when `Dialogue Type` == `email`.
- `Email Icon`: Only used when Dialogue Type == 'email'. Only meaningful when `Dialogue Type` == `email`.
- `Email Id`: Only used when Dialogue Type == 'email'. Only meaningful when `Dialogue Type` == `email`.
- `Email Title`: Only used when Dialogue Type == 'email'. Only meaningful when `Dialogue Type` == `email`.
- `Encounter Name`: Only used when Dialogue Type == 'battle_npc'. Only meaningful when `Dialogue Type` == `battle_npc`.
- `Event Value`: Only used by Dialogue Type 'quest_event'. Only meaningful when `Dialogue Type` == `quest_event`.
- `Failure Message`: Only used when Dialogue Type == 'battle_npc'. Only meaningful when `Dialogue Type` == `battle_npc`.
- `Item 1`: Only used by Dialogue Type 'item', 'itemcheck', or 'shop'. Only meaningful when `Dialogue Type` in {`item`, `itemcheck`, `shop`}.
- `Persist`: Only used when Dialogue Type == 'email'. Only meaningful when `Dialogue Type` == `email`.
- `Quest Name`: Only used by quest-related Dialogue Types. Only meaningful when `Dialogue Type` in {`quest_switch`, `quest_event`, `questcheck`}.
- `Take Item`: Only used when Dialogue Type == 'itemcheck'. Only meaningful when `Dialogue Type` == `itemcheck`.
- `Kick On Loss`: Only used when Dialogue Type == 'battle_npc'. Only meaningful when `Dialogue Type` == `battle_npc`.

### Explosion Trigger

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Follow` | bool |  | false |  |  |
| `Once` | bool |  | false |  |  |
| `Target` | string |  | `""` |  |  |

### Rush Road
**Category:** advanced
ezrushroads interaction object.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Direction` | string (Direction) |  | `Down Left` | advanced |  |
| `Rush Object` | object |  | `""` | advanced |  |

### Compression Tile
**Category:** advanced
Changes player or area scale while standing inside.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Mode` | string (CompressionMode) |  | `Compress` | advanced |  |

### Admin Console

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|

### Button Bot Details
**Category:** appearance
Visual and animation configuration for an OW Button.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Activated Animation` | string |  | `""` | appearance | One-shot animation played when the button activates. Empty = snap straight to Active Animation. |
| `Activation Animation Duration` | number |  | 0.5 | appearance | Seconds the Activated Animation plays before the button state changes. |
| `Active Animation` | string |  | `ACTIVE` | appearance | Looped animation while the button is active. |
| `Animation Name` | string |  | `""` | appearance | Optional idle animation; falls back to the asset default. |
| `Asset Name` | string | yes | `""` | appearance | Sprite asset name (no extension). |
| `Deactivated Animation` | string |  | `""` | appearance | One-shot animation played when the button deactivates. Empty = snap straight to Inactive Animation. |
| `Deactivation Animation Duration` | number |  | 0.5 | appearance | Seconds the Deactivated Animation plays before the button state changes. |
| `Direction` | string (Direction) | yes | `Down` | appearance | Facing direction. |
| `Inactive Animation` | string |  | `INACTIVE` | appearance | Looped animation while the button is inactive. |
| `Mug Animation Name` | string |  | `""` | appearance | Optional portrait animation used while talking. |

**Conditional properties**

- `Activation Animation Duration`: Only used when Activated Animation is set.
- `Deactivation Animation Duration`: Only used when Deactivated Animation is set.

### OW Button
**Category:** gameplay
A pressable button. Unlocks checkpoints through a referenced Unlock Behavior.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Bot Details` | object | yes | `""` | appearance | Reference to the Button Bot Details object that configures this button's appearance. |
| `Activated Time` | number |  | 1 | gameplay | Seconds the button stays active before auto-deactivating. |
| `Bots Can Trigger` | bool |  | false | gameplay | If true, NPCs (bots) entering or leaving this button's trigger also affect its state, using the same Pressure Plate / One-Time / Toggle / Timed rules as players. Ignored for Custom behavior. |
| `Button Activated Behavior` | object |  | `""` | gameplay | Optional reference to an Unlock Behavior object that defines which checkpoint this button unlocks. |
| `Button Behavior` | string (ButtonBehavior) |  | `One-Time` | gameplay | How the button reacts to player presence:<br>• Pressure Plate — active while anyone stands on it.<br>• One-Time — activates once and stays active.<br>• Toggle — flips active/inactive each press.<br>• Custom — runs a map-specific Lua script.<br>• Timed — activates, then auto-deactivates after Activated Time. |
| `Button Deactivated Behavior` | object |  | `""` | gameplay | Optional reference to a Relock Behavior object that defines which checkpoint this button re-locks when it deactivates. |
| `Next 1` | object |  | `""` | gameplay |  |
| `Script Path` | file |  | `""` | gameplay | Lua module path providing on_enter / on_exit handlers. |
| `Trigger Height` | number |  | 4 | gameplay | Trigger rectangle height in map tiles. |
| `Trigger Object` | object |  | `""` | gameplay | Optional separate trigger object. When set, its bounds override the button's own rectangle and Trigger Type/Width/Height are ignored. |
| `Trigger Type` | string (TriggerShape) |  | `rect` | gameplay | Rectangle vs ellipse detection shape. |
| `Trigger Width` | number |  | 4 | gameplay | Trigger rectangle width in map tiles. |
| `Button Chain Type` | string (ButtonChainType) |  | `Any` | advanced | Reserved for future use. Currently not consulted by the runtime. |

**Template properties:** `Next N` — add additional numbered instances manually in Tiled.

**Conditional properties**

- `Activated Time`: Only used when Button Behavior == 'Timed'. Only meaningful when `Button Behavior` == `Timed`.
- `Bots Can Trigger`: Ignored when Button Behavior == 'Custom'. Only meaningful when `Button Behavior` in {`Pressure Plate`, `One-Time`, `Toggle`, `Timed`}.
- `Script Path`: Only used when Button Behavior == 'Custom'. Only meaningful when `Button Behavior` == `Custom`.
- `Trigger Height`: Only used when Trigger Object is empty.
- `Trigger Type`: Only used when Trigger Object is empty.
- `Trigger Width`: Only used when Trigger Object is empty.

### OW Button Group Member
**Category:** gameplay
Button that participates in a Button Group or Button Combo but never unlocks checkpoints on its own.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Bot Details` | object | yes | `""` | appearance | Reference to the Button Bot Details object that configures this button's appearance. |
| `Activated Time` | number |  | 1 | gameplay | Seconds the button stays active before auto-deactivating. |
| `Bots Can Trigger` | bool |  | false | gameplay | If true, NPCs (bots) entering or leaving this member's trigger also affect its state, which propagates to the parent group. |
| `Button Behavior` | string (ButtonBehavior) |  | `One-Time` | gameplay | Same modes as OW Button. Group members never run their own checkpoint actions; their state feeds the parent group. |
| `Script Path` | file |  | `""` | gameplay |  |
| `Trigger Height` | number |  | 4 | gameplay | Trigger rectangle height in map tiles. |
| `Trigger Object` | object |  | `""` | gameplay | Optional separate trigger object. When set, its bounds override the button's own rectangle. |
| `Trigger Type` | string (TriggerShape) |  | `rect` | gameplay | Rectangle vs ellipse detection shape. |
| `Trigger Width` | number |  | 4 | gameplay | Trigger rectangle width in map tiles. |

**Conditional properties**

- `Activated Time`: Only used when Button Behavior == 'Timed'. Only meaningful when `Button Behavior` == `Timed`.
- `Bots Can Trigger`: Ignored when Button Behavior == 'Custom'. Only meaningful when `Button Behavior` in {`Pressure Plate`, `One-Time`, `Toggle`, `Timed`}.
- `Script Path`: Only used when Button Behavior == 'Custom'. Only meaningful when `Button Behavior` == `Custom`.
- `Trigger Height`: Only used when Trigger Object is empty.
- `Trigger Type`: Only used when Trigger Object is empty.
- `Trigger Width`: Only used when Trigger Object is empty.

### Unlock Behavior
**Category:** gameplay
Defines which checkpoint a button unlocks when it becomes active.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Area Wide` | bool |  | false | gameplay | If true, unlocks for every player currently in the area, and for players who enter later (while active). |
| `Unlock Permanently` | bool |  | false | gameplay | true = stays hidden across disconnects; false = re-locks automatically when the button deactivates (or on reconnect). |
| `Unlock This` | object | yes | `""` | gameplay | Checkpoint reference this behavior unlocks. |

### Relock Behavior
**Category:** gameplay
Defines which checkpoint a button re-locks when it becomes inactive.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Area Wide` | bool |  | false | gameplay | If true, re-locks for every player currently in the area. |
| `Relock This` | object | yes | `""` | gameplay | Checkpoint reference this behavior re-locks. |

### Button Trigger
**Category:** gameplay
Optional standalone trigger rectangle referenced by an OW Button.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Trigger Type` | string (TriggerShape) |  | `rect` | gameplay | Rectangle vs ellipse detection shape for the referenced trigger object. |

### Button Group
**Category:** gameplay
Group of OW Button Group Members that share a satisfaction rule; owns its own checkpoint unlocks.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Button 1` | object | yes | `""` | gameplay | Reference to a required OW Button Group Member. Add Button 2..N as needed in Tiled. |
| `Forbidden Button 1` | object |  | `""` | gameplay | Reference to a member that must be inactive for the group to satisfy. |
| `Group ID` | string |  | `""` | gameplay | Optional stable identifier. Falls back to the object's Tiled ID. |
| `Group Mode` | string (ButtonGroupMode) |  | `all_active` | gameplay | How members combine:<br>• all_active — every referenced Button is active.<br>• any_active — at least one is active.<br>• combination — every Button is active AND every Forbidden Button is inactive. |
| `Relock Area Wide` | bool |  | false | gameplay | If true, relock applies to every player in the area. |
| `Relock Checkpoint 1` | object |  | `""` | gameplay | Checkpoint to re-lock when the group becomes unsatisfied. Add Relock Checkpoint 2..N as needed. |
| `Unlock Area Wide` | bool |  | false | gameplay | If true, unlock applies to every player in the area. |
| `Unlock Checkpoint 1` | object |  | `""` | gameplay | Checkpoint to unlock when the group transitions to satisfied. Add Unlock Checkpoint 2..N as needed. |
| `Unlock Permanently` | bool |  | true | gameplay | Whether the group's unlocks are permanent or should be re-locked on group dissolution. |

**Template properties:** `Button N`, `Forbidden Button N`, `Unlock Checkpoint N`, `Relock Checkpoint N` — add additional numbered instances manually in Tiled.

**Conditional properties**

- `Forbidden Button 1`: Only meaningful when Group Mode == 'combination'. Only meaningful when `Group Mode` == `combination`.
- `Relock Checkpoint 1`: Only meaningful when at least one Unlock Checkpoint is configured.

### Button Combo
**Category:** gameplay
One specific button pattern; owns its own checkpoint unlocks.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Button 1` | object | yes | `""` | gameplay | Reference to a required OW Button Group Member. Add Button 2..N as needed. |
| `Forbidden Button 1` | object |  | `""` | gameplay | Reference to a member that must be inactive for this combo to satisfy. |
| `Relock Area Wide` | bool |  | false | gameplay | If true, relock applies to every player in the area. |
| `Relock Checkpoint 1` | object |  | `""` | gameplay | Checkpoint to re-lock when this combo becomes unsatisfied. Add Relock Checkpoint 2..N as needed. |
| `Unlock Area Wide` | bool |  | false | gameplay | If true, unlock applies to every player in the area. |
| `Unlock Checkpoint 1` | object |  | `""` | gameplay | Checkpoint to unlock when this combo becomes satisfied. Add Unlock Checkpoint 2..N as needed. |
| `Unlock Permanently` | bool |  | true | gameplay | Whether this combo's unlocks are permanent or should be re-locked when the combo breaks. |

**Template properties:** `Button N`, `Forbidden Button N`, `Unlock Checkpoint N`, `Relock Checkpoint N` — add additional numbered instances manually in Tiled.

**Conditional properties**

- `Relock Checkpoint 1`: Only meaningful when at least one Unlock Checkpoint is configured.

### Combo Button Group
**Category:** gameplay
A set of Button Combos; satisfying any one fires that combo's actions.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Button Combo 1` | object | yes | `""` | gameplay | Reference to a Button Combo. Add Button Combo 2..N as needed — satisfying ANY one fires its actions. |
| `Combo Mode` | string (ButtonComboMode) |  | `Inclusive` | gameplay | How each referenced combo's button matches are evaluated:<br>• Inclusive — required buttons active and forbidden inactive; other group-members may be active too.<br>• Exclusive — same, but no other group-member button may be active. |
| `Group ID` | string |  | `""` | gameplay | Optional stable identifier. Falls back to the object's Tiled ID. |

**Template properties:** `Button Combo N` — add additional numbered instances manually in Tiled.

### Button Effect
**Category:** gameplay
One button's state transition drives another button's action.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Action` | string (ButtonEffectAction) |  | `activate` | gameplay | What to do to the Target Button when the effect fires. |
| `Event` | string (ButtonEffectEvent) |  | `activated` | gameplay | Which transition on Source Button triggers the effect. |
| `Source Button` | object | yes | `""` | gameplay | Button whose state transition triggers this effect. |
| `Target Button` | object | yes | `""` | gameplay | Button this effect acts on. |

### Button Group Effect
**Category:** gameplay
A group's completion transition drives another button's action.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Action` | string (ButtonEffectAction) |  | `activate` | gameplay | What to do to the Target Button when the effect fires. |
| `Button Group` | object | yes | `""` | gameplay | Button Group (or Combo Button Group) whose completion transition triggers this effect. |
| `Event` | string (ButtonGroupEvent) |  | `completed` | gameplay | Which group transition triggers the effect. |
| `Target Button` | object | yes | `""` | gameplay | Button this effect acts on. |

### Cutscene
**Category:** gameplay
Named cutscene definition. Trigger via radius or script.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Name` | string | yes | `""` | gameplay | Unique cutscene identifier within the area. |
| `Once` | bool |  | false | gameplay | If true, plays at most once per player per session. |
| `Start Step` | object | yes | `""` | gameplay | First step in the chain (Cutscene Step object). |
| `Trigger Radius` | number |  | 0 | gameplay | If > 0, auto-starts when a player enters a circle of this radius (in map pixels) centered on this Cutscene object's own position. Ignored when the Cutscene object is a rectangle. Small values (32–200) match the tile scale; larger values cover a wider area. |

### Cutscene Step
**Category:** gameplay
One action in a cutscene chain. Chain via Next Step; branch via Next N / Fail Next.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Color A` | number |  | 255 | appearance |  |
| `Color B` | number |  | 0 | appearance |  |
| `Color G` | number |  | 0 | appearance |  |
| `Color R` | number |  | 0 | appearance |  |
| `Mugshot Override` | string |  | `""` | appearance | 'player' for the current player's mug, or a mug asset name to override the speaker's mug. |
| `Sound Path` | string |  | `""` | appearance |  |
| `Expected` | string |  | `""` | dialogue | If set, the input must match to route via Next Step; otherwise Fail Next runs. Empty accepts any input. |
| `Message` | string |  | `""` | dialogue | Text shown before the input field appears. |
| `Option 1` | string |  | `""` | dialogue |  |
| `Option 2` | string |  | `""` | dialogue |  |
| `Option 3` | string |  | `""` | dialogue | Optional third option; leave empty for a 2-option quiz. |
| `Question` | string |  | `""` | dialogue |  |
| `Speaker` | object |  | `""` | dialogue | NPC whose mugshot appears with the message. Empty = the NPC that started the cutscene. |
| `Text` | string |  | `""` | dialogue |  |
| `Actor` | object |  | `""` | gameplay | NPC placeholder whose bot moves or poses. Use 'trigger_npc' to reference the NPC that started the cutscene. |
| `Animation` | string |  | `""` | gameplay | Pose animation to set (without moving). |
| `Direction` | string (Direction) |  | `""` | gameplay |  |
| `Duration` | number |  | 0.8 | gameplay |  |
| `End Animation` | string |  | `""` | gameplay | Pose held after reaching the target. Leave empty to keep the move animation. |
| `End Direction` | string (Direction) |  | `""` | gameplay |  |
| `End Hold Seconds` | number |  | 0 | gameplay | 0 = hold indefinitely (until the next pose step). >0 = hold for that many seconds before the next step runs. |
| `End Loop` | bool |  | true | gameplay |  |
| `Fail Next` | object |  | `""` | gameplay | Step to run when the prompt fails to match Expected. |
| `Hold Seconds` | number |  | 0 | gameplay | 0 = indefinite; >0 = await that long before continuing. |
| `Loop` | bool |  | true | gameplay |  |
| `Move Animation` | string |  | `""` | gameplay | Animation played while moving (e.g. WALK_UR). |
| `Move Direction` | string (Direction) |  | `""` | gameplay | Facing direction during movement. |
| `Move Speed` | number |  | 3 | gameplay | Map units per second during movement. |
| `Next 1` | object |  | `""` | gameplay | On Ask Quiz: step to run when option 1 is chosen. |
| `Next 2` | object |  | `""` | gameplay |  |
| `Next 3` | object |  | `""` | gameplay |  |
| `Next Step` | object |  | `""` | gameplay | Step to run after this one. Empty ends the cutscene (for branch types, this is the fallback). |
| `Target` | object |  | `""` | gameplay | Point object to move to. When set, Target X/Y/Z are ignored. If Target, Target X/Y/Z, and the step's own placement are all empty, the step falls back to its own Tiled (x, y, z) as the destination. |
| `Target X` | number |  | 0 | gameplay |  |
| `Target Y` | number |  | 0 | gameplay |  |
| `Target Z` | number |  | 0 | gameplay |  |
| `Type` | string (CutsceneStepType) | yes | `Wait` | gameplay | Which action this step performs. |
| `Wait Seconds` | number |  | 1 | gameplay |  |
| `Event Name` | string |  | `""` | advanced | ezbus event name to emit. Payload includes player_id, area_id, cutscene_name. |

**Conditional properties**

- `Color A`: Only used by Fade Camera. Only meaningful when `Type` == `Fade Camera`.
- `Color B`: Only used by Fade Camera. Only meaningful when `Type` == `Fade Camera`.
- `Color G`: Only used by Fade Camera. Only meaningful when `Type` == `Fade Camera`.
- `Color R`: Only used by Fade Camera. Only meaningful when `Type` == `Fade Camera`.
- `Mugshot Override`: Only used by Show Message, Ask Quiz, and Prompt Player. Only meaningful when `Type` in {`Show Message`, `Ask Quiz`, `Prompt Player`}.
- `Sound Path`: Only used by Play Sound. Only meaningful when `Type` == `Play Sound`.
- `Expected`: Only used by Prompt Player. Only meaningful when `Type` == `Prompt Player`.
- `Message`: Only used by Prompt Player. Only meaningful when `Type` == `Prompt Player`.
- `Option 1`: Only used by Ask Quiz. Only meaningful when `Type` == `Ask Quiz`.
- `Option 2`: Only used by Ask Quiz. Only meaningful when `Type` == `Ask Quiz`.
- `Option 3`: Only used by Ask Quiz. Only meaningful when `Type` == `Ask Quiz`.
- `Question`: Only used by Ask Quiz. Only meaningful when `Type` == `Ask Quiz`.
- `Speaker`: Only used by Show Message, Ask Quiz, and Prompt Player. Only meaningful when `Type` in {`Show Message`, `Ask Quiz`, `Prompt Player`}.
- `Text`: Only used by Show Message. Only meaningful when `Type` == `Show Message`.
- `Actor`: Only used by Move Actor and Set Pose. Only meaningful when `Type` in {`Move Actor`, `Set Pose`}.
- `Animation`: Only used by Set Pose. Only meaningful when `Type` == `Set Pose`.
- `Direction`: Only used by Set Pose. Only meaningful when `Type` == `Set Pose`.
- `Duration`: Only used by Fade Camera and Move Camera. Only meaningful when `Type` in {`Fade Camera`, `Move Camera`}.
- `End Animation`: Only used by Move Actor. Only meaningful when `Type` == `Move Actor`.
- `End Direction`: Only used by Move Actor. Only meaningful when `Type` == `Move Actor`.
- `End Hold Seconds`: Only used by Move Actor. Only meaningful when `Type` == `Move Actor`.
- `End Loop`: Only used by Move Actor. Only meaningful when `Type` == `Move Actor`.
- `Fail Next`: Only used when Type == 'Prompt Player' with Expected set. Only meaningful when `Type` == `Prompt Player`.
- `Hold Seconds`: Only used by Set Pose. Only meaningful when `Type` == `Set Pose`.
- `Loop`: Only used by Set Pose. Only meaningful when `Type` == `Set Pose`.
- `Move Animation`: Only used by Move Actor. Only meaningful when `Type` == `Move Actor`.
- `Move Direction`: Only used by Move Actor. Only meaningful when `Type` == `Move Actor`.
- `Move Speed`: Only used by Move Actor. Only meaningful when `Type` == `Move Actor`.
- `Next 1`: Only used when Type == 'Ask Quiz'. Only meaningful when `Type` == `Ask Quiz`.
- `Next 2`: Only used when Type == 'Ask Quiz'. Only meaningful when `Type` == `Ask Quiz`.
- `Next 3`: Only used when Type == 'Ask Quiz'. Only meaningful when `Type` == `Ask Quiz`.
- `Target`: Only used by Move Actor and Move Camera. Only meaningful when `Type` in {`Move Actor`, `Move Camera`}.
- `Target X`: Only used when Target is empty and Type is Move Actor or Move Camera. If Target X/Y/Z are all empty, the step node's own Tiled position is used. Only meaningful when `Type` in {`Move Actor`, `Move Camera`}.
- `Target Y`: Only used when Target is empty and Type is Move Actor or Move Camera. If Target X/Y/Z are all empty, the step node's own Tiled position is used. Only meaningful when `Type` in {`Move Actor`, `Move Camera`}.
- `Target Z`: Only used when Target is empty and Type is Move Actor or Move Camera. If Target X/Y/Z are all empty, the step node's own Tiled position is used. Only meaningful when `Type` in {`Move Actor`, `Move Camera`}.
- `Wait Seconds`: Only used when Type == 'Wait'. Only meaningful when `Type` == `Wait`.
- `Event Name`: Only used by Emit Event. Only meaningful when `Type` == `Emit Event`.

