1. Object Type or Class
For the engine to recognise your Tiled object as a tournament board, you must set either:

Type = "Tournament Board"
– OR –

Class = "Tournament Board"

(You don’t need to set both; the code checks object.type == "Tournament Board" or object.class == "Tournament Board".)

2. Custom Properties – Full Reference
All properties are string or number values.
The code reads them from object.custom_properties.
Spelling and capitalisation matter exactly as listed, though the system normalises booleans and the Board Type.

A. Board Type (New – determines behaviour)
Property Name (pick one)	Value (case‑insensitive)	Behaviour
Board Type
board_type
Type	scheduled	Default if omitted. Starts at the configured time (see scheduling properties). Global auto_start_when_full may still apply.
instant	Starts as soon as the first player registers. All remaining slots are filled with NPCs. Registration is always “open”.
hosted	The first registrant becomes the host. When that host interacts with the board again, a fourth option "Start Tournament" appears (currently prints a placeholder; see notes).
full_wait	Starts only when 8 human players have registered. Fills empty slots with NPCs at that moment.
mixed_timer	Starts at the scheduled time or when 8 players join, whichever comes first.
If omitted	→ scheduled	Existing behaviour.
B. Visual & Theme Properties
Property Name (pick one)	Type	Description	Valid Values	Default
Tournament Name
Name	string	Display name of the tournament.	Any text.	"WCity Tournament"
Board Background
Tournament Background
board_theme	string	Colour theme for the bracket background and grid.	blue_bn4
green_bn4
pink_yellow_bn4
pink_bn4
lemon_lime_bn4
green_blue_white_bn4
red_orange_bn4	red_orange_bn4
Board Title
board_title	string	Title text displayed on the banner.	Any text.	none
Tournament Title
Tournament Title Banner
Title Banner	string	Which banner image to display.	free-tourney
den-battle
eagle
red-sun	free-tourney
Tournament NPC Pool
NPC Pool	string	Currently unused – placeholder for future custom NPC pools.	Any text (e.g., "default").	"default"
C. Scheduling & Timing Properties (for scheduled and mixed_timer types)
Property Name (pick one)	Type	Description	Valid Values	Default
Tournament Every Hours
Every Hours
Schedule Every Hours	number	How often the tournament repeats (in hours).	Any positive integer.	1
Tournament Hour Offset
Schedule Hour Offset
Hour Offset	number	Offset within the repeat period (0–23).	0–23	0
Tournament Start Minute
Start Minute	number	Minute of the hour when it starts.	0–59	0
Tournament Start Second
Start Second	number	Second of the minute.	0–59	0
Registration Lead Seconds
Tournament Registration Seconds
Registration Seconds	number	How many seconds before the scheduled start that registration opens.	Any positive integer.	600 (10 min)
Tournament Battle Timeout Seconds
Battle Timeout Seconds
Match Timeout Seconds	number	Max seconds a battle can last before a random winner is chosen.	Any positive integer.	600 (10 min)
D. Reward & Stakes Properties
Property Name (pick one)	Type	Description	Valid Values	Default
Tournament Money Reward
Money Reward
Winner Money	number	In‑game money awarded to the champion.	Any integer ≥ 0.	0
Tournament GP Reward
GP Reward
Winner GP	number	GP (guild points, if used) awarded to the champion.	Any integer ≥ 0.	0
Tournament GP Stakes
Deduct Opposing Team GP
GP Stakes	boolean	If "true", deduct GP from the losing side. (Not fully implemented in core code yet.)	"true" / "false" / "yes" / "no" / "1" / "0"	"false"
E. Gameplay / Battle Properties
Property Name (pick one)	Type	Description	Valid Values	Default
Tournament PVP Mode
PVP Mode	string	Controls HP behaviour. "wcity" may skip forced HP; "auto" forces HP to 1000.	auto
wcity
(any other string)	auto
Tournament Force PVP HP
Force PVP HP	boolean	Override the PVP HP rule. If "false", do not force HP; if "true", force it.	"true" / "false" / etc.	(derived from pvp_mode; usually true)
3. How to Add Properties in Tiled
Select your tournament board object.

Open the Custom Properties pane.

For each property you want to set, add a new property with the exact name from the list above, and set its value accordingly.

Important:

Numeric values should be entered as numbers (or strings of digits).

Boolean values accept: true, false, yes, no, 1, 0 (case‑insensitive).

All other values are plain text strings.

4. Quick Examples
Example A – “Instant Battle” Board (starts immediately)
Type / Class = Tournament Board

Board Type = instant

Tournament Name = "Quick Rumble"

Board Background = pink_bn4

Example B – “Scheduled Grand Tournament” (starts every 2 hours at XX:30)
Type / Class = Tournament Board

(Board Type omitted – defaults to scheduled)

Tournament Every Hours = 2

Tournament Start Minute = 30

Registration Lead Seconds = 300 (5 min warning)

Winner Money Reward = 5000

Example C – “Full Wait” Ranked Board (needs 8 players)
Type / Class = Tournament Board

Board Type = full_wait

Board Title = "Ranked Arena"

PVP Mode = wcity (no HP forcing)

Example D – “Hosted” Board (host starts it manually)
Type / Class = Tournament Board

Board Type = hosted

(When the host interacts, they will see a “Start Tournament” button – currently prints a console message.)

5. Important Notes
Board Type is case‑insensitive – the code lower‑cases it (scheduled, instant, etc.).

If you omit Board Type, the board behaves as scheduled and respects the global fallback auto_start_when_full (if set in the server config).

The hosted board’s “Start Tournament” option does not actually launch the tournament yet – it only prints a message. Uncomment the start_queue_tournament(queue, true) line in tournament-manager.lua when you’re ready to enable it.

The background theme keys (blue_bn4, etc.) must match exactly – they point to asset paths defined in tournament-constants.lua.

The title banner keys (free-tourney, etc.) must also match the keys in constants.title_banner_paths.

