-- player_session.lua
local ezlogger = require("scripts/ezlibs-scripts/ezlogger")
local log = ezlogger.get("nebulous-liberations")

local Ability = require("scripts/ezlibs-custom/nebulous-liberations/liberations/ability")
local PlayerSelection = require("scripts/ezlibs-custom/nebulous-liberations/liberations/player_selection")
local Loot = require("scripts/ezlibs-custom/nebulous-liberations/liberations/loot")
local EnemyHelpers = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers")
local ParalyzeEffect = require("scripts/ezlibs-custom/nebulous-liberations/utils/paralyze_effect")
local RecoverEffect = require("scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect")
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")
local ezmemory = require("scripts/ezlibs-scripts/ezmemory")
local Emotes = require("scripts/libs/emotes")

-- Battle end reasons supplied by the battle engine.
local BattleReason = {
    DRAW = 0,
    WIN = 1,
    LOSE = 2,
    RUN = 3,
    USER_PANIC = 4,
}

-- The 20 HP penalty applies only when the player runs or explicitly panics.
-- DRAW and LOSE are not forced exits and must not be penalized.
local PANIC_HP_PENALTY = 20

local function stats_indicate_panic(results)
    if not results then return false end
    local reason = tonumber(results.reason)
    return reason == BattleReason.RUN or reason == BattleReason.USER_PANIC
end

local PlayerSession = {}

function PlayerSession:new(instance, player)
    local player_session = {
        instance = instance,
        player = player,
        health = 100,
        max_health = 100,
        shadowsteps = {},
        paralyze_effect = nil,
        paralyze_counter = 0,
        invincible = false,
        completed_turn = false,
        selection = PlayerSelection:new(instance, player.id),
        ability = Ability.resolve_for_player(player),
        disconnected = false,
        is_trapped = false,
        get_monies = false
    }
    setmetatable(player_session, self)
    self.__index = self
    return player_session
end

function PlayerSession:emote_state()
    if self.player:is_battling() then
        Net.set_player_emote(self.player.id, Emotes.PVP)
    elseif self.invincible then
        Net.set_player_emote(self.player.id, Emotes.GG)
    elseif self.completed_turn then
        Net.set_player_emote(self.player.id, Emotes.ZZZ)
    else
        Net.set_player_emote(self.player.id, Emotes.BLANK)
    end
end

function PlayerSession:get_ability_permission()
    local question_promise = self.player:question_with_mug(self.ability.question)
    question_promise.and_then(function(response)
        if response == 0 then
            self.selection:clear()
            Net.unlock_player_input(self.player.id)
            return
        end
        if self.instance.order_points < self.ability.cost then
            self.player:say("Not enough Order Pts!")
            log:info_data("Player unable to use ability: not enough order points", {
                base_area_id = self.instance.base_area_id,
                instance_area_id = self.instance.area_id,
                player_id = self.player.id,
                ability = self.ability.name,
                ability_cost = self.ability.cost,
                order_points = self.instance.order_points,
            })
            return
        end
        self.instance:set_order_points(self.instance.order_points - self.ability.cost)
        log:info_data("Player activated ability", {
            base_area_id = self.instance.base_area_id,
            instance_area_id = self.instance.area_id,
            player_id = self.player.id,
            ability = self.ability.name,
            ability_cost = self.ability.cost,
            remaining_order_points = self.instance.order_points,
            phase = self.instance.phase,
        })
        self.ability.activate(self.instance, self, nil, self.ability.remove_traps, self.ability.destroy_items)
    end)
end

function PlayerSession:get_pass_turn_permission()
    local question = "End without doing anything?"
    if self.health < self.max_health then
        question = "Recover HP?"
    end
    local question_promise = self.player:question_with_mug(question)
    question_promise.and_then(function(response)
        if response == 0 then
            Net.unlock_player_input(self.player.id)
        elseif response == 1 then
            self:pass_turn()
        end
    end)
end

