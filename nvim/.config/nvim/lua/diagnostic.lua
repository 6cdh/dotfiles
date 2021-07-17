local icons = require 'theme.icons'
local signs = {
    Error = icons.errs,
    Warning = icons.warns,
    Hint = icons.hints,
    Information = icons.infos
}

for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        underline = true,
        virtual_text = false,
        update_in_insert = false
    })
