local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezlocks = require('scripts/ezlibs-scripts/ezlocks')   -- new module

local ezcheckpoints = {}

--[[Features

Key Name (string) = money
    if name is money, spend money
Required Keys (number) = 1
Consume Key (bool) = false

Once (bool) = true 
    if the gate is hidden forever

Unlocking Frame Index (number)
Unlocking Animation Time (number)
Unlocking Sound Path (string)

Skip Prompt (bool) = false 
    dont ask the player if they want to unlock
Description (string) = 
    description before lock prompt
Unlocked Message (string) 
    override the message on unlock
Unlock Failed Message (string) 
    override the message on failed unlock
]]

local function unlock_checkpoint_for_player(player_id,area_id,object_id,unlocking_asset_name,unlocking_sound_path,unlocking_animation_time,once)
    return async(function ()
        Net.lock_player_input(player_id)
        local object = Net.get_object_by_id(area_id,object_id)
        Net.play_sound_for_player(player_id,unlocking_sound_path)
        if once then
            ezmemory.hide_object_from_player(player_id, area_id, object_id)
        else
            ezmemory.hide_object_from_player_till_disconnect(player_id, area_id, object_id)
        end
        if unlocking_animation_time > 0 then
            local new_bot_props = {
                x=object.x,
                y=object.y,
                z=object.z,
                texture_path='/server/assets/ezlibs-assets/ezcheckpoints/'..unlocking_asset_name..'.png',
                animation_path='/server/assets/ezlibs-assets/ezcheckpoints/'..unlocking_asset_name..'.animation',
                animation='UNLOCKING',
                warp_in=false,
                area_id=area_id
            }
            Net.provide_asset(area_id, new_bot_props.texture_path)
            
            local bot_id = Net.create_bot(new_bot_props)
            await(Async.sleep(unlocking_animation_time))
            Net.remove_bot(bot_id, false)
        end
        Net.unlock_player_input(player_id)
    end)
end

Net:on("object_interaction", function(event)
    local button = event.button
    if button ~= 0 then return end
    local player_id = event.player_id
    local object_id = event.object_id
    local area_id = Net.get_player_area(player_id)
    local checkpoint_object = Net.get_object_by_id(area_id, object_id)
    if checkpoint_object.type ~= "Checkpoint" then return end
    --anti spam lock
    local lock_id = player_id.."_"..area_id.."_"..checkpoint_object.id
    local lock = helpers.get_lock(player_id,lock_id)
    if not lock then
        return
    end
    
    local cp = checkpoint_object.custom_properties

    --Gather information from checkpoint object
    local password = cp["Password"] or false
    local key_name = cp["Key Name"] or "money"
    local required_keys = tonumber(cp["Required Keys"] or 1)
    local consume = cp["Consume"] == "true"
    local once = cp["Once"] == "true"
    local unlocking_asset_name = cp["Unlocking Asset Name"] or "bn5cubegreen_bot"
    local unlocking_animation_time = tonumber(cp["Unlocking Animation Time"] or 0)
    local unlocking_sound_path = cp["Unlocking Sound Path"] or "/server/assets/ezlibs-assets/sfx/panel_change.ogg"
    local skip_prompt =  cp["Skip Prompt"] == "true"
    local description = cp["Description"] or "It's a Security Cube"
    local unlocked_message = cp["Unlocked Message"] or "The Security Cube was unlocked!"
    local unlock_failed_message = cp["Unlock Failed Message"] or "You were unable to unlock the Security Cube"

    return async(function ()
        if #description > 0 then
            await(Async.message_player(player_id,description))
        end
        local prompt_message = ""
        local prompt_type = "item"
        if not skip_prompt then
            prompt_message = "Use "..key_name.." to Unlock?"
            if key_name == "money" then
                prompt_type = "money"
                if consume then
                    prompt_message = "Spend "..required_keys.."$ to Unlock?"
                else
                    prompt_message = "Show "..required_keys.."$ to Unlock?"
                end
            elseif prompt_type == "item" and required_keys > 1 then
                if consume then
                    prompt_message = "Use "..required_keys.." "..key_name.." to Unlock?"
                else
                    prompt_message = "Show "..required_keys.." "..key_name.." to Unlock?"
                end
            end
            if password then
                prompt_message = "Please input the password"
                prompt_type = "password"
            end
        end

        local unlocked = false
        if prompt_type == "password" then
            unlocked = await(ezlocks.check_password(player_id, prompt_message, password))
        elseif prompt_type == "money" then
            unlocked = await(ezlocks.check_money(player_id, prompt_message, required_keys, consume))
        else
            unlocked = await(ezlocks.check_item(player_id, prompt_message, key_name, required_keys, consume))
        end

        if unlocked == true then
            await(unlock_checkpoint_for_player(player_id,area_id,object_id,unlocking_asset_name,unlocking_sound_path,unlocking_animation_time,once))
            if #unlocked_message > 0 then
                await(Async.message_player(player_id,unlocked_message))
            end
        elseif unlocked == false then
            await(Async.message_player(player_id,unlock_failed_message))
        end
        lock.release()
    end)
end)

return ezcheckpoints