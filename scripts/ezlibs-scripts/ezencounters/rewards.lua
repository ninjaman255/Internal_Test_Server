-- ezencounters/rewards.lua
-- Hybrid encounter reward selection, battle-screen packets, and ezmemory persistence.
-- No dependency on the Endless Runner or Nebulous Liberations.
-- Only battles explicitly managed by ezencounters or the opt-in external
-- registration API can receive native rewards. Nebulous Liberations does
-- NOT register battles: it continues granting panel loot independently.
-- Lua 5.2 compatible.
--
-- Priority (replacement, not accumulation):
--   runtime_data.rewards > encounter_info.rewards > area_table.rewards
--   > area_table.enemy_rewards (one configured entry per enemy).
-- A literal false or { enabled = false } disables rewards.
-- Explicit callback rewards are appended to the selected reward configuration.
--
-- Native packet types: 0=money, 1=chip, 2=HP, 3=BugFrags.
-- Chip packets display a chip; callers must persist the owned card via their
-- own inventory integration (ezmemory does not expose a chip inventory API).

local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local Rewards = {}

local function integer(value)
    local n = tonumber(value)
    if not n or n ~= n or n == math.huge or n == -math.huge then return nil end
    if n < 0 or n % 1 ~= 0 then return nil end
    return n
end

local function log(message)
    print('[ezencounters][rewards] ' .. tostring(message))
end

function Rewards.is_victory(stats)
    if type(stats) ~= 'table' then return false end
    if stats.ran == true or stats.missing_battle_results == true then return false end
    local reason = tonumber(stats.reason)
    -- Never mistake surviving HP in a DRAW/LOSS/PANIC for a victory.
    if reason ~= nil then return reason == 1 end
    return stats.won == true
end

local function normalize_type(reward_type)
    if reward_type == 0 or reward_type == '0' then return 0 end
    if reward_type == 1 or reward_type == '1' then return 1 end
    if reward_type == 2 or reward_type == '2' then return 2 end
    if reward_type == 3 or reward_type == '3' then return 3 end
    local value = tostring(reward_type or ''):lower()
    if value == 'money' or value == 'monies' then return 0 end
    if value == 'chip' or value == 'card' or value == 'battlechip' then return 1 end
    if value == 'hp' or value == 'health' then return 2 end
    if value == 'bugfrags' or value == 'bugfrag' or value == 'fragments' then return 3 end
    return nil
end

local function normalize_packet(entry, options)
    if type(entry) ~= 'table' then return nil end
    local kind = normalize_type(entry.type)
    if kind == nil then return nil end
    if kind == 2 and options.disable_health_rewards then return nil end
    if kind == 1 then
        local card_id = entry.card_id or entry.package_id or entry.id
        if type(card_id) ~= 'string' or card_id == '' then return nil end
        local code = entry.code or '*'
        if type(code) ~= 'string' or code == '' then return nil end
        return { type = 1, card_id = card_id, code = code }
    end
    local amount = integer(entry.value or entry.amount)
    if not amount or amount == 0 then return nil end
    return { type = kind, value = amount }
end

local function within_score(config, score)
    return (config.min_score == nil or score >= (tonumber(config.min_score) or math.huge))
       and (config.max_score == nil or score <= (tonumber(config.max_score) or -math.huge))
end

local function amount_for(config, score)
    if config == false or config == nil then return 0 end
    if type(config) ~= 'table' then return integer(config) or 0 end
    if config.enabled == false or not within_score(config, score) then return 0 end
    local base = tonumber(config.base or config.amount or config.value or 0) or 0
    local multiplier = tonumber(config.score_multiplier or config.per_score or 0) or 0
    local amount = math.floor(base + score * multiplier)
    return integer(amount) or 0
end

