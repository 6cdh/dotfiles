local preconfig = require 'modules.preconfig'

preconfig 'https://github.com/wbthomason/packer.nvim'
preconfig 'https://github.com/rktjmp/hotpot.nvim'
preconfig 'https://github.com/6cdh/fulib.nvim'

local modules = {
    'hotpot',
    'plugins',
    'register',
    'options',
    'keymap',
    'diagnostic',
    'lsp',
    'modules.lisp',
}

for _, m in ipairs(modules) do
    local ok, err = pcall(require, m)
    if not ok then
        vim.notify(string.format("Can't loading module: %s. ERR: %s", m, err))
    end
end
