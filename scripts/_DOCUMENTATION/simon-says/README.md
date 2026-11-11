# 🎮 Simon Says — Gameplay and control integration

[🏠 Documentation home](../index.md) · [📄 Lua API reference](index.md)

## Contents
- [Lifecycle and control ownership](#lifecycle-and-control-ownership)
- [Player position and facing](#player-position-and-facing)
- [Indicator jitter and sprite bounds](#indicator-jitter-and-sprite-bounds)
- [Map object configuration](#map-object-configuration)
- [Test checklist](#test-checklist)

## Lifecycle and control ownership

Simon Says uses the shared `PlayerControl` engine-input capture rather than directly calling `Net.lock_player_input`. `virtual_input` events still drive the minigame, but native player movement remains locked from acceptance until the win/timeout fade finishes.

1. A player interacts with a spawned Simon NPC and accepts his question.
2. `PlayerControl.acquire_capture(player_id, "simon-says")` locks native movement.
3. During the blackout, the script stores the entry position/direction, positions the player in front of Simon, faces the player toward him, and hides the engine HUD.
4. The board and countdown appear. **Input capture stays active while the introduction textboxes are shown.** The previous intermediate release/reacquire that allowed movement is removed.
5. Gameplay receives `Net:on("virtual_input")`. Accepted inputs remain Interact/Confirm, Shoulder L/R and four movement directions. The actual character does not walk when the movement buttons are pressed.
6. On a win or timeout, the game fades out, removes its overlay elements, restores the player's entry position/facing, restores the engine HUD, fades in, releases occupancy and releases the input capture.

The Simon NPC uses an `occupied` flag to prevent multiple players entering the same match simultaneously. On disconnect, the handler clears this flag; PlayerControl's own disconnect cleanup is responsible for releasing engine resources.

## Player position and facing

Simon is created with animation `IDLE_DR` (Down Right). Based on the server's `Direction.to_vector` mapping, Down Right corresponds to `+X`. The minigame moves the player to:

```lua
x = simon.x + 1
y = simon.y
z = simon.z
```

The player then plays `IDLE_UL`, facing Up Left toward Simon. This uses `Net.move_player`, with `Net.set_player_position` as a fallback, plus `Net.animate_player`. These calls are already used elsewhere in the server. This is a scripted placement, not a same-area transfer.

The original player position and facing are saved before placement and restored after a completed game. If neither positioning API is available, Simon Says logs a warning and leaves the player where they were rather than invoking an unverified API.

## Indicator jitter and sprite bounds

The `indicators.png` atlas is **47×51 pixels** and uses specific small frame rectangles for `A`, `LS`, `RS`, `D`, `L`, `R` and `U`. These rectangles are within the atlas bounds.

Previously, wrong-answer jitter called `games.move_map_element`, which invokes `Net.move_bot` for an actor in the same area. That can trigger walking animations, but the indicator asset's `WALK_*` states have **no frames**. The resulting sheet-like visual is consistent with the video.

The new jitter calls `Net.animate_bot_properties` with four 0.1-second X/Y keyframes; every keyframe explicitly includes the current `Animation` state. The indicator returns to its original position, and the next prompt replaces it only after the 0.4-second sequence completes. No atlas image or animation file needs to be resized.

## Map object configuration

| Tiled field | Use | Default when absent |
|---|---|---|
| Object type | Must equal `Simon Says` | Required |
| Object name | Used in Simon bot identifier | Object must have a usable name |
| `NPC` | NPC asset base path | `/server/assets/simon-says/normal-navi-bn4_green` |
| `NPC Mug` | Mugshot asset base path | `/server/assets/simon-says/normal-navi-bn4_green-mug` |
| `Time` | Countdown in seconds | `60` |
| `Limit` | Correct inputs needed to win | `60` |

The supplied `areas/default.tmx` has `defaultsimon` with `Time=30` and `Limit=10`. The player front offset assumes Simon uses the currently hardcoded `IDLE_DR` direction; changing his spawned facing also requires adjusting that offset and the player's facing.

## Test checklist

- [ ] Accept Simon's question and verify the player is repositioned one tile Down Right of Simon, facing Up Left.
- [ ] With the board and instructions on screen, try movement and ensure the character **does not move**.
- [ ] Confirm that directional buttons still register game answers.
- [ ] Enter an incorrect answer and verify only the currently selected button symbol shakes; no whole-atlas frame appears.
- [ ] Win and separately time out; check UI, HUD, input and original player position/facing are restored.
- [ ] Decline the question; Simon should not remain occupied.
- [ ] Disconnect during a game; Simon should become available to another player.

The script passed syntax checks and a mock-engine win/timeout test. The visual sheet-cropping and native facing must still be verified in a live OpenNetBattle client.