function PlayerSession:initiate_encounter(encounter_path, data)
    return Async.create_promise(function(resolve)
        self.player:initiate_encounter(encounter_path, data).and_then(function(results)
            local total_enemy_health = 0
            for _, enemy in ipairs(results.enemies or {}) do
                total_enemy_health = total_enemy_health + (enemy.health or 0)
            end

            self.health = results.health
            ezmemory.set_player_max_health(self.player.id, self.max_health, true)
            ezmemory.set_player_health(self.player.id, self.health)
            Net.set_player_emotion(self.player.id, results.emotion)

            local reason = tonumber(results.reason)
            if stats_indicate_panic(results) then
                local health_before_penalty = self.health
                if self.health > 0 then
                    self:hurt(PANIC_HP_PENALTY)
                end
                if self.health == 0 then
                    self:paralyze()
                end
                results.success = false
                local exit_message = reason == BattleReason.RUN and "Ran away!" or "Panicked out!"
                self.player:say_with_mug(
                    exit_message .. "\nLiberation failed. (-" ..
                    tostring(PANIC_HP_PENALTY) .. " HP)"
                )
                log:info_data("Player ran or panicked out of battle", {
                    base_area_id = self.instance.base_area_id,
                    instance_area_id = self.instance.area_id,
                    player_id = self.player.id,
                    reason = reason,
                    turns = results.turns,
                    health_before_penalty = health_before_penalty,
                    health_after_penalty = self.health,
                    penalty_hp = PANIC_HP_PENALTY,
                })
                resolve(results)
                return
            end

            if self.health == 0 then
                self:paralyze()
            end

            -- A panel is liberated only for the explicit WIN reason. A draw,
            -- loss, or missing/unknown reason must fail even if no surviving
            -- enemy-health entries were returned by the battle engine.
            results.success = reason == BattleReason.WIN
            if not results.success then
                self.player:say_with_mug("Oh, no!\nLiberation failed!")
            end
            resolve(results)
        end)
    end)
end

function PlayerSession:heal(amount)
    local previous_health = self.health
    self.health = math.min(math.ceil(self.health + amount), self.max_health)
    ezmemory.set_player_max_health(self.player.id, self.max_health, true)
    ezmemory.set_player_health(self.player.id, self.health)
    if previous_health < self.health then
        log:debug_data("Player healed", {
            base_area_id = self.instance.base_area_id,
            instance_area_id = self.instance.area_id,
            player_id = self.player.id,
            amount = amount,
            previous_health = previous_health,
            health = self.health,
        })
        return RecoverEffect:new(self.player.id):remove()
    else
        return Async.create_promise(function(resolve) resolve() end)
    end
end

function PlayerSession:hurt(amount)
    if self.invincible or self.health == 0 or amount <= 0 then return end
    Net.play_sound_for_player(self.player.id, "/server/assets/NebuLibsAssets/sound effects/hurt.ogg")
    self.health = math.max(math.ceil(self.health - amount), 0)
    ezmemory.set_player_max_health(self.player.id, self.max_health, true)
    ezmemory.set_player_health(self.player.id, self.health)
    log:debug_data("Player hurt", {
        base_area_id = self.instance.base_area_id,
        instance_area_id = self.instance.area_id,
        player_id = self.player.id,
        amount = amount,
        health = self.health,
        paralyzed = self.health == 0,
    })
    if self.health == 0 then
        Async.sleep(1).and_then(function()
            self:paralyze()
        end)
    end
end

function PlayerSession:paralyze()
    self.paralyze_counter = 2
    self.paralyze_effect = ParalyzeEffect:new(self.player.id)
    self.is_trapped = true
    log:info_data("Player paralyzed", {
        base_area_id = self.instance.base_area_id,
        instance_area_id = self.instance.area_id,
        player_id = self.player.id,
        paralyze_counter = self.paralyze_counter,
    })
end

function PlayerSession:pass_turn()
    log:info_data("Player passed turn", {
        base_area_id = self.instance.base_area_id,
        instance_area_id = self.instance.area_id,
        player_id = self.player.id,
        health = self.health,
        max_health = self.max_health,
        phase = self.instance.phase,
    })
    self:heal(self.max_health / 2).and_then(function()
        self:complete_turn()
    end)
end