local function add_config(out, config, stats, options)
    if type(config) ~= 'table' or config.enabled == false then return end
    local score = tonumber(stats.score) or 0
    local money = amount_for(config.money or config.monies, score)
    if money > 0 then out[#out + 1] = { type = 'money', value = money } end
    local frags = amount_for(config.bugfrags or config.fragments, score)
    if frags > 0 then out[#out + 1] = { type = 'bugfrags', value = frags } end
    if not options.disable_health_rewards then
        local hp_cfg = config.health or config.hp
        local eligible = type(hp_cfg) ~= 'table'
            or ((hp_cfg.threshold == nil and hp_cfg.if_hp_below == nil)
                or (tonumber(stats.health) or math.huge)
                    <= (tonumber(hp_cfg.threshold or hp_cfg.if_hp_below) or -math.huge))
        if eligible then
            local hp = amount_for(hp_cfg, score)
            if hp > 0 then out[#out + 1] = { type = 'hp', value = hp } end
        end
    end
    local cards = config.chips or config.cards
    if type(cards) == 'table' then
        -- List form only; requires actual package ID and code. Duplicate
        -- ownership must be handled by custom callbacks, not guessed here.
        for _, card in ipairs(cards) do
            if type(card) == 'table' and card.enabled ~= false
                and within_score(card, score)
                and (card.chance == nil or math.random() < (tonumber(card.chance) or 0)) then
                out[#out + 1] = { type = 'chip', card_id = card.card_id or card.id, code = card.code }
            end
        end
    end
end

local function enemy_configuration(area_table, enemy)
    local map = area_table and area_table.enemy_rewards
    if type(map) ~= 'table' or type(enemy) ~= 'table' then return nil end
    local entry = map[enemy.name]
    if type(entry) ~= 'table' then return nil end
    local rank = tostring(enemy.rank or 0)
    if type(entry.ranks) == 'table' then
        return entry.ranks[rank] or entry.ranks[tonumber(rank)] or entry.default
    end
    return entry
end

-- Both area-wide and per-encounter reward shapes are optional; preserve all
-- existing encounters/bosses/special_encounters tables unchanged.
function Rewards.collect(area_table, encounter_info, runtime_data, stats, options)
    local out = {}
    options = options or {}
    if not Rewards.is_victory(stats) then return out, 'not_victory' end
    if options.disable_rewards or (runtime_data and runtime_data.no_battle_rewards)
        or (encounter_info and encounter_info.no_battle_rewards) then
        return out, 'disabled'
    end

    local source = 'none'
    local config
    if runtime_data and runtime_data.rewards ~= nil then
        config, source = runtime_data.rewards, 'runtime'
    elseif encounter_info and encounter_info.rewards ~= nil then
        config, source = encounter_info.rewards, 'encounter'
    elseif area_table and area_table.rewards ~= nil then
        config, source = area_table.rewards, 'area'
    else
        -- One named enemy fallback per enemy entry, not a global random roll.
        source = 'enemy_fallback'
        for _, enemy in ipairs((runtime_data and runtime_data.enemies)
                or (encounter_info and encounter_info.enemies) or {}) do
            add_config(out, enemy_configuration(area_table, enemy), stats, options)
        end
    end
    if config == false or (type(config) == 'table' and config.enabled == false) then
        return {}, 'disabled'
    end
    if config ~= nil then add_config(out, config, stats, options) end
    return out, source
end

local function persist_currency(player_id, packet_type, amount, balance_before)
    local getter, setter
    if packet_type == 0 then
        getter, setter = Net.get_player_money, ezmemory.set_player_money
    else
        getter, setter = Net.get_player_fragments, ezmemory.set_player_fragments
    end
    if type(getter) ~= 'function' or type(setter) ~= 'function' then
        log('currency persistence API unavailable (type=' .. tostring(packet_type) .. ')')
        return false
    end
    local ok, after = pcall(getter, player_id)
    if not ok then log('currency read failed: ' .. tostring(after)); return false end
    local expected = balance_before + amount
    -- Some builds update Net balances when the native reward packet is sent.
    -- Reconcile to the expected balance, rather than adding the packet again.
    local new_balance = math.max(tonumber(after) or 0, expected)
    local success, err = pcall(setter, player_id, new_balance)
    if not success then log('currency save failed: ' .. tostring(err)); return false end
    return true, new_balance
end

-- The caller owns the one-battle-only guard. Exactly one packet is sent for
-- all configured and callback-added rewards, at battle_results time.
function Rewards.finish(player_id, area_table, encounter_info, runtime_data, stats, options, callbacks)
    options = options or {}
    local selected, source = Rewards.collect(area_table, encounter_info, runtime_data, stats, options)
    if Rewards.is_victory(stats) and source ~= 'disabled' then
        for _, cb in ipairs(callbacks or {}) do
            if type(cb.fn) == 'function' then
                local ok, err = pcall(cb.fn, player_id, cb.info or encounter_info, stats, selected)
                if not ok then log('results_callback failed: ' .. tostring(err)) end
            end
        end
    else
        -- Legacy callback behavior: callbacks also see losses/runs. No rewards
        -- may be awarded on those results, regardless of callback output.
        for _, cb in ipairs(callbacks or {}) do
            if type(cb.fn) == 'function' then
                local ok, err = pcall(cb.fn, player_id, cb.info or encounter_info, stats, selected)
                if not ok then log('results_callback failed: ' .. tostring(err)) end
            end
        end
        selected = {}
    end

    local packets = {}
    local totals = { money = 0, bugfrags = 0, hp = 0, chips = 0 }
    for _, entry in ipairs(selected) do
        local packet = normalize_packet(entry, options)
        if packet then
            packets[#packets + 1] = packet
            if packet.type == 0 then totals.money = totals.money + packet.value
            elseif packet.type == 2 then totals.hp = totals.hp + packet.value
            elseif packet.type == 3 then totals.bugfrags = totals.bugfrags + packet.value
            else totals.chips = totals.chips + 1 end
        else
            log('skipping malformed or unsupported reward entry')
        end
    end
    if #packets == 0 then return packets, totals, source end

    -- Refresh persisted balances BEFORE sending the packet, so a native
    -- award does not get counted a second time by ezmemory's max() merge.
    local money_before, frags_before
    if totals.money > 0 then
        local ok, val = pcall(ezmemory.get_player_money, player_id)
        if ok then money_before = val end
    end
    if totals.bugfrags > 0 then
        local ok, val = pcall(ezmemory.get_player_fragments, player_id)
        if ok then frags_before = val end
    end

    if type(Net.send_player_battle_rewards) == 'function' then
        local sent, err = pcall(Net.send_player_battle_rewards, player_id, packets)
        if not sent then log('native battle reward packet failed: ' .. tostring(err)) end
    else
        log('native battle reward API unavailable; persisting currency only')
    end

    if totals.money > 0 and money_before ~= nil then
        persist_currency(player_id, 0, totals.money, money_before)
    end
    if totals.bugfrags > 0 and frags_before ~= nil then
        persist_currency(player_id, 3, totals.bugfrags, frags_before)
    end
    if totals.hp > 0 and options.persistent_health == true and not options.disable_health_rewards then
        local ok, current = pcall(Net.get_player_health, player_id)
        if ok and tonumber(current) then
            pcall(ezmemory.set_player_health, player_id, tonumber(current))
        end
    end
    return packets, totals, source
end

return Rewards
