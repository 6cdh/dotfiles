require"lspconfig".efm.setup {init_options = {documentFormatting = true}}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        underline = true,
        virtual_text = false,
        update_in_insert = false
    })
