# FootBomb scripts — configuration refactor

`main.lua` now imports the shared configuration and roster modules instead of duplicating their values:

- `constants.lua`: source area, asset folders/default Ref assets, cursor assets, off-map position, selector layout, prompt styling, bomb-selector coordinates, direction choices, scoreboard asset/layout, and input-settle delay.
- `navi_options.lua`: selectable Navi names, texture/animation paths, and default animation state.
- `bomb_options.lua`: selectable bomb/ball skins.
- `animation_states.lua`: shared animation-state names, including the bomb preview and small-bomb states.

The main script also rejects a missing direction rather than silently treating it as `Up`; the prompt displays `none` until the player makes a selection. Existing direction-selection input clearing and release gating are preserved.

The script bundle has not been tested on a live OpenNetBattle server. Please test it in-game after replacing the existing FootBomb script files.


## Round scoring and scoreboard

After both participants confirm their directions, the round is resolved once:

- Matching Kicker and Defender directions award the point to the Defender.
- Different directions award the point to the Kicker.
- The point is credited to the winner's player slot (Player 1 or Player 2), not their role.

The scoreboard is drawn near the top center for each human participant. Player 1's score is drawn to the left of the board image and Player 2's score to the right. The board image is expected at `/server/assets/net-game-footbomb/ui/score-board.png`, with a corresponding `score-board.animation` file for `games.add_ui_element`.


## Result animation phase

The result phase begins only after both participants have confirmed their directions. The point is held until the animation completes:

1. The Kicker uses `WALK_UR` while moving to the Tiled point object named `Move Forward`.
2. The Kicker switches to `WALK_U` and moves to the Bomb point/bomb bot.
3. The bomb bot moves to `Defender 1`, `Defender 2`, or `Defender 3` according to the Kicker's selected direction (`Left`, `Up`, or `Right`).
4. Once the bomb reaches its target, the precomputed round winner receives a point and the scoreboard updates.

The map must include point objects named exactly `Move Forward`, `Defender 1`, `Defender 2`, and `Defender 3`, in addition to the existing required points. Movement speeds and update interval are configured in `constants.lua` as `RESULT_KICKER_WALK_UR_SPEED`, `RESULT_KICKER_WALK_U_SPEED`, `RESULT_BOMB_MOVE_SPEED`, and `RESULT_MOVE_STEP_SECONDS`.

Movement uses repeated `Net.move_bot` calls to interpolate between points. The bundle has not been tested on a live server; confirm the movement timing and animation names in-game.


### Interpolated result movement

The result phase uses `Net.animate_bot_properties()` keyframes to interpolate bot X/Y/Z over a duration derived from distance and the configured movement speed. It does not fall back to repeated `Net.move_bot()` calls, so missing animation-property support fails safely rather than teleporting bots. The Kicker movement keyframes preserve `WALK_UR` and `WALK_U`; the bomb keeps its current animation while moving toward the selected Defender point.


### Defender direction response

After both direction selections are confirmed, the Defender responds before the Kicker's result sequence begins:

- `Left`: interpolate to `Defender 1` with `FOOTBOMB_JUMP_LEFT`.
- `Up`: remain at `Defender 2` and use `FOOTBOMB_READY_DEFENSE`.
- `Right`: interpolate to `Defender 3` with `FOOTBOMB_JUMP_RIGHT`.

The movement speed is controlled by `RESULT_DEFENDER_JUMP_SPEED` in `constants.lua`.
