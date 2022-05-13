local plugin_manager = 'packer'
local plugin_path = vim.fn.stdpath 'data' .. '/site/pack/' .. plugin_manager .. '/start/'

-- Example:
-- preconfig 'https://github.com/rktjmp/hotpot.nvim'
local function preconfig(url, name)
    if name == nil then
        local _, repo = url:match '/([^/]-)/([^/]-)/?$'
        name = repo
    end
    local path = plugin_path .. name
    if vim.fn.isdirectory(path) == 0 then
        vim.notify('fetching ' .. url)
        vim.notify(vim.fn.system { 'git', 'clone', url, path, '--depth', '1' })
        vim.notify 'fetching complete'
    end
end

return preconfig
