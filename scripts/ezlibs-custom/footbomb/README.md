# FootBomb PvP disconnect return

When a player disconnects during a player-vs-player FootBomb match, the disconnect handler now snapshots the remaining participant before unregistering the disconnected player, removes the remaining participant's FootBomb representation, and transfers them to the original non-instanced area. It uses the saved return tile in front of the Ref-Prog when available, with a default-area-spawn fallback if the positioned transfer fails. NPC matches and non-FootBomb instances are not changed.

This is a source change only; in-game disconnect behavior has not been tested.
