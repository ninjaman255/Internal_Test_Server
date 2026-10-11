-- preloader.lua
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")

local Preloader = {}

local asset_paths = {}

function Preloader.add_asset(asset_path)
    asset_paths[#asset_paths+1] = asset_path
end

function Preloader.update(area_id)
    -- Always preload the base assets
    for _, asset_path in ipairs(Constants.PreloadAssets) do
        Net.provide_asset(area_id, asset_path)
    end
    -- Also any custom ones added
    for _, asset_path in ipairs(asset_paths) do
        Net.provide_asset(area_id, asset_path)
    end
end

return Preloader