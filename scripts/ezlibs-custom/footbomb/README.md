# FootBomb mugshot freshness fix

This update scopes scoreboard UI element IDs to both the match instance and player, avoiding reuse of mugshot UI bindings across games. Before drawing a scoreboard portrait, the code removes the existing element, re-provides the exact current bot's mugshot texture and animation, and logs the selected Navi and asset paths for diagnosis.

The change preserves the current roster and selected-skin mapping. Runtime behavior still needs in-game verification.