function PlayerSession:complete_turn()
    if self.disconnected then return end
    self.completed_turn = true
    self.selection:clear()
    Net.lock_player_input(self.player.id)
    self:emote_state()
    self.instance.ready_count = self.instance.ready_count + 1
    log:info_data("Player turn complete", {
        base_area_id = self.instance.base_area_id,
        instance_area_id = self.instance.area_id,
        player_id = self.player.id,
        phase = self.instance.phase,
        health = self.health,
        ready_count = self.instance.ready_count,
        player_count = #self.instance.players,
    })
    if self.instance.ready_count < #self.instance.players then
        Net.unlock_player_camera(self.player.id)
    end
end

function PlayerSession:give_turn()
    self.invincible = false
    if self.paralyze_counter > 0 then
        self.paralyze_counter = self.paralyze_counter - 1
        if self.paralyze_counter > 0 then
            log:info_data("Player turn skipped (still paralyzed)", {
                base_area_id = self.instance.base_area_id,
                instance_area_id = self.instance.area_id,
                player_id = self.player.id,
                paralyze_counter = self.paralyze_counter,
            })
            self:complete_turn()
            return
        end
        self.paralyze_effect:remove()
        self.paralyze_effect = nil
        if not self.is_trapped then
            self:heal(self.max_health / 2)
        else
            self.is_trapped = false
        end
    end
    self.completed_turn = false
    log:info_data("Player turn start", {
        base_area_id = self.instance.base_area_id,
        instance_area_id = self.instance.area_id,
        player_id = self.player.id,
        phase = self.instance.phase,
        health = self.health,
        order_points = self.instance.order_points,
    })
    Net.unlock_player_input(self.player.id)
end

function PlayerSession:find_matching_gates()
    local gates = {}
    local selection = self.selection
    for i = 1, #selection:get_panels() do
        for j = 1, #self.instance.panel_gates do
            local check_selection = selection:get_panels()[i]
            local check_gate = self.instance.panel_gates[j]
            if check_selection.custom_properties[Constants.CustomProperties.GateKey] == check_gate.custom_properties[Constants.CustomProperties.GateKey] then
                table.insert(gates, check_gate)
            end
        end
    end
    return gates
end

function PlayerSession:find_gate_points(id)
    local points = {}
    for i = 1, #self.instance.points_of_interest do
        local point = self.instance.points_of_interest[i]
        if point.custom_properties[Constants.CustomProperties.GateID] == id then
            table.insert(points, point)
        end
    end
    return points
end

function PlayerSession:find_closest_guardian()
    local closest_guardian
    local closest_distance = math.huge
    for _, enemy in ipairs(self.instance.enemies) do
        if enemy.is_boss then goto continue end
        local distance = EnemyHelpers.chebyshev_tile_distance(enemy, self.player.x, self.player.y)
        if distance < closest_distance then
            closest_distance = distance
            closest_guardian = enemy
        end
        ::continue::
    end
    return closest_guardian
end

function PlayerSession:liberate_panels(panels, results)
    local co = coroutine.create(function()
        Async.await(Async.sleep(1))
        local msg
        if results and tonumber(results.reason) == 1 and results.turns == 1 and not results.ran then
            msg = "One turn liberation!"
        else
            msg = "Yeah!\nI liberated it!"
        end
        log:info_data("liberate_panels: firing message (fire-and-forget)", {
            base_area_id = self.instance.base_area_id,
            instance_area_id = self.instance.area_id,
            player_id = self.player.id,
            panel_count = #panels,
            turns = results and results.turns,
            ran = results and results.ran,
            message = msg,
        })
        self.player:say_with_mug(msg)
        log:info_data("liberate_panels: proceeding to loot", {
            base_area_id = self.instance.base_area_id,
            instance_area_id = self.instance.area_id,
            player_id = self.player.id,
        })
    end)
    return Async.promisify(co)
end

function PlayerSession:get_cash(panel, destroy_items)
    if self.get_monies then
        if destroy_items ~= true then
            local cash = Net.get_player_money(self.player.id)
            local bonus = 100
            if panel.custom_properties[Constants.CustomProperties.Money] then
                bonus = tonumber(panel.custom_properties[Constants.CustomProperties.Money])
            end
            log:info_data("Player found money", {
                base_area_id = self.instance.base_area_id,
                instance_area_id = self.instance.area_id,
                player_id = self.player.id,
                bonus = bonus,
                panel_x = panel.x,
                panel_y = panel.y,
            })
            self.player:say("Obtained $"..tostring(bonus).."!")
            Net.set_player_money(self.player.id, cash + bonus)
            ezmemory.set_player_money(self.player.id, Net.get_player_money(self.player.id))
        end
        self.get_monies = false
    end
