require'compe'.setup {
    preselect = 'always',
    max_abbr_width = 45,
    source = {
        path = true,
        buffer = true,
        spell = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        tabnine = true,
        vsnip = true
    }
}

