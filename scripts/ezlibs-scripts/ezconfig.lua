local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezconfig')
local ezconfig = nil
logger:info('[ezconfig] loading config...')
ezconfig = require('ezlibs-config')
if ezconfig == nil then
    error('[ezconfig] ezlibs requires a ezlibs-config.lua in the root of your server!')
end
return ezconfig