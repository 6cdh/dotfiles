local packer_plugin_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/'
local packer_path = packer_plugin_path .. 'packer.nvim'
local hotpot_path = packer_plugin_path .. 'hotpot.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/wbthomason/packer.nvim --depth 1 ' .. packer_path
    )
end

if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/rktjmp/hotpot.nvim.git --depth 1 ' .. hotpot_path
    )
end

-- require 'fs_test'

local modules = {
    'hotpot',
    'plugins',
    'theme',
    'options',
    'diagnostic',
    'lsp',
    'keymap',
}

for _, m in ipairs(modules) do
    if not pcall(require, m) then
        print('Import ' .. m .. ' Failed!')
        vim.api.nvim_command 'PackerSync'
        break
    end
end
