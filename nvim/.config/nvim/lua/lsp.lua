-- lspconfig
local lspconfig = require 'lspconfig'

local sumneko_root_path = vim.fn.stdpath 'cache'
    .. '/lspconfig/sumneko_lua/lua-language-server'

local config = {
    default = { flags = { debounce_text_changes = 500 } },
    clangd = {
        on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
        end,
    },
    pyright = {},
    hls = {},
    vimls = {},
    texlab = {},
    gopls = {},
    rust_analyzer = {},
    efm = {
        init_options = { documentFormatting = true },
        languages = {
            lua = {},
            cpp = {},
        },
    },
    sumneko_lua = {
        cmd = { 'lua-language-server', '-E', sumneko_root_path .. '/main.lua' },
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = {
                        [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                        [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
                    },
                },
                telemetry = { enable = false },
            },
        },
    },
}

local enabled_servers = {
    'clangd',
    'pyright',
    'hls',
    'vimls',
    'texlab',
    'gopls',
    'rust_analyzer',
    'efm',
    'sumneko_lua',
}

for _, lsp in ipairs(enabled_servers) do
    local cfg = vim.tbl_extend('force', config.default, config[lsp])
    lspconfig[lsp].setup(cfg)
end

-- lspkind

-- vscode-like pictograms
-- https://github.com/microsoft/vscode-codicons
require('lspkind').init {
    with_text = false,
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
        TypeParameter = ' ',
    },
}
