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
        vsnip = true,
        tabnine = {
            max_line = 1000,
            max_num_resuts = 6,
            sort = false,
            show_prediction_strength = true,
        }
    }
}

