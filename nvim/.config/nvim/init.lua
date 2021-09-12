local fn = vim.fn

-- preinstall plugins

local preinstall_list = {
    packer = { author = 'wbthomason', repo = 'packer.nvim' },
    hotpot = { author = 'rktjmp', repo = 'hotpot.nvim' },
    fulib = { author = '6cdh', repo = 'fulib.nvim' },
}

local preinstall_path = fn.stdpath 'data' .. '/site/pack/packer/start/'

for _, info in pairs(preinstall_list) do
    local plugin_path = preinstall_path .. info.repo
    if fn.empty(fn.glob(plugin_path)) > 0 then
        vim.api.nvim_command(
            string.format(
                '!git clone https://github.com/%s/%s --depth 1 %s',
                info.author,
                info.repo,
                plugin_path
            )
        )
    end
end

-- profile requires

startup_features = {
    profile = true,
    profile_path = fn.stdpath 'cache' .. '/profile.log',
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

if _G.startup_features.profile then
    io.open(_G.startup_features.profile_path, 'w'):close()
    _G._require = require
    _G.require = hack_require
end

-- require modules

local modules = {
    'hotpot',
    -- 'impatient', -- Waiting for hotpot support
    'register',
    'options',
    'keymap',
    'diagnostic',
    'lsp',
    'plugins',
}

for _, m in ipairs(modules) do
    xpcall(function()
        require(m)
    end, function(err)
        print('Import ' .. m .. ' Failed: ' .. err)
    end)
end
