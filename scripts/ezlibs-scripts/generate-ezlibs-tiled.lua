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
-- All three files are written next to the JSON's directory.

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
    -- Element taxonomy used by `Key Type = "navi_element"` checkpoints and
    -- any future navi-property that needs to reference an element.
    NaviElement = {
        type = "string",
        values = {"None", "Fire", "Aqua", "Elec", "Wood", "Sword",
                  "Break", "Cursor", "Wind", "Summon", "Plus"}
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

            -- Navi-based unlock methods (Key Type = navi_name / navi_element / navi_list).
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
            prop("Next Waypoint 1", "object", ""),
            prop("Player Exclusive", "bool", false),
            prop("Quest NPC", "bool", false),
            prop("Quest Exclusive", "string", ""),
            prop("Quest State", "string", "active"),
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
    }
}

-- ----------------------------------------------------------------------
-- META — additive metadata (never emitted into types.json; drives schema.lua,
-- reference.md, and runtime validation).
--
-- Fields:
--   classes[cname] = { category, description, numberedTemplates }
--   properties[cname][pname] = {
--       category, required, description, conditional, dependsOn
--   }
--   dependsOn = { property="X", equals=... | oneOf={...} }
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
            description = "Placed non-player character." },
        ["Pushback NPC"] = { category = "gameplay",
            description = "NPC with a moving collision zone that pushes the player." },
        ["FootBomb Controller"] = { category = "gameplay",
            description = "Interaction actor for the FootBomb minigame." },
        ["Waypoint"] = { category = "gameplay",
            description = "Navigation node for NPCs.",
            numberedTemplates = { "Next Waypoint " } },
        ["OW Button"] = { category = "gameplay",
            description = "One button in the ezbuttons system.",
            numberedTemplates = { "Next " } },
        ["OW Button Group Member"] = { category = "gameplay",
            description = "Button participating in a Button Group." },
        ["Button Group"] = { category = "gameplay",
            description = "Group of OW Buttons that satisfy together.",
            numberedTemplates = { "Button ", "Forbidden Button ",
                                  "Unlock Checkpoint ", "Relock Checkpoint " } },
        ["Button Combo"] = { category = "gameplay",
            description = "One button pattern with optional unlock/relock targets.",
            numberedTemplates = { "Button ", "Forbidden Button ",
                                  "Unlock Checkpoint ", "Relock Checkpoint " } },
        ["Combo Button Group"] = { category = "gameplay",
            description = "Any referenced Button Combo satisfies the group.",
            numberedTemplates = { "Button Combo " } },
        ["Compression Tile"] = { category = "advanced",
            description = "Changes player or area scale while standing inside." },
        ["Item"] = { category = "gameplay",
            description = "Inventory or shop item reference." },
        ["Rush Road"] = { category = "advanced",
            description = "ezrushroads interaction object." },
    },

    properties = {
        ["Checkpoint"] = {
            ["Password"] = {
                category = "gameplay",
                description = "If set, requires typing this password to unlock. Overrides Key Type.",
            },
            ["Key Type"] = {
                category = "gameplay",
                description = "How to unlock when Password is empty. Ignored when Password is set.",
            },
            ["Key Item Name"] = {
                category = "gameplay",
                description = "Item name required when Key Type == 'item'.",
                conditional = "Only used when Key Type == 'item'.",
                dependsOn = { property = "Key Type", equals = "item" },
            },
            ["Required Keys"] = {
                category = "gameplay",
                description = "Amount required for money / fragments / tokens / item.",
            },
            ["Consume"] = {
                category = "gameplay",
                description = "Whether to consume the key on unlock.",
            },
            ["Once"] = {
                category = "gameplay",
                description = "If true, stays hidden permanently; else hidden till disconnect.",
            },
            ["Unlocking Asset Name"] = {
                category = "appearance",
                description = "Asset played during the unlock animation.",
            },
            ["Unlocking Animation Time"] = {
                category = "appearance",
                description = "Seconds to play the unlock animation; 0 skips it.",
            },
            ["Unlocking Sound Path"] = {
                category = "appearance",
                description = "Sound asset to play when the checkpoint unlocks.",
            },
            ["Skip Prompt"] = {
                category = "gameplay",
                description = "If true, attempts the unlock without asking the player.",
            },
            ["Description"] = {
                category = "gameplay",
                description = "Shown to the player before the unlock check.",
            },
            ["Unlocked Message"] = {
                category = "gameplay",
                description = "Shown on successful unlock.",
            },
            ["Unlock Failed Message"] = {
                category = "gameplay",
                description = "Shown when the unlock check fails.",
            },
            ["Navi Name"] = {
                category = "gameplay",
                description = "Exact Navi name required to unlock (case-insensitive).",
                conditional = "Only used when Key Type == 'navi_name'.",
                dependsOn = { property = "Key Type", equals = "navi_name" },
            },
            ["Navi Element"] = {
                category = "gameplay",
                description = "Navi element required to unlock (case-insensitive).",
                conditional = "Only used when Key Type == 'navi_element'.",
                dependsOn = { property = "Key Type", equals = "navi_element" },
            },
            ["Navi 1"] = {
                category = "gameplay",
                description = "First entry in the approved-Navi list (any match unlocks).",
                conditional = "Only used when Key Type == 'navi_list'.",
                dependsOn = { property = "Key Type", equals = "navi_list" },
            },
            -- Navi 2..Navi 10 inherit Navi 1's category and description
            -- conventions via the reference-doc fallback (no per-field entry
            -- needed).
        },
        ["NPC"] = {
            ["Direction"] = {
                category = "appearance",
                description = "Initial facing (Tiled default populates it).",
                required = true,
            },
            ["Asset Name"] = {
                category = "appearance",
                description = "Sprite asset name (no extension).",
                required = true,
            },
            ["Animation Name"] = {
                category = "appearance",
                description = "Idle animation; uses asset default if empty.",
            },
            ["Mug Animation Name"] = {
                category = "appearance",
                description = "Portrait animation used while talking.",
            },
            ["Dont Face Player"] = {
                category = "appearance",
                description = "If true, the NPC does not turn to face the player.",
            },
            ["First Dialogue"] = {
                category = "dialogue",
                description = "Reference to the root Dialogue object.",
            },
            ["Next Waypoint 1"] = {
                category = "gameplay",
                description = "First waypoint in the NPC's path.",
            },
            ["Player Exclusive"] = {
                category = "advanced",
                description = "Only spawned for the owning player.",
            },
            ["Quest NPC"] = {
                category = "advanced",
                description = "NPC is tied to quest state (see Quest Exclusive / Quest State).",
            },
            ["Quest Exclusive"] = {
                category = "advanced",
                description = "Quest name; when set, the NPC is created per-player for that quest.",
            },
            ["Quest State"] = {
                category = "advanced",
                description = "Required quest state for the NPC to appear.",
                conditional = "Only used when Quest Exclusive is set.",
                dependsOn = { property = "Quest Exclusive" },
            },
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
        },
        ["FootBomb Controller"] = {
            ["Instance Map"] = { category = "gameplay",
                description = "Map loaded for a match." },
            ["Points to Win"] = { category = "gameplay",
                description = "Match target score.",
                required = true },
        },
        ["Mystery Data"] = {
            ["Type"] = { category = "gameplay",
                description = "Selects the event flow." },
            ["Quiz List"] = {
                category = "dialogue",
                description = "Root Quiz List object.",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" },
            },
            ["Reward Type"] = {
                category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" },
            },
            ["Reward Name"] = {
                category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" },
            },
            ["Reward Amount"] = {
                category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" },
            },
            ["Reward Description"] = {
                category = "gameplay",
                conditional = "Only used when Type == 'quiz'.",
                dependsOn = { property = "Type", equals = "quiz" },
            },
            ["Cost Type"] = {
                category = "gameplay",
                description = "If non-empty, the object charges this currency on use.",
            },
            ["Cost Amount"] = {
                category = "gameplay",
                conditional = "Only used when Cost Type is set.",
                dependsOn = { property = "Cost Type" },
            },
            ["Cost Failure Message"] = {
                category = "gameplay",
                conditional = "Only used when Cost Type is set.",
                dependsOn = { property = "Cost Type" },
            },
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
            ["Take Item"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'itemcheck'.",
                dependsOn = { property = "Dialogue Type", equals = "itemcheck" } },
            ["Date"] = {
                category = "dialogue",
                conditional = "Only used by Dialogue Type 'before' or 'after'.",
                dependsOn = { property = "Dialogue Type",
                              oneOf = { "before", "after" } } },
            ["Quest Name"] = {
                category = "dialogue",
                conditional = "Only used by quest-related Dialogue Types.",
                dependsOn = { property = "Dialogue Type",
                              oneOf = { "quest_switch", "quest_event", "questcheck" } } },
            ["Event Value"] = {
                category = "dialogue",
                conditional = "Only used by Dialogue Type 'quest_event'.",
                dependsOn = { property = "Dialogue Type", equals = "quest_event" } },
            ["Email Id"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Email Icon"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Email Title"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Email From"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Mug Texture Path"] = {
                category = "appearance",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Mug Animation Path"] = {
                category = "appearance",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Persist"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'email'.",
                dependsOn = { property = "Dialogue Type", equals = "email" } },
            ["Dont Notify"] = {
                category = "dialogue",
                conditional = "Only used by Dialogue Type 'item' or 'email'.",
                dependsOn = { property = "Dialogue Type",
                              oneOf = { "item", "email" } } },
            ["Encounter Name"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'battle_npc'.",
                dependsOn = { property = "Dialogue Type", equals = "battle_npc" } },
            ["Failure Message"] = {
                category = "dialogue",
                conditional = "Only used when Dialogue Type == 'battle_npc'.",
                dependsOn = { property = "Dialogue Type", equals = "battle_npc" } },
        },
        ["Waypoint"] = {
            ["Waypoint Type"] = { category = "gameplay",
                description = "How the next waypoint is selected." },
            ["Date"] = {
                category = "gameplay",
                conditional = "Only used when Waypoint Type is 'before' or 'after'.",
                dependsOn = { property = "Waypoint Type",
                              oneOf = { "before", "after" } } },
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

    -- 1. Duplicate class names
    local seen_classes = {}
    for _, ot in ipairs(object_types) do
        if seen_classes[ot.name] then
            err("duplicate class name: %s", ot.name)
        end
        seen_classes[ot.name] = true
    end

    -- 2. Per-class property checks
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

        -- dependsOn targets
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
-- Strip metadata for the Tiled types.json
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

-- ----------------------------------------------------------------------
-- Build types.json (unchanged shape from existing generator)
-- ----------------------------------------------------------------------
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
-- Build schema.lua
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
-- Build reference.md
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
local function dirname(p)
    return p:match("^(.*[/\\])") or ""
end

local function main(output_path, pretty)
    output_path = output_path or "ezlibs-tiled-types.json"
    pretty = pretty or false

    -- 1. Validate
    local ok, errors = validate_schema()
    if not ok then
        io.stderr:write("Schema validation failed:\n")
        for _, e in ipairs(errors) do
            io.stderr:write("  - " .. e .. "\n")
        end
        error("aborting due to schema errors")
    end

    -- 2. types.json
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

    local dir = dirname(output_path)

    -- 3. schema.lua
    do
        local path = dir .. "ezlibs-tiled-schema.lua"
        local f = assert(io.open(path, "w"))
        f:write(build_schema_lua())
        f:write("\n")
        f:close()
        print("Generated runtime schema: " .. path)
    end

    -- 4. reference.md
    do
        local path = dir .. "ezlibs-tiled-reference.md"
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