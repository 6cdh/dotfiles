local packer_plugin_path = vim.fn.stdpath 'data' .. '/site/pack/packer/'
local packer_path = packer_plugin_path .. 'start/packer.nvim'
local hotpot_path = packer_plugin_path .. 'start/hotpot.nvim'

local fn = vim.fn

if fn.empty(fn.glob(packer_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/wbthomason/packer.nvim --depth 1 ' .. packer_path
    )
end

if fn.empty(fn.glob(hotpot_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/rktjmp/hotpot.nvim.git --depth 1 ' .. hotpot_path
    )
end

startup_features = {
    edit_config = false, -- Change to false to speedup startup once you finish editing nvim config
    profile_path = vim.fn.stdpath 'cache' .. '/profile.log',
}

local _s = nil

if _G.startup_features.edit_config then
    _s = os.clock()
end

require 'hotpot'

if _G.startup_features.edit_config then
    local hotpot_loadtime = os.clock() - _s
    _G._require = require
    _G.require = require('hack_require').require
    local f = io.open(_G.startup_features.profile_path, 'w')
    f:write('hotpot takes ', hotpot_loadtime * 1000, ' ms\n')
    f:close()
end

local modules = {
    'hotpot',
    'register',
    'options',
    'keymap',
    'diagnostic',
    'lsp',
}

for _, m in ipairs(modules) do
    xpcall(function()
        require(m)
    end, function(err)
        print('Import ' .. m .. ' Failed: ' .. err)
    end)
end
