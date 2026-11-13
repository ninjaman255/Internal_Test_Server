-- Default-area net-games NPC demonstrations.
-- Activates the existing authored NPCs using their native scripts.
-- Does not install input listeners, create an input adapter, or render UI.
-- Placement preflight prevents a missing Tiled object from aborting startup.

local M = {}
local DebugLog = require("scripts/logger/logger").register_subsystem("net-games-dialogue", "DEMO-PROGS", {console = false, maxBufferSize = 1})
local AREA_ID = "default"
local initialized = false

-- The names below are the exact Tiled object names read by the NPC modules.
local definitions = {
    { script = "prog_banner_dialogue", objects = { "ProgBannerDialogue" } },
    { script = "prog_basic_dialogue", objects = { "ProgBasicDialogue" } },
    { script = "prog_basic_freedraw", objects = { "ProgBasicFreeDraw" } },
    { script = "prog_dramatic_dialogue", objects = { "ProgDramaticDialogue" } },
    { script = "prog_dyed_dialogue", objects = { "ProgDyedDialogue" } },
    { script = "prog_prompt_dialogue", objects = { "ProgPromptDialogue" } },
    { script = "prog_prompt_dialogue_2", objects = { "ProgPromptDialogue2" } },
    { script = "prog_basic_nameplate", objects = { "ProgBasicNameplateDialogue" } },
    { script = "prog_talk_dialogue", objects = { "prog_talk_prompt_npc" } },
    { script = "prog_talk_colors", objects = { "prog_default", "prog_lime", "prog_red", "prog_purple", "prog_turquoise", "prog_pink", "prog_emerald", "prog_sapphire", "prog_yellow", "prog_orange", "prog_charcoal_grey", "prog_white" } },
    { script = "prog_vert_prompt", objects = { "ProgVertPrompt" } },
    { script = "prog_vert_prompt_2", objects = { "ProgVertPrompt2" } },
    { script = "prog_vert_prompt_sapphire", objects = { "ProgVertPromptSapphire" } },
    { script = "prog_vert_prompt_pink", objects = { "ProgVertPromptPink" } },
    { script = "prog_vert_prompt_lime", objects = { "ProgVertPromptLime" } },
    { script = "prog_vert_prompt_charcoal_grey", objects = { "ProgVertPromptCharcoalGrey" } },
    { script = "prog_vert_prompt_red", objects = { "ProgVertPromptRed" } },
    { script = "prog_vert_prompt_emerald", objects = { "ProgVertPromptEmeraldShop" } },
    { script = "prog_shop", objects = { "ProgShop" } },
}

function M.activate()
    if initialized then return true end
    initialized = true

    local loaded = 0
    local skipped = 0
    local failed = 0
    for _, definition in ipairs(definitions) do
        local missing = {}
        for _, object_name in ipairs(definition.objects) do
            local ok, object = pcall(Net.get_object_by_name, AREA_ID, object_name)
            if not ok or not object then
                missing[#missing + 1] = object_name
            end
        end

        if #missing > 0 then
            DebugLog:warn_data("Demo PROG script skipped; Tiled objects missing", {
                script = definition.script, area_id = AREA_ID, missing = missing,
            })
            skipped = skipped + 1
            print("[net-games/npcs] SKIP " .. definition.script
                .. ": missing default-area Tiled object(s): " .. table.concat(missing, ", "))
        else
            local module_path = "scripts/net-games/npcs/" .. definition.script
            local ok, err = pcall(require, module_path)
            if ok then
                DebugLog:info_data("Demo PROG script loaded", {script = definition.script, area_id = AREA_ID})
                loaded = loaded + 1
                print("[net-games/npcs] Active " .. definition.script)
            else
                DebugLog:error_data("Demo PROG script failed to load", {
                    script = definition.script, area_id = AREA_ID, error = tostring(err),
                })
                failed = failed + 1
                print("[net-games/npcs] ERROR " .. definition.script .. ": " .. tostring(err))
            end
        end
    end

    DebugLog:info_data("Demo PROG activation summary", {loaded = loaded, skipped = skipped, failed = failed})
    print(string.format(
        "[net-games/npcs] default test NPC modules: %d active, %d skipped, %d failed",
        loaded, skipped, failed))
    return failed == 0 and skipped == 0
end

return M
