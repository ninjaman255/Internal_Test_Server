--=====================================================
-- prog_vert_prompt_pink.lua
-- Pink PROG vertical menu demo using Talk.vert_menu
--=====================================================

local Talk = require("scripts/net-games/npcs/talk")

Talk.npc({
    area_id = "default",
    object  = "ProgVertPromptPink",  -- Tiled object name
    name    = "PINK PROMPT PROG",

    texture_path   = "/server/assets/ow/prog/prog_ow_pink.png",
    animation_path = "/server/assets/ow/prog/prog_ow.animation",

    preset = "prog_prompt",
    frame  = "pink",
    mug    = "prog_pink",
    nameplate = "prog",

    on_interact = function(player_id, _bot_id, bot_name)
        Talk.vert_menu(player_id, bot_name, {
            area_id = "default",
            object  = "ProgVertPromptPink",
            preset  = "prog_prompt",
            frame   = "pink",
            mug     = "prog_pink",
            nameplate = "prog",
        }, {
            -- Options: 40 numbered items + Exit
            options = { count = 40, prefix = "Pink Option ", pad = 2, exit_text = "Exit", exit_id = "exit" },

            texts = {
                open_question = "Do you wanna check out the vertical menu?",
                intro_text    = "Awesome. Let me know if there's anything that you like.",
                decline_open  = "No worries. Maybe next time.",

                confirm_format     = 'Are you sure you want "%s"?',
                post_select_format = 'You got "%s".',

                after_yes    = "Thank you!{p_1} Is there anything else you'd like?",
                after_no     = "Is there anything else you'd like?",
                exit_goodbye = "Thanks for stopping by!",
            },

            sfx = "card_desc",
            flow = "prog_prompt",
            layout = "prog_prompt",
        })
    end,
})