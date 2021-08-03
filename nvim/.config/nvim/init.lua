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

nvim_profile = nil

require 'hotpot'

if _G.nvim_profile then
    local _s = os.clock()
    _G._require = require
    _G.require = require('requirebm').require
    local f = io.open(vim.fn.stdpath 'cache' .. '/profile.log', 'w')
    f:write('hotpot takes ', (os.clock() - _s) * 1000, ' ms\n')
    f:close()
end

local modules = {
    'hotpot',
    'lazy',
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
