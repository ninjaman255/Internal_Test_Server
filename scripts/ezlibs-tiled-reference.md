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

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Activated Animation` | string |  | `""` |  |  |
| `Activation Animation Duration` | number |  | 0.5 |  |  |
| `Active Animation` | string |  | `ACTIVE` |  |  |
| `Animation Name` | string |  | `""` |  |  |
| `Asset Name` | string |  | `""` |  |  |
| `Deactivated Animation` | string |  | `""` |  |  |
| `Deactivation Animation Duration` | number |  | 0.5 |  |  |
| `Direction` | string (Direction) |  | `Down` |  |  |
| `Inactive Animation` | string |  | `INACTIVE` |  |  |
| `Mug Animation Name` | string |  | `""` |  |  |

### OW Button
**Category:** gameplay
One button in the ezbuttons system.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Activated Time` | number |  | 1 | gameplay |  |
| `Bot Details` | object |  | `""` | gameplay |  |
| `Button Activated Behavior` | object |  | `""` | gameplay |  |
| `Button Behavior` | string (ButtonBehavior) |  | `One-Time` | gameplay |  |
| `Button Chain Type` | string (ButtonChainType) |  | `Any` | gameplay |  |
| `Button Deactivated Behavior` | object |  | `""` | gameplay |  |
| `Next 1` | object |  | `""` | gameplay |  |
| `Script Path` | file |  | `""` | gameplay |  |
| `Trigger Height` | number |  | 4 | gameplay |  |
| `Trigger Object` | object |  | `""` | gameplay |  |
| `Trigger Type` | string (TriggerShape) |  | `rect` | gameplay |  |
| `Trigger Width` | number |  | 4 | gameplay |  |

**Template properties:** `Next N` — add additional numbered instances manually in Tiled.

### OW Button Group Member
**Category:** gameplay
Button participating in a Button Group.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Activated Time` | number |  | 1 | gameplay |  |
| `Bot Details` | object |  | `""` | gameplay |  |
| `Button Behavior` | string (ButtonBehavior) |  | `One-Time` | gameplay |  |
| `Script Path` | file |  | `""` | gameplay |  |
| `Trigger Height` | number |  | 4 | gameplay |  |
| `Trigger Object` | object |  | `""` | gameplay |  |
| `Trigger Type` | string (TriggerShape) |  | `rect` | gameplay |  |
| `Trigger Width` | number |  | 4 | gameplay |  |

### Unlock Behavior

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Area Wide` | bool |  | false |  |  |
| `Unlock Permanently` | bool |  | false |  |  |
| `Unlock This` | object |  | `""` |  |  |

### Relock Behavior

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Area Wide` | bool |  | false |  |  |
| `Relock This` | object |  | `""` |  |  |

### Button Trigger

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Trigger Type` | string (TriggerShape) |  | `rect` |  |  |

### Button Group
**Category:** gameplay
Group of OW Buttons that satisfy together.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Button 1` | object |  | `""` | gameplay |  |
| `Forbidden Button 1` | object |  | `""` | gameplay |  |
| `Group ID` | string |  | `""` | gameplay |  |
| `Group Mode` | string (ButtonGroupMode) |  | `all_active` | gameplay |  |
| `Relock Area Wide` | bool |  | false | gameplay |  |
| `Relock Checkpoint 1` | object |  | `""` | gameplay |  |
| `Unlock Area Wide` | bool |  | false | gameplay |  |
| `Unlock Checkpoint 1` | object |  | `""` | gameplay |  |
| `Unlock Permanently` | bool |  | true | gameplay |  |

**Template properties:** `Button N`, `Forbidden Button N`, `Unlock Checkpoint N`, `Relock Checkpoint N` — add additional numbered instances manually in Tiled.

### Button Combo
**Category:** gameplay
One button pattern with optional unlock/relock targets.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Button 1` | object |  | `""` | gameplay |  |
| `Forbidden Button 1` | object |  | `""` | gameplay |  |
| `Relock Area Wide` | bool |  | false | gameplay |  |
| `Relock Checkpoint 1` | object |  | `""` | gameplay |  |
| `Unlock Area Wide` | bool |  | false | gameplay |  |
| `Unlock Checkpoint 1` | object |  | `""` | gameplay |  |
| `Unlock Permanently` | bool |  | true | gameplay |  |

**Template properties:** `Button N`, `Forbidden Button N`, `Unlock Checkpoint N`, `Relock Checkpoint N` — add additional numbered instances manually in Tiled.

### Combo Button Group
**Category:** gameplay
Any referenced Button Combo satisfies the group.

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Button Combo 1` | object |  | `""` | gameplay |  |
| `Combo Mode` | string (ButtonComboMode) |  | `Inclusive` | gameplay |  |
| `Group ID` | string |  | `""` | gameplay |  |

**Template properties:** `Button Combo N` — add additional numbered instances manually in Tiled.

### Button Effect

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Action` | string (ButtonEffectAction) |  | `activate` |  |  |
| `Event` | string (ButtonEffectEvent) |  | `activated` |  |  |
| `Source Button` | object |  | `""` |  |  |
| `Target Button` | object |  | `""` |  |  |

### Button Group Effect

| Property | Type | Required | Default | Category | Description |
|---|---|---|---|---|---|
| `Action` | string (ButtonEffectAction) |  | `activate` |  |  |
| `Button Group` | object |  | `""` |  |  |
| `Event` | string (ButtonGroupEvent) |  | `completed` |  |  |
| `Target Button` | object |  | `""` |  |  |

