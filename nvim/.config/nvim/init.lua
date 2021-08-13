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
    edit_config = true, -- Change to false to speedup startup once you finish editing nvim config
    require_profile = false,
    profile_path = vim.fn.stdpath 'cache' .. '/profile.log',
}

local function hack_require(module)
    local _s = os.clock()
    local m = _G._require(module)
    local _e = os.clock()
    local f = io.open(_G.startup_features.profile_path, 'a')
    f:write(module, ' takes ', (_e - _s) * 1000, ' ms\n')
    f:close()
    return m
end

if _G.startup_features.require_profile then
    io.open(_G.startup_features.profile_path, 'w'):close()
    _G._require = require
    _G.require = hack_require
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
