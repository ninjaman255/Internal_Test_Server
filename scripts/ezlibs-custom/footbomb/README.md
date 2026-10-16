# FootBomb textbox role-label visibility update

The bottom-center Kicker/Defense role label is removed before the direction confirmation message/quiz sequence. If the player declines and returns to direction selection, the label is redrawn after the textbox is dismissed and the direction UI is restored. If the player confirms, the label remains hidden through the waiting message; normal match-start HUD setup restores it when active gameplay is revealed.

Based on the latest `footbomb-mugshot-fresh.zip` source.
