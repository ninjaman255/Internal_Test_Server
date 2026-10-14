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
