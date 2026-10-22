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
Placed non-player character.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Animation Name` | string |  | `""` | appearance | Idle animation; uses asset default if empty. |
| `Asset Name` | string | yes | `""` | appearance | Sprite asset name (no extension). |
| `Direction` | string (Direction) | yes | `Down` | appearance | Initial facing (Tiled default populates it). |
| `Dont Face Player` | bool |  | false | appearance | If true, the NPC does not turn to face the player. |
| `Mug Animation Name` | string |  | `""` | appearance | Portrait animation used while talking. |
| `First Dialogue` | object |  | `""` | dialogue | Reference to the root Dialogue object. |
| `Next Waypoint 1` | object |  | `""` | gameplay | First waypoint in the NPC's path. |
| `Player Exclusive` | bool |  | false | advanced | Only spawned for the owning player. |
| `Quest Exclusive` | string |  | `""` | advanced | Quest name; when set, the NPC is created per-player for that quest. |
| `Quest NPC` | bool |  | false | advanced | NPC is tied to quest state (see Quest Exclusive / Quest State). |
| `Quest State` | string |  | `active` | advanced | Required quest state for the NPC to appear. |

**Conditional properties**

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
Navigation node for NPCs.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Date` | string |  | `""` | gameplay |  |
| `Direction` | string (Direction) |  | `""` | gameplay |  |
| `Next Waypoint 1` | object |  | `""` | gameplay |  |
| `Next Waypoint 2` | object |  | `""` | gameplay |  |
| `Next Waypoint 3` | object |  | `""` | gameplay |  |
| `Next Waypoint 4` | object |  | `""` | gameplay |  |
| `Next Waypoint 5` | object |  | `""` | gameplay |  |
| `Wait Time` | number |  | 0 | gameplay |  |
| `Waypoint Type` | string (WaypointType) |  | `first` | gameplay | How the next waypoint is selected. |

**Template properties:** `Next Waypoint N` — add additional numbered instances manually in Tiled.

**Conditional properties**

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
| `Button Behavior` | string (ButtonBehavior) |  | `One-Time` | gameplay | Same modes as OW Button. Group members never run their own checkpoint actions; their state feeds the parent group. |
| `Script Path` | file |  | `""` | gameplay |  |
| `Trigger Height` | number |  | 4 | gameplay | Trigger rectangle height in map tiles. |
| `Trigger Object` | object |  | `""` | gameplay | Optional separate trigger object. When set, its bounds override the button's own rectangle. |
| `Trigger Type` | string (TriggerShape) |  | `rect` | gameplay | Rectangle vs ellipse detection shape. |
| `Trigger Width` | number |  | 4 | gameplay | Trigger rectangle width in map tiles. |

**Conditional properties**

- `Activated Time`: Only used when Button Behavior == 'Timed'. Only meaningful when `Button Behavior` == `Timed`.
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

