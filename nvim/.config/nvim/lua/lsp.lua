-- lspconfig
local lspconfig = require 'lspconfig'

lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
lspconfig.hls.setup {}
lspconfig.vimls.setup {}
lspconfig.texlab.setup {}

require('nvim-ale-diagnostic')

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = false,
        signs = true,
        update_in_insert = false
    })

-- lua
local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'

lspconfig.sumneko_lua.setup {
    cmd = {'lua-language-server', '-E', sumneko_root_path .. '/main.lua'},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {'vim'},
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

local km = require 'keymap'

km.map(km.mode.normal, '<leader>cf', ':Lspsaga lsp_finder<CR>',
       km.opts(km.optstr.noremap))
km.map(km.mode.normal, '<leader>cca', ':Lspsaga code_action<CR>',
       km.opts(km.optstr.noremap))
km.map(km.mode.visual, '<leader>cca', ':Lspsaga range_code_action<CR>',
       km.opts(km.optstr.noremap))

km.map(km.mode.normal, 'K', ':Lspsaga hover_doc<CR>',
       km.opts(km.optstr.noremap, km.optstr.silent))
km.map(km.mode.normal, '<leader>rn', ':Lspsaga rename<CR>',
       km.opts(km.optstr.noremap))

-- lspkind
require'lspkind'.init()
