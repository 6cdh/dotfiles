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

vim.g.do_filetype_lua = 1

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.racket = {
    install_info = {
        url = "https://github.com/6cdh/tree-sitter-racket", -- local path or git repo
        files = { "src/parser.c", "src/scanner.cc" },
        -- optional entries:
        branch = "main", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "racket", -- if filetype does not match the parser name
}