end

function PlayerSession:loot_panels(panels, remove_traps, destroy_items)
    local co = coroutine.create(function()
        for _, panel in ipairs(panels) do
            log:debug_data("loot_panels: processing panel", {
                base_area_id = self.instance.base_area_id,
                instance_area_id = self.instance.area_id,
                player_id = self.player.id,
                panel_type = panel.type,
                panel_x = panel.x,
                panel_y = panel.y,
                has_loot = panel.loot ~= nil,
            })
            if panel.loot then
                Async.await(Loot.loot_item_panel(self.instance, self, panel, destroy_items))
                self:get_cash(panel, destroy_items)
            elseif panel.type == Constants.PanelTypes.TrapPanel then
                local slide_time = .1
                local spawn_x = math.floor(panel.x) + .5
                local spawn_y = math.floor(panel.y) + .5
                local spawn_z = panel.z
                Net.slide_player_camera(self.player.id, spawn_x, spawn_y, spawn_z, slide_time)
                Async.await(Async.sleep(slide_time))
                if remove_traps then
                    log:info_data("Player removed trap", {
                        base_area_id = self.instance.base_area_id,
                        instance_area_id = self.instance.area_id,
                        player_id = self.player.id,
                        panel_x = panel.x,
                        panel_y = panel.y,
                    })
                    self.player:say_with_mug("I found a trap! It's been removed.")
                elseif panel.custom_properties[Constants.CustomProperties.DamageTrap] == "true" then
                    if panel.custom_properties[Constants.CustomProperties.TrapMessage] then
                        self.player:say_with_mug(panel.custom_properties[Constants.CustomProperties.TrapMessage])
                    else
                        self.player:say_with_mug("Ah! A damage trap!")
                    end
                    log:info_data("Player triggered damage trap", {
                        base_area_id = self.instance.base_area_id,
                        instance_area_id = self.instance.area_id,
                        player_id = self.player.id,
                        damage = tonumber(panel.custom_properties[Constants.CustomProperties.DamageDealt]),
                        panel_x = panel.x,
                        panel_y = panel.y,
                    })
                    self:hurt(tonumber(panel.custom_properties[Constants.CustomProperties.DamageDealt]))
                elseif panel.custom_properties[Constants.CustomProperties.StunTrap] == "true" then
                    if panel.custom_properties[Constants.CustomProperties.TrapMessage] then
                        self.player:say_with_mug(panel.custom_properties[Constants.CustomProperties.TrapMessage])
                    else
                        self.player:say_with_mug("Ah! A paralysis trap!")
                    end
                    log:info_data("Player triggered paralysis trap", {
                        base_area_id = self.instance.base_area_id,
                        instance_area_id = self.instance.area_id,
                        player_id = self.player.id,
                        panel_x = panel.x,
                        panel_y = panel.y,
                    })
                    self:paralyze()
                end
            end
            self.instance:remove_panel(panel)
        end
        self.selection:clear()
        log:debug_data("loot_panels: completed", {
            base_area_id = self.instance.base_area_id,
            instance_area_id = self.instance.area_id,
            player_id = self.player.id,
            panel_count = #panels,
        })
    end)
    return Async.promisify(co)
end

function PlayerSession:liberate_and_loot_panels(panels, results, remove_traps, destroy_items)
    return Async.create_promise(function(resolve)
        self:liberate_panels(panels, results).and_then(function()
            self:loot_panels(panels, remove_traps, destroy_items).and_then(resolve)
        end)
    end)
end

function PlayerSession:handle_disconnect()
    self.selection:clear()
    if self.completed_turn then
        self.instance.ready_count = self.instance.ready_count - 1
    end
    if self.paralyze_effect then
        self.paralyze_effect:remove()
    end
    self.disconnected = true
    log:info_data("Player session disconnect cleanup", {
        base_area_id = self.instance.base_area_id,
        instance_area_id = self.instance.area_id,
        player_id = self.player.id,
        completed_turn = self.completed_turn,
        ready_count = self.instance.ready_count,
    })
end

return PlayerSession