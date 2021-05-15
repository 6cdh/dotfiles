-- lspconfig
local lspconfig = require 'lspconfig'

lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
lspconfig.hls.setup {}
lspconfig.vimls.setup {}
lspconfig.texlab.setup {}
lspconfig.gopls.setup {}

-- lua
local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'

lspconfig.sumneko_lua.setup {
    cmd = {'lua-language-server', '-E', sumneko_root_path .. '/main.lua'},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            },
            telemetry = {enable = false}
        }
    }
}

-- lspsaga

local saga = require 'lspsaga'

saga.init_lsp_saga()

-- lspkind
require'lspkind'.init {
    with_text = false,
    -- vscode-like pictograms
    symbol_map = {
        Text = ' ',
        Method = ' ',
        Function = ' ',
        Constructor = ' ',
        Variable = ' ',
        Class = ' ',
        Interface = ' ',
        Module = ' ',
        Property = ' ',
        Unit = ' ',
        Value = ' ',
        Enum = ' ',
        Keyword = ' ',
        Snippet = ' ',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' '
    }
}

-- lsp_signature
require'lsp_signature'.on_attach()
