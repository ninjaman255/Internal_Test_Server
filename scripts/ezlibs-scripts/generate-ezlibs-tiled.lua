-- generate-ezlibs-tiled.lua
-- Generates three artifacts from a single source of truth:
--
--   ezlibs-tiled-types.json    — Tiled project types (unchanged shape;
--                                 metadata fields are stripped so Tiled
--                                 doesn't see anything it might reject).
--   ezlibs-tiled-schema.lua    — Runtime schema including category/required/
--                                 description/dependsOn metadata, consumed by
--                                 tiled_utils.validate_properties.
--   ezlibs-tiled-reference.md  — Map-maker reference generated from the same
--                                 metadata, grouped by category, with a
--                                 conditional-properties section per class.
--
-- Run with: lua generate-ezlibs-tiled.lua [output_path_for_types_json]
--
-- Where each file goes:
--   * types.json       — wherever output_path points (default: cwd).
--   * schema.lua       — next to this generator script. The runtime
--                        requires it from the fixed module path
--                        scripts.ezlibs-scripts.ezlibs-tiled-schema, so its
--                        location is effectively fixed by convention.
--   * reference.md     — same as schema.lua.

local json = require('scripts/ezlibs-scripts/json')

-- ----------------------------------------------------------------------
-- Enums
local Enums = {
    Direction = {
        type = "string",
        values = {"Up", "Down", "Left", "Right", "Up Left", "Up Right", "Down Left", "Down Right"}
    },
    MysteryType = {
        type = "string",
        values = {"keyitem", "item", "money", "random", "quiz", "fragments", "tokens", "encounter"}
    },
    WaypointType = {
        type = "string",
        values = {"first", "random", "before", "after"}
    },
    DialogueType = {
        type = "string",
        values = {"first", "question", "quiz", "random", "itemcheck", "before", "after",
                  "shop", "password", "quest_switch", "quest_event", "item", "email",
                  "questcheck", "battle_npc"}
    },
    ItemType = {
        type = "string",
        values = {"item", "keyitem", "money", "fragments", "tokens"}
    },
    CurrencyType = {
        type = "string",
        values = {"money", "fragments", "tokens"}
    },
    QuizFailAction = {
        type = "string",
        values = {"retry", "hide_once", "hide_temp", "explode"}
    },
    TriggerShape = {
        type = "string",
        values = {"rect", "ellipse"}
    },
    ButtonBehavior = {
        type = "string",
        values = {"Pressure Plate", "One-Time", "Toggle", "Custom", "Timed"}
    },
    KeyType = {
        type = "string",
        values = {"money", "fragments", "tokens", "item", "bossgate",
                  "navi_name", "navi_element", "navi_list"}
    },
    ButtonChainType = {
        type = "string",
        values = {"Any", "Exclusive"}
    },
    ButtonGroupMode = {
        type = "string",
        values = {"all_active", "any_active", "combination"}
    },
    ButtonComboMode = {
        type = "string",
        values = {"Inclusive", "Exclusive"}
    },
    ButtonEffectEvent = {
        type = "string",
        values = {"activated", "deactivated"}
    },
    ButtonGroupEvent = {
        type = "string",
        values = {"completed", "incomplete"}
    },
    ButtonEffectAction = {
        type = "string",
        values = {"activate", "deactivate", "toggle", "reset"}
    },
    CompressionMode = {
        type = "string",
        values = {"Compress", "Normalize", "Enlarge"}
    },
    SizeModeScope = {
        type = "string",
        values = {"Player", "Area Wide"}
    },
    NaviElement = {
        type = "string",
        values = {"None", "Fire", "Aqua", "Elec", "Wood", "Sword",
                  "Break", "Cursor", "Wind", "Summon", "Plus"}
    },
    CutsceneStepType = {
        type = "string",
        values = {"Wait", "Move Actor", "Set Pose", "Show Message",
                  "Ask Quiz", "Prompt Player", "Play Sound",
                  "Fade Camera", "Move Camera", "Emit Event"}
    },
    NPCSpawnMode = {
        type = "string",
        values = {"Once", "Interval"}
    },
}

-- ----------------------------------------------------------------------
local function prop(name, typ, default, enumName)
    local p = { name = name, type = typ, value = default }
    if enumName then
        p.propertyType = enumName
    end
    return p
end

-- ----------------------------------------------------------------------
-- Object types
local object_types = {
    {
        name = "Checkpoint",
        color = "#ffaa00",
        members = {
            prop("Password", "string", ""),
            prop("Key Type", "string", "money", "KeyType"),
            prop("Key Item Name", "string", ""),
            prop("Required Keys", "number", 1),
            prop("Consume", "bool", false),
            prop("Once", "bool", false),
            prop("Unlocking Asset Name", "string", "bn5cubegreen_bot"),
            prop("Unlocking Animation Time", "number", 0),
            prop("Unlocking Sound Path", "string", "/server/assets/ezlibs-assets/sfx/panel_change.ogg"),
            prop("Skip Prompt", "bool", false),
            prop("Description", "string", "It's a Security Cube"),
            prop("Unlocked Message", "string", "The Security Cube was unlocked!"),
            prop("Unlock Failed Message", "string", "You were unable to unlock the Security Cube"),
            prop("Navi Name", "string", ""),
            prop("Navi Element", "string", "", "NaviElement"),
            prop("Navi 1", "string", ""),
            prop("Navi 2", "string", ""),
            prop("Navi 3", "string", ""),
            prop("Navi 4", "string", ""),
            prop("Navi 5", "string", ""),
            prop("Navi 6", "string", ""),
            prop("Navi 7", "string", ""),
            prop("Navi 8", "string", ""),
            prop("Navi 9", "string", ""),
            prop("Navi 10", "string", ""),
        }
    },
    {
        name = "Mystery Data",
        color = "#00aaff",
        members = {
            prop("Locked", "bool", false),
            prop("Password Locked", "string", ""),
            prop("Once", "bool", false),
            prop("Type", "string", "item", "MysteryType"),
            prop("Name", "string", ""),
            prop("Description", "string", ""),
            prop("Amount", "number", 1),
            prop("Quiz List", "object", ""),
            prop("Failure Message", "string", ""),
            prop("On Fail", "string", "retry", "QuizFailAction"),
            prop("Explosion Count", "number", 3),
            prop("Reward Type", "string", "item", "ItemType"),
            prop("Reward Name", "string", ""),
            prop("Reward Amount", "number", 1),
            prop("Reward Description", "string", ""),
            prop("Cost Type", "string", "", "CurrencyType"),
            prop("Cost Amount", "number", 1),
            prop("Cost Failure Message", "string", ""),
            prop("Next 1", "object", ""),
            prop("Next 2", "object", ""),
            prop("Next 3", "object", ""),
            prop("Next 4", "object", ""),
            prop("Next 5", "object", ""),
            prop("Next 6", "object", ""),
            prop("Next 7", "object", ""),
            prop("Next 8", "object", ""),
            prop("Next 9", "object", ""),
            prop("Next 10", "object", ""),
        }
    },
    {
        name = "Quiz List",
        color = "#aa66cc",
        members = {
            prop("Next 1", "object", ""),
            prop("Next 2", "object", ""),
            prop("Next 3", "object", ""),
            prop("Next 4", "object", ""),
            prop("Next 5", "object", ""),
            prop("Next 6", "object", ""),
            prop("Next 7", "object", ""),
            prop("Next 8", "object", ""),
            prop("Next 9", "object", ""),
            prop("Next 10", "object", ""),
        }
    },
    {
        name = "Quiz Question",
        color = "#88aa44",
        members = {
            prop("Question", "string", ""),
            prop("Option 1", "string", ""),
            prop("Option 2", "string", ""),
            prop("Option 3", "string", ""),
            prop("Correct Answer", "number", 1),
        }
    },
    {
        name = "Location Trigger",
        color = "#88ff88",
        members = {
            prop("Event Name", "string", ""),
            prop("Name", "string", ""),
        }
    },
    {
        name = "Server Warp",
        color = "#ff8888",
        members = {
            prop("Incoming Data", "string", ""),
            prop("Direction", "string", "Down", "Direction"),
            prop("Warp In", "bool", false),
            prop("Arrival Animation", "string", ""),
            prop("Dont Teleport", "bool", false),
            prop("Address", "string", ""),
            prop("Port", "number", 0),
            prop("Data", "string", ""),
            prop("Warp Out", "bool", false),
        }
    },
    {
        name = "Custom Warp",
        color = "#ff8888",
        members = {
            prop("Incoming Data", "string", ""),
            prop("Direction", "string", "Down", "Direction"),
            prop("Warp In", "bool", false),
            prop("Arrival Animation", "string", ""),
            prop("Dont Teleport", "bool", false),
            prop("Target Area", "string", ""),
            prop("Target Object", "string", ""),
            prop("Leave Animation", "string", ""),
        }
    },
    {
        name = "Interact Warp",
        color = "#ff8888",
        members = {
            prop("Incoming Data", "string", ""),
            prop("Direction", "string", "Down", "Direction"),
            prop("Warp In", "bool", false),
            prop("Arrival Animation", "string", ""),
            prop("Dont Teleport", "bool", false),
            prop("Target Area", "string", ""),
            prop("Target Object", "string", ""),
            prop("Leave Animation", "string", ""),
        }
    },
    {
        name = "Radius Warp",
        color = "#ff8888",
        members = {
            prop("Incoming Data", "string", ""),
            prop("Direction", "string", "Down", "Direction"),
            prop("Warp In", "bool", false),
            prop("Arrival Animation", "string", ""),
            prop("Dont Teleport", "bool", false),
            prop("Activation Radius", "number", 1),
            prop("Target Area", "string", ""),
            prop("Target Object", "string", ""),
            prop("Leave Animation", "string", ""),
        }
    },
    {
        name = "NPC",
        color = "#aaaaaa",
        members = {
            prop("Direction", "string", "Down", "Direction"),
            prop("Asset Name", "string", ""),
            prop("Animation Name", "string", ""),
            prop("Mug Animation Name", "string", ""),
            prop("Dont Face Player", "bool", false),
            prop("First Dialogue", "object", ""),
            prop("Cutscene", "string", ""),
            prop("Next Waypoint 1", "object", ""),
            prop("Player Exclusive", "bool", false),
            prop("Quest NPC", "bool", false),
            prop("Quest Exclusive", "string", ""),
            prop("Quest State", "string", "active"),
            prop("Template Only", "bool", false),
        }
    },
    {
        name = "Pushback NPC",
        color = "#ff6666",
        members = {
            prop("Direction", "string", "Down", "Direction"),
            prop("Asset Name", "string", "male-navi-exe6_teal"),
            prop("Animation Name", "string", ""),
            prop("Mug Animation Name", "string", ""),
            prop("Dont Face Player", "bool", false),
            prop("First Dialogue", "object", ""),
            prop("Next Waypoint 1", "object", ""),
            prop("Player Exclusive", "bool", false),
            prop("Quest NPC", "bool", false),
            prop("Quest Exclusive", "string", ""),
            prop("Quest State", "string", "active"),
            prop("Collision Enabled", "bool", true),
            prop("Collision Width", "number", 1.5),
            prop("Collision Height", "number", 1.5),
            prop("Push Distance", "number", 1.0),
            prop("Push Duration", "number", 0.28),
            prop("Push Cooldown", "number", 0.75),
            prop("Move Animation State", "string", "MOVE"),
            prop("Template Only", "bool", false),
        }
    },
    {
        name = "NPC Behavior",
        color = "#88bbdd",
        members = {
            prop("Attached NPC", "object", ""),
            prop("Behavior", "string", "Pushback"),
            prop("Enabled", "bool", true),
            prop("Collision Width", "number", 1.5),
            prop("Collision Height", "number", 1.5),
            prop("Push Distance", "number", 1.0),
            prop("Push Duration", "number", 0.28),
            prop("Push Cooldown", "number", 0.75),
            prop("Move Animation State", "string", "MOVE"),
        }
    },
    {
        name = "NPC Spawner",
        color = "#ffcc88",
        members = {
            prop("NPC Template", "object", ""),
            prop("Trigger Radius", "number", 0),
            prop("Spawn Mode", "string", "Once", "NPCSpawnMode"),
            prop("Spawn Interval", "number", 3),
            prop("Max Alive", "number", 0),
            prop("Once", "bool", false),
            prop("Warp Out At End", "bool", false),
            prop("Warp Out Delay", "number", 0),
            prop("Warp Out Animation", "string", ""),
            prop("Warp Out Animation Duration", "number", 0.5),
        }
    },
    {
        name = "FootBomb Controller",
        color = "#ffcc66",
        members = {
            prop("Direction", "string", "Down", "Direction"),
            prop("Asset Name", "string", "male-navi-exe6_teal"),
            prop("Animation Name", "string", ""),
            prop("Mugshot", "string", ""),
            prop("Mug Animation Name", "string", ""),
            prop("Dont Face Player", "bool", false),
            prop("Instance Map", "string", "footbomb"),
            prop("Points to Win", "number", 10),
        }
    },
    {
        name = "Waypoint",
        color = "#55ff55",
        members = {
            prop("Wait Time", "number", 0),
            prop("Direction", "string", "", "Direction"),
            prop("Waypoint Type", "string", "first", "WaypointType"),
            prop("Date", "string", ""),
            prop("Move Animation", "string", ""),
            prop("Move Loop", "bool", true),
            prop("Move Duration", "number", 0),
            prop("Move Direction", "string", "", "Direction"),
            prop("Wait Animation", "string", ""),
            prop("Wait Loop", "bool", true),
            prop("Next Waypoint 1", "object", ""),
            prop("Next Waypoint 2", "object", ""),
            prop("Next Waypoint 3", "object", ""),
            prop("Next Waypoint 4", "object", ""),
            prop("Next Waypoint 5", "object", ""),
        }
    },
    {
        name = "Radius Encounter",
        color = "#ff5555",
        members = {
            prop("Radius", "number", 1),
            prop("Name", "string", ""),
            prop("Path", "file", ""),
            prop("Once", "bool", false),
        }
    },
    {
        name = "Water Refill",
        color = "#4444ff",
        members = {}
    },
    {
        name = "Item",
        color = "#ffdd44",
        members = {
            prop("Name", "string", ""),
            prop("Type", "string", "item", "ItemType"),
            prop("Description", "string", ""),
            prop("Amount", "number", 1),
            prop("Price", "number", 999999),
        }
    },
    {
        name = "Dialogue",
        color = "#cc66cc",
        members = {
            prop("Dialogue Type", "string", "first", "DialogueType"),
            prop("Event Name", "string", ""),
            prop("Mugshot", "string", ""),
            prop("Text 1", "string", ""),
            prop("Text 2", "string", ""),
            prop("Text 3", "string", ""),
            prop("Next 1", "object", ""),
            prop("Next 2", "object", ""),
            prop("Next 3", "object", ""),
            prop("Next 4", "object", ""),
            prop("Next 5", "object", ""),
            prop("Item 1", "object", ""),
            prop("Item 2", "object", ""),
            prop("Take Item", "bool", false),
            prop("Date", "string", ""),
            prop("Quest Name", "string", ""),
            prop("Event Value", "string", ""),
            prop("Dont Notify", "bool", false),
            prop("Email Id", "string", ""),
            prop("Email Icon", "number", 1),
            prop("Email Title", "string", "Mail"),
            prop("Email From", "string", "???"),
            prop("Body 1", "string", ""),
            prop("Body 2", "string", ""),
            prop("Body 3", "string", ""),
            prop("Body 4", "string", ""),
            prop("Body 5", "string", ""),
            prop("Body 6", "string", ""),
            prop("Body 7", "string", ""),
            prop("Body 8", "string", ""),
            prop("Body 9", "string", ""),
            prop("Body 10", "string", ""),
            prop("Notify Delay", "number", 1.5),
            prop("Notify Message", "string", "Looks like you got an e-mail."),
            prop("Mug Texture Path", "string", ""),
            prop("Mug Animation Path", "string", ""),
            prop("Persist", "bool", true),
            prop("Encounter Name", "string", ""),
            prop("Failure Message", "string", ""),
            prop("Kick On Loss", "bool", true),
        }
    },
    {
        name = "Explosion Trigger",
        color = "#ff6600",
        members = {
            prop("Target", "string", ""),
            prop("Follow", "bool", false),
            prop("Once", "bool", false),
        }
    },
    {
        name = "Rush Road",
        color = "#ffaa00",
        members = {
            prop("Rush Object", "object", ""),
            prop("Direction", "string", "Down Left", "Direction"),
        }
    },
    {
        name = "Compression Tile",
        color = "#88aaff",
        members = {
            prop("Mode", "string", "Compress", "CompressionMode"),
        }
    },
    {
        name = "Admin Console",
        color = "#ffaa00",
        members = {}
    },
    {
        name = "Button Bot Details",
        color = "#99ddff",
        members = {
            prop("Asset Name", "string", ""),
            prop("Direction", "string", "Down", "Direction"),
            prop("Animation Name", "string", ""),
            prop("Mug Animation Name", "string", ""),
            prop("Active Animation", "string", "ACTIVE"),
            prop("Inactive Animation", "string", "INACTIVE"),
            prop("Activated Animation", "string", ""),
            prop("Deactivated Animation", "string", ""),
            prop("Activation Animation Duration", "number", 0.5),
            prop("Deactivation Animation Duration", "number", 0.5),
        }
    },
    {
        name = "OW Button",
        color = "#66ccff",
        members = {
            prop("Bot Details", "object", ""),
            prop("Next 1", "object", ""),
            prop("Button Behavior", "string", "One-Time", "ButtonBehavior"),
            prop("Script Path", "file", ""),
            prop("Trigger Object", "object", ""),
            prop("Button Activated Behavior", "object", ""),
            prop("Button Deactivated Behavior", "object", ""),
            prop("Button Chain Type", "string", "Any", "ButtonChainType"),
            prop("Trigger Type", "string", "rect", "TriggerShape"),
            prop("Trigger Width", "number", 4),
            prop("Trigger Height", "number", 4),
            prop("Activated Time", "number", 1),
            prop("Bots Can Trigger", "bool", false),
        }
    },
    {
        name = "OW Button Group Member",
        color = "#66ddbb",
        members = {
            prop("Bot Details", "object", ""),
            prop("Button Behavior", "string", "One-Time", "ButtonBehavior"),
            prop("Script Path", "file", ""),
            prop("Trigger Object", "object", ""),
            prop("Trigger Type", "string", "rect", "TriggerShape"),
            prop("Trigger Width", "number", 4),
            prop("Trigger Height", "number", 4),
            prop("Activated Time", "number", 1),
            prop("Bots Can Trigger", "bool", false),
        }
    },
    {
        name = "Unlock Behavior",
        color = "#ffcc00",
        members = {
            prop("Unlock This", "object", ""),
            prop("Unlock Permanently", "bool", false),
            prop("Area Wide", "bool", false),
        }
    },
    {
        name = "Relock Behavior",
        color = "#ff8888",
        members = {
            prop("Relock This", "object", ""),
            prop("Area Wide", "bool", false),
        }
    },
    {
        name = "Button Trigger",
        color = "#aaddff",
        members = {
            prop("Trigger Type", "string", "rect", "TriggerShape"),
        }
    },
    {
        name = "Button Group",
        color = "#66dd99",
        members = {
            prop("Group ID", "string", ""),
            prop("Group Mode", "string", "all_active", "ButtonGroupMode"),
            prop("Button 1", "object", ""),
            prop("Forbidden Button 1", "object", ""),
            prop("Unlock Checkpoint 1", "object", ""),
            prop("Unlock Permanently", "bool", true),
            prop("Unlock Area Wide", "bool", false),
            prop("Relock Checkpoint 1", "object", ""),
            prop("Relock Area Wide", "bool", false),
        }
    },
    {
        name = "Button Combo",
        color = "#66bbdd",
        members = {
            prop("Button 1", "object", ""),
            prop("Forbidden Button 1", "object", ""),
            prop("Unlock Checkpoint 1", "object", ""),
            prop("Unlock Permanently", "bool", true),
            prop("Unlock Area Wide", "bool", false),
            prop("Relock Checkpoint 1", "object", ""),
            prop("Relock Area Wide", "bool", false)
        }
    },
    {
        name = "Combo Button Group",
        color = "#44bb88",
        members = {
            prop("Group ID", "string", ""),
            prop("Combo Mode", "string", "Inclusive", "ButtonComboMode"),
            prop("Button Combo 1", "object", "")
        }
    },
    {
        name = "Button Effect",
        color = "#ffbb66",
        members = {
            prop("Source Button", "object", ""),
            prop("Event", "string", "activated", "ButtonEffectEvent"),
            prop("Target Button", "object", ""),
            prop("Action", "string", "activate", "ButtonEffectAction")
        }
    },
    {
        name = "Button Group Effect",
        color = "#ff9966",
        members = {
            prop("Button Group", "object", ""),
            prop("Event", "string", "completed", "ButtonGroupEvent"),
            prop("Target Button", "object", ""),
            prop("Action", "string", "activate", "ButtonEffectAction")
        }
    },
    {
        name = "Cutscene",
        color = "#c678dd",
        members = {
            prop("Name", "string", ""),
            prop("Start Step", "object", ""),
            prop("Trigger Radius", "number", 0),
            prop("Once", "bool", false),
        }
    },
    {
        name = "Cutscene Step",
        color = "#e5c07b",
        members = {
            prop("Type", "string", "Wait", "CutsceneStepType"),
            prop("Next Step", "object", ""),
            prop("Next 1", "object", ""),
            prop("Next 2", "object", ""),
            prop("Next 3", "object", ""),
            prop("Fail Next", "object", ""),

            -- Wait
            prop("Wait Seconds", "number", 1),

            -- Move Actor / Set Pose / Move Camera
            prop("Actor", "object", ""),
            prop("Target", "object", ""),
            prop("Target X", "number", 0),
            prop("Target Y", "number", 0),
            prop("Target Z", "number", 0),

            -- Move Actor
            prop("Move Animation", "string", ""),
            prop("Move Direction", "string", "", "Direction"),
            prop("Move Speed", "number", 3),
            prop("End Animation", "string", ""),
            prop("End Direction", "string", "", "Direction"),
            prop("End Hold Seconds", "number", 0),
            prop("End Loop", "bool", true),

            -- Set Pose
            prop("Animation", "string", ""),
            prop("Direction", "string", "", "Direction"),
            prop("Loop", "bool", true),
            prop("Hold Seconds", "number", 0),

            -- Show Message / Ask Quiz / Prompt Player
            prop("Speaker", "object", ""),
            prop("Mugshot Override", "string", ""),
            prop("Text", "string", ""),
            prop("Question", "string", ""),
            prop("Option 1", "string", ""),
            prop("Option 2", "string", ""),
            prop("Option 3", "string", ""),
            prop("Message", "string", ""),
            prop("Expected", "string", ""),

            -- Play Sound
            prop("Sound Path", "string", ""),

            -- Fade Camera / Move Camera
            prop("Color R", "number", 0),
            prop("Color G", "number", 0),
            prop("Color B", "number", 0),
            prop("Color A", "number", 255),
            prop("Duration", "number", 0.8),

            -- Emit Event
            prop("Event Name", "string", ""),
        }
    },
}

-- ----------------------------------------------------------------------
-- META — additive metadata (never emitted into types.json; drives schema.lua,
-- reference.md, and runtime validation).
-- ----------------------------------------------------------------------
local META = {
    classes = {
        ["Checkpoint"] = { category = "gameplay",
            description = "Lockable Security Cube that gates progression.",
            numberedTemplates = { "Navi " } },
        ["Mystery Data"] = { category = "gameplay",
            description = "Pickup or event; behaviour branches on `Type`." },
        ["Quiz List"] = { category = "dialogue",
            description = "Ordered chain of Quiz Question objects.",
            numberedTemplates = { "Next " } },
        ["Quiz Question"] = { category = "dialogue",
            description = "Single quiz entry." },
        ["Dialogue"] = { category = "dialogue",
            description = "Dialogue node. Many properties are type-specific; see the Conditional section.",
            numberedTemplates = { "Text ", "Next ", "Item ", "Body " } },
        ["NPC"] = { category = "gameplay",
            description = "Placed non-player character. Set `Template Only` to use an NPC purely as a reference target for NPC Spawners without spawning it as a standalone NPC." },
        ["Pushback NPC"] = { category = "gameplay",
            description = "NPC with a moving collision zone that pushes the player." },
        ["NPC Spawner"] = { category = "gameplay",
            description = "Spawns NPCs from a template object, lets them follow a waypoint path, and optionally warps them out when the path completes. Supports one-per-entry spawning (Once mode) and continuous spawning at an interval while a player stays inside (Interval mode)." },
        ["FootBomb Controller"] = { category = "gameplay",
            description = "Interaction actor for the FootBomb minigame." },
        ["Waypoint"] = { category = "gameplay",
            description = "Navigation node for NPCs. Move Animation handles travel; Wait Animation handles the arrival hold. Set Move Duration > 0 for scripted (jump-style) movement where the animation has intrinsic timing.",
            numberedTemplates = { "Next Waypoint " } },

        -- Button system -------------------------------------------------
        ["Button Bot Details"] = { category = "appearance",
            description = "Visual and animation configuration for an OW Button." },
        ["OW Button"] = { category = "gameplay",
            description = "A pressable button. Unlocks checkpoints through a referenced Unlock Behavior.",
            numberedTemplates = { "Next " } },
        ["OW Button Group Member"] = { category = "gameplay",
            description = "Button that participates in a Button Group or Button Combo but never unlocks checkpoints on its own." },
        ["Unlock Behavior"] = { category = "gameplay",
            description = "Defines which checkpoint a button unlocks when it becomes active." },
        ["Relock Behavior"] = { category = "gameplay",
            description = "Defines which checkpoint a button re-locks when it becomes inactive." },
        ["Button Trigger"] = { category = "gameplay",
            description = "Optional standalone trigger rectangle referenced by an OW Button." },
        ["Button Group"] = { category = "gameplay",
            description = "Group of OW Button Group Members that share a satisfaction rule; owns its own checkpoint unlocks.",
            numberedTemplates = { "Button ", "Forbidden Button ",
                                  "Unlock Checkpoint ", "Relock Checkpoint " } },
        ["Button Combo"] = { category = "gameplay",
            description = "One specific button pattern; owns its own checkpoint unlocks.",
            numberedTemplates = { "Button ", "Forbidden Button ",
                                  "Unlock Checkpoint ", "Relock Checkpoint " } },
        ["Combo Button Group"] = { category = "gameplay",
            description = "A set of Button Combos; satisfying any one fires that combo's actions.",
            numberedTemplates = { "Button Combo " } },
        ["Button Effect"] = { category = "gameplay",
            description = "One button's state transition drives another button's action." },
        ["Button Group Effect"] = { category = "gameplay",
            description = "A group's completion transition drives another button's action." },

        -- Cutscene system -----------------------------------------------
        ["Cutscene"] = { category = "gameplay",
            description = "Named cutscene definition. Trigger via radius or script." },
        ["Cutscene Step"] = { category = "gameplay",
            description = "One action in a cutscene chain. Chain via Next Step; branch via Next N / Fail Next." },

        ["Compression Tile"] = { category = "advanced",
            description = "Changes player or area scale while standing inside." },
        ["Item"] = { category = "gameplay",
            description = "Inventory or shop item reference." },
        ["Rush Road"] = { category = "advanced",
            description = "ezrushroads interaction object." },
    },

    properties = {
        -- Checkpoint ----------------------------------------------------
        ["Checkpoint"] = {
            ["Password"] = { category = "gameplay",
                description = "If set, requires typing this password to unlock. Overrides Key Type." },
            ["Key Type"] = { category = "gameplay",
                description = "How to unlock when Password is empty. Ignored when Password is set." },
            ["Key Item Name"] = { category = "gameplay",
                description = "Item name required when Key Type == 'item'.",
                conditional = "Only used when Key Type == 'item'.",
                dependsOn = { property = "Key Type", equals = "item" } },
            ["Required Keys"] = { category = "gameplay",
                description = "Amount required for money / fragments / tokens / item." },
            ["Consume"] = { category = "gameplay",
                description = "Whether to consume the key on unlock." },
            ["Once"] = { category = "gameplay",
                description = "If true, stays hidden permanently; else hidden till disconnect." },
            ["Unlocking Asset Name"] = { category = "appearance",
                description = "Asset played during the unlock animation." },
            ["Unlocking Animation Time"] = { category = "appearance",
                description = "Seconds to play the unlock animation; 0 skips it." },
            ["Unlocking Sound Path"] = { category = "appearance",
                description = "Sound asset to play when the checkpoint unlocks." },
            ["Skip Prompt"] = { category = "gameplay",
                description = "If true, attempts the unlock without asking the player." },
            ["Description"] = { category = "gameplay",
                description = "Shown to the player before the unlock check." },
            ["Unlocked Message"] = { category = "gameplay",
                description = "Shown on successful unlock." },
            ["Unlock Failed Message"] = { category = "gameplay",
                description = "Shown when the unlock check fails." },
            ["Navi Name"] = { category = "gameplay",
                description = "Exact Navi name required to unlock (case-insensitive).",
                conditional = "Only used when Key Type == 'navi_name'.",
                dependsOn = { property = "Key Type", equals = "navi_name" } },
            ["Navi Element"] = { category = "gameplay",
                description = "Navi element required to unlock (case-insensitive).",
                conditional = "Only used when Key Type == 'navi_element'.",
                dependsOn = { property = "Key Type", equals = "navi_element" } },
            ["Navi 1"] = { category = "gameplay",
                description = "First entry in the approved-Navi list (any match unlocks).",
                conditional = "Only used when Key Type == 'navi_list'.",
                dependsOn = { property = "Key Type", equals = "navi_list" } },
        },

        -- NPC / Pushback / FootBomb / Spawner ---------------------------
        ["NPC"] = {
            ["Direction"] = { category = "appearance",
                description = "Initial facing (Tiled default populates it).",
                required = true },
            ["Asset Name"] = { category = "appearance",
                description = "Sprite asset name (no extension).",
                required = true },
            ["Animation Name"] = { category = "appearance",
                description = "Idle animation; uses asset default if empty." },
            ["Mug Animation Name"] = { category = "appearance",
                description = "Portrait animation used while talking." },
            ["Dont Face Player"] = { category = "appearance",
                description = "If true, the NPC does not turn to face the player." },
            ["First Dialogue"] = { category = "dialogue",
                description = "Reference to the root Dialogue object." },
            ["Cutscene"] = { category = "gameplay",
                description = "Optional cutscene name. Plays before First Dialogue on the first interaction; subsequent interactions go straight to dialogue.",
                conditional = "Only used if a Cutscene with this Name exists in the area." },
            ["Next Waypoint 1"] = { category = "gameplay",
                description = "First waypoint in the NPC's path." },
            ["Player Exclusive"] = { category = "advanced",
                description = "Only spawned for the owning player." },
            ["Quest NPC"] = { category = "advanced",
                description = "NPC is tied to quest state (see Quest Exclusive / Quest State)." },
            ["Quest Exclusive"] = { category = "advanced",
                description = "Quest name; when set, the NPC is created per-player for that quest." },
            ["Quest State"] = { category = "advanced",
                description = "Required quest state for the NPC to appear.",
                conditional = "Only used when Quest Exclusive is set.",
                dependsOn = { property = "Quest Exclusive" } },
            ["Template Only"] = { category = "advanced",
                description = "If true, this NPC is used only as a reference target for NPC Spawners and does not spawn as a regular NPC on its own. Properties (Asset Name, Direction, Next Waypoint 1, First Dialogue, Cutscene, etc.) are still read by the spawner when it creates a bot from this template." },
        },
        ["Pushback NPC"] = {
            ["Collision Enabled"] = { category = "gameplay",
                description = "Enables the push collision zone." },
            ["Collision Width"] = { category = "gameplay",
                description = "Collision rectangle width." },
            ["Collision Height"] = { category = "gameplay",
                description = "Collision rectangle height." },
            ["Push Distance"] = { category = "gameplay",
                description = "Distance the player is pushed beyond the rectangle edge." },
            ["Push Duration"] = { category = "gameplay",
                description = "Seconds the push animation lasts." },
            ["Push Cooldown"] = { category = "gameplay",
                description = "Seconds before the same player can be pushed again." },
            ["Move Animation State"] = { category = "appearance",
                description = "Bot animation state played during the push." },
            ["Template Only"] = { category = "advanced",
                description = "If true, this NPC is used only as a reference target for NPC Spawners and does not spawn as a regular NPC on its own.",
                conditional = "Only meaningful if the referenced spawner does not also need collision push behaviour on the spawned bot." },
        },
        ["NPC Behavior"] = {
            ["Attached NPC"] = { category = "gameplay",
                description = "Object reference to an NPC or NPC template that receives this behavior.", required = true },
            ["Behavior"] = { category = "gameplay",
                description = "Registered behavior implementation to attach. Currently supported: Pushback." },
            ["Enabled"] = { category = "gameplay",
                description = "Allows this behavior to be disabled without deleting the behavior object." },
            ["Collision Width"] = { category = "gameplay",
                description = "Pushback behavior collision rectangle width in tiles.", conditional = "Used by Pushback behavior." },
            ["Collision Height"] = { category = "gameplay",
                description = "Pushback behavior collision rectangle height in tiles.", conditional = "Used by Pushback behavior." },
            ["Push Distance"] = { category = "gameplay",
                description = "Distance to push a player beyond the collision rectangle.", conditional = "Used by Pushback behavior." },
            ["Push Duration"] = { category = "gameplay",
                description = "Duration of the push movement in seconds.", conditional = "Used by Pushback behavior." },
            ["Push Cooldown"] = { category = "gameplay",
                description = "Seconds before this NPC can push the same player again.", conditional = "Used by Pushback behavior." },
            ["Move Animation State"] = { category = "appearance",
                description = "Animation state played during pushback.", conditional = "Used by Pushback behavior." },
        },
        ["NPC Spawner"] = {
            ["NPC Template"] = { category = "gameplay",
                description = "Reference to an NPC object to spawn. The referenced NPC should have `Template Only` enabled so it doesn't also spawn as a regular NPC on map load.",
                required = true },
            ["Trigger Radius"] = { category = "gameplay",
                description = "If > 0, spawning is gated on a player being within this radius (in tiles) around the spawner. 0 = spawn immediately on area load (Once mode only; Interval falls back to Once with a warning)." },
            ["Spawn Mode"] = { category = "gameplay",
                description = "How the spawner triggers:\n"
                    .. "• Once — spawn one NPC per trigger entry (see Once).\n"
                    .. "• Interval — spawn a new NPC every Spawn Interval seconds while a player stays inside Trigger Radius, up to Max Alive concurrent NPCs." },
            ["Spawn Interval"] = { category = "gameplay",
                description = "Seconds between spawns in Interval mode. The first NPC spawns immediately on entry; subsequent NPCs follow at this interval, subject to Max Alive. If Max Alive pauses spawning, the next spawn fires as soon as a slot opens.",
                conditional = "Only used when Spawn Mode == 'Interval'.",
                dependsOn = { property = "Spawn Mode", equals = "Interval" } },
            ["Max Alive"] = { category = "gameplay",
                description = "Cap on concurrently live NPCs. 0 = unlimited. While at cap, spawning pauses; when a slot frees (warp-out, external removal), the next spawn fires immediately rather than waiting for another interval.",
                conditional = "Only used when Spawn Mode == 'Interval'; Once mode is implicitly limited to one NPC at a time.",
                dependsOn = { property = "Spawn Mode", equals = "Interval" } },
            ["Once"] = { category = "gameplay",
                description = "If true, spawn at most one NPC per session. If false, Once-mode spawners re-arm when the player leaves and can spawn again on the next entry (immediate-mode spawners are always one-shot regardless of this flag). Ignored in Interval mode.",
                conditional = "Only affects Once mode; Interval mode ignores it.",
                dependsOn = { property = "Spawn Mode", equals = "Once" } },
            ["Warp Out At End"] = { category = "gameplay",
                description = "If true, each spawned NPC is removed after reaching the final waypoint in its path. If false, spawned NPCs stay at the last waypoint indefinitely (and, in Interval mode, count toward Max Alive)." },
            ["Warp Out Delay"] = { category = "gameplay",
                description = "Seconds to wait after the path completes before starting the warp-out animation.",
                conditional = "Only used when Warp Out At End is true.",
                dependsOn = { property = "Warp Out At End" } },
            ["Warp Out Animation"] = { category = "appearance",
                description = "Optional animation state to play before the NPC is removed (e.g. WARP_OUT). Empty = remove immediately after the delay with no animation.",
                conditional = "Only used when Warp Out At End is true.",
                dependsOn = { property = "Warp Out At End" } },
            ["Warp Out Animation Duration"] = { category = "appearance",
                description = "Seconds the Warp Out Animation plays before the NPC is removed. Should match the animation's total duration.",
                conditional = "Only used when Warp Out At End and Warp Out Animation are both set.",
                dependsOn = { property = "Warp Out At End" } },
        },
        ["FootBomb Controller"] = {
            ["Instance Map"] = { category = "gameplay",
                description = "Map loaded for a match." },
            ["Points to Win"] = { category = "gameplay",
                description = "Match target score.",
                required = true },
        },

        -- Mystery / Dialogue / Waypoint --------------------------------
        ["Mystery Data"] = {
            ["Type"] = { category = "gameplay",
                description = "Selects the event flow." },
            ["Quiz List"] = { category = "dialogue",
                description = "Root Quiz List object.",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" } },
            ["Reward Type"] = { category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" } },
            ["Reward Name"] = { category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" } },
            ["Reward Amount"] = { category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" } },
            ["Reward Description"] = { category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" } },
            ["Cost Type"] = { category = "gameplay",
                description = "If non-empty, the object charges this currency on use." },
            ["Cost Amount"] = { category = "gameplay",
                conditional = "Only used when Cost Type is set.",
                dependsOn = { property = "Cost Type" } },
            ["Cost Failure Message"] = { category = "gameplay",
                conditional = "Only used when Cost Type is set.",
                dependsOn = { property = "Cost Type" } },
        },
        ["Dialogue"] = {
            ["Text 1"] = { category = "dialogue",
                description = "Primary text; meaning varies by Dialogue Type." },
            ["Text 2"] = { category = "dialogue" },
            ["Text 3"] = { category = "dialogue" },
            ["Next 1"] = { category = "dialogue",
                description = "Primary next-Dialogue reference." },
            ["Item 1"] = { category = "dialogue",
                description = "Item reference used by item / itemcheck / shop types.",
                conditional = "Only used by Dialogue Type 'item', 'itemcheck', or 'shop'.",
                dependsOn = { property = "Dialogue Type",
                              oneOf = { "item", "itemcheck", "shop" } } },
            ["Take Item"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'itemcheck'.",
                dependsOn = { property = "Dialogue Type", equals = "itemcheck" } },
            ["Date"] = { category = "dialogue",
                conditional = "Only used by Dialogue Type 'before' or 'after'.",
                dependsOn = { property = "Dialogue Type",
                              oneOf = { "before", "after" } } },
            ["Quest Name"] = { category = "dialogue",
                conditional = "Only used by quest-related Dialogue Types.",
                dependsOn = { property = "Dialogue Type",
                              oneOf = { "quest_switch", "quest_event", "questcheck" } } },
            ["Event Value"] = { category = "dialogue",
                conditional = "Only used by Dialogue Type 'quest_event'.",
                dependsOn = { property = "Dialogue Type", equals = "quest_event" } },
            ["Email Id"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Email Icon"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Email Title"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Email From"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Mug Texture Path"] = { category = "appearance",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Mug Animation Path"] = { category = "appearance",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Persist"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Dont Notify"] = { category = "dialogue",
                conditional = "Only used by Dialogue Type 'item' or 'email'.",
                dependsOn = { property = "Dialogue Type",
                              oneOf = { "item", "email" } } },
            ["Encounter Name"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'battle_npc'.",
                dependsOn = { property = "Dialogue Type", equals = "battle_npc" } },
            ["Failure Message"] = { category = "dialogue",
                conditional = "Only used when Dialogue Type == 'battle_npc'.",
                dependsOn = { property = "Dialogue Type", equals = "battle_npc" } },
            ["Kick On Loss"] = { category = "gameplay",
                description = "If true, kick the player when they lose. " ..
                              "If false, leave them in place with input unlocked " ..
                              "(useful for scripted losses where the player stays in the map).",
                conditional = "Only used when Dialogue Type == 'battle_npc'.",
                dependsOn = { property = "Dialogue Type", equals = "battle_npc" } },
        },
        ["Waypoint"] = {
            ["Waypoint Type"] = { category = "gameplay",
                description = "How the next waypoint is selected." },
            ["Date"] = { category = "gameplay",
                conditional = "Only used when Waypoint Type is 'before' or 'after'.",
                dependsOn = { property = "Waypoint Type",
                              oneOf = { "before", "after" } } },
            ["Direction"] = { category = "appearance",
                description = "Facing applied when the NPC arrives at this waypoint (and during Wait Time)." },
            ["Move Animation"] = { category = "appearance",
                description = "Animation state played while travelling toward this waypoint (e.g. WALK_UR, RUN, FOOTBOMB_JUMP_LEFT). When set, the animation itself encodes facing; Move Direction is ignored during travel.",
                conditional = "Move Loop controls whether it restarts each cycle. For animations with intrinsic timing (jumps), also set Move Duration > 0 to sync position with the animation." },
            ["Move Loop"] = { category = "appearance",
                description = "Whether Move Animation loops. Set false for one-shot animations like jump arcs; the final frame holds until movement completes.",
                conditional = "Only meaningful when Move Animation is set.",
                dependsOn = { property = "Move Animation" } },
            ["Move Duration"] = { category = "appearance",
                description = "If > 0, switches to scripted movement: the NPC's position is animated over exactly this many seconds via keyframes, matching the animation's intrinsic timing. Required for jump-style animations to stay in sync with the sprite. Leave at 0 for normal walking.",
                conditional = "Only meaningful when Move Animation is set. Leave 0 for walk cycles; set to the animation's total duration for one-shot arcs.",
                dependsOn = { property = "Move Animation" } },
            ["Move Direction"] = { category = "appearance",
                description = "Direction to face while travelling toward this waypoint. Empty = keep whatever direction the NPC was already facing.",
                conditional = "Ignored when Move Animation is set; the animation's encoded facing wins." },
            ["Wait Animation"] = { category = "appearance",
                description = "Animation state held while the NPC waits at this waypoint during Wait Time. Use for END/hold poses (e.g. FOOTBOMB_JUMP_LEFT_END) that should persist after arrival. Empty = keep whatever the Move Animation ended on.",
                conditional = "Only visible when Wait Time > 0 (the pose is applied on arrival and immediately overridden once travel resumes)." },
            ["Wait Loop"] = { category = "appearance",
                description = "Whether Wait Animation loops. Keep true for single-frame holds so the engine doesn't revert to the default idle.",
                conditional = "Only used when Wait Animation is set.",
                dependsOn = { property = "Wait Animation" } },
        },

        -- Button system -------------------------------------------------
        ["Button Bot Details"] = {
            ["Asset Name"] = { category = "appearance",
                description = "Sprite asset name (no extension).",
                required = true },
            ["Direction"] = { category = "appearance",
                description = "Facing direction.",
                required = true },
            ["Animation Name"] = { category = "appearance",
                description = "Optional idle animation; falls back to the asset default." },
            ["Mug Animation Name"] = { category = "appearance",
                description = "Optional portrait animation used while talking." },
            ["Active Animation"] = { category = "appearance",
                description = "Looped animation while the button is active." },
            ["Inactive Animation"] = { category = "appearance",
                description = "Looped animation while the button is inactive." },
            ["Activated Animation"] = { category = "appearance",
                description = "One-shot animation played when the button activates. Empty = snap straight to Active Animation." },
            ["Deactivated Animation"] = { category = "appearance",
                description = "One-shot animation played when the button deactivates. Empty = snap straight to Inactive Animation." },
            ["Activation Animation Duration"] = { category = "appearance",
                description = "Seconds the Activated Animation plays before the button state changes.",
                conditional = "Only used when Activated Animation is set." },
            ["Deactivation Animation Duration"] = { category = "appearance",
                description = "Seconds the Deactivated Animation plays before the button state changes.",
                conditional = "Only used when Deactivated Animation is set." },
        },
        ["OW Button"] = {
            ["Bot Details"] = { category = "appearance",
                description = "Reference to the Button Bot Details object that configures this button's appearance.",
                required = true },
            ["Button Behavior"] = { category = "gameplay",
                description = "How the button reacts to player presence:\n"
                    .. "• Pressure Plate — active while anyone stands on it.\n"
                    .. "• One-Time — activates once and stays active.\n"
                    .. "• Toggle — flips active/inactive each press.\n"
                    .. "• Custom — runs a map-specific Lua script.\n"
                    .. "• Timed — activates, then auto-deactivates after Activated Time." },
            ["Script Path"] = { category = "gameplay",
                description = "Lua module path providing on_enter / on_exit handlers.",
                conditional = "Only used when Button Behavior == 'Custom'.",
                dependsOn = { property = "Button Behavior", equals = "Custom" } },
            ["Trigger Object"] = { category = "gameplay",
                description = "Optional separate trigger object. When set, its bounds override the button's own rectangle and Trigger Type/Width/Height are ignored." },
            ["Button Activated Behavior"] = { category = "gameplay",
                description = "Optional reference to an Unlock Behavior object that defines which checkpoint this button unlocks." },
            ["Button Deactivated Behavior"] = { category = "gameplay",
                description = "Optional reference to a Relock Behavior object that defines which checkpoint this button re-locks when it deactivates." },
            ["Button Chain Type"] = { category = "advanced",
                description = "Reserved for future use. Currently not consulted by the runtime." },
            ["Trigger Type"] = { category = "gameplay",
                description = "Rectangle vs ellipse detection shape.",
                conditional = "Only used when Trigger Object is empty." },
            ["Trigger Width"] = { category = "gameplay",
                description = "Trigger rectangle width in map tiles.",
                conditional = "Only used when Trigger Object is empty." },
            ["Trigger Height"] = { category = "gameplay",
                description = "Trigger rectangle height in map tiles.",
                conditional = "Only used when Trigger Object is empty." },
            ["Activated Time"] = { category = "gameplay",
                description = "Seconds the button stays active before auto-deactivating.",
                conditional = "Only used when Button Behavior == 'Timed'.",
                dependsOn = { property = "Button Behavior", equals = "Timed" } },
            ["Bots Can Trigger"] = { category = "gameplay",
                description = "If true, NPCs (bots) entering or leaving this button's trigger also affect its state, using the same Pressure Plate / One-Time / Toggle / Timed rules as players. Ignored for Custom behavior.",
                conditional = "Ignored when Button Behavior == 'Custom'.",
                dependsOn = { property = "Button Behavior",
                              oneOf = { "Pressure Plate", "One-Time", "Toggle", "Timed" } } },
        },
        ["OW Button Group Member"] = {
            ["Bot Details"] = { category = "appearance",
                description = "Reference to the Button Bot Details object that configures this button's appearance.",
                required = true },
            ["Button Behavior"] = { category = "gameplay",
                description = "Same modes as OW Button. Group members never run their own checkpoint actions; their state feeds the parent group." },
            ["Script Path"] = { category = "gameplay",
                conditional = "Only used when Button Behavior == 'Custom'.",
                dependsOn = { property = "Button Behavior", equals = "Custom" } },
            ["Trigger Object"] = { category = "gameplay",
                description = "Optional separate trigger object. When set, its bounds override the button's own rectangle." },
            ["Trigger Type"] = { category = "gameplay",
                description = "Rectangle vs ellipse detection shape.",
                conditional = "Only used when Trigger Object is empty." },
            ["Trigger Width"] = { category = "gameplay",
                description = "Trigger rectangle width in map tiles.",
                conditional = "Only used when Trigger Object is empty." },
            ["Trigger Height"] = { category = "gameplay",
                description = "Trigger rectangle height in map tiles.",
                conditional = "Only used when Trigger Object is empty." },
            ["Activated Time"] = { category = "gameplay",
                description = "Seconds the button stays active before auto-deactivating.",
                conditional = "Only used when Button Behavior == 'Timed'.",
                dependsOn = { property = "Button Behavior", equals = "Timed" } },
            ["Bots Can Trigger"] = { category = "gameplay",
                description = "If true, NPCs (bots) entering or leaving this member's trigger also affect its state, which propagates to the parent group.",
                conditional = "Ignored when Button Behavior == 'Custom'.",
                dependsOn = { property = "Button Behavior",
                              oneOf = { "Pressure Plate", "One-Time", "Toggle", "Timed" } } },
        },
        ["Unlock Behavior"] = {
            ["Unlock This"] = { category = "gameplay",
                description = "Checkpoint reference this behavior unlocks.",
                required = true },
            ["Unlock Permanently"] = { category = "gameplay",
                description = "true = stays hidden across disconnects; false = re-locks automatically when the button deactivates (or on reconnect)." },
            ["Area Wide"] = { category = "gameplay",
                description = "If true, unlocks for every player currently in the area, and for players who enter later (while active)." },
        },
        ["Relock Behavior"] = {
            ["Relock This"] = { category = "gameplay",
                description = "Checkpoint reference this behavior re-locks.",
                required = true },
            ["Area Wide"] = { category = "gameplay",
                description = "If true, re-locks for every player currently in the area." },
        },
        ["Button Trigger"] = {
            ["Trigger Type"] = { category = "gameplay",
                description = "Rectangle vs ellipse detection shape for the referenced trigger object." },
        },
        ["Button Group"] = {
            ["Group ID"] = { category = "gameplay",
                description = "Optional stable identifier. Falls back to the object's Tiled ID." },
            ["Group Mode"] = { category = "gameplay",
                description = "How members combine:\n"
                    .. "• all_active — every referenced Button is active.\n"
                    .. "• any_active — at least one is active.\n"
                    .. "• combination — every Button is active AND every Forbidden Button is inactive." },
            ["Button 1"] = { category = "gameplay",
                description = "Reference to a required OW Button Group Member. Add Button 2..N as needed in Tiled.",
                required = true },
            ["Forbidden Button 1"] = { category = "gameplay",
                description = "Reference to a member that must be inactive for the group to satisfy.",
                conditional = "Only meaningful when Group Mode == 'combination'.",
                dependsOn = { property = "Group Mode", equals = "combination" } },
            ["Unlock Checkpoint 1"] = { category = "gameplay",
                description = "Checkpoint to unlock when the group transitions to satisfied. Add Unlock Checkpoint 2..N as needed." },
            ["Unlock Permanently"] = { category = "gameplay",
                description = "Whether the group's unlocks are permanent or should be re-locked on group dissolution." },
            ["Unlock Area Wide"] = { category = "gameplay",
                description = "If true, unlock applies to every player in the area." },
            ["Relock Checkpoint 1"] = { category = "gameplay",
                description = "Checkpoint to re-lock when the group becomes unsatisfied. Add Relock Checkpoint 2..N as needed.",
                conditional = "Only meaningful when at least one Unlock Checkpoint is configured." },
            ["Relock Area Wide"] = { category = "gameplay",
                description = "If true, relock applies to every player in the area." },
        },
        ["Button Combo"] = {
            ["Button 1"] = { category = "gameplay",
                description = "Reference to a required OW Button Group Member. Add Button 2..N as needed.",
                required = true },
            ["Forbidden Button 1"] = { category = "gameplay",
                description = "Reference to a member that must be inactive for this combo to satisfy." },
            ["Unlock Checkpoint 1"] = { category = "gameplay",
                description = "Checkpoint to unlock when this combo becomes satisfied. Add Unlock Checkpoint 2..N as needed." },
            ["Unlock Permanently"] = { category = "gameplay",
                description = "Whether this combo's unlocks are permanent or should be re-locked when the combo breaks." },
            ["Unlock Area Wide"] = { category = "gameplay",
                description = "If true, unlock applies to every player in the area." },
            ["Relock Checkpoint 1"] = { category = "gameplay",
                description = "Checkpoint to re-lock when this combo becomes unsatisfied. Add Relock Checkpoint 2..N as needed.",
                conditional = "Only meaningful when at least one Unlock Checkpoint is configured." },
            ["Relock Area Wide"] = { category = "gameplay",
                description = "If true, relock applies to every player in the area." },
        },
        ["Combo Button Group"] = {
            ["Group ID"] = { category = "gameplay",
                description = "Optional stable identifier. Falls back to the object's Tiled ID." },
            ["Combo Mode"] = { category = "gameplay",
                description = "How each referenced combo's button matches are evaluated:\n"
                    .. "• Inclusive — required buttons active and forbidden inactive; other group-members may be active too.\n"
                    .. "• Exclusive — same, but no other group-member button may be active." },
            ["Button Combo 1"] = { category = "gameplay",
                description = "Reference to a Button Combo. Add Button Combo 2..N as needed — satisfying ANY one fires its actions.",
                required = true },
        },
        ["Button Effect"] = {
            ["Source Button"] = { category = "gameplay",
                description = "Button whose state transition triggers this effect.",
                required = true },
            ["Event"] = { category = "gameplay",
                description = "Which transition on Source Button triggers the effect." },
            ["Target Button"] = { category = "gameplay",
                description = "Button this effect acts on.",
                required = true },
            ["Action"] = { category = "gameplay",
                description = "What to do to the Target Button when the effect fires." },
        },
        ["Button Group Effect"] = {
            ["Button Group"] = { category = "gameplay",
                description = "Button Group (or Combo Button Group) whose completion transition triggers this effect.",
                required = true },
            ["Event"] = { category = "gameplay",
                description = "Which group transition triggers the effect." },
            ["Target Button"] = { category = "gameplay",
                description = "Button this effect acts on.",
                required = true },
            ["Action"] = { category = "gameplay",
                description = "What to do to the Target Button when the effect fires." },
        },

        -- Cutscene system -----------------------------------------------
        ["Cutscene"] = {
            ["Name"] = { category = "gameplay",
                description = "Unique cutscene identifier within the area.",
                required = true },
            ["Start Step"] = { category = "gameplay",
                description = "First step in the chain (Cutscene Step object).",
                required = true },
            ["Trigger Radius"] = { category = "gameplay",
                description = "If > 0, auto-starts when a player enters a circle of this radius (in map pixels) centered on this Cutscene object's own position. Ignored when the Cutscene object is a rectangle. Small values (32–200) match the tile scale; larger values cover a wider area." },
            ["Once"] = { category = "gameplay",
                description = "If true, plays at most once per player per session." },
        },
        ["Cutscene Step"] = {
            ["Type"] = { category = "gameplay",
                description = "Which action this step performs.",
                required = true },
            ["Next Step"] = { category = "gameplay",
                description = "Step to run after this one. Empty ends the cutscene (for branch types, this is the fallback)." },

            ["Next 1"] = { category = "gameplay",
                description = "On Ask Quiz: step to run when option 1 is chosen.",
                conditional = "Only used when Type == 'Ask Quiz'.",
                dependsOn = { property = "Type", equals = "Ask Quiz" } },
            ["Next 2"] = { category = "gameplay",
                conditional = "Only used when Type == 'Ask Quiz'.",
                dependsOn = { property = "Type", equals = "Ask Quiz" } },
            ["Next 3"] = { category = "gameplay",
                conditional = "Only used when Type == 'Ask Quiz'.",
                dependsOn = { property = "Type", equals = "Ask Quiz" } },
            ["Fail Next"] = { category = "gameplay",
                description = "Step to run when the prompt fails to match Expected.",
                conditional = "Only used when Type == 'Prompt Player' with Expected set.",
                dependsOn = { property = "Type", equals = "Prompt Player" } },

            ["Wait Seconds"] = { category = "gameplay",
                conditional = "Only used when Type == 'Wait'.",
                dependsOn = { property = "Type", equals = "Wait" } },

            ["Actor"] = { category = "gameplay",
                description = "NPC placeholder whose bot moves or poses. Use 'trigger_npc' to reference the NPC that started the cutscene.",
                conditional = "Only used by Move Actor and Set Pose.",
                dependsOn = { property = "Type",
                              oneOf = { "Move Actor", "Set Pose" } } },

            ["Target"] = { category = "gameplay",
                description = "Point object to move to. When set, Target X/Y/Z are ignored. " ..
                              "If Target, Target X/Y/Z, and the step's own placement are all empty, " ..
                              "the step falls back to its own Tiled (x, y, z) as the destination.",
                conditional = "Only used by Move Actor and Move Camera.",
                dependsOn = { property = "Type",
                              oneOf = { "Move Actor", "Move Camera" } } },
            ["Target X"] = { category = "gameplay",
                conditional = "Only used when Target is empty and Type is Move Actor or Move Camera. If Target X/Y/Z are all empty, the step node's own Tiled position is used.",
                dependsOn = { property = "Type",
                              oneOf = { "Move Actor", "Move Camera" } } },
            ["Target Y"] = { category = "gameplay",
                conditional = "Only used when Target is empty and Type is Move Actor or Move Camera. If Target X/Y/Z are all empty, the step node's own Tiled position is used.",
                dependsOn = { property = "Type",
                              oneOf = { "Move Actor", "Move Camera" } } },
            ["Target Z"] = { category = "gameplay",
                conditional = "Only used when Target is empty and Type is Move Actor or Move Camera. If Target X/Y/Z are all empty, the step node's own Tiled position is used.",
                dependsOn = { property = "Type",
                              oneOf = { "Move Actor", "Move Camera" } } },

            ["Move Animation"] = { category = "gameplay",
                description = "Animation played while moving (e.g. WALK_UR).",
                conditional = "Only used by Move Actor.",
                dependsOn = { property = "Type", equals = "Move Actor" } },
            ["Move Direction"] = { category = "gameplay",
                description = "Facing direction during movement.",
                conditional = "Only used by Move Actor.",
                dependsOn = { property = "Type", equals = "Move Actor" } },
            ["Move Speed"] = { category = "gameplay",
                description = "Map units per second during movement.",
                conditional = "Only used by Move Actor.",
                dependsOn = { property = "Type", equals = "Move Actor" } },
            ["End Animation"] = { category = "gameplay",
                description = "Pose held after reaching the target. Leave empty to keep the move animation.",
                conditional = "Only used by Move Actor.",
                dependsOn = { property = "Type", equals = "Move Actor" } },
            ["End Direction"] = { category = "gameplay",
                conditional = "Only used by Move Actor.",
                dependsOn = { property = "Type", equals = "Move Actor" } },
            ["End Hold Seconds"] = { category = "gameplay",
                description = "0 = hold indefinitely (until the next pose step). >0 = hold for that many seconds before the next step runs.",
                conditional = "Only used by Move Actor.",
                dependsOn = { property = "Type", equals = "Move Actor" } },
            ["End Loop"] = { category = "gameplay",
                conditional = "Only used by Move Actor.",
                dependsOn = { property = "Type", equals = "Move Actor" } },

            ["Animation"] = { category = "gameplay",
                description = "Pose animation to set (without moving).",
                conditional = "Only used by Set Pose.",
                dependsOn = { property = "Type", equals = "Set Pose" } },
            ["Direction"] = { category = "gameplay",
                conditional = "Only used by Set Pose.",
                dependsOn = { property = "Type", equals = "Set Pose" } },
            ["Loop"] = { category = "gameplay",
                conditional = "Only used by Set Pose.",
                dependsOn = { property = "Type", equals = "Set Pose" } },
            ["Hold Seconds"] = { category = "gameplay",
                description = "0 = indefinite; >0 = await that long before continuing.",
                conditional = "Only used by Set Pose.",
                dependsOn = { property = "Type", equals = "Set Pose" } },

            ["Speaker"] = { category = "dialogue",
                description = "NPC whose mugshot appears with the message. Empty = the NPC that started the cutscene.",
                conditional = "Only used by Show Message, Ask Quiz, and Prompt Player.",
                dependsOn = { property = "Type",
                              oneOf = { "Show Message", "Ask Quiz", "Prompt Player" } } },
            ["Mugshot Override"] = { category = "appearance",
                description = "'player' for the current player's mug, or a mug asset name to override the speaker's mug.",
                conditional = "Only used by Show Message, Ask Quiz, and Prompt Player.",
                dependsOn = { property = "Type",
                              oneOf = { "Show Message", "Ask Quiz", "Prompt Player" } } },
            ["Text"] = { category = "dialogue",
                conditional = "Only used by Show Message.",
                dependsOn = { property = "Type", equals = "Show Message" } },
            ["Question"] = { category = "dialogue",
                conditional = "Only used by Ask Quiz.",
                dependsOn = { property = "Type", equals = "Ask Quiz" } },
            ["Option 1"] = { category = "dialogue",
                conditional = "Only used by Ask Quiz.",
                dependsOn = { property = "Type", equals = "Ask Quiz" } },
            ["Option 2"] = { category = "dialogue",
                conditional = "Only used by Ask Quiz.",
                dependsOn = { property = "Type", equals = "Ask Quiz" } },
            ["Option 3"] = { category = "dialogue",
                description = "Optional third option; leave empty for a 2-option quiz.",
                conditional = "Only used by Ask Quiz.",
                dependsOn = { property = "Type", equals = "Ask Quiz" } },
            ["Message"] = { category = "dialogue",
                description = "Text shown before the input field appears.",
                conditional = "Only used by Prompt Player.",
                dependsOn = { property = "Type", equals = "Prompt Player" } },
            ["Expected"] = { category = "dialogue",
                description = "If set, the input must match to route via Next Step; otherwise Fail Next runs. Empty accepts any input.",
                conditional = "Only used by Prompt Player.",
                dependsOn = { property = "Type", equals = "Prompt Player" } },

            ["Sound Path"] = { category = "appearance",
                conditional = "Only used by Play Sound.",
                dependsOn = { property = "Type", equals = "Play Sound" } },

            ["Color R"] = { category = "appearance",
                conditional = "Only used by Fade Camera.",
                dependsOn = { property = "Type", equals = "Fade Camera" } },
            ["Color G"] = { category = "appearance",
                conditional = "Only used by Fade Camera.",
                dependsOn = { property = "Type", equals = "Fade Camera" } },
            ["Color B"] = { category = "appearance",
                conditional = "Only used by Fade Camera.",
                dependsOn = { property = "Type", equals = "Fade Camera" } },
            ["Color A"] = { category = "appearance",
                conditional = "Only used by Fade Camera.",
                dependsOn = { property = "Type", equals = "Fade Camera" } },

            ["Duration"] = { category = "gameplay",
                conditional = "Only used by Fade Camera and Move Camera.",
                dependsOn = { property = "Type",
                              oneOf = { "Fade Camera", "Move Camera" } } },

            ["Event Name"] = { category = "advanced",
                description = "ezbus event name to emit. Payload includes player_id, area_id, cutscene_name.",
                conditional = "Only used by Emit Event.",
                dependsOn = { property = "Type", equals = "Emit Event" } },
        },
    }
}

-- ----------------------------------------------------------------------
-- Schema validation
-- ----------------------------------------------------------------------
local function validate_schema()
    local errors = {}
    local function err(fmt, ...)
        errors[#errors+1] = string.format(fmt, ...)
    end

    local seen_classes = {}
    for _, ot in ipairs(object_types) do
        if seen_classes[ot.name] then
            err("duplicate class name: %s", ot.name)
        end
        seen_classes[ot.name] = true
    end

    for _, ot in ipairs(object_types) do
        local seen = {}
        for i, p in ipairs(ot.members) do
            if type(p.name) ~= "string" or p.name == "" then
                err("%s: member #%d has no name", ot.name, i)
            else
                if seen[p.name] then
                    err("%s: duplicate property '%s'", ot.name, p.name)
                end
                seen[p.name] = true
                if p.propertyType and not Enums[p.propertyType] then
                    err("%s.%s: propertyType '%s' not declared in Enums",
                        ot.name, p.name, tostring(p.propertyType))
                end
            end
        end

        local meta = META.properties[ot.name] or {}
        for pname, pm in pairs(meta) do
            local dep = pm.dependsOn
            if dep and type(dep.property) == "string" then
                if not seen[dep.property] then
                    err("%s.%s: dependsOn references unknown property '%s'",
                        ot.name, pname, dep.property)
                end
            end
        end
    end

    return #errors == 0, errors
end

-- ----------------------------------------------------------------------
local METADATA_FIELDS = {
    category = true, required = true, description = true,
    conditional = true, dependsOn = true,
}

local function strip_member(p)
    local out = {}
    for k, v in pairs(p) do
        if not METADATA_FIELDS[k] then out[k] = v end
    end
    return out
end

local function strip_class_members(members)
    local out = {}
    for i, p in ipairs(members) do
        out[i] = strip_member(p)
    end
    return out
end

local function build_tiled_types()
    local output = {}
    local id = 1

    local enum_names = {}
    for name in pairs(Enums) do enum_names[#enum_names+1] = name end
    table.sort(enum_names)

    for _, enum_name in ipairs(enum_names) do
        local enum = Enums[enum_name]
        table.insert(output, {
            id = id,
            name = enum_name,
            storageType = enum.type,
            type = "enum",
            values = enum.values,
            valuesAsFlags = false,
        })
        id = id + 1
    end

    for _, ot in ipairs(object_types) do
        table.insert(output, {
            id = id,
            name = ot.name,
            color = ot.color,
            drawFill = true,
            type = "class",
            useAs = { "object" },
            members = strip_class_members(ot.members),
        })
        id = id + 1
    end

    return output
end

-- ----------------------------------------------------------------------
local function lua_quote(s)
    return string.format("%q", s)
end

local function serialize_value(v, indent)
    indent = indent or ""
    local t = type(v)
    if t == "string"  then return lua_quote(v) end
    if t == "number"  then return tostring(v) end
    if t == "boolean" then return v and "true" or "false" end
    if t == "table" then
        local inner = indent .. "  "
        local is_array = #v > 0
        if is_array then
            for k in pairs(v) do
                if type(k) ~= "number" then is_array = false; break end
            end
        end
        if is_array then
            local parts = {}
            for _, x in ipairs(v) do
                parts[#parts+1] = serialize_value(x, inner)
            end
            return "{ " .. table.concat(parts, ", ") .. " }"
        else
            local keys = {}
            for k in pairs(v) do keys[#keys+1] = k end
            table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
            local parts = {}
            for _, k in ipairs(keys) do
                local key_repr
                if type(k) == "string" then
                    key_repr = "[" .. lua_quote(k) .. "]"
                else
                    key_repr = "[" .. tostring(k) .. "]"
                end
                parts[#parts+1] = inner .. key_repr .. " = " .. serialize_value(v[k], inner)
            end
            return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
        end
    end
    return "nil"
end

local function merge_member_meta(ot, p)
    local out = {}
    for k, v in pairs(p) do out[k] = v end
    local pm = (META.properties[ot.name] or {})[p.name]
    if pm then
        for k, v in pairs(pm) do out[k] = v end
    end
    return out
end

local function build_schema_lua()
    local lines = {}
    local function w(s) lines[#lines+1] = s end

    w("-- Auto-generated by generate-ezlibs-tiled.lua. Do not edit by hand.")
    w("return {")
    w("  enums = {")
    local enum_names = {}
    for name in pairs(Enums) do enum_names[#enum_names+1] = name end
    table.sort(enum_names)
    for _, name in ipairs(enum_names) do
        local e = Enums[name]
        w("    [" .. lua_quote(name) .. "] = { type = " ..
          lua_quote(e.type) .. ", values = " ..
          serialize_value(e.values, "      ") .. " },")
    end
    w("  },")

    w("  classes = {")
    for _, ot in ipairs(object_types) do
        local cm = META.classes[ot.name] or {}
        w("    [" .. lua_quote(ot.name) .. "] = {")
        w("      color = " .. lua_quote(ot.color) .. ",")
        if cm.category    then w("      category    = " .. lua_quote(cm.category) .. ",") end
        if cm.description then w("      description = " .. lua_quote(cm.description) .. ",") end
        w("      members = {")
        for _, p in ipairs(ot.members) do
            local merged = merge_member_meta(ot, p)
            w("        " .. serialize_value(merged, "        ") .. ",")
        end
        w("      },")
        w("    },")
    end
    w("  },")
    w("}")
    return table.concat(lines, "\n")
end

-- ----------------------------------------------------------------------
local CATEGORY_ORDER = {
    appearance = 1, dialogue = 2, gameplay = 3, advanced = 4,
}

local function md_escape(s)
    if type(s) ~= "string" then return "" end
    s = s:gsub("|", "\\|"):gsub("\n", "<br>")
    return s
end

local function fmt_default(v)
    if v == nil then return "" end
    local t = type(v)
    if t == "string"  then
        if v == "" then return "`\"\"`" end
        return "`" .. v .. "`"
    end
    if t == "boolean" then return v and "true" or "false" end
    if t == "number"  then return tostring(v) end
    return "`" .. md_escape(tostring(v)) .. "`"
end

local function fmt_type(p)
    local base = p.type or "any"
    if p.propertyType then
        return base .. " (" .. p.propertyType .. ")"
    end
    return base
end

local function category_of(ot_name, p)
    local pm = (META.properties[ot_name] or {})[p.name] or {}
    if pm.category then return pm.category end
    local cm = META.classes[ot_name] or {}
    return cm.category
end

local function required_of(ot_name, p)
    local pm = (META.properties[ot_name] or {})[p.name] or {}
    return pm.required == true
end

local function description_of(ot_name, p)
    local pm = (META.properties[ot_name] or {})[p.name] or {}
    return pm.description or ""
end

local function conditional_of(ot_name, p)
    local pm = (META.properties[ot_name] or {})[p.name] or {}
    local out = pm.conditional
    if pm.dependsOn then
        local d = pm.dependsOn
        local expr
        if d.equals ~= nil then
            expr = "`" .. d.property .. "` == `" .. tostring(d.equals) .. "`"
        elseif d.oneOf then
            local parts = {}
            for _, x in ipairs(d.oneOf) do
                parts[#parts+1] = "`" .. tostring(x) .. "`"
            end
            expr = "`" .. d.property .. "` in {" .. table.concat(parts, ", ") .. "}"
        else
            expr = "`" .. d.property .. "` is set"
        end
        out = (out and (out .. " ") or "") .. "Only meaningful when " .. expr .. "."
    end
    return out
end

local function build_reference_md()
    local lines = {}
    local function w(s) lines[#lines+1] = s or "" end

    w("# Tiled Reference")
    w("")
    w("Auto-generated from `generate-ezlibs-tiled.lua`. Do not edit by hand.")
    w("")

    w("## Enums")
    w("")
    local enum_names = {}
    for name in pairs(Enums) do enum_names[#enum_names+1] = name end
    table.sort(enum_names)
    for _, name in ipairs(enum_names) do
        w("### " .. name)
        w("")
        for _, v in ipairs(Enums[name].values) do
            w("- `" .. tostring(v) .. "`")
        end
        w("")
    end

    w("## Classes")
    w("")
    for _, ot in ipairs(object_types) do
        local cm = META.classes[ot.name] or {}
        w("### " .. ot.name)
        if cm.category then w("**Category:** " .. cm.category) end
        if cm.description then w(cm.description) end
        w("")

        local sorted = {}
        for i, p in ipairs(ot.members) do sorted[i] = p end
        table.sort(sorted, function(a, b)
            local ca = CATEGORY_ORDER[category_of(ot.name, a) or ""] or 99
            local cb = CATEGORY_ORDER[category_of(ot.name, b) or ""] or 99
            if ca ~= cb then return ca < cb end
            return a.name < b.name
        end)

        w("| Property | Type | Required | Default | Category | Description |")
        w("|---|---|---|---|---|---|")
        for _, p in ipairs(sorted) do
            w(string.format("| `%s` | %s | %s | %s | %s | %s |",
                p.name,
                fmt_type(p),
                required_of(ot.name, p) and "yes" or "",
                fmt_default(p.value),
                category_of(ot.name, p) or "",
                md_escape(description_of(ot.name, p))))
        end
        w("")

        if cm.numberedTemplates and #cm.numberedTemplates > 0 then
            local parts = {}
            for _, prefix in ipairs(cm.numberedTemplates) do
                parts[#parts+1] = "`" .. prefix .. "N`"
            end
            w("**Template properties:** " .. table.concat(parts, ", ")
                .. " — add additional numbered instances manually in Tiled.")
            w("")
        end

        local has_cond = false
        for _, p in ipairs(sorted) do
            local note = conditional_of(ot.name, p)
            if note and note ~= "" then
                if not has_cond then
                    w("**Conditional properties**")
                    w("")
                    has_cond = true
                end
                w("- `" .. p.name .. "`: " .. note)
            end
        end
        if has_cond then w("") end
    end

    return table.concat(lines, "\n")
end

-- ----------------------------------------------------------------------
-- Directory helpers
--
-- dirname("") returns "", so callers that pass a bare filename end up
-- writing to the process's current directory. That was the source of the
-- "schema in scripts/" bug: running the generator from scripts/ with a
-- bare filename placed the schema there instead of next to the generator.
--
-- script_dirname returns the directory of the running script with a
-- trailing separator, or "./" when there is no directory component (e.g.
-- `lua generate-ezlibs-tiled.lua` from inside ezlibs-scripts/). It only
-- treats the caller as "the generator" when arg[0] actually points at this
-- file, so programmatic `require("...generate-ezlibs-tiled").generate(...)`
-- from a host script doesn't accidentally write into the host's directory.
-- ----------------------------------------------------------------------
local function dirname(p)
    return p:match("^(.*[/\\])") or ""
end

local function script_dirname()
    local a = arg and arg[0]
    if type(a) == "string"
        and (a:find("generate%-ezlibs%-tiled%.lua")
             or a:find("generate_tiled_types_json.lua")) then
        local d = a:match("^(.*[/\\])")
        if d and d ~= "" then return d end
        -- Running from within ezlibs-scripts/ with no path prefix.
        return "./"
    end
    return nil
end

local function main(output_path, pretty)
    output_path = output_path or "ezlibs-tiled-types.json"
    pretty = pretty or false

    local ok, errors = validate_schema()
    if not ok then
        io.stderr:write("Schema validation failed:\n")
        for _, e in ipairs(errors) do
            io.stderr:write("  - " .. e .. "\n")
        end
        error("aborting due to schema errors")
    end

    -- types.json: Tiled-facing artifact, goes wherever the caller asked.
    local types = build_tiled_types()
    do
        local f, err = io.open(output_path, "w")
        if not f then
            error("Could not open " .. output_path .. " for writing: " .. tostring(err))
        end
        f:write(json.encode(types, pretty))
        f:close()
        print("Generated Tiled types: " .. output_path)
    end

    -- schema.lua and reference.md: prefer the generator's own directory so
    -- they always land next to the runtime's fixed require path
    -- (scripts.ezlibs-scripts.ezlibs-tiled-schema). Fall back to the JSON's
    -- directory when invoked programmatically (arg[0] is not this script).
    local json_dir = dirname(output_path)
    if json_dir == "" then json_dir = "./" end
    local script_dir = script_dirname() or json_dir

    do
        local path = script_dir .. "ezlibs-tiled-schema.lua"
        local f = assert(io.open(path, "w"))
        f:write(build_schema_lua())
        f:write("\n")
        f:close()
        print("Generated runtime schema: " .. path)
    end

    do
        local path = script_dir .. "ezlibs-tiled-reference.md"
        local f = assert(io.open(path, "w"))
        f:write(build_reference_md())
        f:write("\n")
        f:close()
        print("Generated reference doc: " .. path)
    end
end

if arg and arg[0] and (arg[0]:find("generate%-ezlibs%-tiled%.lua")
                       or arg[0]:find("generate_tiled_types_json.lua")) then
    main(arg[1])
else
    return { generate = main }
end